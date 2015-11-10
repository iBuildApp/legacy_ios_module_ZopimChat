#import "mZopimchatParameters.h"

static mZopimchatParameters *sharedParameters = nil;

@implementation mZopimchatParameters

+(instancetype)sharedInstance
{
  if(!sharedParameters)
  {
    sharedParameters = [[self alloc] init];
  }
  return sharedParameters;
}

-(void)dealloc
{
  self.mainPageTitle = nil;
  self.moduleId = nil;
  self.zopimKey = nil;
  
  self.design = nil;
  
  [super dealloc];
}

+(instancetype)parametersFromXMLElement:(TBXMLElement)element
{
  mZopimchatParameters *parameters = [[mZopimchatParameters new] autorelease];
  
  TBXMLElement *moduleIdElement = [TBXML childElementNamed:@"module_id" parentElement:&element];
  if ( moduleIdElement )
    parameters.moduleId = [TBXML textForElement:moduleIdElement];
  
  TBXMLElement *zopinKeyElement = [TBXML childElementNamed:@"zopim_key" parentElement:&element];
  if ( zopinKeyElement )
    parameters.zopimKey = [TBXML textForElement:zopinKeyElement];
  
  parameters.design = [mZopimchatDesign designFromXMLElement:element];
  
  return parameters;
}

-(void)fillWithParameters:(mZopimchatParameters *)sourceParameters
{
  self.moduleId = sourceParameters.moduleId;
  self.zopimKey = sourceParameters.zopimKey;
  self.mainPageTitle = sourceParameters.mainPageTitle;
  
  self.design = sourceParameters.design;
}

- (id)initWithCoder:(NSCoder *)coder
{
  self = [super init];
  if ( self )
  {
    self.mainPageTitle = [coder decodeObjectForKey:@"mZopimchatParameters::mainPageTitle"];
    self.moduleId = [coder decodeObjectForKey:@"mZopimchatParameters::module_id"];
    self.zopimKey = [coder decodeObjectForKey:@"mZopimchatParameters::zopim_key"];
    
    self.design = [coder decodeObjectForKey:@"mZopimchatParameters::design"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{  
  [coder encodeObject:self.mainPageTitle forKey:@"mZopimchatParameters::mainPageTitle"];
  [coder encodeObject:self.moduleId forKey:@"mZopimchatParameters::module_id"];
  [coder encodeObject:self.zopimKey forKey:@"mZopimchatParameters::zopim_key"];
  
  [coder encodeObject:self.design forKey:@"mZopimchatParameters::design"];
}

@end
