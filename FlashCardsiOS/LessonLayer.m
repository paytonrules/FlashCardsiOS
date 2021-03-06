#import "LessonLayer.h"
#import "Card.h"
#import "CardSprite.h"
#import "SimpleAudioEngine.h"
#import "FirstLesson.h"
#import "LessonUserInterface.h"

@interface LessonLayer()

@property(strong) NSObject<Lesson> *lesson;
@property(strong) NSObject<SpriteLookup> *lookup;
@property(strong) LessonUserInterface *cont;

@end

@implementation LessonLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	LessonLayer *layer = [LessonLayer node];


  // Plist file
  CardLookupTable *lookupTable = [CardLookupTable new];
  [lookupTable add:@{@"sprite" : @"Enemy Bug.png",
                     @"reading" : @"bug.mp3",
                     @"location-x" : @200,
                     @"location-y" : @400} named: @"bug"];
  
  [lookupTable add:@{@"sprite" : @"Star.png",
                     @"reading" : @"star.mp3",
                     @"location-x" : @700,
                     @"location-y" : @400} named: @"star"];
  
  [lookupTable add:@{@"sprite" : @"Tree Tall.png",
                     @"reading" : @"tree.mp3",
                     @"location-x" : @450,
                     @"location-y" : @600} named: @"tree"];
  NSObject<Lesson> *lesson = [FirstLesson lessonWithCardLookup:lookupTable];
  
  LessonUserInterface *cont = [LessonUserInterface flashCardsControllerWith:lesson view:layer];
  [layer addChild:cont];
  
  layer.lesson = lesson;
  layer.lookup = lookupTable;
  layer.cont = cont;
  
	// add layer as a child to scene
	[scene addChild: layer];
  [layer.cont startLesson];
  [layer scheduleUpdate];
	
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
  [[SimpleAudioEngine sharedEngine] preloadEffect:@"lost-stuff.mp3"];
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

-(void) showIntroduction:(NSObject<UserInterface>*)ui
{
  [self stopAllActions];
  CCSprite *mole = [CCSprite spriteWithFile:@"mole.png"];
  [mole setPosition:CGPointMake(-100.0, 100.0)];
  [self addChild:mole];
  
  id removeMySprite = [CCCallFuncND actionWithTarget:mole
                                            selector:@selector(removeFromParentAndCleanup:)
                                                data:(void*)NO];

  id move = [CCMoveBy actionWithDuration:0.3 position:CGPointMake(250, 0.0)];
  id moveBack = [move reverse];
  [mole runAction:[CCSequence actions:
                   [CCEaseIn actionWithAction:move rate:1.0],
                   [CCCallFunc actionWithTarget:self selector:@selector(playIntroduction)],
                   [CCDelayTime actionWithDuration:3],
                   [CCEaseIn actionWithAction:moveBack rate:1.0],
                   removeMySprite,
                   [CCCallFunc actionWithTarget:ui selector:@selector(introductionComplete)],
                   nil]];
}

-(void) playIntroduction
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"lost-stuff.mp3"];
}

-(void) update:(ccTime)delta
{
  [self.cont update:delta];
}

@end
