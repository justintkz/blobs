//
//  SegmentedViewController.m
//  blob
//
//  Created by Brehmer Chan on 5/6/18.
//  Copyright © 2018 Brehmer Chan. All rights reserved.
//

#import "SegmentedViewController.h"

@interface SegmentedViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIImageView *fitnessImage;
@property (weak, nonatomic) IBOutlet UIButton *mainMenu;
@property (weak, nonatomic) IBOutlet UIImageView *navMenuButton;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UIButton *trackerButton;
@property (weak, nonatomic) IBOutlet UIButton *playgroundButton;

@end

@implementation SegmentedViewController

bool hasChangePic = false;

- (IBAction)trackerButtonTapped:(UIButton *)sender {
    [self dismissNavMenuButton];
}

- (IBAction)touchMenuButton:(UIButton *)sender {
    [UIView transitionWithView:_navMenuButton
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromTop
                    animations:^{
                        _navMenuButton.hidden = false;
                    } completion:nil];
    _playgroundButton.hidden = false;
    _profileButton.hidden = false;
    _trackerButton.hidden = false;
}

- (IBAction)segTapped:(UISegmentedControl *)sender {
    if (_segmentedControl.selectedSegmentIndex==0) {
        UIImage *image = [UIImage imageNamed: @"WorkoutFinal@3x.png"];
        [_fitnessImage setImage:image];
    }
    else if (_segmentedControl.selectedSegmentIndex==1) {
        if (hasChangePic) {
            UIImage *image = [UIImage imageNamed: @"Sugar LevelsFinal2@3x.png"];
            [_fitnessImage setImage:image];
        }
        else {
            UIImage *image = [UIImage imageNamed: @"Sugar LevelsFinal@3x.png"];
            [_fitnessImage setImage:image];
        }
    }
    else if (_segmentedControl.selectedSegmentIndex==2) {
        UIImage *image = [UIImage imageNamed: @"MedicationFinal@3x.png"];
        [_fitnessImage setImage:image];
    }
    else if (_segmentedControl.selectedSegmentIndex==3) {
        UIImage *image = [UIImage imageNamed: @"DietFinal@3x.png"];
        [_fitnessImage setImage:image];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _navMenuButton.hidden = true;
    _playgroundButton.hidden = true;
    _profileButton.hidden = true;
    _trackerButton.hidden = true;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self selector:@selector(pollData:) userInfo:nil repeats:YES];
}

- (void)pollData:(NSTimer *)timer {
    NSString *twitterUrl = @"http://36fe870d.ngrok.io/sugar_level";
    NSString *resp = [self makeRestAPICall: twitterUrl];
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
    _playgroundButton.hidden = true;
    _profileButton.hidden = true;
    _trackerButton.hidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*) makeRestAPICall : (NSString*) reqURLStr
{
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString: reqURLStr]];
    NSURLResponse *resp = nil;
    NSError *error = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest: Request returningResponse: &resp error: &error];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:response //1
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
//    NSLog(@"%lu", (unsigned long)json.count);
//    NSLog(@"%@",responseString);
    for (int i = 0; i < json.count; i++) {
        NSNumber *value = ((NSArray *)json)[i][1];
        if ([value integerValue] == 130 && _segmentedControl.selectedSegmentIndex==1) {
            hasChangePic = true;
            UIImage *image = [UIImage imageNamed: @"Sugar LevelsFinal2@3x.png"];
            [_fitnessImage setImage:image];
        }
    }
    
    return responseString;
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
