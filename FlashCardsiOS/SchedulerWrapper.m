
#import "SchedulerWrapper.h"

@interface SchedulerWrapper ()

@property(strong) CCScheduler *scheduler;
@end

@implementation SchedulerWrapper

+(id) schedulerWrapperWithCocosScheduler:(CCScheduler *)sched
{
  return [[self alloc] initWithCocosScheduler:sched];
}

-(id) initWithCocosScheduler:(CCScheduler *)sched
{
    self = [super init];
    if (self) {
      self.scheduler = sched;
    }
    return self;
}


-(void) scheduleOnce:(id) target action:(SEL) selector delay:(ccTime)delay
{
  [self.scheduler scheduleSelector:selector forTarget:target interval:delay repeat:0 delay:delay paused:NO];
}



@end
