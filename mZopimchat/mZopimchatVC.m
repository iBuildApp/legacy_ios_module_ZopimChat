#import "mZopimchatVC.h"
#import "mZopimchatParameters.h"

#import "iphnavbardata.h"
#import "UIColor+RGB.h"
#import "UIColor+HSL.h"
#import "NSString+colorizer.h"

#import <ZDCChat/ZDCChat.h>
#import "mZopimchatStyle.h"

#import "iphColorskinModel.h"
#import "iphNavBarCustomization.h"


@interface mZopimchatViewController()
{
  CGFloat _currentYOrigin;
  BOOL _chatStarted;
}

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIButton    *backButtonCoverButton;

@property (nonatomic, strong) iphColorskinModel *colorSkin;

@end

@implementation mZopimchatViewController

+ (void)parseXML:(NSValue *)xmlElement_
      withParams:(NSMutableDictionary *)params_
{
  TBXMLElement element;
  [xmlElement_ getValue:&element];
  
  mZopimchatParameters *parameters = [mZopimchatParameters parametersFromXMLElement:element];
  parameters.mainPageTitle = [params_ objectForKey:@"title"];
  
  // processing tag <colorskin>
  NSMutableDictionary *colorSkin = [[NSMutableDictionary alloc] init];
  TBXMLElement *colorskinElement = [TBXML childElementNamed:@"colorskin" parentElement:&element];
  if (colorskinElement)
  {
    // <color1>
    // <color2>
    // <color3>
    // <color4>
    // <color5>
    // <color6>
    // <color7>
    // <color8>
    // <isLight>
    TBXMLElement *colorElement = colorskinElement->firstChild;
    while(colorElement)
    {
      NSString *colorElementContent = [TBXML textForElement:colorElement];
      
      if ([colorElementContent length])
        [colorSkin setValue:colorElementContent forKey:[TBXML elementName:colorElement]];
      
      colorElement = colorElement->nextSibling;
    }
  }
  
  if(colorSkin.count)
    [params_ setObject:colorSkin forKey:@"colorskin"];
  
  [params_ setObject:parameters forKey:@"mZopimchatParameters"];
}

- (void)setParams:(NSMutableDictionary *)params
{
  if ( params != nil )
  {
    mZopimchatParameters *parameters_ = [params objectForKey:@"mZopimchatParameters"];
    [[mZopimchatParameters sharedInstance] fillWithParameters:parameters_];
    
    // set values for ColorskinModel
    NSDictionary *colorskinDict = [params objectForKey:@"colorskin"];
    
    _colorSkin = [[iphColorskinModel alloc] init];
    
    NSString *isLightValue = [colorskinDict objectForKey:@"isLight"];
    if(isLightValue && [isLightValue length])
      _colorSkin.isLight = [isLightValue boolValue];
    
    NSString *color1Value = [colorskinDict objectForKey:@"color1"];
    if(color1Value && [color1Value length])
      _colorSkin.color1 = [color1Value asColor];
    
    if([[color1Value uppercaseString]  isEqualToString:@"#FFFFFF"])
      _colorSkin.color1IsWhite = YES;
    
    if([[color1Value uppercaseString]  isEqualToString:@"#000000"])
      _colorSkin.color1IsBlack = YES;
    
    NSString *color2Value = [colorskinDict objectForKey:@"color2"];
    if(color2Value && [color2Value length])
      _colorSkin.color2 = [color2Value asColor];
    
    NSString *color3Value = [colorskinDict objectForKey:@"color3"];
    if(color3Value && [color3Value length])
      _colorSkin.color3 = [color3Value asColor];
    
    NSString *color4Value = [colorskinDict objectForKey:@"color4"];
    if(color4Value && [color4Value length])
      _colorSkin.color4 = [color4Value asColor];
    
    NSString *color5Value = [colorskinDict objectForKey:@"color5"];
    if(color5Value && [color5Value length])
      _colorSkin.color5 = [color5Value asColor];
    
    NSString *color6Value = [colorskinDict objectForKey:@"color6"];
    if(color6Value && [color6Value length])
      _colorSkin.color6 = [color6Value asColor];
    
    NSString *color7Value = [colorskinDict objectForKey:@"color7"];
    if(color7Value && [color7Value length])
      _colorSkin.color7 = [color7Value asColor];
    
    NSString *color8Value = [colorskinDict objectForKey:@"color8"];
    if(color8Value && [color8Value length])
      _colorSkin.color8 = [color8Value asColor];
    
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
  [self.backButtonCoverButton removeFromSuperview];
}

-(void)viewDidLoad
{
  [super viewDidLoad];
  
  [iphNavBarCustomization setNavBarSettingsWhenViewDidLoadWithController:self];
  
  UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc] init];
  [tapBackground addTarget:self action:@selector(dismissKeyboard)];
  [tapBackground setNumberOfTapsRequired:1];
  [self.view addGestureRecognizer:tapBackground];
  
  self.view.backgroundColor = [mZopimchatParameters sharedInstance].design.color1;
  self.title = [mZopimchatParameters sharedInstance].mainPageTitle;
  
  [self setupInterface];
  
  self.backButtonCoverButton = [[UIButton alloc] init];
  self.backButtonCoverButton.frame = CGRectMake(0, 0, 80, CGRectGetHeight(self.navigationController.navigationBar.frame));
  self.backButtonCoverButton.alpha = 1.0f;
  [self.backButtonCoverButton addTarget:self action:@selector(backButtonCoverButtonTapped) forControlEvents:UIControlEventTouchUpInside];
  
  [self.navigationController.navigationBar addSubview:self.backButtonCoverButton];
  [ZDCChat initializeWithAccountKey:[mZopimchatParameters sharedInstance].zopimKey];
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
  
  [iphNavBarCustomization customizeNavBarWithController:self colorskinModel:_colorSkin];
  
  self.backButtonCoverButton.enabled = NO;
  
  _chatStarted = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
  if(_chatStarted == NO)
    [iphNavBarCustomization restoreNavBarWithController:self colorskinModel:_colorSkin];

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
  UILabel *helloMessageLabel = [[UILabel alloc] initWithFrame:frame];
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
  UILabel *enterNameLabel = [[UILabel alloc] initWithFrame:frame];
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
  self.nameTextField = [[UITextField alloc] initWithFrame:frame];
  CGPoint center = self.nameTextField.center;
  center.x = self.view.center.x;
  self.nameTextField.center = center;
  NSString *placeholderText = NSBundleLocalizedString(@"mZopimchat_namePlaceholder", @"Enter your name");
  NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:placeholderText
                                                                    attributes:@{ NSForegroundColorAttributeName : [[UIColor blackColor] colorWithAlphaComponent:0.4]}];
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
  UIButton *startChatButton = [[UIButton alloc] initWithFrame:frame];
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
    _chatStarted = YES;

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
    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:self.nameTextField.placeholder
                                                                       attributes:attrs];
    self.nameTextField.attributedPlaceholder = placeholder;
  }
}

-(void)dismissKeyboard
{
  [self.nameTextField resignFirstResponder];
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

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
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
