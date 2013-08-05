#import <UIKit/UIKit.h>
#import "Lesson.h"
#import "SpriteTableLookupFactory.h"
#import "RandomNumberGenerator.h"

@class Card;

@interface FirstLesson : NSObject<Lesson>

+(id) lessonWithSpriteTableFactory:(NSObject<SpriteTableLookupFactory>*) tableFactory andRandomNumberGenerator:(NSObject<RandomNumberGenerator>*) generator;
+(id) lessonWithSpriteTableFactory:(NSObject<SpriteTableLookupFactory>*) tableFactory;

-(Card *) getCard:(NSInteger) cardNumber;
@end
