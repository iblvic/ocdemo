//
//  CTDisplayView.m
//  ocdemo
//
//  Created by haosimac on 2023/6/27.
//

#import "CTDisplayView.h"
#import <CoreText/CoreText.h>

@implementation CTDisplayView
static inline CGFloat YYTextDegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
}

- (void)setText:(NSString *)text {
    _text = text;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.text.length == 0) {
        return;
    }
    // 步骤 1
    CGContextRef context = UIGraphicsGetCurrentContext();

    // 步骤 2
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextTranslateCTM(context, 30, 30);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -rect.size.height);

    // 步骤 3
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);

    // 步骤 4
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:self.text ?: @""];
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, [attString length]), path, NULL);

    // 步骤 5
    CFArrayRef lines = CTFrameGetLines(frame);
    CGFloat lineY = rect.size.height - 16;
    for (NSInteger i = 0; i < CFArrayGetCount(lines); i++) {
        CFArrayRef runs = CTLineGetGlyphRuns(CFArrayGetValueAtIndex(lines, i));
        //    CGContextRotateCTM(context, YYTextDegreesToRadians(-90));
            CGContextSetTextPosition(context, 0, lineY);
        //    CTLineDraw(CFArrayGetValueAtIndex(lines, 0), context);
        for (NSInteger j = 0; j < CFArrayGetCount(runs); j++) {
            CTRunDraw(CFArrayGetValueAtIndex(runs, j), context, CFRangeMake(0, 0));
        }
        lineY -= 16;
    }
//    CTFrameDraw(frame, context);

    // 步骤 6
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 20, 60, 30) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(15, 15)];
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGContextSetLineWidth(context, 2);
//    [UIColor.blackColor setStroke];
//    CGPathMoveToPoint(path, nil, 30, 10);
//    CGPathAddLineToPoint(path, nil, 0, 40);
//    CGPathAddLineToPoint(path, nil, 60, 40);
//    CGPathCloseSubpath(path);
//    CGContextAddPath(context, path);
//    CGContextStrokePath(context);
}

//NSAttributedString* applyParaStyle(
//                CFStringRef fontName , CGFloat pointSize,
//                                   CFStringRef plainText, CGFloat lineSpaceInc){
//
//    // Create the font so we can determine its height.
//    CTFontRef font = CTFontCreateWithName(fontName, pointSize, NULL);
//
//    // Set the lineSpacing.
//    CGFloat lineSpacing = (CTFontGetLeading(font) + lineSpaceInc) * 2;
//
//    // Create the paragraph style settings.
//    CTParagraphStyleSetting setting;
//
//    setting.spec = kCTParagraphStyleSpecifierLineSpacing;
//    setting.valueSize = sizeof(CGFloat);
//    setting.value = &lineSpacing;
//
//    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(&setting, 1);
//
//    // Add the paragraph style to the dictionary.
//    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                               (__bridge id)font, (id)kCTFontNameAttribute,
//                               (__bridge id)paragraphStyle,
//                               (id)kCTParagraphStyleAttributeName, nil];
//    CFRelease(font);
//    CFRelease(paragraphStyle);
//
//    // Apply the paragraph style to the string to created the attributed string.
//    NSAttributedString* attrString = [[NSAttributedString alloc]
//                                      initWithString:(__bridge NSString*)plainText
//                                      attributes:attributes];
//
//    return attrString;
//}
//
//- (void)drawRect:(CGRect)rect {
//    // Initialize a graphics context in iOS.
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    // Flip the context coordinates in iOS only.
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//
//    // Set the text matrix.
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//
//    CFStringRef fontName = CFSTR("Didot Italic");
//    CGFloat pointSize = 24.0;
//
//    CFStringRef string = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
//
//    // Apply the paragraph style.
//    NSAttributedString* attrString = applyParaStyle(fontName, pointSize, string, 10.0);
//
//    // Put the attributed string with applied paragraph style into a framesetter.
//    CTFramesetterRef framesetter =
//             CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
//
//    // Create a path to fill the View.
//    CGPathRef path = CGPathCreateWithRect(rect, NULL);
//
//    // Create a frame in which to draw.
//    CTFrameRef frame = CTFramesetterCreateFrame(
//                                    framesetter, CFRangeMake(0, 0), path, NULL);
//
//    // Draw the frame.
//    CTFrameDraw(frame, context);
//    CFRelease(frame);
//    CGPathRelease(path);
//    CFRelease(framesetter);
//}

