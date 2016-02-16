//
//  BubbleTransition.h
//  BubbleTransitionDemo
//
//  Created by Mtel on 16/2/16.
//  Copyright © 2016年 SNde. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSUInteger, BubbleTransitionMode) {
    BubbleTransitionModePresent,
    BubbleTransitionModeDismiss,
    BubbleTransitionModePop,
};


@interface BubbleTransition : NSObject <UIViewControllerAnimatedTransitioning>
@property (assign, nonatomic) CGFloat duration;
@property (assign, nonatomic) CGPoint startingPoint;
@property (assign, nonatomic) BubbleTransitionMode transitionMode;
@property (strong, nonatomic) UIView *bubble;
@property (strong, nonatomic) UIColor *bubbleColor;




@end
