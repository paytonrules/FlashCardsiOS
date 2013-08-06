#ifndef FlashCardsiOS_CardInfo_h
#define FlashCardsiOS_CardInfo_h

typedef struct _CardInfo {
  NSString *spriteName;
  NSString *reading;
  CGPoint location;
  
} CardInfo;

CardInfo *createCard(NSString *name, NSString *reading, int x, int y);
#endif
