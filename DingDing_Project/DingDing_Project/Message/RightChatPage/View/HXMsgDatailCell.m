//
//  HXMsgDatailCell.m
//  DingDing_Project
//
//  Created by hanxiaoqing on 2016/10/9.
//  Copyright © 2016年 HXQ. All rights reserved.
//

#import "HXMsgDatailCell.h"
#import "HXPrefixHeader.h"

#import "HXTextView.h"
#import "NSMutableAttributedString+CTFrameRef.h"
#import "NSMutableAttributedString+Config.h"

@interface HXMsgDatailCell ()

@property (weak) IBOutlet NSImageView *iconImageView;

@property (weak) IBOutlet NSTextField *nameLabel;

@property (weak) IBOutlet NSTextField *timeLable;

@property (unsafe_unretained) IBOutlet HXTextView *attTextView;

@property (weak) IBOutlet NSLayoutConstraint *textHeightCons;
@property (weak) IBOutlet NSLayoutConstraint *textWidthCons;

@end

@implementation HXMsgDatailCell

- (void)awakeFromNib {
    
    self.attTextView.textContainerInset = NSMakeSize(5, 10.0);
    self.attTextView.drawsBackground = NO;
    self.attTextView.borderColor = HXColor(225, 224, 228);
    self.attTextView.font = [NSFont systemFontOfSize:14.0];
    self.attTextView.textColor = HXColor(70, 70, 70);

}



- (void)setMessage:(HXMessage *)message {
    _message = message;
    [self.iconImageView sd_setImageWithURL:message.profile_image placeholderImage:nil options:SDWebImageCircledImage];
    self.nameLabel.stringValue = message.name;
    
    // 2014-10-30 18:07:47
    self.timeLable.stringValue = [message.create_time substringWithRange:NSMakeRange(message.create_time.length - 5, 5)];
    
    
    CustomAttachMentCell *attCell = [[CustomAttachMentCell alloc] init];
    attCell.attachImage = [NSImage imageNamed:@"haha@2x"];
    attCell.attachSize = CGSizeMake(20, 20);

    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:message.text];
//    [attString apppendAttachmentCell:attCell];
    
    
    [attString setFont:[NSFont systemFontOfSize:14.0]];
    [attString setLineSpacing:5];
    [self.attTextView insertText:attString replacementRange:NSMakeRange(0, 0)];
    self.attTextView.editable = NO;
    CGSize textRealSize = [attString realitySizeForWidth:310 numberOfLines:0];
    CGFloat onelineWidth = [attString oneLineRealityWidth];
    if (onelineWidth <= 310.0) {
        self.textWidthCons.constant = textRealSize.width + 20;
    }
    self.textHeightCons.constant = textRealSize.height + 20;
    

}


- (void)layout {
    [super layout];
}

@end
