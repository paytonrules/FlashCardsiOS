
#import <Foundation/Foundation.h>
#import "CardLookupTable.h"
#import "UserInterface.h"

@class Card;

@protocol GameView <NSObject>

-(void) addCard:(Card *) card;
-(void) playCorrectSound;
-(void) playInCorrectSound;
-(void) playClue:(Card *)card;
-(void) showIntroduction:(NSObject<UserInterface>*) del;

@end
