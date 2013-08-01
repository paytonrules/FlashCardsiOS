//
//  Bug.m
//  FlashCardsiOS
//
//  Created by Eric Smith on 8/1/13.
//  Copyright 2013 Eric Smith. All rights reserved.
//

#import "CardSprite.h"
#import "Card.h"

@interface CardSprite () {
  Card *card;
}

@end

@implementation CardSprite

-(id) initWithFile:(NSString *)fileName
{
  self = [super initWithFile:fileName];
  if (self)
  {
    card = [[Card alloc] init];
    
    //Note - this isn't real optimized
    CCDirector* pDirector = [CCDirector sharedDirector];
    [[pDirector touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
  }
  
  return self;
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
  return NO;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
}

- (void)dealloc
{
  [card release];
  [super dealloc];
}

@end
