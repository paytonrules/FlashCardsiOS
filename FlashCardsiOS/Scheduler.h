#import <Foundation/Foundation.h>

@protocol Scheduler <NSObject>

-(void) scheduleOnce:(id) target action:(SEL) selector delay:(ccTime)delay;

@end
