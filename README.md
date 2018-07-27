# ProgImage

## Application Information

#### Ruby version
```
v2.4.1
```

#### System dependencies

* [Gemfile.lock](https://github.com/bazay/prog_image/blob/master/Gemfile.lock)
* Environment variables:
  * `AWS_ACCESS_KEY_ID` of AWS IAM User for accessing AWS S3
  * `AWS_ACCESS_KEY` of AWS IAM User for accessing AWS S3
  * `AWS_BUCKET_NAME` of bucket to upload images on AWS S3
  * `AWS_REGION` of AWS region

#### Setup command

For setting up in development environment you can use the following rake task:
```
bundle exec rake prog_image::setup
```
The task will ask for the following information:

* AWS `access_key_id` for the authenticated IAM user
* AWS `access_key` for the authenticated IAM user

This will then generate the necessary `application.yml` required.


#### How to run the test suite
```
bundle exec rspec && rubocop
```

#### Deployment instructions
```
bundle exec puma config.ru
```


## Reference

### API

The API is written in [Grape](https://github.com/ruby-grape/grape), a rack-based framework that provides a decent level of boilerplate code whilst remaining [performant](#benchmarking).

**POST /api/v1.0/images**

This endpoint allows images to be uploaded and accepts the following parameters:

* `image_file` **(required)** (File) - The multipart file to upload

This endpoint returns a JSON object with the following structure:
```
{
  "key": "4ae870d1-5a1a-4dd5-b1c6-b813582dbc45/example.png"
}
```

**GET /api/v1.0/images**

This endpoint images to be retrieved and accepts the following parameters:

* `key` **(required)** (String) - The key returned when performing POST request for an image
* `extension` *(optional)* (String) - The extension of the image extension you want to convert to, e.g. 'PNG', 'JPG', 'TIFF', etc

This endpoint returns a JSON object with the following structure:
```
{
  "key": "4ae870d1-5a1a-4dd5-b1c6-b813582dbc45/example.png",
  "public_url": "http://s3.region.com/bucket-name/4ae870d1-5a1a-4dd5-b1c6-b813582dbc45/example.png"
}
```

### Forms

#### ImageConvertForm

This form ensures that validations are performed on the key attempting to be converted to new extension. 
The two primary validations are:

* `ensure_extension_is_different` - Checks the provided `extension` is different to the image type attempting to be converted. 
* `ensure_extension_is_an_image` - Checks the provided `extension` is a valid image extension using `MimeMagic` gem. 

Image types are not limited i.e. the upload is checked using `MiniMagick` gem which supports a great deal of image types.

#### ImageUploadForm

This form ensures that validations are performed on the file uploaded. 
The two primary validations are:

* `filename` - The filename for the file is valid file format (i.e. includes an extension) - however this could be disabled to allow images without extensions in the filename...
* `ensure_file_is_an_image` - The uploaded file is an image. 

Image types are not limited i.e. the upload is checked using `MiniMagick` gem which supports a great deal of image types.

### Libraries

#### Connectors

The purpose of connectors are to act as interfaces to other services. There can be many and are designed to be interchangable where necessary. They are isolated and therefore do not contain or perform any logic related to the `ProgImage` application.

**Connectors::Aws::S3Connector**

This connector is the method of interacting with the AWS S3 storage. It supports the uploading and the retrieval of files and file information stored on S3.

*Interestingly, S3 supports the concept of *presigning posts*. In short, the server receives information about a file to be uploaded to S3 and rather than facilitating that file upload using server resource, it creates temporary permission for the client to perform the upload directly to S3 themselves. An interesting way to potentially free up server resource.*

### Services

#### FileFetcher

This service is responsible for retrieving a file from storage.
It has the following public methods:

**#initialize(key)**

**#fetch**

Fetches the file from storage using `key` passed in on `#initialize` and returns an instance of `Aws::S3::Object`.

**#connector** (private)

The connector used to connect to the storage service.

#### FileUploader

This service is responsible for uploading an image to storage.
It has the following public methods:

**#initialize(file)**

**#upload**

Uploads the file to storage using `file` passed in on `#initialize` and returns `key` (success) or `false` (failure).

**#build_key_path** (private)

Generates a unique key by combining a uuid folder name with the original filename within that folder. This allows to images with the same filename to be uploaded to the service without issue. An example folder structure:
```
/bucket-name/4ae870d1-5a1a-4dd5-b1c6-b813582dbc45/example.png
```

**#connector** (private)

The connector used to connect to the storage service.

#### ImageHandler

This service is responsible for handling image file operations using the `MiniMagick` and `MimeMagic` gems.

**#initialize(image_file)**

**#image_file**

Returns an instance of `MiniMagick::Image` if `image_file` is a valid image file, otherwise returns `nil`.

**#image?**

Returns a `TrueClass` if `image_file` is a valid image file, otherwise returns `FalseClass`.

**#image_extension?(extension)**

Returns a `TrueClass` if `extension` argument is a valid image file extension, otherwise returns `FalseClass`.

**#different_extension?(extension)**

Returns a `TrueClass` if `extension` argument is a different file extension to the temporary image file, otherwise returns `FalseClass`.

**#convert_extension(extension)**

Attempts to convert the `image_file` to the new extension. There are 3 expected outcomes:
* If the extension is valid it converts the image and returns the `MiniMagick`-wrapped converted image
* If the extension is the same as the image it just returns the original image
* If the extension is not valid it returns `nil`.

If for some reason the conversion fails, a custom error `ProgImage::Errors::ImageConversionError` is thrown and captured in the api layer and handled accordingly.


## Benchmarking

Measuring performance across Ruby frameworks (Grape, Rails/Grape) tested on Macbook Pro 2016 3.3GHz i7 16GB DDR3 using `ApacheBench`.

#### TL;DR

A Rack-only server is significantly faster than a Rails/Grape API-only framework. This is multiplied significantly if Puma is run in clustered mode, seeing request times as low as 4ms per transaction.

This result is due mainly to the additional middlewares and gems included in Rails, many of which are not required for this particular use-case.

### Rails/Grape

```
$ rails s
=> Booting Puma
=> Rails 5.2.0 application starting in development
=> Run `rails server -h` for more startup options
Loaded in: 0.365606s
Puma starting in single mode...
* Version 3.12.0 (ruby 2.4.1-p111), codename: Llamas in Pajamas
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
```

**GET /api/version**

```
$ ab -n 100 -c 5 "http://127.0.0.1:3000/api/version"
This is ApacheBench, Version 2.3 <$Revision: 1807734 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient).....done


Server Software:
Server Hostname:        127.0.0.1
Server Port:            3000

Document Path:          /api/version
Document Length:        48 bytes

Concurrency Level:      5
Time taken for tests:   0.241 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      28800 bytes
HTML transferred:       4800 bytes
Requests per second:    415.59 [#/sec] (mean)
Time per request:       12.031 [ms] (mean)
Time per request:       2.406 [ms] (mean, across all concurrent requests)
Transfer rate:          116.89 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.1      0       1
Processing:     4   12   5.2     11      31
Waiting:        4   11   4.5     10      29
Total:          4   12   5.2     11      31

Percentage of the requests served within a certain time (ms)
  50%     11
  66%     12
  75%     14
  80%     14
  90%     17
  95%     26
  98%     30
  99%     31
 100%     31 (longest request)
 ```

### Grape

```
$ puma config.ru
Puma starting in single mode...
* Version 3.12.0 (ruby 2.4.1-p111), codename: Llamas in Pajamas
* Min threads: 0, max threads: 16
* Environment: development
Loaded in: 1.039307s
* Listening on tcp://0.0.0.0:9292
Use Ctrl-C to stop
```

**GET /api/version**

```
$ ab -n 100 -c 5 "127.0.0.1:9292/api/version"
This is ApacheBench, Version 2.3 <$Revision: 1807734 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient).....done


Server Software:
Server Hostname:        127.0.0.1
Server Port:            9292

Document Path:          /api/version
Document Length:        48 bytes

Concurrency Level:      5
Time taken for tests:   0.071 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      11900 bytes
HTML transferred:       4800 bytes
Requests per second:    1417.62 [#/sec] (mean)
Time per request:       3.527 [ms] (mean)
Time per request:       0.705 [ms] (mean, across all concurrent requests)
Transfer rate:          164.74 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.2      0       1
Processing:     1    3   1.4      3      10
Waiting:        1    2   1.1      2       6
Total:          1    3   1.5      3      10

Percentage of the requests served within a certain time (ms)
  50%      3
  66%      3
  75%      4
  80%      4
  90%      6
  95%      6
  98%      8
  99%     10
 100%     10 (longest request)
```
