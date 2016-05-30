import libcouchbase
import Foundation

//callbacks
let storage_callback:lcb_store_callback = {
    (instance, cookie, op, err, resp) -> Void in
    let key =  NSData(bytes: resp!.pointee.v.v0.key, length: resp!.pointee.v.v0.nkey)
    print("Stored key \(NSString(data: key, encoding: NSUTF8StringEncoding)!)")
}

let get_callback:lcb_get_callback = {
    (instance, cookie, err, resp) -> Void in
    let key =  NSData(bytes: resp!.pointee.v.v0.key, length: resp!.pointee.v.v0.nkey)
    print("Retrieved key \(NSString(data: key, encoding: NSUTF8StringEncoding)!)")
    
    let bytes = NSData(bytes:resp!.pointee.v.v0.bytes, length:resp!.pointee.v.v0.nbytes)
    print("Value is \(NSString(data: bytes, encoding: NSUTF8StringEncoding)!)")
}

var cropts:lcb_create_st = lcb_create_st()
cropts.version = 3;
cropts.v.v3.connstr = ("couchbase://localhost/default" as NSString).utf8String //NSString is used to interop with C

print(String(cString: cropts.v.v3.connstr)) //Must put parameter name cString

var err:lcb_error_t
var instance:lcb_t?

err = lcb_create( &instance, &cropts )
if ( err != LCB_SUCCESS ) {
    print("Couldn't create instance!")
    exit(1)
}

// connecting
lcb_connect(instance)
lcb_wait(instance)
err = lcb_get_bootstrap_status(instance)
if ( err != LCB_SUCCESS ) {
    print("Couldn't bootstrap!")
    exit(1);
}

// Installing callbacks
lcb_set_store_callback(instance, storage_callback)
lcb_set_get_callback(instance, get_callback)

// Store operation
var scmd:lcb_store_cmd_t = lcb_store_cmd_t()
var scmdlist:UnsafePointer<lcb_store_cmd_t>? = withUnsafePointer(&scmd) {
    UnsafePointer<lcb_store_cmd_t>($0)
}
scmd.v.v0.key = UnsafePointer<Void>?(("Hello" as NSString).utf8String!)
scmd.v.v0.nkey = 5
scmd.v.v0.bytes = UnsafePointer<Void>?(("Couchbase" as NSString).utf8String!)
scmd.v.v0.nbytes = 9
scmd.v.v0.operation = LCB_SET
err = lcb_store(instance, nil, 1, &scmdlist)
if (err != LCB_SUCCESS) {
    print("Couldn't schedule storage operation! \(err)");
    exit(1);
}
lcb_wait(instance); //storage_callback is invoked here


// Get operation
var gcmd:lcb_get_cmd_t = lcb_get_cmd_t();
var gcmdlist:UnsafePointer<lcb_get_cmd_t>? = withUnsafePointer(&gcmd) {
    UnsafePointer<lcb_get_cmd_t>($0)
}
gcmd.v.v0.key = UnsafePointer<Void>?(("Hello" as NSString).utf8String!)
gcmd.v.v0.nkey = 5;
err = lcb_get(instance, nil, 1, &gcmdlist);
if (err != LCB_SUCCESS) {
    print("Couldn't schedule get operation! \(err)");
    exit(1);
}
lcb_wait(instance); // get_callback is invoked here


//Store and retrieve json doc
var doc:NSString = "{ \"json\" : \"data\" }"
var docKey:NSString = "a_simple_key"
var cmd = lcb_store_cmd_st()
var cmdlist:UnsafePointer<lcb_store_cmd_st>? = withUnsafePointer(&cmd) {
    UnsafePointer<lcb_store_cmd_st>($0)
}
cmd.v.v0.key = UnsafePointer<Void>?(docKey.utf8String!)
cmd.v.v0.nkey = docKey.length
cmd.v.v0.bytes = UnsafePointer<Void>?(doc.utf8String!)
cmd.v.v0.nbytes = doc.length
cmd.v.v0.operation = LCB_ADD

err = lcb_store(instance, nil, 1, &cmdlist);
if (err == LCB_SUCCESS) {
    lcb_wait(instance)
} else {
    print("Could not store json doc: \(lcb_strerror(instance, err))")
}


gcmd.v.v0.key = UnsafePointer<Void>?(docKey.utf8String!)
gcmd.v.v0.nkey = docKey.length;
err = lcb_get(instance, nil, 1, &gcmdlist);
if (err != LCB_SUCCESS) {
    print("Couldn't schedule get operation! \(err)");
    exit(1);
}
lcb_wait(instance);

lcb_destroy(instance);


print("\n--Exit Program")



