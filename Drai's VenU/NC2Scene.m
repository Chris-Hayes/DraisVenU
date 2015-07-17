//
//  NC2Scene.m
//  Drai's VenU
//
//  Created by Chris Hayes on 4/17/15.
//  Copyright (c) 2015 CustomAppVentures. All rights reserved.
//

#import "NC2Scene.h"
#import "HomeScene.h"

@interface NC2Scene ()
{
    BOOL starWasPlaced;
    BOOL shareIsAvailable;
    BOOL adSpaceTouched;
    BOOL movingStar;
}

@property (nonatomic, weak) SKSpriteNode *floorPlan;
@property (nonatomic, weak) SKLabelNode *levelLbl;
@property (nonatomic, weak) SKSpriteNode *placedPin;
@property (nonatomic, weak) SKSpriteNode *bottleOption;
@property (nonatomic, weak) SKSpriteNode *shareOption;
@property (nonatomic, weak) SKSpriteNode *logoHeader;

@end

@implementation NC2Scene

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor blackColor];
        
        starWasPlaced = NO;
        shareIsAvailable = NO;
        adSpaceTouched = NO;
        movingStar = NO;
        
        SKSpriteNode *logo = [SKSpriteNode spriteNodeWithImageNamed:@"DraisHeader"];
        logo.position = CGPointMake(CGRectGetMidX(self.frame), size.height - 65);
        
        [self addChild:logo];
        
        SKSpriteNode *floorPlan = [SKSpriteNode spriteNodeWithImageNamed:@"Nightclub2_zoom"];
        
        SKLabelNode *label = [SKLabelNode labelNodeWithText:@"Nightclub"];
        SKLabelNode *levelLbl = [SKLabelNode labelNodeWithText:@"Level 2"];
        
        floorPlan.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:floorPlan];

        levelLbl.fontSize = 22;
        levelLbl.fontName = @"HelveticaNeue-Thin";
        levelLbl.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(floorPlan.frame) - 45);
        [levelLbl runAction:[SKAction scaleTo:0.1 duration:0.0]];
        

        label.fontSize = 22;
        label.fontName = @"HelveticaNeue-Thin";
        label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(logo.frame) - 25);
        [label runAction:[SKAction scaleTo:0.1 duration:0.0]];
        
        
        
        [self addChild:levelLbl];
        [self addChild:label];
        
        [levelLbl runAction:[SKAction scaleTo:1.0 duration:0.3]];
        [label runAction:[SKAction scaleTo:1.0 duration:0.3]];
        
        SKSpriteNode *bottlePin = [SKSpriteNode spriteNodeWithImageNamed:@"PurchaseIcon"];
        bottlePin.position = CGPointMake(CGRectGetMinX(floorPlan.frame), CGRectGetMidY(logo.frame));
        bottlePin.alpha = 0.0;
        [bottlePin runAction:[SKAction scaleBy:1.3 duration:0.0]];
        
        [self addChild:bottlePin];
        
        SKSpriteNode *shareOption = [SKSpriteNode spriteNodeWithImageNamed:@"ShareIcon"];
        shareOption.position = CGPointMake(CGRectGetMaxX(floorPlan.frame), CGRectGetMidY(logo.frame));
        shareOption.alpha = 0.0;
        shareOption.size = CGSizeMake(60, 115);
        
        [self addChild:shareOption];
        
        [floorPlan runAction:[SKAction scaleBy:1.3 duration:0.2] completion:^{
            [bottlePin runAction:[SKAction fadeInWithDuration:0.1]];
            [shareOption runAction:[SKAction fadeAlphaTo:0.2 duration:0.1]];
        }];
        
        _logoHeader = logo;
        _floorPlan = floorPlan;
        _levelLbl = levelLbl;
        _bottleOption = bottlePin;
        _shareOption = shareOption;
    }
    
    return self;
}

