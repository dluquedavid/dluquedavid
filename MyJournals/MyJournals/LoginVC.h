//
//  LoginVC.h
//  MyJournals
//
//  Created by developer on 13-06-11.
//  Copyright (c) 2013 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController<UITextFieldDelegate>

@property(nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong) IBOutlet UIView *contentView;
@property(nonatomic, strong) IBOutlet UIView *footerView;
@property(nonatomic, strong) IBOutlet UITextField *txtUserName;
@property(nonatomic, strong) IBOutlet UITextField *txtPassword;

- (void)registerForKeyboardNotifications;

-(IBAction)touchLogin:(id)sender;
-(IBAction)touchJoinUs:(id)sender;
@end
