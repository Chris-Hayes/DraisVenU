//
//  HomeScene.m
//  Drai's VenU
//
//  Created by Chris Hayes on 4/16/15.
//  Copyright (c) 2015 CustomAppVentures. All rights reserved.
//

#import "HomeScene.h"
#import "BC1Scene.h"
#import "BC2Scene.h"
#import "NC1Scene.h"
#import "NC2Scene.h"
#import "AFScene.h"

@interface HomeScene ()
{
    BOOL clubSelected;
}

@property (nonatomic, weak)SKSpriteNode *beachClub1;
@property (nonatomic, weak)SKSpriteNode *nightClub1;
@property (nonatomic, weak)SKSpriteNode *beachClub2;
@property (nonatomic, weak)SKSpriteNode *nightClub2;
@property (nonatomic, weak)SKSpriteNode *afterHours;

@property (nonatomic, strong) SKSpriteNode *tableMenu;
@property (nonatomic, strong) SKSpriteNode *booth;
@property (nonatomic, strong) SKSpriteNode *cabana;

@property (nonatomic, strong) SKSpriteNode *tableStar;                      //          Table Submitted & Paid
@property (nonatomic, strong) SKSpriteNode *drinkOrder;                     //          Drink Order Submitted & Paid



@end

@implementation HomeScene
{
    BOOL tableSelected, menuOpened;
}

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor blackColor];
        
        clubSelected = NO;
        tableSelected = NO;
        menuOpened = NO;
        
        SKSpriteNode *logo = [SKSpriteNode spriteNodeWithImageNamed:@"DraisHeader"];
        logo.position = CGPointMake(CGRectGetMidX(self.frame), size.height - 65);
        
        [self addChild:logo];
        
        [self layoutPageContents];
    }
    
    return self;
}

- (void)layoutPageContents
{
    
    // FLOOR PLANS
    
    SKSpriteNode *beachClub1 = [SKSpriteNode spriteNodeWithImageNamed:@"DraisBC1"];
    SKSpriteNode *beachClub2 = [SKSpriteNode spriteNodeWithImageNamed:@"DraisBC2"];
    SKSpriteNode *nightClub1 = [SKSpriteNode spriteNodeWithImageNamed:@"DraisNC1"];
    SKSpriteNode *nightClub2 = [SKSpriteNode spriteNodeWithImageNamed:@"DraisNC2"];
    SKSpriteNode *afterHours = [SKSpriteNode spriteNodeWithImageNamed:@"DraisAH1"];
    
    beachClub1.position = CGPointMake(self.size.width * 0.28, self.size.height * 0.67);
    beachClub2.position = CGPointMake(self.size.width * 0.72, self.size.height * 0.67);
    nightClub1.position = CGPointMake(self.size.width * 0.28, self.size.height * 0.4);
    nightClub2.position = CGPointMake(self.size.width * 0.72, self.size.height * 0.4);
    afterHours.position = CGPointMake(self.size.width / 2, self.size.height * 0.15);
    
    beachClub1.name = @"BeachClub1_zoom";
    beachClub2.name = @"BeachClub2_zoom";
    nightClub1.name = @"Nightclub1_zoom";
    nightClub2.name = @"Nightclub2_zoom";
    afterHours.name = @"Afterhours_zoom";
    
    [self addChild:beachClub1];
    [self addChild:beachClub2];
    [self addChild:nightClub1];
    [self addChild:nightClub2];
    [self addChild:afterHours];
    
    _beachClub1 = beachClub1;
    _beachClub2 = beachClub2;
    _nightClub1 = nightClub1;
    _nightClub2 = nightClub2;
    _afterHours = afterHours;
    
    // CLUB NAMES
    
    SKLabelNode *labelBC = [SKLabelNode labelNodeWithText:@"Beach Club"];
    labelBC.fontSize = 18;
    labelBC.fontName = @"HelveticaNeue-Thin";
    labelBC.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(beachClub1.frame) + 3);
    
    SKLabelNode *labelNC = [SKLabelNode labelNodeWithText:@"Nightclub"];
    labelNC.fontSize = 18;
    labelNC.fontName = @"HelveticaNeue-Thin";
    labelNC.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(nightClub1.frame) + 6);
    
    SKLabelNode *labelAH = [SKLabelNode labelNodeWithText:@"Afterhours"];
    labelAH.fontSize = 18;
    labelAH.fontName = @"HelveticaNeue-Thin";
    labelAH.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(afterHours.frame) + 6);
    
    [self addChild:labelNC];
    [self addChild:labelBC];
    [self addChild:labelAH];
    
    // LEVEL LABELS
    
    uint fontsize = 12;
    
    SKLabelNode *bcL1 = [SKLabelNode labelNodeWithText:@"Level 1"];
    bcL1.fontName = @"HelveticaNeue-Thin";
    bcL1.fontSize = fontsize;
    bcL1.fontColor = [SKColor lightGrayColor];
    
    SKLabelNode *bcL2 = [SKLabelNode labelNodeWithText:@"Level 2"];
    bcL2.fontName = @"HelveticaNeue-Thin";
    bcL2.fontSize = fontsize;
    bcL2.fontColor = [SKColor lightGrayColor];
    
    SKLabelNode *ncL1 = [SKLabelNode labelNodeWithText:@"Level 1"];
    ncL1.fontName = @"HelveticaNeue-Thin";
    ncL1.fontSize = fontsize;
    ncL1.fontColor = [SKColor lightGrayColor];
    
    SKLabelNode *ncL2 = [SKLabelNode labelNodeWithText:@"Level 2"];
    ncL2.fontName = @"HelveticaNeue-Thin";
    ncL2.fontSize = fontsize;
    ncL2.fontColor = [SKColor lightGrayColor];
    
    for (int i = 0; i < 2; i++)
    {
        if (i == 0)
        {
            bcL1.position = CGPointMake(CGRectGetMidX(beachClub1.frame), CGRectGetMinY(beachClub1.frame) - 11);
            bcL2.position = CGPointMake(CGRectGetMidX(beachClub2.frame), CGRectGetMinY(beachClub2.frame) - 11);
            
            [self addChild:bcL1];
            [self addChild:bcL2];
        }
        else if (i == 1)
        {
            ncL1.position = CGPointMake(CGRectGetMidX(nightClub1.frame), CGRectGetMinY(nightClub1.frame) - 11);
            ncL2.position = CGPointMake(CGRectGetMidX(nightClub2.frame), CGRectGetMinY(nightClub2.frame) - 11);
            
            [self addChild:ncL1];
            [self addChild:ncL2];
        }
    }
}


