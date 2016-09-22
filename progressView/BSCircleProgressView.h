

#import <UIKit/UIKit.h>

#define DEFAULT_RingColor          ([UIColor lightGrayColor])
#define DEFAULT_TintRingColor      ([UIColor grayColor])

@interface BSCircleProgressView : UIView

//圆色(选中)
@property (strong, nonatomic)UIColor *ringColor;
//(非选中)
@property (strong, nonatomic)UIColor *tintRingColor;


//百分比数值（0-1）
@property (assign, nonatomic)float progress;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end

