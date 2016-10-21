//
//  UILabel+VerticalAlignment.m
//  SingleMusic
//
//  Created by wer_chen on 15/9/1.
//  Copyright (c) 2015年 werchen. All rights reserved.
//

#import "UILabel+VerticalAlignment.h"


@implementation UILabel (VerticalAlignment)

@dynamic verticalAlignment;
- (void)setVerticalAlignment:(NSVerticalAlignment)verticalAlignment
{
    //  属性字典
    NSDictionary *attributes = @{NSFontAttributeName : self.font};
    
    //  视图高度
    CGFloat viewHeight = self.frame.size.height;
    
    //  单行字体高度
    CGFloat fontHeight = [self.text sizeWithAttributes:attributes].height;
    
    //  内容高度
    CGFloat contentHeight = [self.text boundingRectWithSize:self.frame.size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attributes context:nil].size.height;
    
    //  超出文字的行数
    NSInteger freeLines = (viewHeight  - contentHeight) / fontHeight;
    
    for(int i = 0; i<freeLines; i++) {
        switch (verticalAlignment) {
            case NSVerticalAlignmentTop:
                self.text = [self.text stringByAppendingString:@"\n"];
                break;
                
            case NSVerticalAlignmentBottom:
                self.text = [NSString stringWithFormat:@"\n%@",self.text];
                break;
        }
    }
}


@end
