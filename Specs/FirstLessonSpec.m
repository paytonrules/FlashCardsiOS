#import <OCDSpec2/OCDSpec2.h>
#import <OCMock/OCMock.h>
#import "FirstLesson.h"
#import "SpriteTableLookupFactory.h"
#import "RandomNumberGenerator.h"
#import "CardInfo.h"

CardInfo *createCard(NSString *name, int x, int y)
{
  CardInfo *info = malloc(sizeof(CardInfo));
  memset(info, 0, sizeof(CardInfo));
  info->spriteName = name;
  info->location = CGPointMake(x, y);
  return info;
}

@interface SimpleTableFactory : NSObject<SpriteTableLookupFactory>
@property(strong) NSArray *cards;
+(id) factoryWithCards:(CardInfo *)card, ... NS_REQUIRES_NIL_TERMINATION;
@end

@implementation SimpleTableFactory

+(id) factoryWithCards:(CardInfo *) card, ...
{
  NSMutableArray *cards = [NSMutableArray array];
  va_list args;
  va_start(args, card);
  for (CardInfo *arg = card; arg != nil; arg = va_arg(args, CardInfo *))
  {
    [cards addObject:[NSValue valueWithBytes:arg objCType:@encode(CardInfo)]];
  }
  va_end(args);
  
  return [[SimpleTableFactory alloc] initWithCards:cards];
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

@interface SimpleRandomNumberGenerator : NSObject<RandomNumberGenerator>
@property(strong) NSMutableArray *numbers;
@end

@implementation SimpleRandomNumberGenerator

-(id) initWithRandomNumbers:(NSArray *)numbers
{
    self = [super init];
    if (self) {
      self.numbers = [NSMutableArray arrayWithArray:numbers];
    }
    return self;
}

-(int) next
{
  int nextNum = [[self.numbers objectAtIndex:0] intValue];
  if (self.numbers.count > 1)
  {
    [self.numbers removeObjectAtIndex:0];
  }
  
  return nextNum;
}
@end

OCDSpec2Context(FirstLessonSpec) {
  
  Describe(@"The first lesson", ^{
    
    It(@"starts by creating a sprite from a card", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[SimpleRandomNumberGenerator alloc]
                                                           initWithRandomNumbers:@[@0]];
      
      NSObject<SpriteTableLookupFactory> *tableFactory =[SimpleTableFactory
                                                         factoryWithCards:createCard(@"huzzah", 2, 4), nil];
      
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      CGPoint location = CGPointMake(2, 4);
      
      NSObject<Lesson> *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory
                                                  andRandomNumberGenerator: simpleGenerator];
      
      [[view expect] addNewSprite:@"huzzah"
                          forCard:[OCMArg any]
                       atLocation:location];
      
      [lesson startWithView:view];
      
      [view verify];
    });
    
    It(@"chooses the next sprite based on the random number and the length of the list", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[SimpleRandomNumberGenerator alloc]
                                                            initWithRandomNumbers:@[@0, @1]];
      
      NSObject<SpriteTableLookupFactory> *tableFactory =[SimpleTableFactory
                                                         factoryWithCards:createCard(@"huzzah", 2, 4),
                                                                          createCard(@"again", 1, 1),
                                                                          nil];
      
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      NSObject<Lesson> *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory
                                                  andRandomNumberGenerator: simpleGenerator];

      [view setExpectationOrderMatters:YES];
      [[view expect] addNewSprite:@"huzzah"
                          forCard:[OCMArg any]
                       atLocation:CGPointMake(2, 4)];

      [[view expect] addNewSprite:@"again"
                          forCard:[OCMArg any]
                       atLocation:CGPointMake(1, 1)];
      
      [lesson startWithView:view];
      [lesson addCard];
      
      [view verify];
    });
    
    // Need an actual random number generator
    // Need an actual table lookup
    // Need to make the default first lesson use those
    
    
  });
  
}
