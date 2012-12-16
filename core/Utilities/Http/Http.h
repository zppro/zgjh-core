//
//  Http.h
//  HttpTest
//
//  Created by shrek on 10-9-9.
//  Copyright 2010 mysays.com. All rights reserved.
//

// 摘要:
//     包含为 HTTP 定义的状态代码的值。
typedef enum {
    // 摘要:
    //     Equivalent to HTTP status 100.System.Net.HttpStatusCode.Continue indicates
    //     that the client can continue with its request.
    Continue = 100,
    //
    // 摘要:
    //     Equivalent to HTTP status 101.System.Net.HttpStatusCode.SwitchingProtocols
    //     indicates that the protocol version or protocol is being changed.
    SwitchingProtocols = 101,
    //
    // 摘要:
    //     Equivalent to HTTP status 200.System.Net.HttpStatusCode.OK indicates that
    //     the request succeeded and that the requested information is in the response.这是最常接收的状态代码。
    OK = 200,
    //
    // 摘要:
    //     Equivalent to HTTP status 201.System.Net.HttpStatusCode.Created indicates
    //     that the request resulted in a new resource created before the response was
    //     sent.
    Created = 201,
    //
    // 摘要:
    //     Equivalent to HTTP status 202.System.Net.HttpStatusCode.Accepted indicates
    //     that the request has been accepted for further processing.
    Accepted = 202,
    //
    // 摘要:
    //     Equivalent to HTTP status 203.System.Net.HttpStatusCode.NonAuthoritativeInformation
    //     indicates that the returned metainformation is from a cached copy instead
    //     of the origin server and therefore may be incorrect.
    NonAuthoritativeInformation = 203,
    //
    // 摘要:
    //     Equivalent to HTTP status 204.System.Net.HttpStatusCode.NoContent indicates
    //     that the request has been successfully processed and that the response is
    //     intentionally blank.
    NoContent = 204,
    //
    // 摘要:
    //     Equivalent to HTTP status 205.System.Net.HttpStatusCode.ResetContent indicates
    //     that the client should reset (not reload) the current resource.
    ResetContent = 205,
    //
    // 摘要:
    //     Equivalent to HTTP status 206.System.Net.HttpStatusCode.PartialContent indicates
    //     that the response is a partial response as requested by a GET request that
    //     includes a byte range.
    PartialContent = 206,
    //
    // 摘要:
    //     Equivalent to HTTP status 300.System.Net.HttpStatusCode.MultipleChoices indicates
    //     that the requested information has multiple representations.默认操作是将此状态视为重定向，并遵循与此响应关联的
    //     Location 头的内容。
    MultipleChoices = 300,
    //
    // 摘要:
    //     Equivalent to HTTP status 300.System.Net.HttpStatusCode.Ambiguous indicates
    //     that the requested information has multiple representations.默认操作是将此状态视为重定向，并遵循与此响应关联的
    //     Location 头的内容。
    Ambiguous = 300,
    //
    // 摘要:
    //     Equivalent to HTTP status 301.System.Net.HttpStatusCode.MovedPermanently
    //     indicates that the requested information has been moved to the URI specified
    //     in the Location header.接收到此状态时的默认操作为遵循与响应关联的 Location 头。
    MovedPermanently = 301,
    //
    // 摘要:
    //     Equivalent to HTTP status 301.System.Net.HttpStatusCode.Moved indicates that
    //     the requested information has been moved to the URI specified in the Location
    //     header.接收到此状态时的默认操作为遵循与响应关联的 Location 头。原始请求方法为 POST 时，重定向的请求将使用 GET 方法。
    Moved = 301,
    //
    // 摘要:
    //     Equivalent to HTTP status 302.System.Net.HttpStatusCode.Found indicates that
    //     the requested information is located at the URI specified in the Location
    //     header.接收到此状态时的默认操作为遵循与响应关联的 Location 头。原始请求方法为 POST 时，重定向的请求将使用 GET 方法。
    Found = 302,
    //
    // 摘要:
    //     Equivalent to HTTP status 302.System.Net.HttpStatusCode.Redirect indicates
    //     that the requested information is located at the URI specified in the Location
    //     header.接收到此状态时的默认操作为遵循与响应关联的 Location 头。原始请求方法为 POST 时，重定向的请求将使用 GET 方法。
    Redirect = 302,
    //
    // 摘要:
    //     Equivalent to HTTP status 303.System.Net.HttpStatusCode.SeeOther automatically
    //     redirects the client to the URI specified in the Location header as the result
    //     of a POST.用 GET 生成对 Location 头所指定的资源的请求。
    SeeOther = 303,
    //
    // 摘要:
    //     Equivalent to HTTP status 303.System.Net.HttpStatusCode.RedirectMethod automatically
    //     redirects the client to the URI specified in the Location header as the result
    //     of a POST.用 GET 生成对 Location 头所指定的资源的请求。
    RedirectMethod = 303,
    //
    // 摘要:
    //     Equivalent to HTTP status 304.System.Net.HttpStatusCode.NotModified indicates
    //     that the client's cached copy is up to date.未传输此资源的内容。
    NotModified = 304,
    //
    // 摘要:
    //     Equivalent to HTTP status 305.System.Net.HttpStatusCode.UseProxy indicates
    //     that the request should use the proxy server at the URI specified in the
    //     Location header.
    UseProxy = 305,
    //
    // 摘要:
    //     Equivalent to HTTP status 306.System.Net.HttpStatusCode.Unused is a proposed
    //     extension to the HTTP/1.1 specification that is not fully specified.
    Unused = 306,
    //
    // 摘要:
    //     Equivalent to HTTP status 307.System.Net.HttpStatusCode.TemporaryRedirect
    //     indicates that the request information is located at the URI specified in
    //     the Location header.接收到此状态时的默认操作为遵循与响应关联的 Location 头。原始请求方法为 POST 时，重定向的请求还将使用
    //     POST 方法。
    TemporaryRedirect = 307,
    //
    // 摘要:
    //     Equivalent to HTTP status 307.System.Net.HttpStatusCode.RedirectKeepVerb
    //     indicates that the request information is located at the URI specified in
    //     the Location header.接收到此状态时的默认操作为遵循与响应关联的 Location 头。原始请求方法为 POST 时，重定向的请求还将使用
    //     POST 方法。
    RedirectKeepVerb = 307,
    //
    // 摘要:
    //     Equivalent to HTTP status 400.System.Net.HttpStatusCode.BadRequest indicates
    //     that the request could not be understood by the server.System.Net.HttpStatusCode.BadRequest
    //     is sent when no other error is applicable, or if the exact error is unknown
    //     or does not have its own error code.
    BadRequest = 400,
    //
    // 摘要:
    //     Equivalent to HTTP status 401.System.Net.HttpStatusCode.Unauthorized indicates
    //     that the requested resource requires authentication.WWW-Authenticate 头包含如何执行身份验证的详细信息。
    Unauthorized = 401,
    //
    // 摘要:
    //     Equivalent to HTTP status 402.System.Net.HttpStatusCode.PaymentRequired is
    //     reserved for future use.
    PaymentRequired = 402,
    //
    // 摘要:
    //     Equivalent to HTTP status 403.System.Net.HttpStatusCode.Forbidden indicates
    //     that the server refuses to fulfill the request.
    Forbidden = 403,
    //
    // 摘要:
    //     Equivalent to HTTP status 404.System.Net.HttpStatusCode.NotFound indicates
    //     that the requested resource does not exist on the server.
    NotFound = 404,
    //
    // 摘要:
    //     Equivalent to HTTP status 405.System.Net.HttpStatusCode.MethodNotAllowed
    //     indicates that the request method (POST or GET) is not allowed on the requested
    //     resource.
    MethodNotAllowed = 405,
    //
    // 摘要:
    //     Equivalent to HTTP status 406.System.Net.HttpStatusCode.NotAcceptable indicates
    //     that the client has indicated with Accept headers that it will not accept
    //     any of the available representations of the resource.
    NotAcceptable = 406,
    //
    // 摘要:
    //     Equivalent to HTTP status 407.System.Net.HttpStatusCode.ProxyAuthenticationRequired
    //     indicates that the requested proxy requires authentication.Proxy-authenticate
    //     头包含如何执行身份验证的详细信息。
    ProxyAuthenticationRequired = 407,
    //
    // 摘要:
    //     Equivalent to HTTP status 408.System.Net.HttpStatusCode.RequestTimeout indicates
    //     that the client did not send a request within the time the server was expecting
    //     the request.
    RequestTimeout = 408,
    //
    // 摘要:
    //     Equivalent to HTTP status 409.System.Net.HttpStatusCode.Conflict indicates
    //     that the request could not be carried out because of a conflict on the server.
    Conflict = 409,
    //
    // 摘要:
    //     Equivalent to HTTP status 410.System.Net.HttpStatusCode.Gone indicates that
    //     the requested resource is no longer available.
    Gone = 410,
    //
    // 摘要:
    //     Equivalent to HTTP status 411.System.Net.HttpStatusCode.LengthRequired indicates
    //     that the required Content-length header is missing.
    LengthRequired = 411,
    //
    // 摘要:
    //     Equivalent to HTTP status 412.System.Net.HttpStatusCode.PreconditionFailed
    //     indicates that a condition set for this request failed, and the request cannot
    //     be carried out.条件是用条件请求标头（如 If-Match、If-None-Match 或 If-Unmodified-Since）设置的。
    PreconditionFailed = 412,
    //
    // 摘要:
    //     Equivalent to HTTP status 413.System.Net.HttpStatusCode.RequestEntityTooLarge
    //     indicates that the request is too large for the server to process.
    RequestEntityTooLarge = 413,
    //
    // 摘要:
    //     Equivalent to HTTP status 414.System.Net.HttpStatusCode.RequestUriTooLong
    //     indicates that the URI is too long.
    RequestUriTooLong = 414,
    //
    // 摘要:
    //     Equivalent to HTTP status 415.System.Net.HttpStatusCode.UnsupportedMediaType
    //     indicates that the request is an unsupported type.
    UnsupportedMediaType = 415,
    //
    // 摘要:
    //     Equivalent to HTTP status 416.System.Net.HttpStatusCode.RequestedRangeNotSatisfiable
    //     indicates that the range of data requested from the resource cannot be returned,
    //     either because the beginning of the range is before the beginning of the
    //     resource, or the end of the range is after the end of the resource.
    RequestedRangeNotSatisfiable = 416,
    //
    // 摘要:
    //     Equivalent to HTTP status 417.System.Net.HttpStatusCode.ExpectationFailed
    //     indicates that an expectation given in an Expect header could not be met
    //     by the server.
    ExpectationFailed = 417,
    //
    // 摘要:
    //     Equivalent to HTTP status 500.System.Net.HttpStatusCode.InternalServerError
    //     indicates that a generic error has occurred on the server.
    InternalServerError = 500,
    //
    // 摘要:
    //     Equivalent to HTTP status 501.System.Net.HttpStatusCode.NotImplemented indicates
    //     that the server does not support the requested function.
    NotImplemented = 501,
    //
    // 摘要:
    //     Equivalent to HTTP status 502.System.Net.HttpStatusCode.BadGateway indicates
    //     that an intermediate proxy server received a bad response from another proxy
    //     or the origin server.
    BadGateway = 502,
    //
    // 摘要:
    //     Equivalent to HTTP status 503.System.Net.HttpStatusCode.ServiceUnavailable
    //     indicates that the server is temporarily unavailable, usually due to high
    //     load or maintenance.
    ServiceUnavailable = 503,
    //
    // 摘要:
    //     Equivalent to HTTP status 504.System.Net.HttpStatusCode.GatewayTimeout indicates
    //     that an intermediate proxy server timed out while waiting for a response
    //     from another proxy or the origin server.
    GatewayTimeout = 504,
    //
    // 摘要:
    //     Equivalent to HTTP status 505.System.Net.HttpStatusCode.HttpVersionNotSupported
    //     indicates that the requested HTTP version is not supported by the server.
    HttpVersionNotSupported = 505
}CEHttpStatusCode;

