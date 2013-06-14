//
//
//  Created by David Rodriguez Luque <dluque.david@gmail.com> 
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ApiHelper.h"
#import "AppData.h"
#import "JSON.h"

@implementation ApiHelper

#pragma mark -
+(NSData*)login:(NSString*)username password:(NSString*)password
{
	NSString *url=@"http://staging.livingalpha.com/web_service/api/wsusers/login";
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setRequestHeaders:[NSMutableDictionary dictionaryWithObjectsAndKeys:OAUTH_KEY,@"OAUTH-KEY",OAUTH_ACCESS_CODE,@"OAUTH-ACCESS-CODE",@"application/json",@"Content-Type", nil]];
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",password,@"password",nil];
    [request setPostBody:[NSMutableData dataWithData:[[jsonDictionary JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding]]];
    request.timeOutSeconds=60;
    [request startSynchronous];
    
    NSError *error = [request error];
	if (!error) {
		NSString *response = [request responseString];
        NSLog(@"login response: %@", response); 
        return [request responseData];
    }
    
    return nil;
}

+(NSData*)joinUs:(NSString*)username
       firstname:(NSString*)firstname
        lastname:(NSString*)lastname
           email:(NSString*)email
        password:(NSString*)password
          waiver:(NSString*)waiver
     birth_month:(NSString*)birth_month
       birth_day:(NSString*)birth_day
      birth_year:(NSString*)birth_year
             sex:(NSString*)sex
{
    NSString *url=@"http://staging.livingalpha.com/web_service/api/wsusers/signup_mobile";
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setRequestHeaders:[NSMutableDictionary dictionaryWithObjectsAndKeys:OAUTH_KEY,@"OAUTH-KEY",OAUTH_ACCESS_CODE,@"OAUTH-ACCESS-CODE",@"application/json",@"Content-Type", nil]];
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",firstname,@"firstname",lastname,@"lastname",email,@"email",password,@"password",waiver,@"waiver",birth_month,@"birth_month",birth_day,@"birth_day",birth_year,@"birth_year",sex,@"sex",nil];
    [request setPostBody:[NSMutableData dataWithData:[[jsonDictionary JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding]]];
    request.timeOutSeconds=60;
    [request startSynchronous];
    
    NSError *error = [request error];
	if (!error) {
		NSString *response = [request responseString];
        NSLog(@"joinUs response: %@", response);
        return [request responseData];
    }
    
    return nil;
}

@end