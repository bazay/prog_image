# README

## Application Information

* Ruby version: v2.4.1

* System dependencies: See `Gemfile.lock (DEPENDENCIES)`

* How to run the test suite
`bundle exec rspec && rubocop`

* Services (job queues, cache servers, search engines, etc.): TODO

* Deployment instructions
`bundle exec puma config.ru`

## Performance

Measuring performance across Ruby frameworks (Grape, Rails/Grape) tested on Macbook Pro 2016 3.3GHz i7 16GB DDR3 using `ApacheBench`.

#### Rails/Grape
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
*/api/version*
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

#### Grape
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
*/api/version*
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
