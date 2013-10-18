#import <Foundation/Foundation.h>
#import "GameView.h"
#import "Lesson.h"
#import "cocos2d.h"

@interface LessonUserInterface : CCNode {
    
}

+(id) flashCardsControllerWith:(NSObject<Lesson>*) lesson view:(NSObject<GameView> *) view;


@end
