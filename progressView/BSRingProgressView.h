//
//  BSRingProgressView1.h
//  圆圈进度条
//
//  Created by cbs on 16/9/22.
//  Copyright © 2016年 CBS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_CenterColor        ([UIColor whiteColor])
#define DEFAULT_RingColor          ([UIColor lightGrayColor])
#define DEFAULT_TintRingColor      ([UIColor grayColor])
#define DEFAULT_TextColor          ([UIColor brownColor])

#define DEFAULT_TextFond           ([UIFont systemFontOfSize:24])
#define DEFAULT_String(progress)   ([NSString stringWithFormat:@"%.2lf%%",progress * 100])

#define DEFAULT_LineWidth          20.0

@protocol BSRingProgressViewDelegate <NSObject>

@optional

- (NSString *)centerStringWithProgress:(CGFloat)progress;

@end

@interface BSRingProgressView : UIView

//中心颜色
@property (strong, nonatomic)UIColor *centerColor;
//字体颜色
@property (strong, nonatomic)UIColor *textColor;
//圆环色(选中)
@property (strong, nonatomic)UIColor *ringColor;
//(非选中)
@property (strong, nonatomic)UIColor *tintRingColor;


//百分比数值（0-1）
@property (assign, nonatomic)float progress;

//圆环宽度
@property (assign, nonatomic)float lineWidth;
//字体
@property (strong, nonatomic)UIFont *font;

@property (weak, nonatomic)id<BSRingProgressViewDelegate>delegate;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
