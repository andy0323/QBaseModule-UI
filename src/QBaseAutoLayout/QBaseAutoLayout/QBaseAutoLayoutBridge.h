//
//  QBaseAutoLayoutModel.h
//  ADLayout
//
//  Created by andy on 4/13/15.
//  Copyright (c) 2015 andy_ios@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    QBaseAutoLayoutDirectionLeft = 1,
    QBaseAutoLayoutDirectionRight,
    QBaseAutoLayoutDirectionTop,
    QBaseAutoLayoutDirectionBottom
}QBaseAutoLayoutDirection;

@interface QBaseAutoLayoutBridge : NSObject
@property (nonatomic, strong) UIView *relatedView;
@property (nonatomic, assign) QBaseAutoLayoutDirection layoutAttribute;
@property (nonatomic, assign) CGFloat offsetValue;

QBaseAutoLayoutBridge* QBase_newLayoutBridge(UIView *relatedView, QBaseAutoLayoutDirection layoutAttribute, CGFloat offsetValue);

@end
