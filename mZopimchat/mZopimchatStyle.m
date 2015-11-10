#import "mZopimchatStyle.h"
#import "mZopimchatParameters.h"

#import "NSString+colorizer.h"

@implementation mZopimchatStyle

+ (void) applyStyling
{
  mZopimchatDesign *design = [mZopimchatParameters sharedInstance].design;
  
  UIEdgeInsets insets;
  
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Loading the chat
  ////////////////////////////////////////////////////////////////////////////////////////////////
  
  [[ZDCLoadingView appearance] setLoadingLabelFont:[UIFont boldSystemFontOfSize:12.0f]];
  [[ZDCLoadingView appearance] setLoadingLabelTextColor:design.color3];
  
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Loading errors/notifications
  ////////////////////////////////////////////////////////////////////////////////////////////////
  
  [[ZDCLoadingErrorView appearance] setIconImage:nil]; // provide an image name to override default image
  
  [[ZDCLoadingErrorView appearance] setTitleFont:[UIFont boldSystemFontOfSize:15.0f]];
  [[ZDCLoadingErrorView appearance] setTitleColor:design.color3];
  [[ZDCLoadingErrorView appearance] setMessageFont:[UIFont systemFontOfSize:15.0f]];
  [[ZDCLoadingErrorView appearance] setMessageColor:design.color3];
  [[ZDCLoadingErrorView appearance] setButtonFont:[UIFont boldSystemFontOfSize:15.0f]];
  [[ZDCLoadingErrorView appearance] setButtonTitleColor:design.color1];
  [[ZDCLoadingErrorView appearance] setButtonBackgroundColor:design.color5];
  [[ZDCLoadingErrorView appearance] setButtonImage:nil]; // provide an image name to override default image
  
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Chat cells
  ////////////////////////////////////////////////////////////////////////////////////////////////
  
  insets = UIEdgeInsetsMake(10.0f, 70.0f , 10.0f, 20.0f);
  [[ZDCJoinLeaveCell appearance] setTextInsets:[NSValue valueWithUIEdgeInsets:insets]];
  [[ZDCJoinLeaveCell appearance] setTextColor:design.color3];
  [[ZDCJoinLeaveCell appearance] setTextFont:[UIFont systemFontOfSize:13.0f]];
  
  insets = UIEdgeInsetsMake(8.0f, 75.0f , 7.0f, 15.0f);
  [[ZDCVisitorChatCell appearance] setBubbleInsets:[NSValue valueWithUIEdgeInsets:insets]];
  insets = UIEdgeInsetsMake(12.0f, 15.0f, 12.0f, 15.0f);
  [[ZDCVisitorChatCell appearance] setTextInsets:[NSValue valueWithUIEdgeInsets:insets]];
  [[ZDCVisitorChatCell appearance] setBubbleBorderColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3f]];
  [[ZDCVisitorChatCell appearance] setBubbleColor:[[UIColor blackColor] colorWithAlphaComponent:0.6f]];
  [[ZDCVisitorChatCell appearance] setBubbleCornerRadius:@(3.0f)];
  [[ZDCVisitorChatCell appearance] setTextAlignment:@(NSTextAlignmentLeft)];
  [[ZDCVisitorChatCell appearance] setTextColor:[UIColor whiteColor]];
  [[ZDCVisitorChatCell appearance] setTextFont:[UIFont systemFontOfSize:15.0f]];
  [[ZDCVisitorChatCell appearance] setUnsentTextColor:[UIColor colorWithWhite:0.26f alpha:1.0f]];
  [[ZDCVisitorChatCell appearance] setUnsentTextFont:[UIFont systemFontOfSize:12.0f]];
  [[ZDCVisitorChatCell appearance] setUnsentMessageTopMargin:@(5.0f)];
  [[ZDCVisitorChatCell appearance] setUnsentIconLeftMargin:@(10.0f)];
  
  insets = UIEdgeInsetsMake(8.0f, 55.0f, 7.0f, 15.0f);
  [[ZDCAgentChatCell appearance] setBubbleInsets:[NSValue valueWithUIEdgeInsets:insets]];
  insets = UIEdgeInsetsMake(12.0f, 15.0f, 12.0f, 15.0f);
  [[ZDCAgentChatCell appearance] setTextInsets:[NSValue valueWithUIEdgeInsets:insets]];
  [[ZDCAgentChatCell appearance] setBubbleBorderColor:[[UIColor blackColor] colorWithAlphaComponent:0.2f]];
  [[ZDCAgentChatCell appearance] setBubbleColor:[UIColor whiteColor]];
  [[ZDCAgentChatCell appearance] setBubbleCornerRadius:@(3.0f)];
  [[ZDCAgentChatCell appearance] setTextAlignment:@(NSTextAlignmentLeft)];
  [[ZDCAgentChatCell appearance] setTextColor:[[UIColor blackColor] colorWithAlphaComponent:0.8f]];
  [[ZDCAgentChatCell appearance] setTextFont:[UIFont systemFontOfSize:15.0f]];
  [[ZDCAgentChatCell appearance] setAvatarHeight:@(30.0f)];
  [[ZDCAgentChatCell appearance] setAvatarLeftInset:@(14.0f)];
  [[ZDCAgentChatCell appearance] setAuthorColor:design.color3];
  [[ZDCAgentChatCell appearance] setAuthorFont:[UIFont systemFontOfSize:12]];
  [[ZDCAgentChatCell appearance] setAuthorHeight:@(25.0f)];
  
  insets = UIEdgeInsetsMake(10.0f, 20.0f, 10.0f, 20.0f);
  [[ZDCSystemTriggerCell appearance] setTextInsets:[NSValue valueWithUIEdgeInsets:insets]];
  [[ZDCSystemTriggerCell appearance] setTextColor:[UIColor colorWithWhite:0.26f alpha:1.0f]];
  [[ZDCSystemTriggerCell appearance] setTextFont:[UIFont boldSystemFontOfSize:14.0f]];
  
  insets = UIEdgeInsetsMake(10.0f, 20.0f, 10.0f, 20.0f);
  [[ZDCChatTimedOutCell appearance] setTextInsets:[NSValue valueWithUIEdgeInsets:insets]];
  [[ZDCChatTimedOutCell appearance] setTextColor:[UIColor colorWithWhite:0.26f alpha:1.0f]];
  [[ZDCChatTimedOutCell appearance] setTextFont:[UIFont boldSystemFontOfSize:14.0f]];
  
  [[ZDCRatingCell appearance] setTitleColor:[UIColor colorWithWhite:0.26f alpha:1.0f]];
  [[ZDCRatingCell appearance] setTitleFont:[UIFont boldSystemFontOfSize:14]];
  [[ZDCRatingCell appearance] setCellToTitleMargin:@(20.0f)];
  [[ZDCRatingCell appearance] setTitleToButtonsMargin:@(10.0f)];
  [[ZDCRatingCell appearance] setRatingButtonToCommentMargin:@(20.0f)];
  [[ZDCRatingCell appearance] setEditCommentButtonHeight:@(44.0f)];
  [[ZDCRatingCell appearance] setRatingButtonSize:@(40.0f)];
  
  [[ZDCAgentAttachmentCell appearance] setActivityIndicatorViewStyle:@(UIActivityIndicatorViewStyleGray)];
  
  [[ZDCVisitorAttachmentCell appearance] setActivityIndicatorViewStyle:@(UIActivityIndicatorViewStyleGray)];
  
  
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Chat text entry area
  ////////////////////////////////////////////////////////////////////////////////////////////////
  
  [[ZDCTextEntryView appearance] setSendButtonImage:nil];
  [[ZDCTextEntryView appearance] setTopBorderColor:[UIColor colorWithWhite:0.831f alpha:1.0f]];
  [[ZDCTextEntryView appearance] setTextEntryFont:[UIFont systemFontOfSize:14.0f]];
  [[ZDCTextEntryView appearance] setTextEntryColor:[UIColor colorWithWhite:0.4f alpha:1.0f]];
  [[ZDCTextEntryView appearance] setTextEntryBackgroundColor:[UIColor colorWithWhite:0.945f alpha:1.0f]];
  [[ZDCTextEntryView appearance] setTextEntryBorderColor:[UIColor colorWithWhite:0.831f alpha:1.0f]];
  [[ZDCTextEntryView appearance] setAreaBackgroundColor:[UIColor whiteColor]];
  
  
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Chat UI background colors
  ////////////////////////////////////////////////////////////////////////////////////////////////
  
  // set all view backgrounds transparent
  [[ZDCPreChatFormView appearance] setFormBackgroundColor:design.color1];
  [[ZDCOfflineMessageView appearance] setFormBackgroundColor:design.color1];
  [[ZDCChatView appearance] setChatBackgroundColor:design.color1];
  [[ZDCLoadingView appearance] setLoadingBackgroundColor:design.color1];
  
  UIColor *bgColor = design.color1;
  const CGFloat *component = CGColorGetComponents(bgColor.CGColor);
  CGFloat brightness = ((component[0] * 299) + (component[1] * 587) + (component[2] * 114)) / 1000;
  if (brightness < 0.1)
    bgColor = [@"#808080" asColor];
  
  [[ZDCLoadingErrorView appearance] setErrorBackgroundColor:bgColor];
  
  // Set the base view background color
  [[ZDCChatUI appearance] setChatBackgroundColor:design.color1];
  
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Custom chat background (static image)
  ////////////////////////////////////////////////////////////////////////////////////////////////
  
  // set the base view background image name and anchor
  //[[ZDCChatUI appearance] setChatBackgroundImage:@"SampleBackground"];
  //[[ZDCChatUI appearance] setChatBackgroundAnchor:@(ZDCChatBackgroundAnchorCenter)];
  
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // UI notifications
  ////////////////////////////////////////////////////////////////////////////////////////////////
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatLoaded:) name:ZDC_CHAT_UI_DID_LOAD object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatLayout:) name:ZDC_CHAT_UI_DID_LAYOUT object:nil];
}


+ (void) chatLoaded:(NSNotification*)notification
{
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Custom chat background (runtime image)
  ////////////////////////////////////////////////////////////////////////////////////////////////
  
  // Those attributes controllable by UIAppearance should still be controlled via the standard appearance
  // invocations. For a chat-wide background image to work you will need to also uncomment the background
  // color apperance settings above
  
  //ZDCChatUI *chatUI = notification.object;
  
  //chatUI.chatBackgroundAnchor = @(ZDCChatBackgroundAnchorTop);
  //chatUI.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SampleBackground"]];
}


+ (void) chatLayout:(NSNotification*)notification
{
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Customise the layout of any part of the chat UI here
  ////////////////////////////////////////////////////////////////////////////////////////////////
}


@end
