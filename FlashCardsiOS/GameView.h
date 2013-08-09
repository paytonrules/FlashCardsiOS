
#import <Foundation/Foundation.h>
#import "CardInfo.h"

@protocol GameView <NSObject>

-(void) addNewSprite:(NSString *)filename forCard:(NSObject *) card atLocation:(CGPoint) location;
-(void) addNewSprite:(CardInfo *)cardInfo forCard:(NSObject *) card;

-(void) playCorrectSound;
-(void) playInCorrectSound;

@end
