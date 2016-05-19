//
//  UIView+HLUntil.h
//  AutoSizeView
//
//  Created by 易海 on 16/4/1.
//  Copyright © 2016年 易海. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef struct
{
    int top;        //上边距
    int bottom;     //下边距
    int left;       //左边距
    int right;      //右边距
    int maxHeight;  //最大高度
    int maxWidth;   //最大宽度
    int minHeight;  //最小高度
    int minWidth;   //最小宽度
}hly_constraint;

typedef NS_ENUM(NSUInteger, hly_alignment)
{
    hly_alignmentNone       = 1 << 0,   //无布局
    hly_alignmentHorizontal = 1 << 1,   //水平布局
    hly_alignmentVertical   = 1 << 2,   //垂直布局
    
};

@class HLAutoViewCreator;
@interface UIView (hly_ViewFrameUitil)

/**
 *  @brief 约束信息
 */
@property (nonatomic) hly_constraint constraint;

/**
 *  @brief 布局类型
 */
@property (nonatomic) hly_alignment alignment;

/**
 *  @brief 是否垂直居中
 */
@property (nonatomic) BOOL hl_centerX;

/**
 *  @brief 是否水平居中
 */
@property (nonatomic) BOOL hl_centerY;

/**
 *  @brief creator， 这里防止被释放
 */
@property (nonatomic, retain) HLAutoViewCreator *creator;

/**
 *  @brief 用户数据
 */
@property (nonatomic, retain) id hl_userData;

/**
 *  @brief 事件数据
 */
@property (nonatomic, retain) id hl_actionData;

/**
 *  @brief corner value
 *
 *  set layer.cornerRadius = hly_corner;
 *      layer.maskToBounds = YES;
 */
@property (nonatomic) CGFloat hly_corner;

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat hly_left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat hly_top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat hly_right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat hly_bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat hly_width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat hly_height;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint hly_origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize hly_size;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat hly_centerX;

/**
 *  右上角
 *  self.origin.x+self.size.width,self.origin.y
 */
@property (nonatomic) CGPoint hly_topRight;

/**
 *  左下角
 *
 *  self.origin.x,self.origin.y+self.size.height
 */
@property (nonatomic) CGPoint hly_bottomLeft;

/**
 *  右下角
 *
 *  self.origin.x+self.size.width,self.origin.y+self.size.height
 */
@property (nonatomic) CGPoint hly_bottomRight;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat hly_centerY;

/**
 *  Shortcut for right to superview
 *  Sets frame.origin.x = superview.width - rightToSuper -frame.size.width
 */
@property (nonatomic) CGFloat hly_rightToSuper;

/**
 *  shortcut for bottom to superview
 *  set frame.origin.y = superview.height - bottomToSuper - frame.size.height
 */
@property (nonatomic) CGFloat hly_bottomToSuper;


@end

