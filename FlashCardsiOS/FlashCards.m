#import "FlashCards.h"
#import "CardSprite.h"


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
    background = [CCSprite spriteWithFile:@"background.jpg"];
		background.position = ccp(size.width/2, size.height/2);
    
    CardSprite *bug;
    bug = [[[CardSprite alloc] initWithFile:@"Enemy Bug.png"] autorelease];
    bug.position = ccp(200, 600);
    
		// add the label as a child to this Layer
		[self addChild: background];
    [self addChild: bug];
	}
	
	return self;
}
@end
