##1024swift介绍
- 框架集成了Alamofire，SwiftHttp两大网络访问类库
- 数据库类SQLite.swift
- json数据处理SwiftyJSON类库
- Dollar.swift计算
- LTMorphingLabel，Surge
- 弹出框SCLAlertView-Swift
- 快速创建表格的类库SwiftForms

这款框架的目标是成为快速开发swift软件的框架
## 使用说明
- 代码里面有详细的使用说明，建议ForK一份研究。
- 每个类库的使用方法请参考官网说明

## Alamofire网络类库使用说明--参考官网
Alamofire is an HTTP networking library written in Swift, from the [creator](https://github.com/mattt) of [AFNetworking](https://github.com/afnetworking/afnetworking).

## Features

- [x] Chainable Request / Response methods
- [x] URL / JSON / plist Parameter Encoding
- [x] Upload File / Data / Stream
- [x] Download using Request or Resume data
- [x] Authentication with NSURLCredential
- [x] HTTP Response Validation
- [x] Progress Closure & NSProgress
- [x] cURL Debug Output
- [x] Comprehensive Unit Test Coverage
- [x] Complete Documentation

## Requirements

- iOS 7.0+ / Mac OS X 10.9+
- Xcode 6.1

## Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/alamofire). (Tag 'alamofire')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/alamofire).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

> For application targets that do not support embedded frameworks, such as iOS 7, Alamofire can be integrated by including the `Alamofire.swift` source file directly, wrapping the top-level types in `struct Alamofire` to simulate a namespace. Yes, this sucks.

_Due to the current lack of [proper infrastructure](http://cocoapods.org) for Swift dependency management, using Alamofire in your project requires the following steps:_

1. Add Alamofire as a [submodule](http://git-scm.com/docs/git-submodule) by opening the Terminal, `cd`-ing into your top-level project directory, and entering the command `git submodule add https://github.com/Alamofire/Alamofire.git`
2. Open the `Alamofire` folder, and drag `Alamofire.xcodeproj` into the file navigator of your app project.
3. In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
4. Ensure that the deployment target of Alamofire.framework matches that of the application target.
5. In the tab bar at the top of that window, open the "Build Phases" panel.
6. Expand the "Target Dependencies" group, and add `Alamofire.framework`.
7. Click on the `+` button at the top left of the panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `Alamofire.framework`.

---

## Usage

### Making a Request

```swift
import Alamofire

Alamofire.request(.GET, "http://httpbin.org/get")
```

### Response Handling

```swift
Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
         .response { (request, response, data, error) in
                     println(request)
                     println(response)
                     println(error)
                   }
```

> Networking in Alamofire is done _asynchronously_. Asynchronous programming may be a source of frustration to programmers unfamiliar with the concept, but there are [very good reasons](https://developer.apple.com/library/ios/qa/qa1693/_index.html) for doing it this way.

> Rather than blocking execution to wait for a response from the server, a [callback](http://en.wikipedia.org/wiki/Callback_%28computer_programming%29) is specified to handle the response once it's received. The result of a request is only available inside the scope of a response handler. Any execution contingent on the response or data received from the server must be done within a handler.

### Response Serialization

**Built-in Response Methods**

- `response()`
- `responseString(encoding: NSStringEncoding)`
- `responseJSON(options: NSJSONReadingOptions)`
- `responsePropertyList(options: NSPropertyListReadOptions)`

####  Response String Handler

```swift
Alamofire.request(.GET, "http://httpbin.org/get")
         .responseString { (_, _, string, _) in
                  println(string)
         }
```

####  Response JSON Handler

```swift
Alamofire.request(.GET, "http://httpbin.org/get")
         .responseJSON { (_, _, JSON, _) in
                  println(JSON)
         }
```

#### Chained Response Handlers

Response handlers can even be chained:

```swift
Alamofire.request(.GET, "http://httpbin.org/get")
         .responseString { (_, _, string, _) in
                  println(string)
         }
         .responseJSON { (_, _, JSON, _) in
                  println(JSON)
         }
```

### HTTP Methods

`Alamofire.Method` lists the HTTP methods defined in [RFC 7231 §4.3](http://tools.ietf.org/html/rfc7231#section-4.3):

```swift
public enum Method: String {
    case OPTIONS = "OPTIONS"
    case GET = "GET"
    case HEAD = "HEAD"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
    case TRACE = "TRACE"
    case CONNECT = "CONNECT"
}
```

These values can be passed as the first argument of the `Alamofire.request` method:

```swift
Alamofire.request(.POST, "http://httpbin.org/post")

Alamofire.request(.PUT, "http://httpbin.org/put")

Alamofire.request(.DELETE, "http://httpbin.org/delete")
```

### Parameters

#### GET Request With URL-Encoded Parameters

```swift
Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
// http://httpbin.org/get?foo=bar
```

#### POST Request With URL-Encoded Parameters

```swift
let parameters = [
    "foo": "bar",
    "baz": ["a", 1],
    "qux": [
        "x": 1,
        "y": 2,
        "z": 3
    ]
]

Alamofire.request(.POST, "http://httpbin.org/post", parameters: parameters)
// HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
```

### Parameter Encoding

Parameters can also be encoded as JSON, Property List, or any custom format, using the `ParameterEncoding` enum:

```swift
enum ParameterEncoding {
    case URL
    case JSON
    case PropertyList(format: NSPropertyListFormat,
                      options: NSPropertyListWriteOptions)

    func encode(request: NSURLRequest,
                parameters: [String: AnyObject]?) ->
                    (NSURLRequest, NSError?)
    { ... }
}
```

- `URL`: A query string to be set as or appended to any existing URL query for `GET`, `HEAD`, and `DELETE` requests, or set as the body for requests with any other HTTP method. The `Content-Type` HTTP header field of an encoded request with HTTP body is set to `application/x-www-form-urlencoded`. _Since there is no published specification for how to encode collection types, the convention of appending `[]` to the key for array values (`foo[]=1&foo[]=2`), and appending the key surrounded by square brackets for nested dictionary values (`foo[bar]=baz`)._
- `JSON`: Uses `NSJSONSerialization` to create a JSON representation of the parameters object, which is set as the body of the request. The `Content-Type` HTTP header field of an encoded request is set to `application/json`.
- `PropertyList`: Uses `NSPropertyListSerialization` to create a plist representation of the parameters object, according to the associated format and write options values, which is set as the body of the request. The `Content-Type` HTTP header field of an encoded request is set to `application/x-plist`.
- `Custom`: Uses the associated closure value to construct a new request given an existing request and parameters.

#### Manual Parameter Encoding of an NSURLRequest

```swift
let URL = NSURL(string: "http://httpbin.org/get")!
var request = NSURLRequest(URL: URL)

let parameters = ["foo": "bar"]
let encoding = Alamofire.ParameterEncoding.URL
(request, _) = encoding.encode(request, parameters)
```

#### POST Request with JSON-encoded Parameters

```swift
let parameters = [
    "foo": [1,2,3],
    "bar": [
        "baz": "qux"
    ]
]

Alamofire.request(.POST, "http://httpbin.org/post", parameters: parameters, encoding: .JSON)
// HTTP body: {"foo": [1, 2, 3], "bar": {"baz": "qux"}}
```

### Caching

Caching is handled on the system framework level by [`NSURLCache`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSURLCache_Class/Reference/Reference.html#//apple_ref/occ/cl/NSURLCache).

### Uploading

**Supported Upload Types**

- File
- Data
- Stream

#### Uploading a File

```swift
let fileURL = NSBundle.mainBundle()
                      .URLForResource("Default",
                                      withExtension: "png")

Alamofire.upload(.POST, "http://httpbin.org/post", file: fileURL)
```

#### Uploading w/Progress

```swift
Alamofire.upload(.POST, "http://httpbin.org/post", file: fileURL)
         .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
             println(totalBytesWritten)
         }
         .responseJSON { (request, response, JSON, error) in
             println(JSON)
         }
```


