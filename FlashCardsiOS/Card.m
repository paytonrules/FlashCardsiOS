#import "Card.h"

@interface Card()

@property(strong) NSObject<Lesson> *lesson;
@property(assign) BOOL current;
@property(strong) NSString *name;

@end

@implementation Card

+(Card *) cardWithName: (NSString *) name lesson:(NSObject<Lesson> *) lesson
{
  Card *tempCard = [[Card alloc] initWithName:name lesson:lesson];
  
  return tempCard;
}

-(id) initWithName:(NSString *) name
{
  return [self initWithName:name lesson: nil];
}

-(id) initWithName:(NSString *) name lesson:(NSObject<Lesson> *) lesson
{
  self = [super init];
  if (self) {
    self.lesson = lesson;
    self.current = NO;
    self.name = name;
  }
  return self;
}

-(void) tap
{
  self.current ? [self.lesson correctGuess] : [self.lesson incorrectGuess];
}

-(void) makeUnCurrent
{
  self.current = NO;
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
