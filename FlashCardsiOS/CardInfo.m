#import <Foundation/Foundation.h>
#include "CardInfo.h"

@implementation CardInfo

+(CardInfo *) cardInfoWithName:(NSString *)name reading:(NSString *)reading atLocation:(CGPoint) location
{
  CardInfo *info = [[CardInfo new] autorelease];
  info.spriteName = name;
  info.reading = reading;
  info.location = location;
  return info;
  
}

@end