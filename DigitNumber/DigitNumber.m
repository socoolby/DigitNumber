//
//  DigitNumber.m
//  DigitNumber
//
//  Created by socoolby on 19/07/2017.
//  Copyright © 2017 YZXZYH. All rights reserved.
//

#import "DigitNumber.h"



@implementation DigitNumber
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

/*1-13: 0,1,2,3,4,5,6,7,8,9,:,-,space,Unknow*/
static int const DN[14]={0b111111000,0b001100000,0b011011100,0b011110100,0b101100100,0b110110100,0b110111100,0b011100000,0b111111100,0b111110100,0b000000011,0b000000100,0b000000000,0b111111111};
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        [self loadView];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self loadView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self setNeedsDisplay];
}
- (void)loadView{
    self.fontSize=60;
    self.fontPadding=5;
    self.padding=5;
    self.textAlias=DN_ALIGH_LEFT;
}
-(void)setTextAlias:(NSUInteger)textAlias{
    _textAlias=textAlias;
    [self setNeedsDisplay];
}
-(void)setContent:(NSString *)content{
    _content=content;
    [self setNeedsDisplay];
}
-(void)setFontPadding:(NSInteger)fontMargin{
    _fontPadding=fontMargin;
    [self setNeedsDisplay];
}
-(void)setFontSize:(NSInteger)fontSize{
    _fontSize=fontSize;
    [self setNeedsDisplay];
}
-(void)setPadding:(NSInteger)margin{
    if(margin<0)
        _padding=0;
    else
    _padding=margin;
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect{
    NSInteger len=[self.content length];
    for(int i=0;i<len;i++){
        char c=[self.content characterAtIndex:i];
        if(c>=48 && c<=58){
            [self drawNumber:c-48 indexOfNumber:i stringLength:len];
        }else if(c=='-'){
            [self drawNumber:11 indexOfNumber:i stringLength:len];
        }else if(c==' '){
            [self drawNumber:12 indexOfNumber:i stringLength:len];
        }else{
             [self drawNumber:13 indexOfNumber:i stringLength:len];
        }
    }
}
-(int)calculateMinWidth{
    float height=self.fontSize;
    float width=ceilf(height/1.670678337);
    NSUInteger stringLength=self.content.length;
    int fontsWidth=self.padding*2+stringLength*width+(stringLength-1)*self.fontPadding;
    return fontsWidth;
}
-(int)calculateMinHeight{
    float height=self.fontSize+2*self.padding;
    return height;
}
-(void)drawNumber:(NSInteger)num indexOfNumber:(NSInteger)index stringLength:(NSInteger)stringLength
{
    int number=DN[num];
    CGContextRef context=UIGraphicsGetCurrentContext();
    float height=self.fontSize;
    float width=ceilf(height/1.670678337);
    int frameWidth=self.frame.size.width;
    
    NSInteger x=0;
    NSInteger y=self.padding;
    if(self.textAlias==DN_ALIGH_LEFT){
        x=self.padding+(index*(self.fontPadding+width));
    }else if(self.textAlias==DN_ALIGH_CENTER){
        int fontsWidth=stringLength*width+(stringLength-1)*self.fontPadding;
        x=(frameWidth-fontsWidth)/2+(width*index+self.fontPadding*index);
        y=(self.frame.size.height-height)/2;
    }else if(self.textAlias==DN_ALIGH_RIGHT){
        x=frameWidth-(self.padding+(stringLength-index)*width+(stringLength-index-1)*self.fontPadding);
    }
    x=x<0?0:x;
    y=y<0?0:y;
    float fontWidth=ceilf(height/9.31097561);
    float conerMarging=ceilf(height/50.9);
    float middleMargin=ceil(height/25.032786885);
    float halfHeight=height/2;
    float halfFontWidth=fontWidth/2;
    
    if((number>>8&0b1)==0b1)
    {
        CGPoint dLeftTop[5];
        dLeftTop[0]=CGPointMake(x+0,y+floorf(conerMarging));
        dLeftTop[1]=CGPointMake(x+fontWidth, y+floorf(fontWidth+conerMarging));
        dLeftTop[2]=CGPointMake(x+fontWidth,y+halfHeight-halfFontWidth-height/29.3);
        dLeftTop[3]=CGPointMake(x+middleMargin,y+ halfHeight-fontWidth/5.3);
        dLeftTop[4]=CGPointMake(x+0, y+halfHeight-halfFontWidth-fontWidth/15.4);
        CGContextAddLines(context, dLeftTop, 5);
    }
    if((number>>7&0b1)==0b1)
    {
        CGPoint dTop[4];
        dTop[0] =CGPointMake(x+conerMarging, y+0);
        dTop[1] =CGPointMake(x+width-conerMarging, y+0);
        dTop[2] =CGPointMake(x+width-fontWidth-conerMarging, y+fontWidth);
        dTop[3] =CGPointMake(x+fontWidth+conerMarging, y+fontWidth);
        CGContextAddLines(context, dTop, 4);
    }
    if((number>>6&0b1)==0b1)
    {
        CGPoint dRightTop[5];
        dRightTop[0]=CGPointMake(x+width,y+conerMarging);
        dRightTop[1]=CGPointMake(x+width-fontWidth, y+fontWidth+conerMarging);
        dRightTop[2]=CGPointMake(x+width-fontWidth,y+halfHeight-halfFontWidth-height/29.3);
        dRightTop[3]=CGPointMake(x+width-middleMargin, y+halfHeight-fontWidth/5.3);
        dRightTop[4]=CGPointMake(x+width, y+halfHeight-halfFontWidth-fontWidth/15.4);
        CGContextAddLines(context, dRightTop, 5);
    }
    if((number>>5&0b1)==0b1)
    {
        CGPoint dRightButtom[5];
        dRightButtom[0]=CGPointMake(x+width,y+height-conerMarging);
        dRightButtom[1]=CGPointMake(x+width-fontWidth, y+height-fontWidth-conerMarging);
        dRightButtom[2]=CGPointMake(x+width-fontWidth,y+halfHeight+halfFontWidth+height/29.3);
        dRightButtom[3]=CGPointMake(x+width-middleMargin, y+halfHeight+fontWidth/5.3);
        dRightButtom[4]=CGPointMake(x+width, y+halfHeight+halfFontWidth+fontWidth/15.4);
        CGContextAddLines(context, dRightButtom, 5);
    }
    if((number>>4&0b1)==0b1)
    {
        CGPoint dButtom[4];
        dButtom[0] =CGPointMake(x+conerMarging, y+height);
        dButtom[1] =CGPointMake(x+width-conerMarging, y+height);
        dButtom[2] =CGPointMake(x+width-fontWidth-conerMarging, y+height-fontWidth);
        dButtom[3] =CGPointMake(x+fontWidth+conerMarging, y+height-fontWidth);
        CGContextAddLines(context, dButtom, 4);
    }
    if((number>>3&0b1)==0b1)
    {
        CGPoint dLeftButtom[5];
        dLeftButtom[0]=CGPointMake(x+0,y+height-conerMarging);
        dLeftButtom[1]=CGPointMake(x+fontWidth,y+ height-fontWidth-conerMarging);
        dLeftButtom[2]=CGPointMake(x+fontWidth,y+halfHeight+halfFontWidth+height/29.3);
        dLeftButtom[3]=CGPointMake(x+middleMargin,y+ halfHeight+fontWidth/5.3);
        dLeftButtom[4]=CGPointMake(x+0, y+halfHeight+halfFontWidth+fontWidth/15.4);
        CGContextAddLines(context, dLeftButtom, 5);
    }
    if((number>>2&0b1)==0b1)
    {
        
        CGPoint dMiddle[6];
        dMiddle[0]=CGPointMake(x+ceilf(fontWidth-fontWidth/2.26), y+halfHeight);
        dMiddle[1]=CGPointMake(x+ceilf(fontWidth+height/114.25), y+halfHeight-halfFontWidth);
        dMiddle[2]=CGPointMake(x+floorf(width-fontWidth-height/114.25), y+halfHeight-halfFontWidth);
        dMiddle[3]=CGPointMake(x+floorf(width-fontWidth+fontWidth/2.26), y+halfHeight);
        dMiddle[4]=CGPointMake(x+floorf(width-fontWidth-height/114.25), y+halfHeight+halfFontWidth);
        dMiddle[5]=CGPointMake(x+fontWidth+height/114.25, y+halfHeight+halfFontWidth);
        
        CGContextAddLines(context, dMiddle, 6);
    }
    if((number>>1&0b1)==0b1)
    {
        
        CGPoint dDotTop[4];
        dDotTop[0]=CGPointMake(x+width/2-halfFontWidth, y+(height+fontWidth)/4-halfFontWidth);
        dDotTop[1]=CGPointMake(x+width/2+halfFontWidth, y+(height+fontWidth)/4-halfFontWidth);
        dDotTop[2]=CGPointMake(x+width/2+halfFontWidth, y+(height+fontWidth)/4+halfFontWidth);
        dDotTop[3]=CGPointMake(x+width/2-halfFontWidth, y+(height+fontWidth)/4+halfFontWidth);
        CGContextAddLines(context, dDotTop, 4);
    }
    if((number&0b1)==0b1)
    {
        CGPoint dDotButtom[4];
        dDotButtom[0]=CGPointMake(x+width/2-halfFontWidth, y+halfHeight+(height-fontWidth)/4-halfFontWidth);
        dDotButtom[1]=CGPointMake(x+width/2+halfFontWidth, y+halfHeight+(height-fontWidth)/4-halfFontWidth);
        dDotButtom[2]=CGPointMake(x+width/2+halfFontWidth, y+halfHeight+(height-fontWidth)/4+halfFontWidth);
        dDotButtom[3]=CGPointMake(x+width/2-halfFontWidth, y+halfHeight+(height-fontWidth)/4+halfFontWidth);
        CGContextAddLines(context, dDotButtom, 4);
    }
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextSetFillColorWithColor(context,self.fontColor.CGColor);
    //    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
}
- (UIColor *)fontColor
{
    if (!_fontColor) {
        _fontColor = [UIColor blackColor];
    }
    return _fontColor;
}
@end
