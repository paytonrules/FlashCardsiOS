#import <Foundation/Foundation.h>
#include "CardLookupTable.h"

@interface CardLookupTable()
@property(strong) NSMutableDictionary *cards;
@end

@implementation CardLookupTable

// This should die
// it makes no sense
+(CardLookupTable *) cardInfoWithName:(NSString *)name reading:(NSString *)reading atLocation:(CGPoint) location
{
  CardLookupTable *info = [[CardLookupTable new] autorelease];
  info.spriteName = name;
  info.reading = reading;
  info.location = location;
  return info;
}

-(id) init
{
  self = [super init];
  if (self) {
    self.cards = [NSMutableDictionary dictionary];
  }
  return self;
}

-(void) add:(NSDictionary *)cardData
{
  [self.cards setObject:cardData forKey:[cardData objectForKey:@"name"]];
}

-(CGPoint) locationByName:(NSString *) name
{
  NSDictionary *card = [self.cards objectForKey:name];
  return CGPointMake([[card objectForKey:@"location-x"] floatValue],
                     [[card objectForKey:@"location-y"] floatValue]);
}

-(NSString *) spriteByName:(NSString *) name
{
  NSDictionary *card = [self.cards objectForKey:name];
  return [card objectForKey:@"sprite"];
}

-(NSString *) readingByName:(NSString *) name
{
  NSDictionary *card = [self.cards objectForKey:name];
  return [card objectForKey:@"reading"];
}

@end
