//
//  JoinUsVC.m
//  MyJournals
//
//  Created by developer on 13-06-12.
//  Copyright (c) 2013 developer. All rights reserved.
//

#import "JoinUsVC.h"
#import "AlertHelper.h"
#import "ApiHelper.h"
#import "AppData.h"
#import "JSON.h"

@interface JoinUsVC ()
{
    BOOL keyboardShown;
    CGPoint position;
    UITextField *currentTextField;
}
@end

@implementation JoinUsVC

#pragma mark - server
-(void)sendJoinUs
{
    NSString *month = @"05";
    NSString *day = @"22";
    NSString *year = @"1990";
    
    NSString *sex = @"m";
    if (self.btnFemale.selected) {
        sex = @"f";
    }
                    
    NSData *responce= [ApiHelper joinUs:self.txtUserName.text
                              firstname:self.txtFirstName.text
                               lastname:self.txtLastName.text
                                  email:self.txtEmail.text
                               password:self.txtPassword.text
                                 waiver:@"Y"
                            birth_month:month
                              birth_day:day
                             birth_year:year
                                    sex:sex];
    
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
-(IBAction)touchBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)touchJoinUs:(id)sender
{
    /*if (self.txtPassword.text.length <= 0 || self.txtUserName.text.length <= 0) {
        [[[[UIAlertView alloc] initWithTitle:@""
                                     message:@"You must select Username and Password"
                                    delegate:nil
                           cancelButtonTitle:@"ok"
                           otherButtonTitles:nil] autorelease] show];
        
        return;
    }*/
    
    [AlertHelper showActivity:@""];
    [self performSelector:@selector(sendJoinUs) withObject:nil afterDelay:0.2];
}

-(IBAction)touchMale:(id)sender
{
    if (!self.btnMale.selected) {
        self.btnMale.selected = TRUE;
        self.btnFemale.selected = FALSE;
    }
}

-(IBAction)touchFemale:(id)sender
{
    if (!self.btnFemale.selected) {
        self.btnFemale.selected = TRUE;
        self.btnMale.selected = FALSE;
    }
}

-(IBAction)touchBirthDay:(id)sender
{
    
}

-(IBAction)touchUploadPhoto:(id)sender
{
    
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
    
    [self.scrollView addSubview:self.contentView];
    if (!IS_IPHONE5) {
        [self.scrollView setContentSize:CGSizeMake(320, 524)];
    }
    else
    {
        [self.scrollView setContentSize:CGSizeMake(320, 524)];
    }
    
    [self registerForKeyboardNotifications];
    
    position.x = 0;
    position.y = 0;
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
        [self.scrollView setFrame:CGRectMake(0, 46, 320, 200)];
    }
    else{
        [self.scrollView setFrame:CGRectMake(0, 46, 320, 289)];
    }
}

- (void)keyboardWasHidden:(NSNotification*)aNotification
{
    keyboardShown = FALSE;
    
    if (!IS_IPHONE5) {
        [self.scrollView setFrame:CGRectMake(0, 46, 320, 414)];
    }
    else
    {
        [self.scrollView setFrame:CGRectMake(0, 46, 320, 502)];
    }
}

#pragma mark - UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    currentTextField = textField;
    
    if (textField == self.txtUserName || textField == self.txtFirstName) {
        position.y = textField.frame.origin.y;
    }
    else {
        position.y = textField.frame.origin.y-69;
        [self.scrollView setContentOffset:position animated:YES];
    }
    
    return TRUE;
}

@end
