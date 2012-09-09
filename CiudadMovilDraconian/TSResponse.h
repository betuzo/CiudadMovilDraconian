//
//  TSResponse.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSResponse : NSObject

@property (nonatomic) BOOL success;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSNumber *count;

@end
