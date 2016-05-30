#CouchbaseSwift
[TOC]
##Introduction
This project demos how to use Couchbase C SDK with Swift SDK (**For Ubuntu Linux**). Following the Couchbase C SDK getting started example.

The project demostrates how to store and get a binary and json doc.

One good thing about using Swift is that you can use the C library directly using the `module.modulemap` and include header and dynamic library.

The tedious part is the conversion(casting) between different pointer types. You can see lots of `UnsafePointer<T>` being converted from/to `UnsafePointer<Void>` before assignment.

##Environment
Ubuntu 16.04  
Swift 3.0 DEVELOPMENT-SNAPSHOT-2016-05-09-a  
Couchbase Server 4.5.0-BETA  
libcouchbase 2.6.0 (Couchbase C SDK)  

##Prerequisites
###swiftenv
1. Install [swiftenv](https://github.com/kylef/swiftenv)
2. Run: `$ env UBUNTU_VERSION=ubuntu15.10 swiftenv install DEVELOPMENT-SNAPSHOT-2016-05-09-a`

###libcouchbase 2.6.0
1. [Follow instruction](http://developer.couchbase.com/documentation/server/4.1/sdks/c-2.4/download-install.html) to install libcouchbase.
2. The headers and libraries will be located in  
/usr/include/libcouchbase  
/usr/lib/x86_64-linux-gnu  

###Couchbase Server 4.5.0-BETA
Get from couchbase.com. Once installed create a `default` bucket.

##Installation & Run
### Download
`$ git clone -b for-linux https://github.com/Zev23/CouchbaseSwift.git`

### Run
```sh
#Build
$ cd CouchbaseSwift

$ swift build -Xcc -I/usr/include -Xlinker -L/usr/lib/x86_64-linux-gnu  -Xcc -I./Modules -v

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
