//
//  BubbleTransition.m
//  BubbleTransitionDemo
//
//  Created by Mtel on 16/2/16.
//  Copyright © 2016年 SNde. All rights reserved.
//

#import "BubbleTransition.h"

@implementation BubbleTransition

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.duration = 0.5;
        self.startingPoint = CGPointZero;
        self.transitionMode = BubbleTransitionModePresent;
        self.bubbleColor = [UIColor whiteColor];
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return _duration;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = transitionContext.containerView;
    if (!containerView) {
        return;
    }
    if (_transitionMode == BubbleTransitionModePresent) {
        UIView *presentedControllerView = [transitionContext viewForKey:UITransitionContextToViewKey];
        CGPoint originalCenter = presentedControllerView.center;
        CGSize  originalSize   = presentedControllerView.frame.size;
        
        _bubble = [UIView new];
        _bubble.frame = [self frameForBubbleOriginalCenter:originalCenter size:originalSize start:_startingPoint];
        _bubble.layer.cornerRadius = _bubble.frame.size.height/2;
        _bubble.center = _startingPoint;
        _bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
        _bubble.backgroundColor = _bubbleColor;
        
        [containerView addSubview:_bubble];
        
        presentedControllerView.center = _startingPoint;
        presentedControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        presentedControllerView.alpha = 0;
        [containerView addSubview:presentedControllerView];
        
        [UIView animateWithDuration:_duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
//        [UIView animateWithDuration:_duration animations:^{
            self.bubble.transform = CGAffineTransformIdentity;
            presentedControllerView.transform = CGAffineTransformIdentity;
            presentedControllerView.alpha = 1;
            presentedControllerView.center = originalCenter;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
        
        
        
    }else {
        NSString *key = (_transitionMode == BubbleTransitionModePop ) ? UITransitionContextToViewKey : UITransitionContextFromViewKey;
        UIView *returningControllerView = [transitionContext viewForKey:key];
        CGPoint originalCenter = returningControllerView.center;
        CGSize originalSize = returningControllerView.frame.size;
        if (_transitionMode != BubbleTransitionModePop){
            UIView *toControllerView = [transitionContext viewForKey:UITransitionContextToViewKey];
            [containerView insertSubview:toControllerView belowSubview:_bubble];
        }
        _bubble.frame = [self frameForBubbleOriginalCenter:originalCenter size:originalSize start:_startingPoint];
        _bubble.layer.cornerRadius = _bubble.frame.size.height / 2;
        _bubble.center = _startingPoint;

//        [UIView animateWithDuration:_duration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
        [UIView animateWithDuration:_duration animations:^{
            self.bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            returningControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            returningControllerView.center = self.startingPoint;
            returningControllerView.alpha = 0;
            
            if (self.transitionMode == BubbleTransitionModePop) {
                [containerView insertSubview:returningControllerView
                                belowSubview:returningControllerView];
                [containerView insertSubview:self.bubble
                                belowSubview:returningControllerView];
            }
        }completion:^(BOOL finished) {
            [returningControllerView removeFromSuperview];
            [self.bubble removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    

    }

}


-(CGRect)frameForBubbleOriginalCenter:(CGPoint)originalCenter size :(CGSize)originalSize start:(CGPoint)start {
    CGFloat lengthX = fmax(start.x, originalSize.width - start.x);
    CGFloat lengthY = fmax(start.y, originalSize.height - start.y);
    CGFloat offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2;
    CGSize size =CGSizeMake(offset, offset);
    return CGRectMake(CGPointZero.x, CGPointZero.y, size.width, size.height);
}

-(void)setStartingPoint:(CGPoint)startingPoint {
    _startingPoint = startingPoint;
    _bubble.center = startingPoint;
}

@end
