#ifndef FlashCardsiOS_CardInfo_h
#define FlashCardsiOS_CardInfo_h

typedef struct _CardInfo {
  NSString *spriteName;
  CGPoint location;
  
} CardInfo;

CardInfo *createCard(NSString *name, int x, int y);
#endif
