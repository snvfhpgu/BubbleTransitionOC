//
//  ViewController.m
//  BubbleTransitionDemo
//
//  Created by Mtel on 16/2/15.
//  Copyright © 2016年 SNde. All rights reserved.
//

#import "ViewController.h"
#import "BubbleTransition.h"
@interface ViewController () <UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) BubbleTransition *transition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.transition = [[BubbleTransition alloc] init];
    self.navigationController.delegate = self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *controller = segue.destinationViewController;
    controller.transitioningDelegate = self;
    controller.modalTransitionStyle = UIModalPresentationCustom;
    
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.transition.transitionMode = BubbleTransitionModePresent;
    self.transition.startingPoint = self.button.center;
    self.transition.bubbleColor = self.button.backgroundColor;
    return self.transition;
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transition.transitionMode = BubbleTransitionModeDismiss;
    self.transition.startingPoint = self.button.center;
    self.transition.bubbleColor = self.button.backgroundColor;

    return self.transition;
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation ==UINavigationControllerOperationPush) {
        self.transition.transitionMode = BubbleTransitionModePresent;
    }else {
        self.transition.transitionMode = BubbleTransitionModeDismiss;
    }
    self.transition.startingPoint = self.button.center;
    self.transition.bubbleColor = self.button.backgroundColor;

    return self.transition;
}

@end
