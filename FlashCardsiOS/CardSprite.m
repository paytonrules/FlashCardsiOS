#import "CardSprite.h"
#import "Card.h"
#import "SimpleAudioEngine.h"

@interface CardSprite ()
@property(strong) Card *card;
@property(readonly) CGRect rectInPixels;
@end

@implementation CardSprite

-(id) initWithFile:(NSString *)fileName andCard:(Card *)card
{
  self = [super initWithFile:fileName];
  if (self)
  {
    self.card = card;
    
    //Note - this isn't real optimized
    CCDirector* pDirector = [CCDirector sharedDirector];
    [[pDirector touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
  }
  
  return self;
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
  CGSize textureSize = [self.texture contentSizeInPixels];
  if ([Card contains: [self convertTouchToNodeSpaceAR:touch] inTextureSize:textureSize])
  {
    [self setScale:1.2f];
    return true;
  }
  return false;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
  [self setScale:1.0f];
  [self.card tap];
}



@end
