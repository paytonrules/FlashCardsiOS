#import <UIKit/UIKit.h>
#import <CCScheduler.h>
#import "Scheduler.h"

@class CCScheduler;

@interface SchedulerWrapper : NSObject<Scheduler>

@property(readonly) CCScheduler *scheduler;

+(id) schedulerWrapperWithCocosScheduler:(CCScheduler *)sched;
-(void) scheduleOnce:(id) target action:(SEL) selector delay:(ccTime)delay;

@end
