//
//  BSRingProgressView1.m
//  圆圈进度条
//
//  Created by cbs on 16/9/22.
//  Copyright © 2016年 CBS. All rights reserved.
//

#import "BSRingProgressView.h"

@implementation BSRingProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setProgress:(float)progress animated:(BOOL)animated{
    
    progress = MAX(MIN(progress, 1.0), 0.0);
    if (animated) {
        
    }else{
        [self setProgress:progress];
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

- (void)setCenterColor:(UIColor *)centerColor{
    _centerColor = centerColor;
    [self setNeedsDisplay];
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [self setNeedsDisplay];
}
- (void)setRingColor:(UIColor *)ringColor{
    _ringColor = ringColor;
    [self setNeedsDisplay];
}
- (void)setTintRingColor:(UIColor *)tintRingColor{
    _tintRingColor = tintRingColor;
    [self setNeedsDisplay];
}
- (void)setLineWidth:(float)lineWidth{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font{
    _font = font;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self addArcBackColor];
    [self addCenterBack];
    [self addProgressRing];
    [self addCenterText];
    
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
    CGContextAddArc(contextRef, center.x, center.y, radius, 0,2*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef, color);
    CGContextFillPath(contextRef);
}
-(void)addCenterBack{
    
    CGSize viewSize = self.bounds.size;
    
    float lineWidth = (_lineWidth <= 0) ? DEFAULT_LineWidth : _lineWidth;
    
    CGFloat radius = ((viewSize.width / 2)<(viewSize.height / 2)?(viewSize.width / 2):(viewSize.height / 2)) - lineWidth;
    
    if (radius <= 0) {
        return ;
    }
    
    
    CGColorRef color = (_centerColor == nil) ? DEFAULT_CenterColor.CGColor : _centerColor.CGColor;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius, 0,2*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef, color);
    CGContextFillPath(contextRef);
}

- (void)addProgressRing{
    
    if (_progress <= 0 || _progress > 1) {
        return;
    }
    float endAngle = 2*M_PI*_progress;
    CGColorRef color = (_tintRingColor == nil) ? DEFAULT_TintRingColor.CGColor : _tintRingColor.CGColor;
    
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    // Draw the slices.
    CGFloat radius = (viewSize.width / 2)<(viewSize.height / 2)?(viewSize.width / 2):(viewSize.height / 2);
    CGFloat lineWidth = (DEFAULT_LineWidth > radius) ? radius:DEFAULT_LineWidth;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, color);//画笔线的颜色
    CGContextSetLineWidth(context, lineWidth);//线得宽度
    CGContextAddArc(context, center.x, center.y, radius - lineWidth * 0.5, - M_PI_2, endAngle - M_PI_2, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke);//绘制路径
}
- (void)addCenterText{
    
    
    UIColor *textColor = (_textColor == nil)?DEFAULT_TextColor:_textColor;
    UIFont *textFont = (_font == nil) ? DEFAULT_TextFond : _font;
    
    NSString *centerString = nil;
    
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(centerStringWithProgress:)]) {
        centerString = [self.delegate centerStringWithProgress:_progress];
    }else{
        centerString = DEFAULT_String(_progress);
    }
    
    CGRect textRect = CGRectZero;
    
    CGSize size = self.bounds.size;
    CGFloat radius = (size.width / 2)<(size.height / 2)?(size.width / 2):(size.height / 2);
    CGFloat width = radius * sqrt(2.0);
    
    textRect.origin = CGPointMake((size.width - width) * 0.5, (size.height - 30) * 0.5);
    textRect.size = CGSizeMake(width, 30);
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:textFont,NSFontAttributeName ,textColor,NSForegroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil];
    
    [centerString drawInRect:textRect withAttributes:attributes];
}
@end
