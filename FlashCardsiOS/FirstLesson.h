#import <UIKit/UIKit.h>
#import "Lesson.h"
#import "TableFactory.h"
#import "RandomNumberGenerator.h"

@interface FirstLesson : NSObject<Lesson>

+(id) lessonWithSpriteTableFactory:(NSObject<TableFactory>*) tableFactory andRandomNumberGenerator:(NSObject<RandomNumberGenerator>*) generator;
@end
