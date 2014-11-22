GScrollCategoryMenuController

developed by goshan

Destenition: make categoryMenu scroll automatically and smoothly with listPanel

2014.11.21（不同的人对于满足感的定义是不一样的，我的定义就是有效的完成了超出自身能力或者预计的事情，虽然这个事情曾经是你能轻而易举完成的。比如：你可以用汉语轻而易举地解释一大堆用户需求的代码施事的原因。但是当你第一次用日语完成这个任务的时候，就会产生满足感）
starting...
build environment: a single page appli for developing

顺道了解了一下xcode6 的size class特性：
9种size设定：width, height分别分为Compact, Any, Regular三种
不同的设备尺寸设定来源于不同的size class设定。常用的尺寸设定有以下几种：
1. width Compact + height Compact = 各类iPhone的Landscape
2. widht Compact + height Regular = 各类iPhone的portrait
3. width Regular + height Compact = 5.5寸iPhone的landscape（话说有这种设备吗？）
4. widht Any + height Any = 基本配置（For all layout）
5. widht Regular + height Regular = iPad的landscape和portrait
size class 能够对应4种情况: 约束（Constrants）的设置，文字字体，约束的开关，子视图的开关（是否显示）

2014.11.22


