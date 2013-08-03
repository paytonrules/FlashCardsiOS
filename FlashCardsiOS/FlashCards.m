#import "FlashCards.h"
#import "Card.h"
#import "CardSprite.h"
#import "FirstLesson.h"
#import "SimpleAudioEngine.h"
#import "Lesson.h"

@interface FlashCards()

@property(strong) NSObject<Lesson> *lesson;
@end

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
  
  [layer startLesson];
	
	// return the scene
	return scene;
}

-(void) startLesson
{
  self.lesson = [FirstLesson new];
  [self.lesson startWithView:self];
}

-(void) createBackground
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *background;		
    background = [CCSprite spriteWithFile:@"background.jpg"];
    background.position = ccp(size.width/2, size.height/2);
    [self addChild: background];
}

-(void) preloadSoundEffects
{
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Powerup.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"jump.wav"];
}

-(void) addNewSprite:(NSString *)filename forCard:(Card *) card atLocation:(CGPoint) location
{
  CardSprite *sprite;
  sprite = [[[CardSprite alloc] initWithFile:filename] autorelease];
  sprite.position = location;
  [self addChild: sprite];
}

// Does this belong in init?  Probably not right
-(id) init
{
	if( (self=[super init])) {
    [self createBackground];
    
    [self addNewSprite:@"Enemy Bug.png" forCard:nil atLocation:ccp(200, 600)];
    
    [self preloadSoundEffects];
	}
	
	return self;
}
@end
