//
//  TSUser.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSUser : NSObject

@property (nonatomic) long id;
@property (nonatomic, strong) UIImage *type;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic) BOOL compartir;
@property (nonatomic) BOOL verIncidentes;
@property (nonatomic) BOOL verComprtidos;

@end
