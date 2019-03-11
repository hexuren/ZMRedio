//
//  APPRequest.m
//  lantu
//
//  Created by Eric Wang on 15/7/5.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "APPRequest.h"
#import "SuccessResponseModel.h"
#import "AuthorManager.h"

#define kErrorCdoeResponseKey @"error_code"
#define kErrorMessageKey @"message"

@implementation APPRequest

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                   modelClass:(Class)modelClass
                      keyPath:(NSString *)keyPath
                      success:(CommonSuccessResponse)success
                      failure:(CommonErrorResponse)failure{
    return [[APPSessionManager sharedManager] GET:URLString
                                       parameters:parameters
                                         progress:nil
                                       modelClass:modelClass
                                          keyPath:keyPath
                                          success:success
                                          failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSInteger statusCode = [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];

        if (statusCode == ErrorCodeTypeLoginInvalid){
            [AuthorManager postLoginStatusInvalidNotification];
            FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:error.code errorMessage:@"登录已经失效，请重新登录"];
            failure(task, failureResponse);
        }
        else{
            NSData *errorData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (errorData) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                NSInteger errorcCode = [[json objectForKey:kErrorCdoeResponseKey] integerValue];
                NSString *message = [json objectForKey:kErrorMessageKey];
                FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:errorcCode errorMessage:message];
                failure(task, failureResponse);
            }
            else{
                FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:error.code errorMessage:error.userInfo[NSLocalizedDescriptionKey]];
                failure(task, failureResponse);
            }
        }
    }];
}

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                     progress:(CommonDownloadProgressResponse) downloadProgress
                   modelClass:(Class)modelClass
                      keyPath:(NSString *)keyPath
                      success:(CommonSuccessResponse)success
                      failure:(CommonErrorResponse)failure{
    return [[APPSessionManager sharedManager] GET:URLString
                                       parameters:parameters
                                         progress:downloadProgress
                                       modelClass:modelClass
                                          keyPath:keyPath
                                          success:success
                                          failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              NSInteger statusCode = [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
                                              
                                              if (statusCode == ErrorCodeTypeLoginInvalid){
                                                  [AuthorManager postLoginStatusInvalidNotification];
                                                  FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:error.code errorMessage:@"登录已经失效，请重新登录"];
                                                  failure(task, failureResponse);
                                              }
                                              else{
                                                  NSData *errorData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                                                  if (errorData) {
                                                      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                                                      NSInteger errorcCode = [[json objectForKey:kErrorCdoeResponseKey] integerValue];
                                                      NSString *message = [json objectForKey:kErrorMessageKey];
                                                      FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:errorcCode errorMessage:message];
                                                      failure(task, failureResponse);
                                                  }
                                                  else{
                                                      FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:error.code errorMessage:error.userInfo[NSLocalizedDescriptionKey]];
                                                      failure(task, failureResponse);
                                                  }
                                              }
                                          }];
    
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                    modelClass:(Class)modelClass
                       keyPath:(NSString *)keyPath
                       success:(CommonSuccessResponse)success
                       failure:(CommonErrorResponse)failure{
    return [[APPSessionManager sharedManager] POST:URLString
                                        parameters:parameters
                                          progress:nil
                                        modelClass:modelClass
                                           keyPath:keyPath
                                           success:success
                                           failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSInteger statusCode = [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
        if (statusCode == ErrorCodeTypeLoginInvalid){
            [AuthorManager postLoginStatusInvalidNotification];
            FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:error.code errorMessage:@"登录已经失效，请重新登录"];
            failure(task, failureResponse);
        }
        else{
            NSData *errorData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (errorData) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                NSInteger errorcCode = [[json objectForKey:kErrorCdoeResponseKey] integerValue];
                NSString *message = [json objectForKey:kErrorMessageKey];
                FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:errorcCode errorMessage:message];
                failure(task, failureResponse);
            }
            else{
                FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:error.code errorMessage:error.userInfo[NSLocalizedDescriptionKey]];
                failure(task, failureResponse);
            }
            
        }
    }];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                      progress:(CommonUploadProgressResponse)uploadProgress
                    modelClass:(Class)modelClass
                       keyPath:(NSString *)keyPath
                       success:(CommonSuccessResponse)success
                       failure:(CommonErrorResponse)failure{
    return [[APPSessionManager sharedManager] POST:URLString
                                        parameters:parameters
                                          progress:uploadProgress
                                        modelClass:modelClass
                                           keyPath:keyPath
                                           success:success
                                           failure:^(NSURLSessionDataTask *task, NSError *error){
                                               
                                               NSInteger statusCode = [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
                                               if (statusCode == ErrorCodeTypeLoginInvalid){
                                                   [AuthorManager postLoginStatusInvalidNotification];
                                                   FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:error.code errorMessage:@"登录已经失效，请重新登录"];
                                                   failure(task, failureResponse);
                                               }
                                               else{
                                                   NSData *errorData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                                                   if (errorData) {
                                                       NSDictionary *json = [NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                                                       NSInteger errorcCode = [[json objectForKey:kErrorCdoeResponseKey] integerValue];
                                                       NSString *message = [json objectForKey:kErrorMessageKey];
                                                       FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:errorcCode errorMessage:message];
                                                       failure(task, failureResponse);
                                                   }
                                                   else{
                                                       FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:error.code errorMessage:error.userInfo[NSLocalizedDescriptionKey]];
                                                       failure(task, failureResponse);
                                                   }
                                                   
                                               }
                                               
                                           }];
    
}

+ (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                      modelClass:(Class)modelClass
                         keyPath:(NSString *)keyPath
                         success:(CommonSuccessResponse)success
                         failure:(CommonErrorResponse)failure{
    return [[APPSessionManager sharedManager] DELETE:URLString
                                          parameters:parameters
                                          modelClass:modelClass
                                             keyPath:keyPath
                                             success:success
                                             failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                 NSInteger statusCode = [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
                                                 if (statusCode == ErrorCodeTypeLoginInvalid){
                                                     [AuthorManager postLoginStatusInvalidNotification];
                                                     FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:error.code errorMessage:@"登录已经失效，请重新登录"];
                                                     failure(task, failureResponse);
                                                 }
                                                 else{
                                                     NSData *errorData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                                                     if (errorData) {
                                                         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                                                         NSInteger errorcCode = [[json objectForKey:kErrorCdoeResponseKey] integerValue];
                                                         NSString *message = [json objectForKey:kErrorMessageKey];
                                                         FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:errorcCode errorMessage:message];
                                                         failure(task, failureResponse);
                                                     }
                                                     else{
                                                         FailureResponseModel *failureResponse = [[FailureResponseModel alloc] initWithErrorCode:error.code errorMessage:error.userInfo[NSLocalizedDescriptionKey]];
                                                         failure(task, failureResponse);
                                                     }
                                                     
                                                 }
    }];
}

@end
