//
//  AlertHelper.m
//  
//
//  Created by David Rodriguez Luque <dluque.david@gmail.com>.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlertHelper.h"
#import <QuartzCore/QuartzCore.h>

static     AlertHelper *AlertView;

static UIColor *fillColor = nil;
static UIColor *borderColor = nil;

@implementation AlertHelper

+ (void) setBackgroundColor:(UIColor *) background withStrokeColor:(UIColor *) stroke
{
    if(fillColor != nil)
    {
        [fillColor release];
        [borderColor release];
    }

    fillColor = [background retain];
    borderColor = [stroke retain];
}


- (id)initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame]))
    {
        if(fillColor == nil)
        {
            fillColor = [[UIColor blackColor] retain];
            borderColor = [[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8] retain];
        }
    }

    return self;
}

- (void)layoutSubviews
{
	for (UIView *sub in [self subviews])
	{
		if([sub class] == [UIImageView class] && sub.tag == 0)
		{
			// The alert background UIImageView tag is 0, 
			// if you are adding your own UIImageView's 
			// make sure your tags != 0 or this fix 
			// will remove your UIImageView's as well!
			[sub removeFromSuperview];
			break;
		}
	}
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextClearRect(context, rect);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetLineWidth(context, 0.0);
    CGContextSetAlpha(context, 0.75);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [borderColor CGColor]);
    CGContextSetFillColorWithColor(context, [fillColor CGColor]);

    // Draw background
    CGFloat backOffset = 2;
    CGRect backRect = CGRectMake(120, 10, 49, 49);
    //CGRect backRect =CGRectMake(rect.origin.x + backOffset, rect.origin.y + backOffset, rect.size.width - backOffset*2, rect.size.height - backOffset*2);
    [self drawRoundedRect:backRect inContext:context withRadius:25];
    CGContextDrawPath(context, kCGPathFillStroke);

    // Clip Context
    CGRect clipRect = CGRectMake(backRect.origin.x + backOffset-1, backRect.origin.y + backOffset-1, backRect.size.width - (backOffset-1)*2, backRect.size.height - (backOffset-1)*2);
    [self drawRoundedRect:clipRect inContext:context withRadius:8];
    CGContextClip (context);


}

- (void) drawRoundedRect:(CGRect) rrect inContext:(CGContextRef) context withRadius:(CGFloat) radius
{
    CGContextBeginPath (context);

    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);

    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    CGContextClosePath(context);
}

+ (void) showActivity:(NSString*)title
{
     [AlertHelper setBackgroundColor:[UIColor clearColor] withStrokeColor:[UIColor clearColor]];
    //if (!AlertView) {
        
    
     AlertHelper *tmpAlertView = [[AlertHelper alloc] initWithTitle: @""
     message: nil
     delegate: self
     cancelButtonTitle: nil
     otherButtonTitles: nil];
    
    UIView *hudView = [[UIView alloc] initWithFrame:CGRectMake(90,-15, 100, 100)];
    hudView.layer.cornerRadius = 10;
    hudView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [tmpAlertView addSubview:hudView];
    
     UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
     activityView.frame = CGRectMake(125,20, 30, 30);
     [tmpAlertView addSubview:activityView];
     [activityView startAnimating];
     [activityView release];
     AlertView = tmpAlertView;
    //}
    [AlertView show];
}

+(void) hideActivity
{
   if(AlertView)
      [AlertView dismissWithClickedButtonIndex:99 animated:YES];
}
@end