// Create a path in the shape of a donut.
//static void AddSquashedDonutPath(CGMutablePathRef path,
//              const CGAffineTransform *m, CGRect rect)
//{
//    CGFloat width = CGRectGetWidth(rect);
//    CGFloat height = CGRectGetHeight(rect);
//
//    CGFloat radiusH = width / 3.0;
//    CGFloat radiusV = height / 3.0;
//
//    CGPathMoveToPoint( path, m, rect.origin.x, rect.origin.y + height - radiusV);
//    CGPathAddQuadCurveToPoint( path, m, rect.origin.x, rect.origin.y + height,
//                               rect.origin.x + radiusH, rect.origin.y + height);
//    CGPathAddLineToPoint( path, m, rect.origin.x + width - radiusH,
//                               rect.origin.y + height);
//    CGPathAddQuadCurveToPoint( path, m, rect.origin.x + width,
//                               rect.origin.y + height,
//                               rect.origin.x + width,
//                               rect.origin.y + height - radiusV);
//    CGPathAddLineToPoint( path, m, rect.origin.x + width,
//                               rect.origin.y + radiusV);
//    CGPathAddQuadCurveToPoint( path, m, rect.origin.x + width, rect.origin.y,
//                               rect.origin.x + width - radiusH, rect.origin.y);
//    CGPathAddLineToPoint( path, m, rect.origin.x + radiusH, rect.origin.y);
//    CGPathAddQuadCurveToPoint( path, m, rect.origin.x, rect.origin.y,
//                               rect.origin.x, rect.origin.y + radiusV);
//    CGPathCloseSubpath( path);
//
//    CGPathAddEllipseInRect( path, m,
//                            CGRectMake( rect.origin.x + width / 2.0 - width / 5.0,
//                            rect.origin.y + height / 2.0 - height / 5.0,
//                            width / 5.0 * 2.0, height / 5.0 * 2.0));
//}
//
//// Generate the path outside of the drawRect call so the path is calculated only once.
//- (NSArray *)paths
//{
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGRect bounds = self.bounds;
//    bounds = CGRectInset(bounds, 10.0, 10.0);
//    AddSquashedDonutPath(path, NULL, bounds);
//
//    NSMutableArray *result =
//              [NSMutableArray arrayWithObject:CFBridgingRelease(path)];
//    return result;
//}
//
//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//
//    // Initialize a graphics context in iOS.
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    // Flip the context coordinates in iOS only.
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//
//    // Set the text matrix.
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//
//    // Initialize an attributed string.
//    CFStringRef textString = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
//
//    // Create a mutable attributed string.
//     CFMutableAttributedStringRef attrString =
//                CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
//
//    // Copy the textString into the newly created attrString.
//    CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0), textString);
//
//    // Create a color that will be added as an attribute to the attrString.
//    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
//    CGFloat components[] = { 1.0, 0.0, 0.0, 0.8 };
//    CGColorRef red = CGColorCreate(rgbColorSpace, components);
//    CGColorSpaceRelease(rgbColorSpace);
//
//    // Set the color of the first 13 chars to red.
//    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 13),
//                                     kCTForegroundColorAttributeName, red);
//
//    // Create the framesetter with the attributed string.
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
//
//    // Create the array of paths in which to draw the text.
//    NSArray *paths = [self paths];
//
//    CFIndex startIndex = 0;
//
//    // In OS X, use NSColor instead of UIColor.
//    #define GREEN_COLOR [UIColor greenColor]
//    #define YELLOW_COLOR [UIColor yellowColor]
//    #define BLACK_COLOR [UIColor blackColor]
//
//    // For each path in the array of paths...
//    for (id object in paths) {
//        CGPathRef path = (__bridge CGPathRef)object;
//
//        // Set the background of the path to yellow.
//        CGContextSetFillColorWithColor(context, [YELLOW_COLOR CGColor]);
//
//        CGContextAddPath(context, path);
//        CGContextFillPath(context);
//
//        CGContextDrawPath(context, kCGPathStroke);
//
//        // Create a frame for this path and draw the text.
//        CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
//                                         CFRangeMake(startIndex, 0), path, NULL);
//        CTFrameDraw(frame, context);
//
//        // Start the next frame at the first character not visible in this frame.
//        CFRange frameRange = CTFrameGetVisibleStringRange(frame);
//        startIndex += frameRange.length;
//        CFRelease(frame);
//}
//
//CFRelease(attrString);
//CFRelease(framesetter);
//}

//- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGRect bounds = self.bounds;
//    CGRect insetBounds = CGRectInset(bounds, 10, 10);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:insetBounds];
//    CGContextAddRect(context, bounds);
//    CGContextAddPath(context, path.CGPath);
//    CGContextEOClip(context);
//    CGContextAddRect(context, bounds);
//    CGContextSetLineWidth(context, 40);
////    [UIColor.yellowColor setFill];
////    CGContextFillPath(context);
////    CGContextEOFillPath(context);
//    [UIColor.greenColor setStroke];
//    CGContextStrokePath(context);
//}
@end
