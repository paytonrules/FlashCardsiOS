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
//+(CCScene *) sceneWithLesson: lookup:
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

-(id) init
{
	if( (self=[super init])) {
    [self createBackground];
    
    [self preloadSoundEffects];
	}
	
	return self;
}

-(void) startLesson
{
  self.lesson = [FirstLesson new];
  [self.lesson startWithView:self];
  [self.lesson readFlashCard];
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

-(void) addNewSprite:(CardLookupTable *)cardInfo forCard:(Card *) card
{
  CardSprite *sprite;
  sprite = [[[CardSprite alloc] initWithFile:cardInfo.spriteName andCard:card] autorelease];
  sprite.position = cardInfo.location;
  [self addChild: sprite];
  
}

-(void) playCorrectSound
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"Powerup.wav"];
}

-(void) playInCorrectSound
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"jump.wav"];
}

-(void) playClue:(NSString *)reading
{
  [[SimpleAudioEngine sharedEngine] playEffect:reading];
}

@end
