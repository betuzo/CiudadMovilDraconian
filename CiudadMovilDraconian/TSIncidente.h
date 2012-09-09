//
//  TSIncidente.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSIncidente : NSObject

@property (nonatomic, strong) UIImage *type;
@property (nonatomic, strong) NSString *description;
@property (nonatomic) double longitude;
@property (nonatomic) double latitude;

@end
