//
//  CountrySelector.h
//  Created by Venu Pendota on 10/12/17.
//

#import <UIKit/UIKit.h>

@protocol CountrySelectorDelegate <NSObject>

- (void) selectedCountryWithName:(NSString *) countryName andWithDailer:(NSString *) dailerCode andWithCountryCode:(NSString *) countryCode;

@end

@interface CountrySelector : UIView <UITableViewDelegate,UITableViewDataSource> {
    
    IBOutlet UITableView *countryTable;
    IBOutlet UISearchBar *searchBar;
    IBOutlet UIView *bgView;

}

@property (strong, nonatomic) id<CountrySelectorDelegate> countrySelDelegate;

- (IBAction)closeCountrySelector:(id)sender;

@end
