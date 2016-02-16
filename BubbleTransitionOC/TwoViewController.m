//
//  TwoViewController.m
//  BubbleTransitionDemo
//
//  Created by Mtel on 16/2/15.
//  Copyright © 2016年 SNde. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController (){
    
    __weak IBOutlet UIButton *closeBtn;
}

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [closeBtn setTransform:CGAffineTransformMakeRotation(M_PI_4)];
}

-(void)viewWillAppear:(BOOL)animated {
//
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
//  [[UIApplication sharedApplication]setStatusBarStyle:(UIStatusBarStyleDefault)];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
