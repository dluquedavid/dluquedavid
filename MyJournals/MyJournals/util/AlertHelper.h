//
//  AlertHelper.h
//  
//
//  Created by David Rodriguez Luque <dluque.david@gmail.com>.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AlertHelper : UIAlertView {

}

+ (void) setBackgroundColor:(UIColor *) background withStrokeColor:(UIColor *) stroke;
+ (void) showActivity:(NSString*)title;
+ (void) hideActivity;


- (void) drawRoundedRect:(CGRect) rect inContext:(CGContextRef) context withRadius:(CGFloat) radius;
@end
