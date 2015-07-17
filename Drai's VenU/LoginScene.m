//
//  LoginScene.m
//  Drai's VenU
//
//  Created by Chris Hayes on 4/15/15.
//  Copyright (c) 2015 CustomAppVentures. All rights reserved.
//

#import "LoginScene.h"
#import "HomeScene.h"

@interface LoginScene ()
{
    SKSpriteNode * background;
    SKSpriteNode * loginHeader;
    SKSpriteNode * textboxBar1;
    SKSpriteNode * textboxBar2;
    UITextField * username;
    UITextField * password;
    SKSpriteNode * login;
    SKSpriteNode * signup;
    
    BOOL contentCreated;
    BOOL usernameIsFilled;
    BOOL passwordIsFilled;
    BOOL tappedOnce;
    
    CGFloat shiftFloat;
}

@end

@implementation LoginScene
{
    CGFloat tHeight, tWidth;
    CGSize sceneSize;
}


- (instancetype) initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        sceneSize = size;
        tWidth = size.width;
        tHeight = size.height;
        shiftFloat = 0.48;
        usernameIsFilled = NO;                      // Store username and in memory incase logout
        passwordIsFilled = NO;
        
        [self setupBackgroundWithSize:size];
        
        contentCreated = NO;
    }
    
    return self;
}

- (void)setupBackgroundWithSize:(CGSize)size
{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"DraisLoginEmpty"];
    background = [SKSpriteNode spriteNodeWithTexture:texture];
    background.size = size;
    background.position = CGPointMake(size.width / 2, size.height / 2);
    [self addChild: background];
    
    [self setupTextBoxes];
}

- (void)setupTextBoxes
{
    SKSpriteNode *userBox = [SKSpriteNode spriteNodeWithImageNamed:@"TextBoxBar"];
    userBox.position = CGPointMake(-25.0f, tHeight * 0.33);
    userBox.anchorPoint = CGPointMake(0, 0);
    userBox.alpha = 0.2;
    textboxBar1 = userBox;
    
    SKSpriteNode *passwordBox = [SKSpriteNode spriteNodeWithImageNamed:@"TextBoxBar"];
    passwordBox.position = CGPointMake(-25.0f, tHeight * 0.28);
    passwordBox.anchorPoint = CGPointMake(0, 0);
    passwordBox.alpha = 0.2;
    textboxBar2 = passwordBox;
    
    SKSpriteNode *loginBox = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:textboxBar1.size];
    loginBox.anchorPoint = CGPointMake(0, 0);
    loginBox.position = CGPointMake(-25.0f, tHeight * 0.22);
    login = loginBox;
    
    [self addChild:loginBox];
    [self addChild:userBox];
    [self addChild:passwordBox];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPnt = [touch locationInNode:self];
    
    if ([textboxBar1 containsPoint:touchPnt] && !usernameIsFilled)
    {
        [self autoTypeUsername:@"Mike_Lichwa"];
    }
    
    if ([textboxBar2 containsPoint:touchPnt] && !passwordIsFilled && usernameIsFilled)
    {
        [self autoTypePassword];
    }
    
    if (passwordIsFilled && usernameIsFilled && [login containsPoint:touchPnt])
    {
        HomeScene *homeScene = [[HomeScene alloc] initWithSize:self.size];
        SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
        
        [self.scene.view presentScene:homeScene transition:doors];
    }
}

- (void)autoTypeUsername:(NSString *)name
{
    SKLabelNode *nameLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-Thin"];
    nameLabel.fontColor = [SKColor whiteColor];
    nameLabel.fontSize = 20;
    nameLabel.position = CGPointMake(tWidth * 0.5, tHeight * 0.34);
    nameLabel.text = name;
    
    [self addChild:nameLabel];
    
    usernameIsFilled = YES;
}

