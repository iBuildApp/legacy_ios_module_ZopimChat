#import "mZopimchatDesign.h"
#import "NSString+colorizer.h"

#define kDefaultBackgroundColor [UIColor blackColor]

@implementation mZopimchatDesign

+(instancetype)designFromXMLElement:(TBXMLElement)element
{
  TBXMLElement *colorskinElement = [TBXML childElementNamed:@"colorskin" parentElement:&element];
  if (colorskinElement)
  {
    mZopimchatDesign *design = [mZopimchatDesign new];
    
    NSMutableDictionary *colorSkinDictionary = [NSMutableDictionary new];
    
    TBXMLElement *colorElement = colorskinElement->firstChild;
    while( colorElement )
    {
      NSString *colorElementContent = [TBXML textForElement:colorElement];
      
      if ( [colorElementContent length] )
      {
        [colorSkinDictionary setValue:colorElementContent forKey:[[TBXML elementName:colorElement] lowercaseString]];
      }
      
      colorElement = colorElement->nextSibling;
    }
    
    NSString *color1String = [colorSkinDictionary objectForKey:@"color1"];
    
    design.color1 = [color1String asColor];
    design.color2 = [[colorSkinDictionary objectForKey:@"color2"] asColor];
    design.color3 = [[colorSkinDictionary objectForKey:@"color3"] asColor];
    design.color4 = [[colorSkinDictionary objectForKey:@"color4"] asColor];
    design.color5 = [[colorSkinDictionary objectForKey:@"color5"] asColor];
    
    design.isLight = [[colorSkinDictionary objectForKey:@"isLight"] boolValue];
    
    if([color1String isEqualToString:@"#ffffff"] ||
       [color1String isEqualToString:@"#fff"] ||
       [color1String isEqualToString:@"white"])
    {
      design.isWhiteBackground = YES;
    }
    
    return design;
  }
  
  return nil;
}

- (id)initWithCoder:(NSCoder *)coder
{
  self = [super init];
  if ( self )
  {
    self.color1 = [coder decodeObjectForKey:@"mZopimchatDesign::color1"];
    self.color2 = [coder decodeObjectForKey:@"mZopimchatDesign::color2"];
    self.color3 = [coder decodeObjectForKey:@"mZopimchatDesign::color3"];
    self.color4 = [coder decodeObjectForKey:@"mZopimchatDesign::color4"];
    self.color5 = [coder decodeObjectForKey:@"mZopimchatDesign::color5"];
    
    self.isLight = [coder decodeBoolForKey:@"mZopimchatDesign::isLight"];
    self.isWhiteBackground = [coder decodeBoolForKey:@"mZopimchatDesign::isWhiteBackground"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [coder encodeObject:self.color1 forKey:@"mZopimchatDesign::color1"];
  [coder encodeObject:self.color2 forKey:@"mZopimchatDesign::color2"];
  [coder encodeObject:self.color3 forKey:@"mZopimchatDesign::color3"];
  [coder encodeObject:self.color4 forKey:@"mZopimchatDesign::color4"];
  [coder encodeObject:self.color5 forKey:@"mZopimchatDesign::color5"];
  
  [coder encodeBool:self.isLight forKey:@"mZopimchatDesign::isLight"];
  [coder encodeBool:self.isWhiteBackground forKey:@"mZopimchatDesign::isWhiteBackground"];
}



@end
