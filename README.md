# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

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
Time taken for tests:   0.258 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      28800 bytes
HTML transferred:       4800 bytes
Requests per second:    387.93 [#/sec] (mean)
Time per request:       12.889 [ms] (mean)
Time per request:       2.578 [ms] (mean, across all concurrent requests)
Transfer rate:          109.10 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.1      0       1
Processing:     5   13   5.3     11      30
Waiting:        5   11   4.1     10      25
Total:          5   13   5.3     11      30

Percentage of the requests served within a certain time (ms)
  50%     11
  66%     13
  75%     15
  80%     16
  90%     21
  95%     27
  98%     29
  99%     30
 100%     30 (longest request)
 ```

#### Grape
```
$ rackup
Loaded in: 1.048874s
Puma starting in single mode...
* Version 3.12.0 (ruby 2.4.1-p111), codename: Llamas in Pajamas
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://localhost:9292
Use Ctrl-C to stop
```
*/api/version*
```
$ ab -n 100 -c 5 "http://localhost:9292/api/version"
This is ApacheBench, Version 2.3 <$Revision: 1807734 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient).....done


Server Software:
Server Hostname:        localhost
Server Port:            9292

Document Path:          /api/version
Document Length:        48 bytes

Concurrency Level:      5
Time taken for tests:   0.229 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      11900 bytes
HTML transferred:       4800 bytes
Requests per second:    437.50 [#/sec] (mean)
Time per request:       11.429 [ms] (mean)
Time per request:       2.286 [ms] (mean, across all concurrent requests)
Transfer rate:          50.84 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.2      0       1
Processing:     3   11  10.3      9      53
Waiting:        2    9  10.2      7      52
Total:          3   11  10.3      9      54

Percentage of the requests served within a certain time (ms)
  50%      9
  66%     11
  75%     12
  80%     13
  90%     15
  95%     53
  98%     54
  99%     54
 100%     54 (longest request)
 ```
