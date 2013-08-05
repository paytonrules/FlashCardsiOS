#import "SimpleTableFactory.h"

@interface SimpleTableFactory()

@property(strong) NSArray *cards;

@end

@implementation SimpleTableFactory

+(id) factoryWithCards:(CardInfo *) card, ...
{
  NSMutableArray *cards = [NSMutableArray array];
  va_list args;
  va_start(args, card);
  for (CardInfo *arg = card; arg != nil; arg = va_arg(args, CardInfo *))
  {
    [cards addObject:[NSValue valueWithBytes:arg objCType:@encode(CardInfo)]];
  }
  va_end(args);
  
  return [[[SimpleTableFactory alloc] initWithCards:cards] autorelease];
}

-(id) initWithCards:(NSArray *) cards
{
  self = [super init];
  if (self) {
    self.cards = [NSArray arrayWithArray:cards];
  }
  return self;
}

-(NSArray *) create
{
  return self.cards;
}

@end
