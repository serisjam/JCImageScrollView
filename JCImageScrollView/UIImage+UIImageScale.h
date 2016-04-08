//
//  UIImage+UIImageScale.h
//  JC139house
//
//  Created by Jam on 13-5-6.
//  Copyright (c) 2013年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageScale)

- (UIImage*)getSubImage:(CGRect)rect;
- (UIImage*)scaleToSize:(CGSize)size;

@end
