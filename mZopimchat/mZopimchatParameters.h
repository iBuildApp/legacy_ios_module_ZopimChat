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

#import <Foundation/Foundation.h>
#import "mZopimchatDesign.h"
#import "TBXML.h"

/**
 * Class to store module-wide configuration parameters.
 */
@interface mZopimchatParameters : NSObject<NSCoding>

/**
 * Convenience method to get the shared instance of the parameters.
 */
+(instancetype)sharedInstance;

/**
 * Creates parameters object and populates it with the contents of the xml element.
 *
 * @param element -- xml element with parameters.
 */
+(instancetype)parametersFromXMLElement:(TBXMLElement)element;

/**
 * Zopim account key.
 */
@property (nonatomic, strong) NSString *zopimKey;

/**
 * Identificator of the module in the app.
 */
@property (nonatomic, strong) NSString *moduleId;

/**
 * Title of the main controller of the module. Set on the iBuildApp server side.
 *
 * @see mFacebookViewController
 */
@property (nonatomic, strong) NSString *mainPageTitle;


/**
 * Visual parameters, color sceheme of the module.
 *
 * @see mZopimchatDesign
 */
@property (nonatomic, strong) mZopimchatDesign *design;

/**
 * Fills self with values from the sourceParameters
 *
 * @param sourceParameters -- parameters for self to be filled with.
 */
-(void)fillWithParameters:(mZopimchatParameters *)sourceParameters;

@end
