
#import "StandardRandomNumberGenerator.h"

@implementation StandardRandomNumberGenerator

-(id) init
{
  return [self initWithSeed:time(NULL)];
}

-(id) initWithSeed:(unsigned int)seed
{
    self = [super init];
    if (self) {
      srand(seed);
    }
    return self;
}

-(int) next
{
  return rand();
}

@end
