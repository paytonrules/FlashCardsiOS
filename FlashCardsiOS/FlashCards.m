//
//  IntroLayer.m
//  FlashCardsiOS
//
//  Created by Eric Smith on 7/31/13.
//  Copyright Eric Smith 2013. All rights reserved.
//


// Import the interfaces
#import "FlashCards.h"
#import "HelloWorldLayer.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation FlashCards

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	FlashCards *layer = [FlashCards node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init
{
	if( (self=[super init])) {
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;		
    background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
	}
	
	return self;
}
@end
