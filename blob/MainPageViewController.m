//
//  MainPageViewController.m
//  blob
//
//  Created by Brehmer Chan on 5/6/18.
//  Copyright © 2018 Brehmer Chan. All rights reserved.
//

#import "MainPageViewController.h"

@interface MainPageViewController ()
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIImageView *navMenuButton;
@property (weak, nonatomic) IBOutlet UIButton *playGroundButton;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UIButton *trackerButton;

@end

@implementation MainPageViewController
- (IBAction)touchProfileButton:(UIButton *)sender {
    [self dismissNavMenuButton];
}

- (IBAction)touchMenuButton:(UIButton *)sender {
        [UIView transitionWithView:_navMenuButton
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromTop
                    animations:^{
                        _navMenuButton.hidden = false;
                    } completion:nil];
        _playGroundButton.hidden = false;
        _profileButton.hidden = false;
        _trackerButton.hidden = false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _navMenuButton.hidden = true;
    _playGroundButton.hidden = true;
    _profileButton.hidden = true;
    _trackerButton.hidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self dismissNavMenuButton];
    }
}

- (void)dismissNavMenuButton {
    [UIView transitionWithView:_navMenuButton
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromTop
                    animations:^{
                        _navMenuButton.hidden = true;
                    } completion:nil];
    _playGroundButton.hidden = true;
    _profileButton.hidden = true;
    _trackerButton.hidden = true;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
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
