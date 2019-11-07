//
//  CYNetworkCommand.m
//  CYKit
//
//  Created by 成焱 on 2019/9/17.
//

#import "CYNetworkCommand.h"
#import "AFNetworking.h"
#import "CYKitDefines.h"
#import "ReactiveObjC.h"

NSString *k_CY_URL = @"url";
NSString *k_CY_PARAMS = @"params";

@interface CYNetworkCommand ()

@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManger;

@end

@implementation CYNetworkCommand

- (id) init
{
    self = [super init];
    if (self) {
        [self subscribeCommendSignals];
    }
    return self;
}

- (RACCommand *)getCommand
{
    if (!_getCommand) {
        @weakify(self);
        _getCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            NSString *url = [input objectForKey:k_CY_URL];
            NSDictionary *parasm = [input objectForKey:k_CY_PARAMS];
            //供子类覆盖
            if (!url) {
                url = [self url];
            }
            if (!parasm) {
                parasm = [self params];
            }
            
            NSAssert(url, @"url不能为空");
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [self getUrl:url params:parasm successBlock:^(BOOL success, id obj) {
                    [subscriber sendNext:obj];
                    [subscriber sendCompleted];
                } failure:^(NSError *error, id obj) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _getCommand;
}

- (RACCommand *) postCommand
{
    if (!_postCommand) {
        @weakify(self);
        _postCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            NSString *url = [input objectForKey:k_CY_URL];
            NSDictionary *parasm = [input objectForKey:k_CY_PARAMS];
            //供子类覆盖
            if (!url) {
                url = [self url];
            }
            if (!parasm) {
                parasm = [self params];
            }
            NSAssert(url, @"url不能为空");
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [self postUrl:url params:parasm successBlock:^(BOOL success, id obj) {
                    [subscriber sendNext:obj];
                    [subscriber sendCompleted];
                } failure:^(NSError *error, id obj) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _postCommand;
}


- (AFHTTPSessionManager *)httpSessionManger
{
    if (!_httpSessionManger) {
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        _httpSessionManger = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:nil];
        _httpSessionManger.requestSerializer = [AFJSONRequestSerializer  serializer];
        _httpSessionManger.requestSerializer.timeoutInterval = 10;
        _httpSessionManger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript",@"text/html",@"image/jpeg",@"image/png", nil];
        [_httpSessionManger setSecurityPolicy:securityPolicy];
        
        
    }
    return _httpSessionManger;
}

- (void) getUrl:(NSString *)url params:(NSDictionary *)params successBlock:(CYSuccessBlock)success failure:(CYFailureBlock)failure
{
    [self.httpSessionManger GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success?success(YES,responseObject):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure?failure(error,nil):nil;
    }];
}

- (void) postUrl:(NSString *)url params:(NSDictionary *)params successBlock:(CYSuccessBlock)success failure:(CYFailureBlock)failure
{
    [self.httpSessionManger POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success?success(YES,responseObject):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure?failure(error,nil):nil;
    }];
}

- (void) subscribeCommendSignals
{
    //订阅外层信号，执行相应代码,外层信号传递的是一个signal
    @weakify(self);
    [self.getCommand.executionSignals subscribeNext:^(RACSignal *  innerSignal) {
        @strongify(self);
        [innerSignal subscribeNext:^(id  _Nullable x) {
            self.data = x;
            self.status = CYNetworkStatus_End;
        }];
        
        self.error = nil;
        self.status = CYNetworkStatus_Begin;
    }];
    
    [self.getCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        self.error = x;
        self.data = nil;
        self.status = CYNetworkStatus_Error;
    }];
    
    [self.postCommand.executionSignals subscribeNext:^(RACSignal *   innerSignal) {
        @strongify(self);
        [innerSignal subscribeNext:^(id  _Nullable x) {
            self.data = x;
            self.status = CYNetworkStatus_End;
        }];
        
        self.error = nil;
        self.status = CYNetworkStatus_Begin;
    }];
    
    [self.postCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self);
        self.error = x;
        self.data = nil;
        self.status = CYNetworkStatus_Error;
    }];
}
@end
