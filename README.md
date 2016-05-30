#CouchbaseSwift
[TOC]
##Introduction
This project demos how to use Couchbase C SDK with Swift SDK (**without Xcode**). Following the Couchbase C SDK getting started example.

The project demostrates how to store and get a binary and json doc.

One good thing about using Swift is that you can use the C library directly using the `module.modulemap` and include header and dynamic library.

The tedious part is the conversion(casting) between different pointer types. You can see lots of `UnsafePointer<T>` being converted from/to `UnsafePointer<Void>` before assignment.

##Environment
Mac OSX El Capitan 10.11.5  
Swift 3.0 DEVELOPMENT-SNAPSHOT-2016-05-09-a  
Couchbase Server 4.5.0-BETA  
libcouchbase 2.6.0 (Couchbase C SDK)  

##Prerequisites
###swiftenv
1. Install [swiftenv](https://github.com/kylef/swiftenv)
2. Run: `$ swiftenv install DEVELOPMENT-SNAPSHOT-2016-05-09-a`

###libcouchbase 2.6.0
(Must have [Homebrew](http://brew.sh) installed)  
1. Run: `$ brew install libcouchbase`  
2. The headers and libraries will be located in  
/usr/local/Cellar/libcouchbase/2.6.0/include  
/usr/local/Cellar/libcouchbase/2.6.0/lib  

###Couchbase Server 4.5.0-BETA
Get from couchbase.com. Once installed create a `default` bucket.

##Installation & Run
### Download
`$ git clone https://github.com/Zev23/CouchbaseSwift.git`

### Run
```sh
#Build
$ cd CouchbaseSwift

$ swift build -Xcc -I/usr/local/Cellar/libcouchbase/2.6.0/include -Xlinker -L/usr/local/Cellar/libcouchbase/2.6.0/lib/  -Xcc -I./Modules -v

#Run
$ .build/debug/CouchbaseSwift

couchbase://localhost/default
Stored key Hello
Retrieved key Hello
Value is Couchbase
Stored key a_simple_key
Retrieved key a_simple_key
Value is { "json" : "data" }
```
