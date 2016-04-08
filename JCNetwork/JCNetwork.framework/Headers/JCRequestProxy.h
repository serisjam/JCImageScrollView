//
//  JCRequestProxy.h
//  JCNetwork
//
//  Created by Jam on 16/1/5.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCRequestObj.h"

typedef void(^JCNetworkResponseBlock)(JCNetworkResponse *response);
typedef void(^JCNetworkImageFetch)(UIImage *fetchImage, BOOL isCache);

@interface JCRequestProxy : NSObject

+ (id)sharedInstance;
- (id)init;

// Get Request
- (JCRequestID)httpGetWithRequest:(JCRequestObj *)requestObj entityClass:(NSString *)entityName withCompleteBlock:(JCNetworkResponseBlock)responedBlock;

//Post Request
- (JCRequestID)httpPostWithRequest:(JCRequestObj *)requestObj entityClass:(NSString *)entityName withCompleteBlock:(JCNetworkResponseBlock)responedBlock;

//upload
- (JCRequestID)upLoadFileWithRequest:(JCRequestObj *)requestObj files:(NSDictionary *)files entityClass:(NSString *)entityName withUpLoadBlock:(JCNetworkResponseBlock)responedBlock;

//download
- (JCRequestID)downLoadFileFrom:(NSURL *)remoteURL toFile:(NSString*)filePath withDownLoadBlock:(JCNetworkResponseBlock)responedBlock;

//Image请求
- (void)autoLoadImageWithURL:(NSURL *)imageURL placeHolderImage:(UIImage*)image toImageView:(UIImageView *)imageView;
- (void)loadImageWithURL:(NSURL *)imageURL size:(CGSize)size completionHandler:(JCNetworkImageFetch)imageFetchBlock;
- (UIImage *)getImageIfExisted:(NSURL *)imageURL;

// 根据请求ID取消一个请求
- (void)cancelRequestID:(JCRequestID)requestID;

@end
