//
//  AlertHelper.m
//  
//
//  Created by David Rodriguez Luque <dluque.david@gmail.com> o
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppData.h"


@implementation AppData

@synthesize  isLoggin;

static AppData *_intance;

+(AppData *)getIntance
{
    @synchronized(self)
    {
        if (!_intance) {
            _intance = [[AppData alloc] init];
            //[NSTimer scheduledTimerWithTimeInterval:30 target:_intance selector:@selector(loadTerms:) userInfo:self repeats:YES];
        }
        
    }
    return _intance;
}
@end
