#import "mZopimchatVC.h"
#import "mZopimchatParameters.h"

#import "iphnavbardata.h"
#import "UIColor+RGB.h"
#import "UIColor+HSL.h"

#import <ZDCChat/ZDCChat.h>
#import "mZopimchatStyle.h"


@interface mZopimchatViewController()
{
  CGFloat _currentYOrigin;
}

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIButton    *backButtonCoverButton;

@end

@implementation mZopimchatViewController

+ (void)parseXML:(NSValue *)xmlElement_
      withParams:(NSMutableDictionary *)params_
{
  TBXMLElement element;
  [xmlElement_ getValue:&element];
  
  mZopimchatParameters *parameters = [mZopimchatParameters parametersFromXMLElement:element];
  parameters.mainPageTitle = [params_ objectForKey:@"title"];
  [params_ setObject:parameters forKey:@"mZopimchatParameters"];
}

- (void)setParams:(NSMutableDictionary *)params
{
  if ( params != nil )
  {
    mZopimchatParameters *parameters_ = [params objectForKey:@"mZopimchatParameters"];
    [[mZopimchatParameters sharedInstance] fillWithParameters:parameters_];
  }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if ( self )
  {
    
  }
  return self;
}

- (void)dealloc
{
  self.nameTextField = nil;
  
  [self.backButtonCoverButton removeFromSuperview];
  self.backButtonCoverButton = nil;
  
  [super dealloc];
}

-(void)viewDidLoad
{
  [super viewDidLoad];
  
  UITapGestureRecognizer *tapBackground = [[[UITapGestureRecognizer alloc] init] autorelease];
  [tapBackground addTarget:self action:@selector(dismissKeyboard)];
  [tapBackground setNumberOfTapsRequired:1];
  [self.view addGestureRecognizer:tapBackground];
  
  self.view.backgroundColor = [mZopimchatParameters sharedInstance].design.color1;
  self.title = [mZopimchatParameters sharedInstance].mainPageTitle;
  
  [self setupInterface];
  
  self.backButtonCoverButton = [[[UIButton alloc] init] autorelease];
  self.backButtonCoverButton.frame = CGRectMake(0, 0, 80, CGRectGetHeight(self.navigationController.navigationBar.frame));
  self.backButtonCoverButton.alpha = 1.0f;
  [self.backButtonCoverButton addTarget:self action:@selector(backButtonCoverButtonTapped) forControlEvents:UIControlEventTouchUpInside];
  
  [self.navigationController.navigationBar addSubview:self.backButtonCoverButton];
  
  [ZDCChat configure:^(ZDCConfig *defaults)
   {
     defaults.accountKey = [mZopimchatParameters sharedInstance].zopimKey;
   }];
  
  [mZopimchatStyle applyStyling];
}

-(void)backButtonCoverButtonTapped
{
  UIViewController *target = [ZDCChat instance].chatViewController;
  SEL selector = NSSelectorFromString(@"end");
  
  //[target.navigationItem removeObserver:self forKeyPath:@"rightBarButtonItem"];
  
  if ([target respondsToSelector:selector])
  {
    [target performSelector:selector];
  }
  else
  {
    [[ZDCChat instance].chatViewController dismiss];
  }
}

-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  // before hiding / displaying tabBar we must remember its previous state
  //self.tabBarIsHidden = [[self.tabBarController tabBar] isHidden];
  [[self.tabBarController tabBar] setHidden:YES];

  
  self.backButtonCoverButton.enabled = NO;
  
  [self.navigationController setNavigationBarHidden:NO];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(customizeNavBarAppearanceCompleted:)
                                               name:TIPhoneNavBarDataCustomizeNavBarAppearanceCompleted
                                             object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:TIPhoneNavBarDataCustomizeNavBarAppearanceCompleted
                                                object:nil];

  [super  viewWillDisappear:animated];
}

-(void)setupInterface
{
  _currentYOrigin = 55.f;
  
  [self placeHelloMessageLabel];
  [self placeNameLabel];
  [self placeNameTextField];
  [self placeStartChatButton];
}

-(void)placeHelloMessageLabel
{
  CGRect frame = CGRectMake(0, _currentYOrigin, CGRectGetWidth(self.view.frame), 30);
  UILabel *helloMessageLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
  helloMessageLabel.font = [UIFont systemFontOfSize:25.0f];
  helloMessageLabel.backgroundColor = [UIColor clearColor];
  helloMessageLabel.textColor = [mZopimchatParameters sharedInstance].design.color3;
  helloMessageLabel.text = NSBundleLocalizedString(@"mZopimchat_helloMessage", @"Let's Start");
  helloMessageLabel.textAlignment = NSTextAlignmentCenter;
  
  [self.view addSubview:helloMessageLabel];
  
  _currentYOrigin += frame.size.height + 45;
}

