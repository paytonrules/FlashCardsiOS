#import "SimpleCardLookupFactory.h"

@interface SimpleCardLookupFactory()

@property(strong) NSArray *cards;

@end

@implementation SimpleCardLookupFactory

+(id) factoryWithCards:(CardLookupTable *) card, ...
{
  NSMutableArray *cards = [NSMutableArray array];
  va_list args;
  va_start(args, card);
  for (CardLookupTable *arg = card; arg != nil; arg = va_arg(args, CardLookupTable *))
  {
    [cards addObject:arg];
  }
  va_end(args);
  
  return [[[SimpleCardLookupFactory alloc] initWithCards:cards] autorelease];
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
