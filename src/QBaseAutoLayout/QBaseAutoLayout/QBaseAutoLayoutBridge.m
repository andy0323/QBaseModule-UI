//
//  QBaseAutoLayoutModel.m
//  ADLayout
//
//  Created by andy on 4/13/15.
//  Copyright (c) 2015 andy_ios@163.com. All rights reserved.
//

#import "QBaseAutoLayoutBridge.h"

@implementation QBaseAutoLayoutBridge

QBaseAutoLayoutBridge* QBase_newLayoutBridge(UIView *relatedView, QBaseAutoLayoutDirection layoutAttribute, CGFloat offsetValue)
{
    QBaseAutoLayoutBridge *bridge = [QBaseAutoLayoutBridge new];
    bridge.relatedView = relatedView;
    bridge.layoutAttribute = layoutAttribute;
    bridge.offsetValue = offsetValue;
    
    return bridge;
}
@end
