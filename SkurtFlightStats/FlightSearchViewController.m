//
//  FlightSearchViewController.m
//  SkurtFlightStats
//
//  Created by Andrew Lopez-Vass on 2/28/16.
//  Copyright © 2016 Andrew Lopez-Vass. All rights reserved.
//

#import "FlightSearchViewController.h"
#import "ALVTitledTextFieldView.h"
#import "ALVTextField.h"
#import "ALVButton.h"

#import "FlightStatsHTTPReqest.h"

#import "ALVAirlineTableViewCell.h"

#import "UIView+additions.h"
#import "UIResponder+additions.h"

static NSString *const kSelectAirline = @"Select Airline";
static NSString *const kSelectDepartureDate = @"Select Departure Date";
static NSString *const kEnterFlightNumber = @"Enter Flight Number";
static NSString *const kSearchFlights = @"Search for Flights";

static NSString *const DFSYearMonthDayNumbers = @"yyyy-MM-dd";

static const CGFloat kBorderHeight = 1.5;

@interface FlightSearchViewController ()

@property (weak, nonatomic) IBOutlet ALVTitledTextFieldView *airlineInputField;
@property (weak, nonatomic) IBOutlet ALVTitledTextFieldView *flightNumberInputField;
@property (weak, nonatomic) IBOutlet ALVTitledTextFieldView *departureDateInputField;
@property (weak, nonatomic) IBOutlet ALVButton *searchButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *airlineMatches;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintButtonBottomMargin;
@property (assign, nonatomic) CGFloat constant;

@property (nonatomic, strong) NSString *selectedAirlineName;
@property (nonatomic, strong) NSString *flightNumberString;
@property (nonatomic, strong) NSDate *departureDate;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation FlightSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerNib:[UINib nibWithNibName:[ALVAirlineTableViewCell className] bundle:nil] forCellReuseIdentifier:[ALVAirlineTableViewCell className]];
    
    [_airlineInputField addTopBorderWithHeight:kBorderHeight andColor:[UIColor colorFromHexString:ColorBorderHex]];
    [_airlineInputField addBottomBorderWithHeight:kBorderHeight andColor:[UIColor colorFromHexString:ColorBorderHex]];
    [_flightNumberInputField addBottomBorderWithHeight:kBorderHeight andColor:[UIColor colorFromHexString:ColorBorderHex]];
    [_departureDateInputField addBottomBorderWithHeight:kBorderHeight andColor:[UIColor colorFromHexString:ColorBorderHex]];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker addTarget:self action:@selector(pickerSelectedDate:) forControlEvents:UIControlEventValueChanged];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minimumDate = [NSDate date];
    datePicker.date = [NSDate date];
    [_departureDateInputField.textField setInputView:datePicker];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:DFSYearMonthDayNumbers];
    [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    
    [_searchButton setTitle:kSelectAirline forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:ALVKeyboardObserverWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:ALVKeyboardObserverDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:ALVKeyboardObserverWillHideNotification object:nil];
    
    [_airlineInputField.textField addObserver:self forKeyPath:@"delayedText" options:NSKeyValueObservingOptionNew context:NULL];
    [_flightNumberInputField.textField addObserver:self forKeyPath:@"delayedText" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _constant = _ConstraintButtonBottomMargin.constant;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_airlineInputField.textField removeObserver:self forKeyPath:@"delayedText"];
    [_flightNumberInputField.textField removeObserver:self forKeyPath:@"delayedText"];
}

