#import "Card.h"

@interface Card()

@property(strong) NSObject<CardView> *view;
@property(assign) BOOL current;
@end

@implementation Card

-(id) initWithView:(NSObject<CardView> *)view
{
    self = [super init];
    if (self) {
      self.view = view;
      self.current = NO;
    }
    return self;
}

+(Card *) cardWithView:(NSObject<CardView> *)view
{
  Card *tempCard = [[[Card alloc] initWithView:view] autorelease];
  
  return tempCard;
}

-(void) tap:(CGPoint) location
{
  if (CGRectContainsPoint(self.view.boundingBox, location))
  {
    if (self.current)
    {
      [self.view correct];
    }
    else
    {
      [self.view incorrect];
    }
  }
}

-(void) makeCurrent
{
  self.current = YES;
}

@end
