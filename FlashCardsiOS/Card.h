
#import <Foundation/Foundation.h>
#import "CardView.h"

@interface Card : NSObject

-(void) tap;
-(void) makeCurrent;
+(Card *) cardWithView:(NSObject<CardView> *)view;

@end
