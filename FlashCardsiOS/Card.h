
#import <Foundation/Foundation.h>
#import "Lesson.h"

@interface Card : NSObject

+(BOOL) contains:(CGPoint) nodeSpaceLocation inTextureSize:(CGSize) size;
+(Card *) cardWithName: (NSString *) name lesson:(NSObject<Lesson> *) lesson;

-(id) initWithName:(NSString *) name;
-(id) initWithName:(NSString *) name lesson:(NSObject<Lesson> *) lesson;
-(void) tap;
-(void) makeCurrent;

@property(readonly) BOOL current;
@property(readonly) NSObject<Lesson> *lesson;
@property(readonly) NSString *name;

@end
