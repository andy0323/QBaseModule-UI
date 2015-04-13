//
//  QBaseMessageVerifyButton.h
//  QBaseMessageVerifyButton
//
//  Created by andy on 3/31/15.
//  Copyright (c) 2015 andy_ios@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QBaseMessageVerifyButton;
@protocol QBaseMessageVerifyButtonDelegate <NSObject>

/// 开始获取短信消息
- (void)messageVerifyButtonWillFetchMessage:(QBaseMessageVerifyButton *)button;

/// 短信获取超时
- (void)messageVerifyButtonFetchTimeout:(QBaseMessageVerifyButton *)button;

@end

/**
 *  校验按钮
 */
@interface QBaseMessageVerifyButton : UIButton

/// 代理
@property (nonatomic, weak) id<QBaseMessageVerifyButtonDelegate> delegate;

/// 校验间隔
@property (nonatomic, assign) int interval;

/**
 *  校验按钮
 *
 *  @param interval 校验间隔时间
 *
 *  @return 校验按钮
 */
+ (QBaseMessageVerifyButton *)buttonWithInterval:(int)interval;

@end
