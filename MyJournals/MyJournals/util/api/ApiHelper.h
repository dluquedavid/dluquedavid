//
//
//  Created by David Rodriguez Luque <dluque.david@gmail.com> 
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
	
@interface ApiHelper : NSObject

+(NSData*)login:(NSString*)username password:(NSString*)password;
+(NSData*)joinUs:(NSString*)username
       firstname:(NSString*)firstname
        lastname:(NSString*)lastname
           email:(NSString*)email
        password:(NSString*)password
          waiver:(NSString*)waiver
     birth_month:(NSString*)birth_month
       birth_day:(NSString*)birth_day
      birth_year:(NSString*)birth_year
             sex:(NSString*)sex;

@end