// Settings Transition
// Calendar Transition
// Table Transition
// Drink Order Transition


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPnt = [touch locationInNode:self];
    
    if (!clubSelected)
    {
        if ([_beachClub1 containsPoint:touchPnt])
        {
            [self switchToDetailedFloorPlanOf:_beachClub1.name atLocation:_beachClub1.position];
        }
        else if ([_beachClub2 containsPoint:touchPnt])
        {
            [self switchToDetailedFloorPlanOf:_beachClub2.name atLocation:_beachClub2.position];
        }
        else if ([_nightClub1 containsPoint:touchPnt])
        {
            [self switchToDetailedFloorPlanOf:_nightClub1.name atLocation:_nightClub1.position];
        }
        else if ([_nightClub2 containsPoint:touchPnt])
        {
            [self switchToDetailedFloorPlanOf:_nightClub2.name atLocation:_nightClub2.position];
        }
        else if ([_afterHours containsPoint:touchPnt])
        {
            [self switchToDetailedFloorPlanOf:_afterHours.name atLocation:_afterHours.position];
        }
    }
}


- (void)switchToDetailedFloorPlanOf:(NSString *)clubName atLocation:(CGPoint)position
{
    SKSpriteNode *floorPlan = [SKSpriteNode spriteNodeWithImageNamed:clubName];
    [floorPlan runAction:[SKAction scaleBy:0.5f duration:0.0]];
    floorPlan.position = position;
    
    clubSelected = YES;
    
    [self addChild:floorPlan];
    [floorPlan runAction:[SKAction group:@[[SKAction scaleTo:1.0 duration:0.3],
                                           [SKAction moveTo:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)) duration:0.3]]] completion:^{
        
        if ([clubName isEqualToString:@"BeachClub1_zoom"])
        {
            BC1Scene *bc1 = [[BC1Scene alloc] initWithSize:self.size];
            [self.scene.view presentScene:bc1];
        }
        else if ([clubName isEqualToString:@"BeachClub2_zoom"])
        {
            BC2Scene *bc2 = [[BC2Scene alloc] initWithSize:self.size];
            [self.scene.view presentScene:bc2];
        }
        else if ([clubName isEqualToString:@"Nightclub1_zoom"])
        {
            NC1Scene *nc1 = [[NC1Scene alloc] initWithSize:self.size];
            [self.scene.view presentScene:nc1];
        }
        else if ([clubName isEqualToString:@"Nightclub2_zoom"])
        {
            NC2Scene *nc2 = [[NC2Scene alloc] initWithSize:self.size];
            [self.scene.view presentScene:nc2];
        }
        else if ([clubName isEqualToString:@"Afterhours_zoom"])
        {
            AFScene *aScene = [[AFScene alloc] initWithSize:self.size];
            [self.scene.view presentScene:aScene];
        }
    }];
}



@end
























