
#import <Foundation/Foundation.h>
#import "Lesson.h"

@interface Card : NSObject

+(BOOL) contains:(CGPoint) nodeSpaceLocation inTextureSize:(CGSize) size;
+(Card *) cardWithLesson:(NSObject<Lesson> *) lesson;


-(void) tap;
-(void) makeCurrent;

@property(readonly) BOOL current;
@property(readonly) NSObject<Lesson> *lesson;

@end
