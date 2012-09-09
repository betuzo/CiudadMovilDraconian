//
//  WebLoad.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "WebDelegate.h"

@interface WebLoad : NSObject<RKObjectLoaderDelegate, RKRequestDelegate>

@property (nonatomic, assign) id<WebDelegate> delegate;
@property (nonatomic, strong) NSString * resourceComplete;

- (void) loadWithResource: (NSString *) resource andMapping: (RKObjectMapping *) mapping andDelegate: (id) delegate andParameter: (NSArray *) parameteres;

@end