- (void)didFinishUpdate
{
    if (starWasPlaced && !shareIsAvailable)
    {
        [_shareOption runAction:[SKAction fadeAlphaTo:1.0 duration:0.2] completion:^{
            shareIsAvailable = YES;
        }];
        [_bottleOption runAction:[SKAction fadeAlphaTo:0.2 duration:0.2]];
    }
    else if (!starWasPlaced && shareIsAvailable)
    {
        [_shareOption runAction:[SKAction fadeAlphaTo:0.2 duration:0.2] completion:^{
            shareIsAvailable = NO;
        }];
        [_bottleOption runAction:[SKAction fadeAlphaTo:1.0 duration:0.2]];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPnt = [touch locationInNode:self];
    
    if ([_floorPlan containsPoint:touchPnt] && !starWasPlaced)
    {
        [self dropPinAtLocation:touchPnt];
    }
    else if ([_logoHeader containsPoint:touchPnt])
    {
        [self.scene.view presentScene:[[HomeScene alloc] initWithSize:self.size] transition:[SKTransition fadeWithDuration:0.8]];
    }
    else if (touchPnt.y < CGRectGetMinY(_levelLbl.frame))
    {
        [self displayFeatureConsiderations];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint lastTouch = [touch locationInNode:self];
    CGPoint firstTouch = [touch previousLocationInNode:self];
    
    if (starWasPlaced && [_floorPlan containsPoint:firstTouch])
    {
        if (![_floorPlan containsPoint:lastTouch])
        {
            [_placedPin removeFromParent];
            starWasPlaced = NO;
        }
        else
        {
            [_placedPin removeActionForKey:@"PulseKey"];
            
            if (!movingStar)
            {
                [_placedPin runAction:[SKAction scaleTo:2.0 duration:0.2]];
                movingStar = YES;
            }
            
            [_placedPin runAction:[SKAction moveTo:lastTouch duration:0.1]];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPnt = [touch locationInNode:self];
    
    if (movingStar && [_floorPlan containsPoint:touchPnt])
    {
        [_placedPin runAction:[SKAction scaleTo:1.0 duration:0.2]];
        movingStar = NO;
        
        SKAction *bigger = [SKAction scaleTo:0.6 duration:0.5];
        SKAction *smaller = [SKAction scaleTo:0.3 duration:0.5];
        SKAction *pulse = [SKAction sequence:@[bigger, smaller]];
        
        [_placedPin runAction:[SKAction sequence:@[[SKAction scaleTo:0.5 duration:0.3],
                                                   [SKAction repeatActionForever:pulse]]]
                      withKey:@"PulseKey"];
    }
}

- (void)dropPinAtLocation:(CGPoint)point
{
    SKSpriteNode *bottlePin = [SKSpriteNode spriteNodeWithImageNamed:@"TableStar"];
    bottlePin.position = point;
    [bottlePin runAction:[SKAction scaleTo:0.1 duration:0.0]];
    
    [self addChild:bottlePin];
    
    SKAction *bigger = [SKAction scaleTo:0.6 duration:0.5];
    SKAction *smaller = [SKAction scaleTo:0.3 duration:0.5];
    SKAction *pulse = [SKAction sequence:@[bigger, smaller]];
    
    [bottlePin runAction:[SKAction sequence:@[[SKAction scaleTo:0.5 duration:0.3],
                                              [SKAction repeatActionForever:pulse]]]
                 withKey:@"PulseKey"];

    _placedPin = bottlePin;
    starWasPlaced = YES;
}


- (void)displayFeatureConsiderations
{
    
    if (!adSpaceTouched)
    {
        SKLabelNode *title = [SKLabelNode labelNodeWithText:@"Purchasing Power"];
        title.fontName = @"HelveticaNeue-Light";
        title.fontSize = 18;
        title.fontColor = [UIColor lightGrayColor];
        
        title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(_levelLbl.frame) - 60);
        
        SKLabelNode *opt1 = [SKLabelNode labelNodeWithText:@"1. Tables now?"];
        SKLabelNode *opt2 = [SKLabelNode labelNodeWithText:@"2. Tables in the future?"];
        SKLabelNode *opt3 = [SKLabelNode labelNodeWithText:@"3. Drinks to a location?"];
        SKLabelNode *opt4 = [SKLabelNode labelNodeWithText:@"AD SPACE"];
        
        SKAction *fadeOut = [SKAction fadeOutWithDuration:0.0];
        
        opt1.fontName = @"HelveticaNeue-Thin";
        opt1.fontSize = 15;
        opt1.fontColor = [UIColor lightGrayColor];
        opt1.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(title.frame) - 15);
        [opt1 runAction:fadeOut];
        
        opt2.fontName = @"HelveticaNeue-Thin";
        opt2.fontSize = 15;
        opt2.fontColor = [UIColor lightGrayColor];
        opt2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(opt1.frame) - 15);
        [opt2 runAction:fadeOut];
        
        opt3.fontName = @"HelveticaNeue-Thin";
        opt3.fontSize = 15;
        opt3.fontColor = [UIColor lightGrayColor];
        opt3.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(opt2.frame) - 15);
        [opt3 runAction:fadeOut];
        
        opt4.fontName = @"HelveticaNeue-Thin";
        opt4.fontSize = 30;
        opt4.fontColor = [UIColor lightGrayColor];
        opt4.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(_levelLbl.frame) - 100);
        [opt4 runAction:fadeOut];
        
        opt1.name = @"opt1";
        opt2.name = @"opt2";
        opt3.name = @"opt3";
        opt4.name = @"opt4";
        
        [self addChild:title];
        [self addChild:opt1];
        [self addChild:opt2];
        [self addChild:opt3];
        [self addChild:opt4];
        
        NSArray *intervals = @[[SKAction waitForDuration:0.8],
                               [SKAction runAction:[SKAction fadeInWithDuration:0.2] onChildWithName:@"opt1"],
                               [SKAction waitForDuration:0.8],
                               [SKAction runAction:[SKAction fadeInWithDuration:0.2] onChildWithName:@"opt2"],
                               [SKAction waitForDuration:0.8],
                               [SKAction runAction:[SKAction fadeInWithDuration:0.2] onChildWithName:@"opt3"],
                               [SKAction waitForDuration:1.6]];
        
        [self runAction:[SKAction sequence:intervals] completion:^{
            [opt4 runAction:[SKAction fadeInWithDuration:0.2]];
            [title runAction:[SKAction removeFromParent]];
            [opt1 runAction:[SKAction removeFromParent]];
            [opt2 runAction:[SKAction removeFromParent]];
            [opt3 runAction:[SKAction removeFromParent]];
        }];
        
        adSpaceTouched = YES;
    }
}

- (void)willMoveFromView:(SKView *)view
{
    [self removeAllChildren];
}

@end
