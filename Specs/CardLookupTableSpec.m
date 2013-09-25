#import <OCDSpec2/OCDSpec2.h>
#import "CardLookupTable.h"

OCDSpec2Context(CardLookupTable) {
  
  Describe(@"creating card info structures", ^{
    
    It(@"creates a card info structure", ^{
      CardLookupTable *info = [CardLookupTable cardInfoWithName:@"name"
                                        reading:@"reading"
                                     atLocation:CGPointMake(0, 1)];
      
      [ExpectInt(info.location.x) toBe:0];
      [ExpectInt(info.location.y) toBe:1];
      [ExpectStr(info.spriteName) toContain:@"name"];
      [ExpectStr(info.reading) toContain:@"reading"];
    });
    
    It(@"returns location information for a card", ^{
      CardLookupTable *table = [CardLookupTable new];
      [table add:@{@"name" : @"eric", 
                    @"location-x" : [NSNumber numberWithInt:1],
                    @"location-y" : [NSNumber numberWithInt:2]}];

      NSObject<SpriteLookup> *lookup = table;

      [ExpectInt([lookup locationByName:@"eric"].x) toBe: 1];
      [ExpectInt([lookup locationByName:@"eric"].y) toBe: 2];
    });

    It(@"returns sprite information for a card", ^{
      CardLookupTable *table = [CardLookupTable new];
      [table add:@{@"name" : @"eric", 
                    @"sprite" : @"sprite.png"}];

      NSObject<SpriteLookup> *lookup = table;

      [ExpectObj([lookup spriteByName:@"eric"]) toBe: @"sprite.png"];
    });

    It(@"returns reading information for a card", ^{
      CardLookupTable *table = [CardLookupTable new];
      [table add:@{@"name" : @"eric", 
                    @"reading" : @"reading.mp3"}];

      NSObject<SpriteLookup> *lookup = table;

      [ExpectObj([lookup readingByName:@"eric"]) toBe: @"reading.mp3"];
    });

    It(@"retruns all the cards in the table, by name", ^{
      CardLookupTable *table = [CardLookupTable new];
      [table add:@{@"name" : @"eric"}];
      [table add:@{@"name" : @"rick"}];

      NSObject<CardLookup> *lookup = table;

      [ExpectObj([[lookup allCards] objectAtIndex:0]) toBe:@"eric"];
      [ExpectObj([[lookup allCards] objectAtIndex:1]) toBe:@"rick"];
    });
  });
}
