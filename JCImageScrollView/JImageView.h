//
//  JImageView.h
//  JCFindHouse
//
//  Created by Jam on 13-8-31.
//  Copyright (c) 2013年 jiamiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JCNetwork/JCRequestProxy.h>

@interface JImageView : UIControl

@property (nonatomic, retain) UIActivityIndicatorView *loadingView;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic) BOOL isLoading;
@property (nonatomic, assign) UIImage *failImage;
@property (nonatomic, assign) BOOL loadFinish;

- (void)startRequestWithURL:(NSURL *)url;
- (void)startLoadingAnimation;
- (void)stopLoadingAnimation;

- (void)resetStatus; //优化重用性

@end
