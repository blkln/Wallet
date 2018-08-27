//
//  ViewController.m
//  Wallet
//
//  Created by Serhii Kovtunenko on 8/25/18.
//  Copyright © 2018 Serhii Kovtunenko. All rights reserved.
//

#import "ViewController.h"
#import "RoundedCornersButton.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet RoundedCornersButton *sendMoneyButton;
@property (strong, nonatomic) IBOutlet RoundedCornersButton *payButton;
@property (strong, nonatomic) IBOutlet RoundedCornersButton *billButton;
@property (weak, nonatomic) IBOutlet RoundedCornersButton *replenishButton;
@property (weak, nonatomic) IBOutlet RoundedCornersButton *withdrawButton;

@property (weak, nonatomic) IBOutlet UILabel *accountNumber;
@property (weak, nonatomic) IBOutlet UILabel *balance;

@property (nonatomic) NSString *accountNumberString;
@property (assign) long balanceValue;
@property (nonatomic) NSMutableArray *invoices;
@property (nonatomic) NSMutableArray *favorites;
@property (nonatomic) NSMutableArray *last;

@end

@implementation ViewController

-(NSMutableArray *)invoices
{
    if (!_invoices) {
        _invoices = [[NSMutableArray alloc] init];
    }
    return _invoices;
}

-(NSMutableArray *)favorites
{
    if (!_favorites) {
        _favorites = [[NSMutableArray alloc] init];
    }
    return _favorites;
}

-(NSMutableArray *)last
{
    if (!_last) {
        _last = [[NSMutableArray alloc] init];
    }
    return _last;
}

#pragma mark - Button actions

- (IBAction)replenish:(RoundedCornersButton *)sender
{
    [self showButtonDescription:sender.buttonDescription withTitle:sender.buttonTitle];
}

- (IBAction)withdraw:(RoundedCornersButton *)sender
{
    [self showButtonDescription:sender.buttonDescription withTitle:sender.buttonTitle];
}

- (IBAction)sendMoney:(RoundedCornersButton *)sender
{
    [self showButtonDescription:sender.buttonDescription withTitle:sender.buttonTitle];
}
- (IBAction)pay:(RoundedCornersButton *)sender
{
    [self showButtonDescription:sender.buttonDescription withTitle:sender.buttonTitle];
}
- (IBAction)bill:(RoundedCornersButton *)sender
{
    [self showButtonDescription:sender.buttonDescription withTitle:sender.buttonTitle];
}

-(void)showButtonDescription:(NSString *)description withTitle:(NSString *)title
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:description
                                                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];


}

#pragma mark - TableViewDelegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountDescription" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"accountDescription"];
    }
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *accountNumberLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UIImageView *accountImage = (UIImageView *)[cell.contentView viewWithTag:3];
    UIImageView *favoritesImage = (UIImageView *)[cell.contentView viewWithTag:4];
    
    
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    
    switch (indexPath.section) {
        case 0:
            dictionary = [self.invoices firstObject];
            favoritesImage.image = [UIImage imageNamed:@"star-gray"];
            break;
        
        case 1:
            dictionary = [self.favorites objectAtIndex:indexPath.row];
            favoritesImage.image = [UIImage imageNamed:@"star-orange"];
            break;
            
        case 2:
            dictionary = [self.last objectAtIndex:indexPath.row];
            favoritesImage.image = [UIImage imageNamed:@"star-gray"];
            break;
            
        default:
            break;
    }
    
    NSString *key;
    if (indexPath.section == 0) {
        key = @"account";
    } else {
        key = @"account1";
    }
    
    if ([dictionary[@"name"] length]) {
        nameLabel.text = dictionary[@"name"];
        accountNumberLabel.text = dictionary[key];
        if ([dictionary[@"name"] isEqual: @"Жена"]) {
            accountImage.image = [UIImage imageNamed:@"user_female_circle"];
        } else {
            accountImage.image = [UIImage imageNamed:@"user_male_circle"];
        }
        
    } else {
        nameLabel.text = dictionary[key];
        accountNumberLabel.text = @"";
        accountImage.image = [UIImage imageNamed:indexPath.section == 1 ? @"visa" : @"mastercard"];
    }
    

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    unsigned long rowsInSection;
    switch (section) {
        case 0:
            rowsInSection = [self.invoices count];
            break;
        case 1:
            rowsInSection = [self.favorites count];
            break;
        case 2:
            rowsInSection = [self.last count];
            break;
            
        default:
            break;
    }
    return rowsInSection;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView    // Default is 1 if not implemented
{
    return 3;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    NSString *sectionName;
    switch (section) {
        case 0:
            sectionName = @"Инвойсы";
            break;
        case 1:
            sectionName = @"Избранные";
            break;
        case 2:
            sectionName = @"Последние";
            break;
            
        default:
            break;
    }
    return sectionName;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.textLabel.textColor = [UIColor grayColor];
    header.textLabel.font = [UIFont systemFontOfSize:11];
    CGRect headerFrame = header.frame;
    header.textLabel.frame = headerFrame;
    header.textLabel.textAlignment = NSTextAlignmentLeft;
}


#pragma mark - Data reading

