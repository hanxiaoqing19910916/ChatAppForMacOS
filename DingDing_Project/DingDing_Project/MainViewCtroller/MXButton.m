//
//  MXButton.m
//  Mixim
//
//  Created by Joe Rickerby on 04/08/2015.
//  Copyright (c) 2015 Mixim Technology Ltd. All rights reserved.
//

#import "MXButton.h"

@interface MXButtonCell : NSButtonCell 

@property (assign) CGFloat cornerRadius;
@property (strong) NSColor *background;
@property (strong) NSColor *highlightColor;
@property (strong) NSColor *textColor;
@property (strong) NSColor *highlightTextColor;
@property (assign) NSEdgeInsets padding;

@end

@interface MXButton ()

@property (strong) MXButtonCell *cell;

@end

@implementation MXButton

@dynamic cell;
@dynamic cornerRadius, backgroundColor, highlightColor, textColor, highlightTextColor;

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    
    if (self) {
        self.cornerRadius = 4;
        
        self.font = [NSFont systemFontOfSize:13];
        self.subpixelAntialiasing = YES;
        
        self.wantsLayer = YES;
    }
    
    return self;
}

- (id)initWithHighlightColor:(NSColor *)highlightColor
{
    self = [self initWithFrame:NSMakeRect(0, 0, 0, 0)];
    
    if (self){
       self.highlightColor = highlightColor;
       self.highlightTextColor = highlightColor;
    }
    
    return self;
}




- (void)drawRect:(NSRect)dirtyRect
{
    // Get the graphics context.
    CGContextRef context = [[NSGraphicsContext currentContext] CGContext];
    
    // Save the graphics context state.
    CGContextSaveGState(context);
    
    // Set up font rasterization so that subpixel antialiasing is used.
    CGContextSetShouldSmoothFonts(context, self.subpixelAntialiasing);
    CGContextSetShouldSubpixelPositionFonts(context, self.subpixelAntialiasing);
    CGContextSetShouldSubpixelQuantizeFonts(context, self.subpixelAntialiasing);
    
    // Draw the button.
    [super drawRect:dirtyRect];
    
    // Restore the graphics context state.
    CGContextRestoreGState(context);
}

+ (Class)cellClass
{
    return [MXButtonCell class];
}

#pragma mark Cell passthroughs

- (CGFloat)cornerRadius
{
    return self.cell.cornerRadius; 
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.cell.cornerRadius = cornerRadius; 
}
- (NSColor *)backgroundColor
{
    return self.cell.background;
}
- (void)setBackgroundColor:(NSColor *)backgroundColor
{
    self.cell.backgroundColor = backgroundColor;
    self.cell.background = backgroundColor;
}
- (NSColor *)highlightColor
{
    return self.cell.highlightColor; 
}
- (void)setHighlightColor:(NSColor *)highlightColor
{
    self.cell.highlightColor = highlightColor; 
}
- (NSColor *)textColor
{
    return self.cell.textColor; 
}
- (void)setTextColor:(NSColor *)textColor
{
    self.cell.textColor = textColor;
//    NSLog(@"buttonCell-------%@",self.cell);

}
- (NSColor *)highlightTextColor
{
    return self.cell.highlightTextColor;
}
- (void)setHighlightTextColor:(NSColor *)textColor
{
    self.cell.highlightTextColor = textColor;
}
- (NSEdgeInsets)padding
{
    return self.cell.padding;
}
- (void)setPadding:(NSEdgeInsets)padding
{
    self.cell.padding = padding;
}

//- (BOOL)sendAction:(SEL)theAction to:(id)theTarget {
//    
//    return YES;
//}


- (void)mouseDown:(NSEvent *)theEvent {

    [super mouseDown:theEvent];
}

@end

@implementation MXButtonCell
/**
 *  鼠标高亮点击时候会调用
 */
- (void)highlight:(BOOL)flag withFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    
//    [super highlight:flag withFrame:cellFrame inView:controlView];
}


- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    [super drawInteriorWithFrame:cellFrame inView:controlView];

     if (self.highlighted) {
         
          NSLog(@"drawInteriorWithFrame");
         NSGraphicsContext* ctx = [NSGraphicsContext currentContext];
         [ctx saveGraphicsState];
         {
//             
//             
//             //Highlight BG
//             [[NSBezierPath bezierPathWithRoundedRect:cellFrame
//                                              xRadius:self.cornerRadius
//                                              yRadius:self.cornerRadius] setClip];
//             
//             [self.highlightColor setFill];
//             
//             NSRectFillUsingOperation(cellFrame, NSCompositeSourceIn);
//             
//             //Draw title text over it
//             NSMutableAttributedString *attrString = [self.attributedTitle mutableCopy];
//             [attrString beginEditing];
//             [attrString addAttribute:NSForegroundColorAttributeName value:[NSColor whiteColor] range:NSMakeRange(0, [attrString length])];
//             [attrString endEditing];

         }
         [ctx restoreGraphicsState];
     }
}

- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView
{
    NSGraphicsContext* ctx = [NSGraphicsContext currentContext];
    
    [ctx saveGraphicsState];
    {
        // 圆角
//        [[NSBezierPath bezierPathWithRoundedRect:frame
//                                         xRadius:self.cornerRadius
//                                         yRadius:self.cornerRadius] setClip];
//
//            [self.background setFill];
//            NSRectFillUsingOperation(frame, NSCompositeSourceOver);
    }
    [ctx restoreGraphicsState];
}

- (NSRect)drawTitle:(NSAttributedString *)title withFrame:(NSRect)frame inView:(NSView *)controlView
{
    NSGraphicsContext* ctx = [NSGraphicsContext currentContext];
    NSRect result;
    [ctx saveGraphicsState];
    {
        NSLog(@"MXButtonCell------%@",self.textColor);
        
        if (self.textColor && !self.highlighted) {
            NSMutableAttributedString *attrString = [title mutableCopy];

            [attrString beginEditing];
            [attrString addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, [attrString length])];
            [attrString endEditing];
            
            title = attrString;
            
            result = [super drawTitle:title withFrame:frame inView:controlView];
        }
        
    }
    [ctx restoreGraphicsState];
    
    return result;
}

- (NSRect)titleRectForBounds:(NSRect)theRect
{
    NSEdgeInsets padding = self.padding;
    
    theRect.origin.x += padding.left;
    theRect.origin.y += padding.top;
    theRect.size.width -= (padding.left + padding.right);
    theRect.size.height -= (padding.top + padding.bottom);
    
    return theRect;
}


- (NSRect)imageRectForBounds:(NSRect)theRect {
    
    NSRect rect = NSMakeRect(10, 0, 40, theRect.size.height);
    return rect;
     
    
}



//- (NSSize)cellSizeForBounds:(NSRect)aRect
//{
//    NSSize result = [super cellSizeForBounds:aRect];
//    NSEdgeInsets padding = self.padding;
//
//    result.width += padding.left + padding.right;
//    result.height += padding.top + padding.bottom;
//    
//    return result;
//}

/*- (NSSize)intrinsicContentSize
{

    
}
 */

@end