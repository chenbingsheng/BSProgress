//
//  ViewController.m
//  圆圈进度条
//
//  Created by cbs on 16/9/21.
//  Copyright © 2016年 CBS. All rights reserved.
//

#import "ViewController.h"
#import "BSCircleProgressView.h"
#import "BSRingProgressView.h"

@interface ViewController ()

@property(nonatomic, strong)BSCircleProgressView *progressView;
@property(nonatomic, strong)BSRingProgressView *progressView1;
@property(nonatomic, strong)dispatch_source_t timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.progressView1];
    
    self.progressView.progress = 0.0;
    
//    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
//    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(_timer, ^{
//        self.progressView.progress += 0.01;
//    });
//    dispatch_resume(_timer);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
    self.progressView1.progress = 0.5;
    
}
- (void)tap{
    [self.progressView setProgress:arc4random() %101/100.0 animated:YES];
    [self.progressView1 setProgress:arc4random() %101/100.0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BSCircleProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[BSCircleProgressView alloc] initWithFrame:CGRectMake(87.5, 80, 200, 250)];
        _progressView.userInteractionEnabled = YES;
    }
    return _progressView;
}
- (BSRingProgressView *)progressView1{
    if (_progressView1 == nil) {
        _progressView1 = [[BSRingProgressView alloc] initWithFrame:CGRectMake(87.5, 400, 200, 250)];
        _progressView1.userInteractionEnabled = YES;
        _progressView1.tintRingColor = [UIColor blueColor];
    }
    return _progressView1;
}
@end
