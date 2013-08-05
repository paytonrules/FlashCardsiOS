#import "Card.h"

@interface Card()

@property(strong) NSObject<Lesson> *lesson;
@property(assign) BOOL current;

@end

@implementation Card

-(id) initWithLesson:(NSObject<Lesson> *) lesson
{
    self = [super init];
    if (self) {
      self.lesson = lesson;
      self.current = NO;
    }
    return self;
}

+(Card *) cardWithLesson:(NSObject<Lesson> *) lesson
{
  Card *tempCard = [[[Card alloc] initWithLesson:lesson] autorelease];
  
  return tempCard;
}

-(void) tap
{
  self.current ? [self.lesson correctGuess] : [self.lesson incorrectGuess];
}

-(void) makeCurrent
{
  self.current = YES;
}

+(BOOL) contains:(CGPoint)nodeSpaceLocation inTextureSize:(CGSize) textureSize
{
  CGRect tempRect = CGRectMake(-textureSize.width / 2,
                               -textureSize.height /2,
                               textureSize.width,
                               textureSize.height);
  return CGRectContainsPoint(tempRect, nodeSpaceLocation);
}

@end
