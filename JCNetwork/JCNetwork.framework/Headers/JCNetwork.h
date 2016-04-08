//
//  JCNetwork.h
//  JCNetwork
//
//  Created by Jam on 16/1/5.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include(<JCNetwork/JCNetwork.h>)
FOUNDATION_EXPORT double JCNetworkVersionNumber;
FOUNDATION_EXPORT const unsigned char JCNetworkVersionString[];
#import <JCNetwork/JCNetworkDefine.h>
#import <JCNetwork/JCNetworkResponse.h>
#import <JCNetwork/JCRequestProxy.h>
#import <JCNetwork/JCRequestObj.h>
#import <JCNetwork/JCResponedObj.h>
#else
#import "JCNetworkDefine.h"
#import "JCNetworkResponse.h"
#import "JCRequestProxy.h"
#import "JCRequestObj.h"
#import "JCResponedObj.h"
#endif



