#CouchbaseSwift

##Introduction
This project demos how to use Couchbase C SDK with Swift SDK **in Xcode**. Following the Couchbase C SDK getting started example.

The project demostrates how to store and get a binary and json doc.

##Environment
Mac OSX El Capitan 10.11.5  
Swift 3.0 from Xcode 8 Beta  
Couchbase Server 4.5.0-BETA  
libcouchbase 2.6.0 (Couchbase C SDK)  

##Prerequisites
###libcouchbase 2.6.0
(Must have [Homebrew](http://brew.sh) installed)  
1. Run: `$ brew install libcouchbase`  
2. The headers and libraries will be located in  
  - /usr/local/Cellar/libcouchbase/2.6.0/include  
  - /usr/local/Cellar/libcouchbase/2.6.0/lib  

###Couchbase Server 4.5.0-BETA
Get from couchbase.com. Once installed create a `default` bucket.

##Installation & Run
### Download
`$ git clone https://github.com/Zev23/CouchbaseSwift.git`

### Open project
```sh
#Build
$ cd CouchbaseSwift

$ open CouchbaseSwift.xcodeproj
```

### Build and Run
You should see log as below in console.
```
couchbase://localhost/default
Stored key Hello
Retrieved key Hello
Value is Couchbase
Stored key a_simple_key
Retrieved key a_simple_key
Value is { "json" : "data" }
```

##Setup steps to use libcouchbase in project:
1. Create BridgeHeader.h and put in `#import <libcouchbase/couchbase.h>`
2. Build Settings -> 
    - **Objective-C Bridging Header**: $SRCROOT/BridgeHeader.h
    - **Other Linker Flags**: -lcouchbase
    - **Header Search Paths**: /usr/local/Cellar/libcouchbase/2.6.0/include
    - **Library Search Paths**: /usr/local/Cellar/libcouchbase/2.6.0/lib
