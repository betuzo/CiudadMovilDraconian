//
//  WebDelegate.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSResponse.h"

@protocol WebDelegate <NSObject>

@required

- (void)modelLoadCompletedWithResponse:(TSResponse *)response;

- (void)modelLoadCompletedWithError:(NSError *)error;

@end
