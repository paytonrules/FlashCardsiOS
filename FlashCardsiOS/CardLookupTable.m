#import <Foundation/Foundation.h>
#include "CardLookupTable.h"

@interface CardLookupTable()
@property(strong) NSMutableDictionary *cards;
@end

@implementation CardLookupTable

-(id) init
{
  self = [super init];
  if (self) {
    self.cards = [NSMutableDictionary dictionary];
  }
  return self;
}

-(void) add:(NSDictionary *)cardData named:(NSString *)name
{
  [self.cards setObject:cardData forKey:name];
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

-(NSArray *) allCards
{
  return [self.cards allKeys];
}

@end
