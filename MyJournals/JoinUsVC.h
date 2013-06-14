//
//  JoinUsVC.h
//  MyJournals
//
//  Created by developer on 13-06-12.
//  Copyright (c) 2013 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinUsVC : UIViewController<UITextFieldDelegate>

@property(nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong) IBOutlet UIView *contentView;
@property(nonatomic, strong) IBOutlet UITextField *txtUserName;
@property(nonatomic, strong) IBOutlet UITextField *txtFirstName;
@property(nonatomic, strong) IBOutlet UITextField *txtLastName;
@property(nonatomic, strong) IBOutlet UITextField *txtEmail;
@property(nonatomic, strong) IBOutlet UITextField *txtPassword;
@property(nonatomic, strong) IBOutlet UIButton *btnMale;
@property(nonatomic, strong) IBOutlet UIButton *btnFemale;

- (void)registerForKeyboardNotifications;

-(IBAction)touchBack:(id)sender;
-(IBAction)touchJoinUs:(id)sender;
-(IBAction)touchMale:(id)sender;
-(IBAction)touchFemale:(id)sender;
-(IBAction)touchBirthDay:(id)sender;
-(IBAction)touchUploadPhoto:(id)sender;

@end
