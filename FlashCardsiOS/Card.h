
#import <Foundation/Foundation.h>
#import "CardView.h"

@interface Card : NSObject

+(BOOL) contains:(CGPoint) nodeSpaceLocation inTextureSize:(CGSize) size;
+(Card *) cardWithView:(NSObject<CardView> *)view;


-(void) tap;
-(void) makeCurrent;

@property(readonly) BOOL current;

@end
