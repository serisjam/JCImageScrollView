//
//  JCScrollView.h
//  JCFindHouse
//
//  Created by Jam on 14-4-21.
//  Copyright (c) 2014年 jiamiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCImageScrollView;

@protocol JCImageScrollViewDelegate  <NSObject>

@optional
- (void)didClickScrollView:(NSInteger)pageIndex;

@end

@interface JCImageScrollView : UIView

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) UIImageView *backgroundView;
@property (nonatomic, strong) UIImage *failImage;
@property (nonatomic, assign) NSTimeInterval autoDuration;
@property (nonatomic, assign) id<JCImageScrollViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;
- (void)loadImageURL:(NSArray *)urls;

//重新设置信息
- (void)resetData;

@end