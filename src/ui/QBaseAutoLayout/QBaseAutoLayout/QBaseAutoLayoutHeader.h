//
//  QBaseAutoLayoutHeader.h
//  ADLayout
//
//  Created by andy on 4/13/15.
//  Copyright (c) 2015 andy_ios@163.com. All rights reserved.
//

#ifndef ADLayout_QBaseAutoLayoutHeader_h
#define ADLayout_QBaseAutoLayoutHeader_h

// AutoLayout Usage
//
// QBaseAutoLayoutThat(self, qbase_related_left(superView), qbase_left_value(1.0));

#import "QBaseAutoLayoutBridge.h"

#define QBaseAutoLayoutThat(_Self, _View, _Value) \
{\
    NSLayoutConstraint *layoutConstraint = \
    [NSLayoutConstraint constraintWithItem:_Self   \
                                 attribute:(NSLayoutAttribute)_Value.layoutAttribute \
                                 relatedBy:NSLayoutRelationEqual  \
                                    toItem:_View.relatedView      \
                                 attribute:(NSLayoutAttribute)_View.layoutAttribute  \
                                multiplier:1.0f                   \
                                  constant:_Value.offsetValue];   \
    NSLog(@"%@", layoutConstraint);\
}


#define qbase_layout_bridge QBase_newLayoutBridge


#define qbase_related_left(_View) \
    qbase_layout_bridge(_View, QBaseAutoLayoutDirectionLeft, 0)
#define qbase_related_right(_View) \
    qbase_layout_bridge(_View, QBaseAutoLayoutDirectionRight, 0)
#define qbase_related_top(_View) \
    qbase_layout_bridge(_View, QBaseAutoLayoutDirectionTop, 0)
#define qbase_related_bottom(_View) \
    qbase_layout_bridge(_View, QBaseAutoLayoutDirectionBottom, 0)


#define qbase_value_left(_Value)  \
    qbase_layout_bridge(nil, QBaseAutoLayoutDirectionLeft, _Value)
#define qbase_value_right(_Value) \
    qbase_layout_bridge(nil, QBaseAutoLayoutDirectionRight, _Value)
#define qbase_value_top(_Value) \
    qbase_layout_bridge(nil, QBaseAutoLayoutDirectionTop, _Value)
#define qbase_value_bottom(_Value) \
    qbase_layout_bridge(nil, QBaseAutoLayoutDirectionTop, _Value)

#endif
