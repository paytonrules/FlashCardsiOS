
#import <Foundation/Foundation.h>
#import "CardLookupTable.h"

@class Card;

@protocol GameView <NSObject>

-(void) addNewSprite:(CardLookupTable *)cardInfo forCard:(Card *) card;

-(void) playCorrectSound;
-(void) playInCorrectSound;
-(void) playClue:(NSString *)reading;

@end
