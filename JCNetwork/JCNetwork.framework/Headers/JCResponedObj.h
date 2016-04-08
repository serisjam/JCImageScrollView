//
//  JCResponedObject.h
//  JCNetwork
//
//  Created by Jam on 16/1/5.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCResponedObj : NSObject

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

+ (NSDictionary *)modelCustomPropertyMapper;
+ (NSDictionary *)modelContainerPropertyGenericClass;

- (id)modelToJSONObject;


@end
