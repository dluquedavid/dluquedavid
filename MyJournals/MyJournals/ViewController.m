//
//  ViewController.m
//  MyJournals
//
//  Created by developer on 13-06-11.
//  Copyright (c) 2013 developer. All rights reserved.
//

#import "ViewController.h"
#import "AppData.h"
#import "LoginVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(![AppData getIntance].isLoggin)
    {
        LoginVC *vc = [[[LoginVC  alloc] initWithNibName:@"LoginVC" bundle:nil] autorelease];
        UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:vc];
        navCtrl.navigationBar.barStyle=UIBarStyleBlackTranslucent;
        navCtrl.navigationBar.alpha=0;
        [self presentViewController:navCtrl animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
