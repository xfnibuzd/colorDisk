//
//  ColorDisk.m
//  EsoonProject
//
//  Created by liuxiaofeng on 16/8/26.
//  Copyright © 2016年 Soonbuy. All rights reserved.
//

#import "ColorDisk.h"

@interface ColorDisk()

@property (nonatomic,strong) UIImageView *handle;
@property (nonatomic,strong) UIImageView *bgImage;

@end

#define handHeight 8

@implementation ColorDisk

-(UIImageView *)handle{
    if (!_handle) {
        _handle = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, handHeight, handHeight)];
        _handle.layer.cornerRadius = handHeight*0.5;
        _handle.layer.borderWidth = 1.0;
        _handle.layer.borderColor = [UIColor blackColor].CGColor;
        _handle.backgroundColor = [UIColor clearColor];
    }
    return _handle;
}

-(UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]initWithFrame:self.bounds];
        _bgImage.image = [UIImage imageNamed:@"circle.png"];
    }
    return _bgImage;
}


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        [self addSubview:self.bgImage];
        [self addSubview:self.handle];
        self.handle.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
        self.layer.cornerRadius = self.bounds.size.width*0.5;
    }
    return self;
}


#pragma mark - UIControl Override -

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    
    CGPoint lastPoint = [touch locationInView:self];
    
    [self movehandle:lastPoint];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint lastPoint = [touch locationInView:self];
    
    [self movehandle:lastPoint];
    
    [super endTrackingWithTouch:touch withEvent:event];
    
}

-(void)movehandle:(CGPoint)lastPoint{
    
    float pos_x = lastPoint.x;
    float pos_y = lastPoint.y;
    float width = self.bounds.size.width*0.5;
    float height = self.bounds.size.height*0.5;
    float width_x = (-lastPoint.x+width)*(-lastPoint.x+width);
    float height_y = (-lastPoint.y+height)*(-lastPoint.y+height);
    float radius = sqrtf(width_x+height_y);
    
    if (radius>width) {
        pos_x = (width*pos_x)/radius-width*width/radius;
        pos_y = (height*pos_y)/radius-height*height/radius;
        pos_x = pos_x + width;
        pos_y = pos_y + height;
    }
    
    lastPoint.x = pos_x;
    lastPoint.y = pos_y;
    self.selectedColor = [self colorFromImage:&lastPoint :width :height];
    self.handle.center = lastPoint;
}

- (UIColor*)colorFromImage:(CGPoint *)p :(float) frameWidth :(float) frameHeight {
    
    float halfWidth = (frameWidth / 2);
    float halfHeight = (frameHeight / 2);
    
    float x = (*p).x - halfWidth;
    float y = (*p).y - halfHeight;
    
    float radius = sqrtf( (x*x) + (y*y));
    
    float angleRad = atan2 (y, x);
    float angleDeg = (angleRad/M_PI*180) + (angleRad > 0 ? 0 : 360);
    
    float hue = angleDeg / 360.0;
    float saturation = radius / halfWidth;
    
    UIColor* returnColor = [UIColor colorWithHue:hue saturation:saturation brightness:1.0 alpha:1.0];
    return (returnColor);
}


@end
