#import <Foundation/Foundation.h>
#import <cocos2d/ccTypes.h>

@protocol Scheduler <NSObject>

-(void) scheduleOnce:(id) target action:(SEL) selector delay:(ccTime)delay;

@end
