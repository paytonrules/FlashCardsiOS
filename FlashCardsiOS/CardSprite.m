//
//  Bug.m
//  FlashCardsiOS
//
//  Created by Eric Smith on 8/1/13.
//  Copyright 2013 Eric Smith. All rights reserved.
//

#import "CardSprite.h"
#import "Card.h"
#import "CocosDenshion.h"

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

-(CGRect) rectInPixels
{
  CGSize s = [self.texture contentSizeInPixels];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
  // these two lines seem testable
  CGPoint point = [self convertTouchToNodeSpaceAR:touch];
  if (CGRectContainsPoint(self.rectInPixels, point))
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
  
}

-(void) incorrect
{
}

- (void)dealloc
{
  [self.card release];
  [super dealloc];
}

@end
