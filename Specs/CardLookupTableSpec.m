#import <OCDSpec2/OCDSpec2.h>
#import "CardLookupTable.h"

OCDSpec2Context(CardLookupTable) {
  
  Describe(@"creating card info structures", ^{
       
    It(@"returns location information for a card", ^{
      CardLookupTable *table = [CardLookupTable new];
      [table add:@{@"location-x" : @1,
                   @"location-y" : @2}
           named:@"eric"];

      NSObject<SpriteLookup> *lookup = table;

      [ExpectInt([lookup locationByName:@"eric"].x) toBe: 1];
      [ExpectInt([lookup locationByName:@"eric"].y) toBe: 2];
    });

    It(@"returns sprite information for a card", ^{
      CardLookupTable *table = [CardLookupTable new];
      [table add:@{@"sprite" : @"sprite.png"} named:@"eric"];

      NSObject<SpriteLookup> *lookup = table;

      [ExpectObj([lookup spriteByName:@"eric"]) toBe: @"sprite.png"];
    });

    It(@"returns reading information for a card", ^{
      CardLookupTable *table = [CardLookupTable new];
      [table add:@{@"reading" : @"reading.mp3"} named:@"eric"];

      NSObject<SpriteLookup> *lookup = table;

      [ExpectObj([lookup readingByName:@"eric"]) toBe: @"reading.mp3"];
    });

    It(@"retruns all the cards in the table, by name", ^{
      CardLookupTable *table = [CardLookupTable new];
      [table add:@{} named:@"eric"];
      [table add:@{} named:@"rick"];

      NSObject<CardLookup> *lookup = table;

      [ExpectObj([lookup allCards][0]) toBe:@"eric"];
      [ExpectObj([lookup allCards][1]) toBe:@"rick"];
    });
  });
}
