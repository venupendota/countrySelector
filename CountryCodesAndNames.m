//
//  CountryCodesAndNames.m
//  Created by Venu Pendota on 10/12/17.
//

#import "CountryCodesAndNames.h"

@implementation CountryCodesAndNames


+ (NSArray *) arrayPfCountriesFromJson {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CountryCodes" ofType:@"json"];
    NSData *content = [[NSData alloc] initWithContentsOfFile:filePath];
    NSArray *jsonCountry = [NSJSONSerialization JSONObjectWithData:content options:kNilOptions error:nil];
    return jsonCountry;
}

+ (NSString *) dailerCodeForCountryWithCountryCode :(NSString *) selectedCountryCode{
    
    NSString *dailerCode = @"";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CountryCodes" ofType:@"json"];
    NSData *content = [[NSData alloc] initWithContentsOfFile:filePath];
    NSArray *jsonCountry = [NSJSONSerialization JSONObjectWithData:content options:kNilOptions error:nil];
    
    for (NSDictionary *countryDic in jsonCountry) {
        NSString *countryCode = [countryDic valueForKey:@"code"];
        if ([countryCode isEqualToString:selectedCountryCode]) {
            dailerCode = [countryDic valueForKey:@"dial_code"];
            if ([dailerCode hasPrefix:@"+"] && [dailerCode length] > 1) {
                dailerCode = [dailerCode substringFromIndex:1];
            }
            NSLog(@"Dail Code = %@",dailerCode);
        }
    }

    
    return dailerCode;
}


+ (NSString *) nameOfTheCountryWithDailerCode :(NSString *) countryDailerCode {
    
    NSString *countryName = @"";
    
    NSString *prefix = @"+";
    NSString *dailerCode = [prefix stringByAppendingString:countryDailerCode];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CountryCodes" ofType:@"json"];
    NSData *content = [[NSData alloc] initWithContentsOfFile:filePath];
    NSArray *jsonCountry = [NSJSONSerialization JSONObjectWithData:content options:kNilOptions error:nil];
    
    for (NSDictionary *countryDic in jsonCountry) {
        NSString *tempDailCode = [countryDic valueForKey:@"dial_code"];
        if ([tempDailCode isEqualToString:dailerCode]) {
            countryName = [countryDic valueForKey:@"name"];
            NSLog(@"Country Name = %@",countryName);
            return countryName;
        }
    }
    
    return countryName;
}

@end
