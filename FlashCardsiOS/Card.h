
#import <Foundation/Foundation.h>
#import "CardView.h"

@interface Card : NSObject

-(void) tap;
-(void) makeCurrent;
-(BOOL) contains:(CGPoint) nodeSpaceLocation;
+(Card *) cardWithView:(NSObject<CardView> *)view;

@end
