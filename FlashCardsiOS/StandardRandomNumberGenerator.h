//
//  StandardRandomNumberGenerator.h
//  FlashCardsiOS
//
//  Created by Eric Smith on 8/4/13.
//  Copyright (c) 2013 Eric Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RandomNumberGenerator.h"

@interface StandardRandomNumberGenerator : NSObject<RandomNumberGenerator>

-(id) initWithSeed:(unsigned int) seed;

@end
