//
//  ViewController.m
//  Drai's VenU
//
//  Created by Chris Hayes on 4/10/15.
//  Copyright (c) 2015 CustomAppVentures. All rights reserved.
//

#import "ViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "LoginScene.h"
#import "HomeScene.h"

@interface ViewController ()

@property (nonatomic, weak) LoginScene *scene;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    SKView *skView = (SKView *)self.view;
    
    LoginScene *loginScene = [[LoginScene alloc] initWithSize:self.view.frame.size];
    loginScene.scaleMode = SKSceneScaleModeAspectFit;
    loginScene.parentVC = self;
    _scene = loginScene;
    
    HomeScene *homeScene = [[HomeScene alloc] initWithSize:self.view.frame.size];
    homeScene.scaleMode = SKSceneScaleModeAspectFit;
    
    [skView presentScene:homeScene];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
