//
//  JCScrollView.m
//  JCFindHouse
//
//  Created by Jam on 14-4-21.
//  Copyright (c) 2014年 jiamiao. All rights reserved.
//

#import "JCImageScrollView.h"
#import "JImageView.h"
#import "UIView+JCView.h"
#import "NSArray+ExtraMethod.h"
#import "NSTimer+Addition.h"

@interface JCImageScrollView () <JCImageScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, strong) NSArray *imagePaths;
@property (nonatomic , strong) NSTimer *animationTimer;
@property (nonatomic, strong) UIPageControl *pageControl;

//使用三个ImageView实现循环
@property (nonatomic, strong) JImageView *leftImageView;
@property (nonatomic, strong) JImageView *centerImageView;
@property (nonatomic, strong) JImageView *rightImageView;

@end

@implementation JCImageScrollView

@synthesize scrollView = _scrollView;
@synthesize currentPageIndex = _currentPageIndex;
@synthesize failImage = _failImage;
@synthesize imagePaths = _imagePaths;
@synthesize leftImageView = _leftImageView;
@synthesize rightImageView = _rightImageView;
@synthesize centerImageView = _centerImageView;
@synthesize animationTimer = _animationTimer;
@synthesize autoDuration = _autoDuration;
@synthesize backgroundView = _backgroundView;
@synthesize pageControl = _pageControl;

- (UIImage *)failImage
{
    if (_failImage == nil) {
        _failImage = [UIImage imageNamed:@"adv_default.png"];
    }
    return _failImage;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _currentPageIndex = 0;
        _useParallaxEffect = YES;
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.pageControl = [[UIPageControl alloc] init];
        
        _scrollView.autoresizingMask = 0xFF;
        _scrollView.contentMode = UIViewContentModeCenter;
        _scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        
        [self.pageControl sizeToFit];
        [self.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithWhite:220.0/255.0 alpha:1.0]];
        [self.pageControl setCenter:CGPointMake(frame.size.width/2.0, frame.size.height - 15.0)];
        [self.pageControl setHidden:YES];
        
        [self createContentViews];
        [self addSubview:self.backgroundView];
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)createContentViews
{
    _leftImageView = [[JImageView alloc] initWithFrame:self.bounds];
    _centerImageView = [[JImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame), 0.0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
    _rightImageView = [[JImageView alloc] initWithFrame:CGRectMake(2 * CGRectGetWidth(self.scrollView.frame), 0.0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
    
    [_centerImageView addTarget:self action:@selector(onClickImageView) forControlEvents:UIControlEventTouchUpInside];
    
    [_leftImageView setFailImage:self.failImage];
    [_centerImageView setFailImage:self.failImage];
    [_rightImageView setFailImage:self.failImage];
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_centerImageView];
    [_scrollView addSubview:_rightImageView];
}

- (void)configContentViews
{
    [_leftImageView resetStatus];
    [_rightImageView resetStatus];
    [_centerImageView resetStatus];
    
    [_leftImageView startRequestWithURL:[self.imagePaths objectSafetyAtIndex:[self checkNextPageIndex:_currentPageIndex-1]]];
    [_centerImageView startRequestWithURL:[self.imagePaths objectSafetyAtIndex:[self checkNextPageIndex:_currentPageIndex]]];
    [_rightImageView startRequestWithURL:[self.imagePaths objectSafetyAtIndex:[self checkNextPageIndex:_currentPageIndex+1]]];
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_animationTimer resumeTimerAfterTimeInterval:_autoDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self checkNextPageIndex:self.currentPageIndex + 1];
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self checkNextPageIndex:self.currentPageIndex - 1];
        [self configContentViews];
    }
    
    self.pageControl.currentPage = self.currentPageIndex;

    if (_useParallaxEffect) {
        _leftImageView.imageView.frame = CGRectMake(scrollView.contentOffset.x, 0, CGRectGetWidth(self.scrollView.frame) - scrollView.contentOffset.x, CGRectGetHeight(self.scrollView.frame));
        _centerImageView.imageView.frame = CGRectMake(0, 0, scrollView.contentOffset.x, CGRectGetHeight(self.scrollView.frame));
        _rightImageView.imageView.frame = CGRectMake(scrollView.contentOffset.x-CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame) - scrollView.contentOffset.x, CGRectGetHeight(self.scrollView.frame));
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark public method

- (void)loadImageURL:(NSArray *)urls
{
    _imagePaths = urls;
    if ([_imagePaths count] > 1) {
        _scrollView.scrollEnabled = YES;
        [self.pageControl setHidden:NO];
        self.pageControl.numberOfPages = [_imagePaths count];
        _animationTimer = [NSTimer scheduledTimerWithTimeInterval:_autoDuration target:self selector:@selector(animationTimerDidFired:) userInfo:nil repeats:YES];
        [self performSelector:@selector(beginTime) withObject:nil afterDelay:_autoDuration];
    } else {
        _scrollView.scrollEnabled = NO;
        [self.pageControl setHidden:YES];
        self.pageControl.numberOfPages = 0;
        [_animationTimer invalidate];
    }
    [self configContentViews];
}

- (void)resetData
{
    [_animationTimer invalidate];
    _animationTimer = nil;
    _currentPageIndex = 0;
}

#pragma mark self method

- (NSInteger)checkNextPageIndex:(NSInteger)nextPage
{
    if(nextPage == -1) {
        return [_imagePaths count] - 1;
    } else if (nextPage == [_imagePaths count]) {
        return 0;
    } else {
        return nextPage;
    }
}

- (void)beginTime
{
    [_animationTimer resumeTimer];
}

#pragma mark - EventHandler

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)onClickImageView
{
    if ([self.delegate respondsToSelector:@selector(didClickScrollView:)]) {
        [self.delegate didClickScrollView:self.currentPageIndex];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
