//
//  CommonResponseBlock.h
//  lantu
//
//  Created by Eric Wang on 15/7/5.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#ifndef zfbuser_CommonResponseBlock_h
#define zfbuser_CommonResponseBlock_h

@class FailureResponseModel;

typedef void(^CommonSuccessResponse)(NSURLSessionDataTask *dataTask, id response);
typedef void(^CommonArrayResponse)(NSURLSessionDataTask *dataTask, NSArray *arrayResponse);
typedef void(^CommonErrorResponse)(NSURLSessionDataTask *dataTask, FailureResponseModel *failureResponse);
typedef void(^CommonUploadProgressResponse)(NSProgress *uploadProgress);
typedef void(^FloatValueUploadProgressResponse)(double uploadProgress);
typedef void(^CommonDownloadProgressResponse)(NSProgress *downloadProgress);
#endif
