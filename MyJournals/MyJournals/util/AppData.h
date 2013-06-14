//
//  AlertHelper.m
//  
//
//  Created by David Rodriguez Luque <dluque.david@gmail.com> 
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppData : NSObject {
  
    
    BOOL isLoggin;  
}

+ (AppData *)getIntance;

@property(nonatomic,assign)  BOOL isLoggin;

@end
