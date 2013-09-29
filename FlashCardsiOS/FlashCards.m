#import "FlashCards.h"
#import "Card.h"
#import "CardSprite.h"
#import "SimpleAudioEngine.h"

@interface FlashCards()

@property(strong) NSObject<Lesson> *lesson;
@property(strong) NSObject<SpriteLookup> *lookup;

@end

@implementation FlashCards

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) sceneWithLesson:(NSObject<Lesson> *)lesson spriteLookup:(NSObject<SpriteLookup> *)lookup
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	FlashCards *layer = [FlashCards node];
	
	// add layer as a child to scene
	[scene addChild: layer];

  layer.lesson = lesson;
  layer.lookup = lookup;
  [layer.lesson startWithView:layer];
  [layer.lesson readFlashCard];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self = [super init])) {
    // Not sure this belongs here
    [self createBackground];
    [self preloadSoundEffects];
	}
	
	return self;
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

-(void) addCard:(Card *)card
{
  CardSprite *sprite;
  sprite = [[CardSprite alloc] initWithFile:[self.lookup spriteByName:card.name]
                                     andCard: card];
  sprite.position = [self.lookup locationByName: card.name];
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

-(void) playClue:(Card *)card
{
  NSString *reading = [self.lookup readingByName:card.name];
  [[SimpleAudioEngine sharedEngine] playEffect:reading];
}

@end
