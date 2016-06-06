//
//  ViewController.m
//  JCImageScrollViewDemo
//
//  Created by Jam on 16/4/8.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "ViewController.h"
#import "JCImageScrollView.h"

@interface ViewController () <JCImageScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    JCImageScrollView *imageScrollView = [[JCImageScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0f, 120.0f)];
    [imageScrollView setUseParallaxEffect:YES];
    [self.view addSubview:imageScrollView];
    
    imageScrollView.autoDuration = 3.0f;
    [imageScrollView setDelegate:self];
    
    NSURL *imageURL1 = [NSURL URLWithString:@"http://www.uc129.com/uploads/allimg/150428/1-15042Q04030.jpg"];
    NSURL *imageURL2 = [NSURL URLWithString:@"http://www.people.com.cn/h/pic/20111031/99/15317457967897249011.jpg"];
    NSURL *imageURL3 = [NSURL URLWithString:@"http://school.indexedu.com/data/uploads/picture/westminster_1/20140117144515.jpg"];
    
    [imageScrollView loadImageURL:@[imageURL1, imageURL2, imageURL3]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark JCImageScrollViewDelegate

- (void)didClickScrollView:(NSInteger)pageIndex {
    NSLog(@"on click index:%ld", pageIndex);
}

@end
