#import <UIKit/UIKit.h>
#import "Lesson.h"
#import "SpriteTableLookupFactory.h"
#import "RandomNumberGenerator.h"

@interface FirstLesson : NSObject<Lesson>

+(id) lessonWithSpriteTableFactory:(NSObject<SpriteTableLookupFactory>*) tableFactory andRandomNumberGenerator:(NSObject<RandomNumberGenerator>*) generator;
@end
