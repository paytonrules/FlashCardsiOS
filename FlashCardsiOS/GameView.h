
#import <Foundation/Foundation.h>
#import "CardLookupTable.h"

@class Card;

@protocol GameView <NSObject>

-(void) addCard:(Card *) card;
-(void) playCorrectSound;
-(void) playInCorrectSound;
-(void) playClue:(NSString *)reading;

@end
