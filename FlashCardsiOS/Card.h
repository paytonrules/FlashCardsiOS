
#import <Foundation/Foundation.h>
#import "CardView.h"

@interface Card : NSObject

-(void) tap:(CGPoint) location;
-(void) makeCurrent;
+(Card *) cardWithView:(NSObject<CardView> *)view;

@end
