#import <OCDSpec2/OCDSpec2.h>
#import "StandardRandomNumberGenerator.h"

OCDSpec2Context(StandardRandomNumberGeneratorSpec) {
  
  Describe(@"Generating Random Numbers", ^{
    
    It(@"creates a pseudorandom number for each next", ^{
      StandardRandomNumberGenerator *gen = [[[StandardRandomNumberGenerator alloc] initWithSeed:1] autorelease];
      
      // Since I set the seed to 1, these are the next three numbers
      [ExpectInt([gen next]) toBe:16807];
      [ExpectInt([gen next]) toBe:282475249];
      [ExpectInt([gen next]) toBe:1622650073];
    });
  });
}
