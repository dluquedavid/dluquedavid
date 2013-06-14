//
//  LoginVC.m
//  MyJournals
//
//  Created by developer on 13-06-11.
//  Copyright (c) 2013 developer. All rights reserved.
//

#import "LoginVC.h"
#import "AppData.h"
#import "ApiHelper.h"
#import "AlertHelper.h"
#import "JSON.h"
#import "JoinUsVC.h"

@interface LoginVC ()
{
    BOOL keyboardShown;
}
@end

@implementation LoginVC

#pragma mark - server
-(void)sendLogin
{
    NSData *responce= [ApiHelper login:self.txtUserName.text password:self.txtPassword.text];
    
   	[AlertHelper hideActivity];
    
    if (responce==nil) {
        [[[[UIAlertView alloc] initWithTitle:@"Error"
                                     message:@"Server Error"
                                    delegate:nil
                           cancelButtonTitle:@"Close"
                           otherButtonTitles:nil] autorelease] show];
        return;
    }
    
    NSString *content=[[NSString alloc] initWithData:responce encoding:NSUTF8StringEncoding];
    
    SBJSON *json = [[[SBJSON alloc] init] autorelease];
    NSDictionary *dict=[json objectWithString:content];
    [content release];
    
    NSLog(@"result: %@", dict);
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        
        if (![[dict objectForKey:@"success"] boolValue]) {
            [[[[UIAlertView alloc] initWithTitle:@"Error"
                                         message:[dict objectForKey:@"message"]
                                        delegate:nil
                               cancelButtonTitle:@"Close"
                               otherButtonTitles:nil] autorelease] show];
            return;
        }
        
        [AppData getIntance].isLoggin = true;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [[[[UIAlertView alloc] initWithTitle:@"Error"
                                     message:@"Server Error"
                                    delegate:nil
                           cancelButtonTitle:@"Close"
                           otherButtonTitles:nil] autorelease] show];
        return;
    }
    
    
}

#pragma mark - Actions
-(IBAction)touchLogin:(id)sender
{
    if (self.txtPassword.text.length <= 0 || self.txtUserName.text.length <= 0) {
                [[[[UIAlertView alloc] initWithTitle:@""
                                             message:@"You must select Username and Password"
                                            delegate:nil
                                   cancelButtonTitle:@"ok"
                                   otherButtonTitles:nil] autorelease] show];
        
        return;
    }
    
    [AlertHelper showActivity:@""];
    [self performSelector:@selector(sendLogin) withObject:nil afterDelay:0.2];
}

-(IBAction)touchJoinUs:(id)sender
{
    JoinUsVC *vc = [[[JoinUsVC alloc] initWithNibName:@"JoinUsVC" bundle:nil] autorelease];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (!IS_IPHONE5) {
        [self.scrollView setContentSize:CGSizeMake(320, 460)];
        [self.footerView setFrame:CGRectMake(0, 414, 320, 46)];
    }
    else
    {
        [self.scrollView setContentSize:CGSizeMake(320, 548)];
    }
    
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIKeyboardDidShowNotification

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardDidHideNotification object:nil];
}


- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if (keyboardShown)
        return;
    
    keyboardShown = TRUE;
    if (!IS_IPHONE5) {
        [self.scrollView setFrame:CGRectMake(0, 0, 320, 245)];
    }
    else{
        [self.scrollView setFrame:CGRectMake(0, 0, 320, 335)];
    }
}


- (void)keyboardWasHidden:(NSNotification*)aNotification
{
    keyboardShown = FALSE;
    
    [self.scrollView setFrame:CGRectMake(0, 0, 320, 548)];
}

#pragma mark - UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}
@end
