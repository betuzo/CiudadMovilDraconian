//
//  TSSitio.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSSitio : NSObject

@property (nonatomic, strong) UIImage *type;
@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) NSString *telefono;
@property (nonatomic) double longitude;
@property (nonatomic) double latitude;

@end
