// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameView.h"
#import "Lesson.h"

@interface LessonLayer : CCLayer<GameView>
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
