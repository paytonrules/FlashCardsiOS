#import <UIKit/UIKit.h>
#import "Lesson.h"
#import "CardLookupFactory.h"
#import "RandomNumberGenerator.h"

@class Card;

@interface FirstLesson : NSObject<Lesson>

+(id) lessonWithCardLookup:(NSObject<CardLookup> *) cardLookup;
+(id) lessonWithCardLookup:(NSObject<CardLookup> *) cardLookup andRandomNumberGenerator:(NSObject<RandomNumberGenerator>*) generator;

-(Card *) getCard:(NSInteger) cardNumber;

@end