#define kMinTimeOut 30
#define kTimeOut kMinTimeOut

// todo
//#define kTimeOut ([[MyUtilites valueFromLocalForKey:kHttpTimeOut] intValue] < kMinTimeOut ? kMinTimeOut : [[MyUtilites valueFromLocalForKey:kHttpTimeOut] intValue])

#define HTTP_GET @"GET"
#define HTTP_POST @"POST"
#define HTTP_PUT @"PUT"
#define HTTP_DELETE @"DELETE"

#if NS_BLOCKS_AVAILABLE
typedef void (^HTTPCompletionBlock)(NSString *response);
typedef void (^HTTPFailedBlock)(NSError *error);
#endif

#import <Foundation/Foundation.h>

@interface Http : NSObject

// HTTP GET
+ (NSString *)get:(NSString *)url error:(NSError **)error;

#if NS_BLOCKS_AVAILABLE
+ (void)getAsync:(NSString *)url completion:(HTTPCompletionBlock)completion failed:(HTTPFailedBlock)failed;
#endif
+ (void)getAsync:(NSString *)url completion:(SEL)completion failed:(SEL)failed withObject:(id)obj;

// HTTP POST
+ (NSString *)post:(NSString *)url params:(NSDictionary *)params error:(NSError **)error;
#if NS_BLOCKS_AVAILABLE
+ (void)postAsync:(NSString *)url params:(NSDictionary *)params completion:(HTTPCompletionBlock)completion failed:(HTTPFailedBlock)failed;
#endif

