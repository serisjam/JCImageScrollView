//
//  LImageView.m
//
//  Created by Jam on 10/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "JImageView.h"
#import "UIImage+UIImageScale.h"

@implementation JImageView

@synthesize loadingView = _loadingView;
@synthesize imageView = _imageView;
@synthesize isLoading = _isLoading;
@synthesize failImage = _failImage;
@synthesize loadFinish = _loadFinish;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _loadingView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.frame.size.width - 20)/2, 
                                                                                 (self.frame.size.height -20)/2, 
                                                                                 20, 20)];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _isLoading = NO;
        _loadFinish = NO;
        [self addSubview:_imageView];
        [_imageView addSubview:_loadingView];
    }
    return self;
}

- (void)startRequestWithURL:(NSURL *)url
{
    if (self.loadFinish) {
        return;
    }
    
    if (self.imageView.image == self.failImage || !_isLoading) {
        UIImage *image = [[JCRequestProxy sharedInstance] getImageIfExisted:url];
        
        if (image) {
            [_imageView setImage:image];
            _isLoading = NO;
            return;
        }
        [self startLoadingAnimation];
        [[JCRequestProxy sharedInstance] loadImageWithURL:url size:self.bounds.size completionHandler:^(UIImage *fetchImage, BOOL isCache){
            [_imageView setImage:fetchImage];
            [self stopLoadingAnimation];
        }];
    }
}

- (void)startLoadingAnimation
{
    [_loadingView startAnimating];
    _isLoading = YES;
}

- (void)stopLoadingAnimation
{
    [_loadingView stopAnimating];
    _isLoading = NO;
}

// 以下两个跟图片设置要求有关，不用看
- (CGRect)calculateBoundsWithImage:(UIImage *)image
{
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat imageWidth = image.size.width;
    CGFloat boundWidth = (height * image.size.width)/image.size.height;
    CGFloat boundHeight = (width * image.size.height)/image.size.width;

    if (imageWidth/imageHeight > width/height) {
        return CGRectMake(0, (height - boundHeight)/2, width, boundHeight);
    } else if (imageWidth/imageHeight < width/height) {
        return CGRectMake((width - boundWidth)/2, 0, boundWidth, height);
    } else {
        return CGRectMake(0, 0, width, height);
    }
}

- (void)setImage:(UIImage *)image toImageView:(UIImageView *)imageView
{
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat imageWidth = image.size.width;
    CGFloat boundWidth = (height * image.size.width)/image.size.height;
    if (image == _failImage) {
        [imageView setImage:image];
        return;
    }
    //CGFloat boundHeight = (width * image.size.height)/image.size.width;
    if (imageWidth/imageHeight > width/height) {
        CGFloat subImageWidth = imageHeight * width/height;
        UIImage *subImage = [image getSubImage:CGRectMake((imageWidth - subImageWidth)/2, 0, subImageWidth, imageHeight)];
        [imageView setImage:subImage];
    } else if (imageWidth/imageHeight < width/height && imageWidth/imageHeight > 1) {
        CGFloat subImageHeight = imageWidth * height/width;
        UIImage *subImage = [image getSubImage:CGRectMake(0, (imageHeight - subImageHeight)/2, imageWidth, subImageHeight)];
        [imageView setImage:subImage];
    } else if (imageWidth/imageHeight <= 1) {
        [imageView setBounds:CGRectMake((width - boundWidth)/2, 0, boundWidth, height)];
        [imageView setImage:image];
    } else {
        [imageView setImage:image];
    }
}

- (void)resetStatus
{
    [self.imageView setImage:nil];
    self.loadFinish = NO;
}

@end
