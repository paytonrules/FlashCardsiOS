//
//  Bug.h
//  FlashCardsiOS
//
//  Created by Eric Smith on 8/1/13.
//  Copyright 2013 Eric Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CardView.h"

@class Card;

@interface CardSprite : CCSprite<CCTouchOneByOneDelegate, CardView> {
}

-(id) initWithFile:(NSString *) fileName andCard:(Card *) card;

@end
