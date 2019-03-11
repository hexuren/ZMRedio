//
//  APPRequest.h
//  lantu
//
//  Created by Eric Wang on 15/7/5.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APPSessionManager.h"
#import "CommonResponseBlock.h"
#import "FailureResponseModel.h"

@interface APPRequest : NSObject

/**
 *  Creates and runs an `NSURLSessionDataTask` with a `GET` request.
 *
 *  @param URLString  The URL string used to create the request URL.
 *  @param parameters The parameters to be encoded according to the client request serializer.
 *  @param modelClass Your MTLModel subclass that also conforms to MTLJSONSerializing. Can be NIL but if so will only return a JSON Dictionary for the given keyPath.
 *  @param keyPath    The root keyPath of the model object.  Can be nil.
 *  @param success    A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 *  @param failure    A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 
 *
 *  @return The created and resumed NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                   modelClass:(Class)modelClass
                      keyPath:(NSString *)keyPath
                      success:(CommonSuccessResponse)success
                      failure:(CommonErrorResponse)failure;

/**
 Creates and runs an `NSURLSessionDataTask` with a `GET` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param progress A block object to be executed when the download progress is updated. Note this block is called on the session queue, not the main queue.
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 
 @see -dataTaskWithRequest:uploadProgress:downloadProgress:completionHandler:
 */
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                     progress:(CommonDownloadProgressResponse) downloadProgress
                   modelClass:(Class)modelClass
                      keyPath:(NSString *)keyPath
                      success:(CommonSuccessResponse)success
                      failure:(CommonErrorResponse)failure;

/**
 *  Creates and runs an `NSURLSessionDataTask` with a `POST` request.
 *
 *  @param URLString  The URL string used to create the request URL.
 *  @param parameters The parameters to be encoded according to the client request serializer.
 *  @param modelClass Your MTLModel subclass that also conforms to MTLJSONSerializing. Can be NIL but if so will only return a JSON Dictionary for the given keyPath.
 *  @param keyPath    The root keyPath of the model object.  Can be nil.
 *  @param success    A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 *  @param failure    A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 
 *
 *  @return The created and resumed NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                    modelClass:(Class)modelClass
                       keyPath:(NSString *)keyPath
                       success:(CommonSuccessResponse)success
                       failure:(CommonErrorResponse)failure;

/**
 Creates and runs an `NSURLSessionDataTask` with a `POST` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param progress A block object to be executed when the upload progress is updated. Note this block is called on the session queue, not the main queue.
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 
 @see -dataTaskWithRequest:uploadProgress:downloadProgress:completionHandler:
 */
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                      progress:(CommonUploadProgressResponse)uploadProgress
                    modelClass:(Class)modelClass
                       keyPath:(NSString *)keyPath
                       success:(CommonSuccessResponse)success
                       failure:(CommonErrorResponse)failure;

/**
 *  Creates and runs an `NSURLSessionDataTask` with a `DELETE` request.
 *
 *  @param URLString  The URL string used to create the request URL.
 *  @param parameters The parameters to be encoded according to the client request serializer.
 *  @param modelClass Your MTLModel subclass that also conforms to MTLJSONSerializing. Can be NIL but if so will only return a JSON Dictionary for the given keyPath.
 *  @param keyPath    The root keyPath of the model object.  Can be nil.
 *  @param success    A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 *  @param failure    A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 
 *
 *  @return The created and resumed NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                      modelClass:(Class)modelClass
                         keyPath:(NSString *)keyPath
                         success:(CommonSuccessResponse)success
                         failure:(CommonErrorResponse)failure;

@end