-(void)placeNameLabel
{
  CGRect frame = CGRectMake(0, _currentYOrigin, CGRectGetWidth(self.view.frame), 15);
  UILabel *enterNameLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
  enterNameLabel.font = [UIFont systemFontOfSize:13.0f];
  enterNameLabel.backgroundColor = [UIColor clearColor];
  enterNameLabel.textColor = [mZopimchatParameters sharedInstance].design.color3;
  enterNameLabel.text = NSBundleLocalizedString(@"mZopimchat_enterYourName", @"Please, enter Your Name");
  enterNameLabel.textAlignment = NSTextAlignmentCenter;
  
  [self.view addSubview:enterNameLabel];
  
  _currentYOrigin += frame.size.height + 12;
}

-(void)placeNameTextField
{
  CGRect frame = CGRectMake(0, _currentYOrigin, 270, 40);
  self.nameTextField = [[[UITextField alloc] initWithFrame:frame] autorelease];
  CGPoint center = self.nameTextField.center;
  center.x = self.view.center.x;
  self.nameTextField.center = center;
  NSString *placeholderText = NSBundleLocalizedString(@"mZopimchat_namePlaceholder", @"Enter your name");
  NSAttributedString *placeholder = [[[NSAttributedString alloc] initWithString:placeholderText
                                                                    attributes:@{ NSForegroundColorAttributeName : [[UIColor blackColor] colorWithAlphaComponent:0.4]}] autorelease];
  self.nameTextField.attributedPlaceholder = placeholder;
  self.nameTextField.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
  self.nameTextField.font = [UIFont systemFontOfSize:18.f];
  self.nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  self.nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
  self.nameTextField.backgroundColor = [UIColor whiteColor];
  self.nameTextField.layer.cornerRadius = 3.f;
  if ([mZopimchatParameters sharedInstance].design.isWhiteBackground)
  {
    self.nameTextField.layer.borderWidth = 1.f;
    self.nameTextField.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f].CGColor;
  }
  self.nameTextField.delegate = self;
  
  [self.view addSubview:self.nameTextField];
  
  _currentYOrigin += frame.size.height + 20;
}

-(void)placeStartChatButton
{
  CGRect frame = CGRectMake(0, _currentYOrigin, 200, 45);
  UIButton *startChatButton = [[[UIButton alloc] initWithFrame:frame] autorelease];
  CGPoint center = startChatButton.center;
  center.x = self.view.center.x;
  startChatButton.center = center;
  [startChatButton setTitle:NSBundleLocalizedString(@"mZopimchat_startChat", @"Start Chat") forState:UIControlStateNormal];
  [startChatButton setTitleColor:[mZopimchatParameters sharedInstance].design.color1 forState:UIControlStateNormal];
  startChatButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
  startChatButton.backgroundColor = [mZopimchatParameters sharedInstance].design.color5;
  startChatButton.layer.cornerRadius = 3.f;
  [startChatButton addTarget:self action:@selector(startChatButtonTapped) forControlEvents:UIControlEventTouchUpInside];
  
  [self.view addSubview:startChatButton];
  
  _currentYOrigin += frame.size.height + 30;
}


-(void)startChatButtonTapped
{
  if (self.nameTextField.text.length)
  {

    [ZDCChat updateVisitor:^(ZDCVisitorInfo *visitor)
    {
      visitor.name = self.nameTextField.text;
    }];
    
    [self dismissKeyboard];
    
    self.backButtonCoverButton.enabled = YES;
    [ZDCChat startChatIn:self.navigationController withConfig:nil];
    [ZDCChat instance].chatViewController.title = [mZopimchatParameters sharedInstance].mainPageTitle;
    
//    [[ZDCChat instance].chatViewController.navigationItem addObserver:self forKeyPath:@"rightBarButtonItem" options:NSKeyValueObservingOptionNew context:nil];
  }
  else
  {
    NSDictionary *attrs = @{ NSForegroundColorAttributeName : [UIColor redColor] };
    NSAttributedString *placeholder = [[[NSAttributedString alloc] initWithString:self.nameTextField.placeholder
                                                                       attributes:attrs] autorelease];
    self.nameTextField.attributedPlaceholder = placeholder;
  }
}

-(void)dismissKeyboard
{
  [self.nameTextField resignFirstResponder];
}

-(void)customizeNavBarAppearanceCompleted:(NSNotification *)notification
{
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
  
  UINavigationBar *navBar = self.navigationController.navigationBar;
  UIColor *backgroundColor = [mZopimchatParameters sharedInstance].design.color1;
  
  if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
    if (backgroundColor.isLight)
      [navBar setBarTintColor:[backgroundColor blend:[[UIColor blackColor] colorWithAlphaComponent:0.2f]]];
    else
      [navBar setBarTintColor:[backgroundColor blend:[[UIColor whiteColor] colorWithAlphaComponent:0.4f]]];
    
    [navBar setTintColor:[UIColor blackColor]];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                     NSFontAttributeName : [UIFont systemFontOfSize:18.0f]}];
  }
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//  if ([keyPath isEqualToString:@"rightBarButtonItem"])
//  {
//    UINavigationItem *navItem = [ZDCChat instance].chatViewController.navigationItem;
//    if (navItem.rightBarButtonItem)
//      navItem.rightBarButtonItem = nil;
//  }
//}

#pragma mark - Autorotate handlers

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

-(BOOL)shouldAutorotate
{
  return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
  return UIInterfaceOrientationPortrait;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField endEditing:YES];
  return NO;
}

@end