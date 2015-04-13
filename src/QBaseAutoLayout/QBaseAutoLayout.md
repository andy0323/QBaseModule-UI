# QBaseAutoLayout

## Usage

首先，下面是通过代码形式实现的自动布局

```
NSLayoutConstraint *constraint =  
	[NSLayoutConstraint constraintWithItem:FIRST_VIWE
					                attribute:NSLayoutAttributeTop
					                relatedBy:NSLayoutRelationEqual
					                toItem:RELATED_VIEW
					                attribute:NSLayoutAttributeTop
					                multiplier:1.0f
					                constant:100.f];
[RELATED_VIEW addConstraint:constraint];
```

通过`QBaseAutoLayout`简化了这样的用法，用法如下

	QBaseAutoLayoutThat(FIRST_VIWE, qbase_related_top(RELATED_VIEW), qbase_value_top(100));

解读函数：  
`FIRST_VIWE的顶部相对于RELATED_VIEW的顶部偏移量为100`