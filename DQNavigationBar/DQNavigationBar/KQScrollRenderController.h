//
//  KQScrollRenderController.h
//  KQCloudService
//
//  Created by DaiQiao on 15/11/20.
//  Copyright © 2015年 DaiQiao. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 * @name   KQScrollRenderController
 * @brief  在滚动视图向上滚动时，慢慢隐藏导航条或者向下滚动时，慢慢显示导航条，支持6.0以上版本系统。
 *         在任何需要使用此功能的控制器类中，只要直接继承于此KQScrollRenderController类，并在
 *         创建滚动视图的时候，调用-followScrollView:方法来设置即可。
 * @note   如果此类需要继承更多的特性，可直接修改继承的父类为自定义的控制器类。也可以把此类作为所有
 *         类的基础父类，在继承此类的基础上，扩展所有基础属性。如KQSuperBaseController : KQScrollRenderController
 * @author daiqiao
 */

@interface KQScrollRenderController : UIViewController
/*!
 * @brief 允许滚动的视图，支付UIScrollView、UITableView、UIWebView
 * @param scrollableView 可滚动的视图
 */
- (void)followScrollView:(UIView *)scrollableView;
@end
