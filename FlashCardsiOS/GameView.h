//
//  GameView.h
//  FlashCardsiOS
//
//  Created by Eric Smith on 8/3/13.
//  Copyright (c) 2013 Eric Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameView <NSObject>
-(void) addNewSprite:(NSString *)filename atLocation:(CGPoint) location;
@end
