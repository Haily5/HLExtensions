//
//  UIView+HLUntil.m
//  AutoSizeView
//
//  Created by 易海 on 16/4/1.
//  Copyright © 2016年 易海. All rights reserved.
//

#import "UIView+HLUntil.h"

#import <objc/runtime.h>

@interface hlyStructObj : NSObject
@property (nonatomic) hly_constraint constraint;
@property (nonatomic) hly_alignment alignment;
@property (nonatomic) BOOL          centerX;
@property (nonatomic) BOOL          centerY;
@end
@implementation hlyStructObj

@end
@implementation UIView (hly_ViewFrameUitil)

char key = 'k';

char dataKey = 'd';
char actionKey = 'c';
char creatorKey = 'r';
- (hlyStructObj *)hlyObj
{
    hlyStructObj *obj = objc_getAssociatedObject(self, &key);
    if (!obj)
    {
        obj = [hlyStructObj new];
        objc_setAssociatedObject(self, &key, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        obj.alignment = hly_alignmentNone;
    }
    return obj;
}
- (void)setConstraint:(hly_constraint)constraint
{
    [self hlyObj].constraint = constraint;
}

- (hly_constraint)constraint
{
    return [self hlyObj].constraint;
}

- (void)setAlignment:(hly_alignment)alignment
{
    [self hlyObj].alignment = alignment;
}

- (hly_alignment)alignment
{
    return [self hlyObj].alignment;
}

- (BOOL)hl_centerX
{
    return [self hlyObj].centerX;
}

- (void)setHl_centerX:(BOOL)hl_centerX
{
    [self hlyObj].centerX = hl_centerX;
}

- (BOOL)hl_centerY
{
    return [self hlyObj].centerY;
}

- (void)setHl_centerY:(BOOL)hl_centerY
{
    [self hlyObj].centerY = hl_centerY;
}

- (void)setHl_userData:(id)hl_userData
{
    objc_setAssociatedObject(self, &dataKey, hl_userData, OBJC_ASSOCIATION_COPY);
}

- (id)hl_userData
{
    return objc_getAssociatedObject(self, &dataKey);
}

- (void)setHl_actionData:(id)hl_actionData
{
    objc_setAssociatedObject(self, &actionKey, hl_actionData, OBJC_ASSOCIATION_RETAIN);
}

- (id)hl_actionData
{
    return objc_getAssociatedObject(self, &actionKey);
}

- (void)setCreator:(HLAutoViewCreator *)creator
{
    objc_setAssociatedObject(self, &creatorKey, creator, OBJC_ASSOCIATION_RETAIN);
}

- (HLAutoViewCreator *)creator
{
    return objc_getAssociatedObject(self, &creatorKey);
}

- (CGFloat)hly_corner
{
    return self.layer.cornerRadius;
}

- (void)setHly_corner:(CGFloat)hly_corner
{
    self.layer.cornerRadius = hly_corner;
    self.layer.masksToBounds = YES;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)hly_left {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHly_left:(CGFloat)hly_left {
    CGRect frame = self.frame;
    frame.origin.x = hly_left;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)hly_top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHly_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)hly_right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHly_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)hly_bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHly_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)hly_width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHly_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)hly_height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHly_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)hly_origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHly_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)hly_size {
    return self.frame.size;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)hly_centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHly_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)hly_centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHly_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHly_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)hly_topRight
{
    return CGPointMake(self.frame.origin.x+self.frame.size.width,self.frame.origin.y);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHly_topRight:(CGPoint)hly_topRight
{
    CGRect frame = self.frame;
    
    CGFloat xdetal = hly_topRight.x - frame.origin.x - frame.size.width;
    frame.origin.x = frame.origin.x + xdetal;
    
    frame.origin.y = hly_topRight.y;
    
    self.frame = frame;
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)hly_bottomLeft
{
    return CGPointMake(self.frame.origin.x,self.frame.origin.y+self.frame.size.height);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHly_bottomLeft:(CGPoint)hly_bottomLeft
{
    CGRect frame = self.frame;
    
    CGFloat ydetal = hly_bottomLeft.y - frame.origin.y - frame.size.height;
    frame.origin.y = frame.origin.y + ydetal;
    
    frame.origin.x = hly_bottomLeft.x;
    
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)hly_bottomRight
{
    return CGPointMake(self.frame.origin.x+self.frame.size.width,self.frame.origin.y+self.frame.size.height);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHly_bottomRight:(CGPoint)hly_bottomRight
{
    CGRect frame = self.frame;
    
    CGFloat xdetal = hly_bottomRight.x - frame.origin.x - frame.size.width;
    frame.origin.x = frame.origin.x + xdetal;
    
    CGFloat ydetal = hly_bottomRight.y - frame.origin.y - frame.size.height;
    frame.origin.y = frame.origin.y + ydetal;
    
    self.frame = frame;
}

- (CGFloat)hly_rightToSuper
{
    return self.superview.bounds.size.width - self.frame.size.width - self.frame.origin.x;
}

- (void)setHly_rightToSuper:(CGFloat)rightToSuper
{
    CGRect frame = self.frame;
    
    frame.origin.x =  self.superview.bounds.size.width - self.frame.size.width  - rightToSuper,
    self.frame = frame;
}

- (CGFloat)hly_bottomToSuper
{
    return self.superview.bounds.size.height - self.frame.size.height - self.frame.origin.y;
}

- (void)setHly_bottomToSuper:(CGFloat)bottomToSuper
{
    CGRect frame = self.frame;
    
    frame.origin.y =  self.superview.bounds.size.height - self.frame.size.height  - bottomToSuper,
    self.frame = frame;
}


@end
