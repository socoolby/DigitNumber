//
//  DigitNumber.h
//  DigitNumber
//
//  Created by socoolby on 19/07/2017.
//  Copyright © 2017 YZXZYH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger,DNAlignType){
    DN_ALIGH_LEFT =0,
    DN_ALIGH_CENTER =1<<0,
    DN_ALIGH_RIGHT =1<<1,
};
@interface DigitNumber : UIView
@property(nonatomic,assign) NSInteger fontSize;
@property(nonatomic,assign) NSInteger fontPadding;
@property(nonatomic,assign) NSInteger padding;
@property(nonatomic,strong) UIColor *fontColor;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,assign)NSUInteger textAlias;
-(void)drawNumber:(NSInteger)num indexOfNumber:(NSInteger)index stringLength:(NSInteger)stringLength;
-(int)calculateMinWidth;
-(int)calculateMinHeight;
@end
