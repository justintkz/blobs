//
//  ViewController.m
//  blob
//
//  Created by Brehmer Chan on 5/5/18.
//  Copyright © 2018 Brehmer Chan. All rights reserved.
//

#import "ViewController.h"
#import "ModalFurnitureCollectionViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *placing1;
@property (weak, nonatomic) IBOutlet UIButton *placing2;
@property (weak, nonatomic) IBOutlet UIButton *placing3;
@property (weak, nonatomic) IBOutlet UIButton *placing4;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIImageView *navMenuButton;
@property (weak, nonatomic) IBOutlet UIButton *playGroundButton;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UIButton *trackerButton;
@property (weak, nonatomic) IBOutlet UIButton *dummyButton;

@end

@implementation ViewController

NSInteger userCash = 300;
UIImage * furnitureImage;

- (IBAction)shopButtonTapped:(UIButton *)sender {
    [self dismissNavMenuButton];
}

- (IBAction)playgroundButtonTapped:(UIButton *)sender {
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
    _dummyButton.hidden = false;
}


- (IBAction)place1:(UIButton *)sender {
    if (self.placing1.currentBackgroundImage == nil) {
        [self.placing1 setBackgroundImage:furnitureImage forState:UIControlStateNormal];
        [self.placing1 setBackgroundColor:nil];
        [self.placing1 setAlpha:1];
    }
    if (self.placing2.currentBackgroundImage == nil) {
        self.placing2.hidden = true;
    }
    if (self.placing3.currentBackgroundImage == nil) {
        self.placing3.hidden = true;
    }
    if (self.placing4.currentBackgroundImage == nil) {
        self.placing4.hidden = true;
    }
}
- (IBAction)place2:(UIButton *)sender {
    if (self.placing2.currentBackgroundImage == nil) {
        [self.placing2 setBackgroundImage:furnitureImage forState:UIControlStateNormal];
        [self.placing2 setBackgroundColor:nil];
        [self.placing2 setAlpha:1];
    }
    if (self.placing1.currentBackgroundImage == nil) {
        self.placing1.hidden = true;
    }
    if (self.placing3.currentBackgroundImage == nil) {
        self.placing3.hidden = true;
    }
    if (self.placing4.currentBackgroundImage == nil) {
        self.placing4.hidden = true;
    }
}
- (IBAction)place3:(UIButton *)sender {
    if (self.placing3.currentBackgroundImage == nil) {
        [self.placing3 setBackgroundImage:furnitureImage forState:UIControlStateNormal];
        [self.placing3 setBackgroundColor:nil];
        [self.placing3 setAlpha:1];
    }
    if (self.placing2.currentBackgroundImage == nil) {
        self.placing2.hidden = true;
    }
    if (self.placing1.currentBackgroundImage == nil) {
        self.placing1.hidden = true;
    }
    if (self.placing4.currentBackgroundImage == nil) {
        self.placing4.hidden = true;
    }
}
- (IBAction)place4:(UIButton *)sender {
    if (self.placing4.currentBackgroundImage == nil) {
        [self.placing4 setBackgroundImage:furnitureImage forState:UIControlStateNormal];
        [self.placing4 setBackgroundColor:nil];
        [self.placing4 setAlpha:1];
    }
    if (self.placing2.currentBackgroundImage == nil) {
        self.placing2.hidden = true;
    }
    if (self.placing1.currentBackgroundImage == nil) {
        self.placing1.hidden = true;
    }
    if (self.placing3.currentBackgroundImage == nil) {
        self.placing3.hidden = true;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    self.placing1.hidden = true;
    self.placing2.hidden = true;
    self.placing3.hidden = true;
    self.placing4.hidden = true;
    
    _navMenuButton.hidden = true;
    _dummyButton.hidden = true;
    _playGroundButton.hidden = true;
    _profileButton.hidden = true;
    _trackerButton.hidden = true;
    //register to listen for event
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(eventHandler:)
     name:@"exitShop"
     object:nil ];
    
    NSArray *imageNames = @[@"Jump 1.png", @"Jump 2.png", @"Jump 3.png", @"Jump 2.png",
                            @"Jump 4.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
    UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(125, 428, 65, 65)];
    animationImageView.animationImages = images;
    animationImageView.animationDuration = 0.5;

    
    [self.view addSubview:animationImageView];
    [animationImageView startAnimating];
}

//event handler when event occurs
-(void)eventHandler: (NSNotification *) notification
{
    NSDictionary* furniturePic = notification.userInfo;
    furnitureImage = (UIImage*)furniturePic[@"pic"];
    self.placing1.hidden = false;
    self.placing2.hidden = false;
    self.placing3.hidden = false;
    self.placing4.hidden = false;
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
    _dummyButton.hidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
