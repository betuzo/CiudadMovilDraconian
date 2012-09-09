//
//  TaxiSiViewController.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CiudadPinAnotation.h"
#import "IdentificarTaxiViewController.h"

@interface TaxiSiViewController : UIViewController <MKMapViewDelegate, MKAnnotation>
{
    IBOutlet MKMapView *ciudadMapView;
}
@property (nonatomic, retain) IBOutlet MKMapView *ciudadMapView;

-(IBAction)identificarTaxi:(id)sender;

-(void)showUserLocation;
-(void) addAnnotationTaxis;
-(void) addAnnotationSitios;
-(void) addAnnotationIncidentes;
-(void) addAnnotationObras;

@end