- (void)autoTypePassword
{
    SKLabelNode *first;
    SKLabelNode *second;
    SKLabelNode *third;
    SKLabelNode *fourth;
    SKLabelNode *fifth;
    SKLabelNode *sixth;
    
    SKAction *startShift = [SKAction moveByX:-10.0f y:0.0f duration:0.3];
    
    NSArray *nameArray = @[@"D", @"r", @"a", @"i", @"'", @"s"];
    
    for (int i = 0; i < [nameArray count]; i++)
    {
        if (i == 0)
        {
            first = [SKLabelNode labelNodeWithText:nameArray[i]];
            first.fontSize = 20;
            first.fontName = @"HelveticaNeue-Thin";
            first.position = CGPointMake(tWidth * 0.62, tHeight * 0.29);
            
            [self addChild:first];
        }
        else if (i == 1)
        {
            [first runAction:[SKAction sequence:@[startShift, [SKAction runBlock:^{
                first.text = @"*";
                [first runAction:[SKAction moveToY:tHeight * 0.28 duration:0.0]];
            }]]]];
            
            second = [SKLabelNode labelNodeWithText:nameArray[i]];
            second.fontSize = 20;
            second.fontName = @"HelveticaNeue-Thin";
            second.position = CGPointMake(tWidth * 0.62, tHeight * 0.29);
            
            [self addChild:second];
        }
        else if (i == 2)
        {
            [first runAction:startShift];
            [second runAction:[SKAction sequence:@[startShift,
                                                   [SKAction runBlock:^{
                second.text = @"*";
                [second runAction:[SKAction moveToY:tHeight * 0.28 duration:0.0]];
            }]]]];
            
            third = [SKLabelNode labelNodeWithText:nameArray[i]];
            third.fontSize = 20;
            third.fontName = @"HelveticaNeue-Thin";
            third.position = CGPointMake(tWidth * 0.62, tHeight * 0.29);
            
            [self addChild:third];
        }
        else if (i == 3)
        {
            [first runAction:startShift];
            [second runAction:startShift];
            [third runAction:[SKAction sequence:@[startShift, [SKAction runBlock:^{
                third.text = @"*";
                [third runAction:[SKAction moveToY:tHeight * 0.28 duration:0.0]];
            }]]]];
            
            fourth = [SKLabelNode labelNodeWithText:nameArray[i]];
            fourth.fontSize = 20;
            fourth.fontName = @"HelveticaNeue-Thin";
            fourth.position = CGPointMake(tWidth * 0.62, tHeight * 0.29);
            
            [self addChild:fourth];
        }
        else if (i == 4)
        {
            [first runAction:startShift];
            [second runAction:startShift];
            [third runAction:startShift];
            [fourth runAction:[SKAction sequence:@[startShift, [SKAction runBlock:^{
                fourth.text = @"*";
                [fourth runAction:[SKAction moveToY:tHeight * 0.28 duration:0.0]];
            }]]]];
            
            fifth = [SKLabelNode labelNodeWithText:nameArray[i]];
            fifth.fontSize = 20;
            fifth.fontName = @"HelveticaNeue-Thin";
            fifth.position = CGPointMake(tWidth * 0.62, tHeight * 0.29);
            
            [self addChild:fifth];
        }
        else if (i == 5)
        {
            [first runAction:startShift];
            [second runAction:startShift];
            [third runAction:startShift];
            [fourth runAction:startShift];
            
            [fifth runAction:[SKAction sequence:@[startShift, [SKAction runBlock:^{
                fifth.text = @"*";
                [fifth runAction:[SKAction moveToY:tHeight * 0.28 duration:0.0]];
            }]]]];
            
            sixth = [SKLabelNode labelNodeWithText:nameArray[i]];
            sixth.fontSize = 20;
            sixth.fontName = @"HelveticaNeue-Thin";
            sixth.position = CGPointMake(tWidth * 0.62, tHeight * 0.29);
            
            [self addChild:sixth];
            
            [sixth runAction:[SKAction sequence:@[[SKAction waitForDuration:0.4], [SKAction runBlock:^{
                sixth.text = @"*";
                [sixth runAction:[SKAction moveToY:tHeight * 0.28 duration:0.0]];
            }]]]];
        }
    }
    
    passwordIsFilled = YES;
}



@end



















