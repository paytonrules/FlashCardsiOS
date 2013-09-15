#import <Foundation/Foundation.h>
#include "CardLookupTable.h"

@implementation CardLookupTable

+(CardLookupTable *) cardInfoWithName:(NSString *)name reading:(NSString *)reading atLocation:(CGPoint) location
{
  CardLookupTable *info = [[CardLookupTable new] autorelease];
  info.spriteName = name;
  info.reading = reading;
  info.location = location;
  return info;
  
}

@end