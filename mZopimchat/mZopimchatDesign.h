/****************************************************************************
 *                                                                           *
 *  Copyright (C) 2014-2015 iBuildApp, Inc. ( http://ibuildapp.com )         *
 *                                                                           *
 *  This file is part of iBuildApp.                                          *
 *                                                                           *
 *  This Source Code Form is subject to the terms of the iBuildApp License.  *
 *  You can obtain one at http://ibuildapp.com/license/                      *
 *                                                                           *
 ****************************************************************************/

#import <UIKit/UIKit.h>
#import "TBXML.h"

/**
 * Visual parameters, color sceheme of the module.
 */
@interface mZopimchatDesign : NSObject<NSCoding>

/**
 * Creates design object and populates it with the contents of the xml element.
 *
 * @param element -- xml element with parameters.
 */
+(instancetype)designFromXMLElement:(TBXMLElement)element;

/**
 * UIColor for color1 from xml configuration.
 */
@property (nonatomic, strong) UIColor *color1;

/**
 * UIColor for color2 from xml configuration.
 */
@property (nonatomic, strong) UIColor *color2;

/**
 * UIColor for color3 from xml configuration.
 */
@property (nonatomic, strong) UIColor *color3;

/**
 * UIColor for color4 from xml configuration.
 */
@property (nonatomic, strong) UIColor *color4;

/**
 * UIColor for color5 from xml configuration.
 */
@property (nonatomic, strong) UIColor *color5;


/**
 * Flag, tells whether the color scheme is light
 * (comes from xml)
 */
@property (nonatomic) BOOL isLight;

/**
 * Flag, tells whether the color1 scheme is purely white.
 */
@property (nonatomic) BOOL isWhiteBackground;

@end
