//
//  QBaseMessageVerifyButton.h
//  QBaseMessageVerifyButton
//
//  Created by andy on 3/31/15.
//  Copyright (c) 2015 andy_ios@163.com. All rights reserved.
//

#import "QBaseMessageVerifyButton.h"

// 默认间隔
static const int kQBaseMessageVerifyButtonDefaultInterval = 60;

/// 默认标题
static NSString *kQBaseMessageVerifyButtonDefaultTitle = @"获取验证码";
static NSString *kQBaseMessageVerifyButtonDefaultAgainTitle = @"重新获取验证码";

/// 读秒后缀
static NSString *kQBaseMessageVerifyButtonDefaultTitleSuffix = @"s后重新获取";

// 默认颜色
#define kQBaseMessageVerifyButtonDefaultColor \
    [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1]

// 选择颜色
#define kQBaseMessageVerifyButtonSelectColor \
    [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]


@interface QBaseMessageVerifyButton ()
{
    int _time;
}
/// 定时器
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation QBaseMessageVerifyButton

- (instancetype)init
{
    if (self = [super init]) {
        [self _init];
    }
    return self;
}

/**
 *  初始化
 */
- (void)_init
{
    // 默认值
    _interval = kQBaseMessageVerifyButtonDefaultInterval;
    [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    // 设置属性
    self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self setTitle:kQBaseMessageVerifyButtonDefaultTitle
          forState:UIControlStateNormal];
    [self setTitleColor:kQBaseMessageVerifyButtonDefaultColor forState:UIControlStateNormal];
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = kQBaseMessageVerifyButtonDefaultColor.CGColor;
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    
    [self addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 创建定时器、 定时器暂停
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                              target:self
                                            selector:@selector(timerAction)
                                            userInfo:nil
                                             repeats:YES];
    // 暂停
    [self stopTimer];
}
- (void)btnClicked:(UIButton *)button
{
    // 开始获取验证码
    self.userInteractionEnabled = NO;
  
    // 开启定时器
    [self startTimer];
}
- (void)timerAction
{
    [self setTitle:[NSString stringWithFormat:@"%d%@", _time--, kQBaseMessageVerifyButtonDefaultTitleSuffix] forState:UIControlStateNormal];
    
    if (_time == 0) {
        [self stopTimer];
        self.userInteractionEnabled = YES;
        [self setTitle:kQBaseMessageVerifyButtonDefaultAgainTitle forState:UIControlStateNormal];
    }
}

/**
 *  校验按钮
 *
 *  @param interval 校验间隔时间
 *
 *  @return 校验按钮
 */
+ (QBaseMessageVerifyButton *)buttonWithInterval:(int)interval
{
    QBaseMessageVerifyButton *btn = [[self alloc] init];
    btn.interval = interval;
    return btn;
}

/**
 *  重写用户交互开关
 */
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    [super setUserInteractionEnabled:userInteractionEnabled];
    
    if (userInteractionEnabled)
    {
        // 激活界面
        [self setTitleColor:kQBaseMessageVerifyButtonDefaultColor forState:UIControlStateNormal];
    
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = kQBaseMessageVerifyButtonDefaultColor.CGColor;
    }else
    {
        // 未激活状态
        [self setTitleColor:kQBaseMessageVerifyButtonSelectColor forState:UIControlStateNormal];
    
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = kQBaseMessageVerifyButtonSelectColor.CGColor;
    }
}

#pragma mark -
#pragma mark Timer

- (void)startTimer
{
    _time = _interval;
    [_timer setFireDate:[NSDate distantPast]];
}

- (void)stopTimer
{
    [_timer setFireDate:[NSDate distantFuture]];
}

@end