//
//  TSTaxi.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSTaxi : NSObject

@property (nonatomic) long id;
@property (nonatomic, strong) UIImage *type;
@property (nonatomic, strong) NSString *tipo;
@property (nonatomic, strong) NSString *placas;
@property (nonatomic, strong) NSString *vehiculo;
@property (nonatomic) double longitude;
@property (nonatomic) double latitude;

@end