// HTTP PUT
+ (NSString *)put:(NSString *)url params:(NSDictionary *)params error:(NSError **)error;
#if NS_BLOCKS_AVAILABLE
+ (void)putAsync:(NSString *)url params:(NSDictionary *)params completion:(HTTPCompletionBlock)completion failed:(HTTPFailedBlock)failed;
#endif

// HTTP DOWNLOAD
+ (BOOL)download:(NSString *)url destination:(NSString *)path;
+ (void)download:(NSString *)url destination:(NSString *)path complete:(HTTPCompletionBlock)complete failed:(HTTPFailedBlock)failed;

+ (NSDictionary*) requestTo:(NSString*)urlString byDelegate:(id) delegate withSendData:(NSDictionary*) dataOfSend andMethod:(NSString*) method  andHeads:(NSDictionary*) headOfSend usingConnection:(NSURLConnection**) connection;

+ (NSDictionary*) post:(NSString*)urlString withFile:(NSData*) fileData andFileName:(NSString*)fileName andHeads:(NSDictionary*) headOfSend usingConnection:(NSURLConnection**) connection;

+ (void)loadAsync:(NSString *)url method:(NSString *)method headers:(NSDictionary *)headers params:(NSDictionary *)params completion:(void (^)(NSString *))completion failed:(void (^)(NSError *))failed;
@end