- (ALVTitledTextFieldView *)activeInputView {
    if (_airlineInputField.textField.isFirstResponder) {
        return _airlineInputField;
        
    } else if (_flightNumberInputField.textField.isFirstResponder) {
        return _flightNumberInputField;
        
    } else if (_departureDateInputField.textField.isFirstResponder) {
        return _departureDateInputField;
    }
    return nil;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    _flightNumberInputField.hidden = [_airlineInputField.textField isFirstResponder];
    _departureDateInputField.hidden = [_airlineInputField.textField isFirstResponder] || [_flightNumberInputField.textField isFirstResponder];
    
    if ([_airlineInputField.textField isFirstResponder]) {
        [_searchButton setTitle:kSelectAirline forState:UIControlStateNormal];
        
    } else if ([_flightNumberInputField.textField isFirstResponder]) {
        [_searchButton setTitle:kEnterFlightNumber forState:UIControlStateNormal];
        
    } else if ([_departureDateInputField.textField isFirstResponder]) {
        [_searchButton setTitle:kSelectDepartureDate forState:UIControlStateNormal];
    }
    
    _ConstraintButtonBottomMargin.constant = [ALVKeyboardObserver singleton].keyboardRect.size.height;
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateAlongsideKeyboard:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        CGFloat y = [self activeInputView].frame.origin.y + [self activeInputView].frame.size.height;
        CGFloat height = _searchButton.frame.origin.y - y;
        
        _tableView.contentInset = UIEdgeInsetsZero;
        _tableView.frame = CGRectMake(_tableView.frame.origin.x, y, self.view.frame.size.width, height);
        _tableView.hidden = ![_airlineInputField.textField isFirstResponder];
    }];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"delayedText"]) {
        if ([object isEqual:_airlineInputField.textField]) {
            [self searchAirlinesWithText:_airlineInputField.textField.delayedText];
            
        } else if ([object isEqual:_flightNumberInputField.textField]) {
            [self enteredFlightNumber:_flightNumberInputField.textField.text];
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
     _tableView.hidden = YES;
    [self updateFields];
    
    _ConstraintButtonBottomMargin.constant = _constant;
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateAlongsideKeyboard:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (IBAction)searchTapped:(UIButton *)sender {
    NSString *currentTitle = sender.titleLabel.text;
    if ([currentTitle isEqualToString:kSelectAirline]) {
        if ([_airlineInputField.textField isFirstResponder]) {
            [_airlineInputField.textField.textChangeTimer invalidate];
            [self selectedAirlineText:[_airlineMatches firstObject]];
            [_airlineInputField.textField resignFirstResponder];
            
        } else {
            _flightNumberInputField.hidden = _departureDateInputField.hidden = YES;
            [_searchButton setTitle:kSelectAirline forState:UIControlStateNormal];
            [_airlineInputField textFieldShouldBecomeFirstResponder];
        }
        
    } else if ([currentTitle isEqualToString:kEnterFlightNumber]) {
        if ([_flightNumberInputField.textField isFirstResponder]) {
            [self enteredFlightNumber:_flightNumberInputField.textField.text];
            [_flightNumberInputField.textField resignFirstResponder];
            
        } else {
            _departureDateInputField.hidden = YES;
            [_searchButton setTitle:kEnterFlightNumber forState:UIControlStateNormal];
            [_flightNumberInputField textFieldShouldBecomeFirstResponder];
        }
        
    } else if ([currentTitle isEqualToString:kSelectDepartureDate]) {
        if ([_departureDateInputField.textField isFirstResponder]) {
            [_departureDateInputField.textField resignFirstResponder];
            
        } else {
            [_searchButton setTitle:kSelectDepartureDate forState:UIControlStateNormal];
            [_departureDateInputField textFieldShouldBecomeFirstResponder];
        }
        
    } else if ([currentTitle isEqualToString:kSearchFlights]) {
        [[UIResponder firstResponder] resignFirstResponder];
        
        FlightStatsHTTPReqest *flightSearch = [[FlightStatsHTTPReqest alloc] init];
        flightSearch.apiName = @"schedules"; // flight/carrier_code/flight_number/departing/year/month,day
        flightSearch.requiredParams = [NSString stringWithFormat:@"flight/%@/%@/departing/%@",
                                       [[AirlinesManager manager] airlineCodeForName:_selectedAirlineName],
                                       _flightNumberString, [[_dateFormatter stringFromDate:_departureDate] stringByReplacingOccurrencesOfString:@"-" withString:@"/"]];
        
        [flightSearch fireWithCompletion:^{
            NSLog(@"Response - %@", flightSearch.response);
            NSArray *scheduledFlights = [flightSearch.response objectForKey:@"scheduledFlights"];
            NSDictionary *lastLegFlight = [scheduledFlights lastObject];
            
            if (lastLegFlight) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Foung Flight" message:[NSString stringWithFormat:@"%@", lastLegFlight] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OKAY" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
}

- (void)searchAirlinesWithText:(NSString *)airlineText {
    _airlineMatches = [[AirlinesManager manager] airlineNamesForSearchText:airlineText];
    [_tableView reloadData];
}

- (void)selectedAirlineText:(NSString *)airline {
    _selectedAirlineName = airline;
    _airlineInputField.textField.text = airline;
    
    [self updateFields];
}

- (void)selectedDate:(NSDate *)departureDate {
    _departureDate = departureDate;
    _departureDateInputField.textField.text = [_dateFormatter stringFromDate:departureDate];
    
    [self updateFields];
}

- (void)enteredFlightNumber:(NSString *)flightNumber {
    _flightNumberString = flightNumber;
    _flightNumberInputField.textField.text = flightNumber;
    
    [self updateFields];
}

- (void)enteredDate:(NSDate *)departureDate {
    _departureDate = departureDate;
    _departureDateInputField.textField.text = [_dateFormatter stringFromDate:departureDate];
    
    [self updateFields];
}
        
- (void)updateFields {
    _flightNumberInputField.hidden = !_selectedAirlineName;
    _departureDateInputField.hidden = _flightNumberInputField.hidden || [_flightNumberString length] == 0;
    
    [_searchButton setTitle:kSelectAirline forState:UIControlStateNormal];
    
    if (!_flightNumberInputField.hidden) {
        [_searchButton setTitle:kEnterFlightNumber forState:UIControlStateNormal];
    }
    
    if (!_departureDateInputField.hidden) {
        [_searchButton setTitle:kSelectDepartureDate forState:UIControlStateNormal];
    }
    
    if (_selectedAirlineName && _flightNumberString && _departureDate) {
        [_searchButton setTitle:kSearchFlights forState:UIControlStateNormal];
    }
}

#pragma mark - UITableViewDelegate/Datasource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_airlineMatches count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ALVAirlineTableViewCell *airlinesCell = [tableView dequeueReusableCellWithIdentifier:[ALVAirlineTableViewCell className] forIndexPath:indexPath];
    airlinesCell.airlineText = [_airlineMatches objectAtIndex:indexPath.row];
    return airlinesCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self selectedAirlineText:[_airlineMatches objectAtIndex:indexPath.row]];
    [_airlineInputField.textField resignFirstResponder];
}

#pragma mark - UIDatePicker Selector Callback
- (void)pickerSelectedDate:(UIDatePicker *)picker {
    [self selectedDate:picker.date];
}

@end
