//
//  CountryCodesAndNames.h
//  Created by Venu Pendota on 10/12/17.
//

#import <Foundation/Foundation.h>

@interface CountryCodesAndNames : NSObject

+ (NSArray *) arrayPfCountriesFromJson;
+ (NSString *) dailerCodeForCountryWithCountryCode :(NSString *) selectedCountryCode;
+ (NSString *) nameOfTheCountryWithDailerCode :(NSString *) countryDailerCode;

@end
