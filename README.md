# countrySelector

A simple library for showing the country list in a view and getting the Country Name, Country Code and Dial Code from delegate method after selecting any country in the list.



First step to go forward is drag and drop all files to your project… 



Second step is just import the CountrySelector.h file in you View Controller where you want to show the list.



#import "CountrySelector.h"



and add the delegate 



@interface ViewController () <CountrySelectorDelegate>



and implement the delegate method in your class as below….



- (void) selectedCountryWithName:(NSString *)countryName andWithDailer:(NSString *)dailerCode andWithCountryCode:(NSString *)countryCode {

    // Do your stuff here

}





Third step is just initialize the Country Selector and delegate, then add subview…



    CountrySelector *countrySel = [[CountrySelector alloc] initWithFrame:self.view.frame];

    countrySel.countrySelDelegate = self;

    [self.view addSubview:countrySel];





Thats it….. 
