#import <UIKit/UIKit.h>
#import "Lesson.h"
#import "CardLookupFactory.h"
#import "RandomNumberGenerator.h"

@class Card;

@interface FirstLesson : NSObject<Lesson>

+(id) lessonWithSpriteTableFactory:(NSObject<CardLookupFactory>*) tableFactory andRandomNumberGenerator:(NSObject<RandomNumberGenerator>*) generator;
+(id) lessonWithSpriteTableFactory:(NSObject<CardLookupFactory>*) tableFactory;

-(Card *) getCard:(NSInteger) cardNumber;
@end