-(void)readData
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"dashboard" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    
    NSError *error = nil;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
    if (!jsonData) {
        NSLog(@"Error parsing JSON: %@", error);
    }
    
    NSNumber *value =jsonData[@"balance"];
    self.balanceValue = [value longValue];
    NSLog(@"%ld", (long)self.balanceValue);
    
    self.accountNumberString = [NSString stringWithString:jsonData[@"account"]];
    NSString *balanceString = [NSString stringWithFormat:@"%@", jsonData[@"balance"]];
    
    NSLog(@"%@", self.accountNumberString);
    NSLog(@"%@", balanceString);

    
    for (id value in jsonData[@"invoices"]) {
        [self.invoices addObject:value];         //  1 element
    }
    
    for (id value in jsonData[@"favorites"]) {
        [self.favorites addObject:value];        //  4 elements
    }

    for (id value in jsonData[@"last"]) {
        [self.last addObject:value];             //  3 elements
    }
    
    for (NSDictionary *dictionary in self.invoices) {
        for (NSString *key in dictionary) {
            id value = dictionary[key];
            NSLog(@"%@ : %@", key, value);
        }
    }
    
    for (NSDictionary *dictionary in self.favorites) {
        for (NSString *key in dictionary) {
            id value = dictionary[key];
            NSLog(@"%@ : %@", key, value);
        }
    }
    
    for (NSDictionary *dictionary in self.last) {
        for (NSString *key in dictionary) {
            id value = dictionary[key];
            NSLog(@"%@ : %@", key, value);
        }
    }
}

#pragma mark - UI preparation


-(NSAttributedString *)makeAttributedAccountNumberString
{
    NSMutableAttributedString *attrStartingString = [[NSMutableAttributedString alloc] initWithString:@"LeoWallet "];
    [attrStartingString addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:13]
                       range:NSMakeRange(0, [@"LeoWallet " length])];
    NSMutableAttributedString *attrEndingString = [[NSMutableAttributedString alloc] initWithString:self.accountNumberString];
    [attrEndingString addAttribute:NSFontAttributeName
                             value:[UIFont boldSystemFontOfSize:15]
                             range:NSMakeRange(0, self.accountNumberString.length)];
    
    [attrStartingString appendAttributedString:attrEndingString];

    return attrStartingString;
}

-(NSAttributedString *)makeAttributedBalanceString
{
    NSString *prefixString = [NSString stringWithFormat:@"₴ "];
    NSString *startingString = [NSString stringWithFormat:@"%ld",(self.balanceValue / 100)];
    NSString *endingString = [NSString stringWithFormat:@".%ld", (self.balanceValue % 100)];
    
    NSLog(@"%@", prefixString);
    NSLog(@"%@", startingString);
    NSLog(@"%@", endingString);
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:prefixString];
    [attrString addAttribute:NSFontAttributeName
                               value:[UIFont systemFontOfSize:40 weight:UIFontWeightThin]
                               range:NSMakeRange(0, prefixString.length)];


    NSMutableAttributedString *attrStartingString = [[NSMutableAttributedString alloc] initWithString:startingString];
    [attrStartingString addAttribute:NSFontAttributeName
                            value:[UIFont boldSystemFontOfSize:40]
                            range:NSMakeRange(0, startingString.length)];
    
    NSMutableAttributedString *attrEndingString = [[NSMutableAttributedString alloc] initWithString:endingString];
    [attrEndingString addAttribute:NSFontAttributeName
                             value:[UIFont boldSystemFontOfSize:20]
                             range:NSMakeRange(0, endingString.length)];
    
    [attrString appendAttributedString:attrStartingString];
    [attrString appendAttributedString:attrEndingString];

    return attrString;
}

-(void)updateUI
{
    self.accountNumber.attributedText = [self makeAttributedAccountNumberString];
    self.balance.attributedText = [self makeAttributedBalanceString];
    
    

}

-(void)setButtonProperties
{
    self.replenishButton.buttonTitle = @"Пополнить";
    self.replenishButton.buttonDescription = @"Пополнение лицевого счета";
    
    self.withdrawButton.buttonTitle = @"Вывести";
    self.withdrawButton.buttonDescription = @"Вывод средств";
    
    self.sendMoneyButton.buttonTitle = @"Перевести деньги";
    self.sendMoneyButton.buttonDescription = @"Перевод средств на другой счет";
    
    self.payButton.buttonTitle = @"Оплатить услуги";
    self.payButton.buttonDescription = @"Провести оплату выбранных услуг";

    self.billButton.buttonTitle = @"Выставить счет";
    self.billButton.buttonDescription = @"Предоставление счета к оплате";


}

-(void)customizeButtons
{
    NSArray *buttons = [[NSArray alloc] initWithObjects:self.sendMoneyButton, self.payButton, self.billButton, nil];
    for (UIButton *button in buttons) {
        button.layer.shadowOffset = CGSizeMake(0.0, 5.0);
        button.layer.shadowOpacity = 0.3;
    }
}

#pragma mark - VC lifecycle

-(void)viewWillAppear:(BOOL)animated
{
    [self customizeButtons];
    [self setButtonProperties];
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self readData];
}

@end

