//
//  Bug.m
//  FlashCardsiOS
//
//  Created by Eric Smith on 8/1/13.
//  Copyright 2013 Eric Smith. All rights reserved.
//

#import "CardSprite.h"
#import "Card.h"
#import "SimpleAudioEngine.h"

@interface CardSprite ()
@property(strong) Card *card;
@property(readonly) CGRect rectInPixels;
@end

@implementation CardSprite

-(id) initWithFile:(NSString *)fileName
{
  self = [super initWithFile:fileName];
  if (self)
  {
    self.card = [Card cardWithView:self];
    [self.card makeCurrent];
    
    //Note - this isn't real optimized
    CCDirector* pDirector = [CCDirector sharedDirector];
    [[pDirector touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
  }
  
  return self;
}

-(CGSize) textureSize
{
  return [self.texture contentSizeInPixels];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
  if ([self.card contains: [self convertTouchToNodeSpaceAR:touch]])
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

-(void) correct
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"Powerup.wav"];
}

-(void) incorrect
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"jump.wav"];
}

- (void)dealloc
{
  [self.card release];
  [super dealloc];
}

@end
