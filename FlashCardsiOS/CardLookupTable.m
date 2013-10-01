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
  (self.cards)[name] = cardData;
}

-(CGPoint) locationByName:(NSString *) name
{
  NSDictionary *card = (self.cards)[name];
  return CGPointMake([card[@"location-x"] floatValue],
                     [card[@"location-y"] floatValue]);
}

-(NSString *) spriteByName:(NSString *) name
{
  NSDictionary *card = (self.cards)[name];
  return card[@"sprite"];
}

-(NSString *) readingByName:(NSString *) name
{
  NSDictionary *card = (self.cards)[name];
  return card[@"reading"];
}

-(NSArray *) allCards
{
  return [self.cards allKeys];
}

@end
