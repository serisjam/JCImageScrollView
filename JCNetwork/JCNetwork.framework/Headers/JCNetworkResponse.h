//
//  JCNetworkResponse.h
//  JCNetworkNew
//
//  Created by Jam on 13-6-23.
//  Copyright (c) 2013年 Jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCNetworkResponse : NSObject

@property (nonatomic, assign) JCRequestID requestID;            //请求ID
@property (nonatomic, assign) JCNetworkResponseStatus status;   //请求响应状态
@property (nonatomic, assign) CGFloat progress;                 //上传下载进度
@property (nonatomic, strong) NSError *error;                   //请求响应错误原因
@property (nonatomic, strong) id content;                       //请求响应返回json内容

@end