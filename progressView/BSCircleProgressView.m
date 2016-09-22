

#import "BSCircleProgressView.h"

@interface BSCircleProgressView()

@property(nonatomic, strong) dispatch_source_t timer;

@end

@implementation BSCircleProgressView



- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setProgress:(float)progress animated:(BOOL)animated{
    
    progress = MAX( MIN(progress, 1.0), 0.0);
    
    if (progress == _progress) {
        return ;
    }else{
 
        if (animated) {
            
            NSTimeInterval secend = 0.001 + 0.002 / (ABS(progress - _progress) + 1);
            
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
            dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, secend * NSEC_PER_SEC, 0.0005 * NSEC_PER_SEC);
            dispatch_source_set_event_handler(_timer, ^{
                if (progress - _progress > 0.005) {
                    self.progress += 0.005;
                }else if(_progress - progress > 0.005){
                    self.progress -= 0.005;
                }else{
                    self.progress = progress;
                    
                    dispatch_cancel(_timer);
                }
            });
            dispatch_resume(_timer);
            
        }else{
            self.progress = progress;
        }
    }
}

- (void)setProgress:(float)progress{
    
    progress = MAX(MIN(progress, 1.0), 0.0);
    
    if (progress == _progress) {
        return ;
    }else{
        _progress = progress;
        [self setNeedsDisplay];
    }
}

- (void)setRingColor:(UIColor *)ringColor{
    _ringColor = ringColor;
    [self setNeedsDisplay];
}
- (void)setTintRingColor:(UIColor *)tintRingColor{
    _tintRingColor = tintRingColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    
    [self addArcBackColor];
    
    [self drawArc];
}

- (void)addArcBackColor{
    
    CGColorRef color = (_ringColor == nil) ? DEFAULT_RingColor.CGColor : _ringColor.CGColor;

    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    
    // Draw the slices.
    CGFloat radius = (viewSize.width / 2)<(viewSize.height / 2)?(viewSize.width / 2):(viewSize.height / 2);
    
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef, color);
    CGContextFillPath(contextRef);
}

- (void)drawArc{
    
    if (_progress <= 0 || _progress > 1) {
        
        return;
    }
    
    float endAngle = 2*M_PI*_progress;
    
    CGColorRef color = (_tintRingColor == nil) ? DEFAULT_TintRingColor.CGColor : _tintRingColor.CGColor;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    // Draw the slices.
    CGFloat radius = (viewSize.width / 2)<(viewSize.height / 2)?(viewSize.width / 2):(viewSize.height / 2);
    
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius, - M_PI_2, endAngle - M_PI_2, 0);
    CGContextSetFillColorWithColor(contextRef, color);
    CGContextFillPath(contextRef);
}

@end
