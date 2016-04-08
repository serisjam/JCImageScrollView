//
//  JCNetworkDefine.h
//  JCNetwork
//
//  Created by Jam on 13-6-23.
//  Copyright (c) 2013年 Jam. All rights reserved.
//

#ifndef JCNetwork_JCNetworkDefine_h
#define JCNetwork_JCNetworkDefine_h

//定义JCRequestID类型用于记录每次请求的ID
//typedef unsigned int JCRequestID;
typedef NSInteger JCRequestID;

//错误的请求ID 对应的serviceID不存在或者是请求的methodName不存在
#define JC_ERROR_REQUESTID 0

//请求响应的状态
typedef NS_ENUM (NSInteger, JCNetworkResponseStatus) {
    JCNetworkResponseStatusSuccess,
    JCNetworkResponseStatusDowning,
    JCNetworkResponseStatusUploading,
    JCNetworkResponseCancelled,
    JCNetworkResponseStatusFailed
};

//请求发送格式

typedef NS_ENUM (NSInteger, JCNetworkParameterType) {
    JCNetworkParameterTypeURL = 0,
    JCNetworkParameterTypeJSON = 1,
    JCNetworkParameterTypelist = 2
};

#endif
