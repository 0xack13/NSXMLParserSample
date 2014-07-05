//
//  ViewController.m
//  XMLParserSample
//
//  Created by 0xack13 on 6/20/14.
//  Copyright (c) 2014 0xack13. All rights reserved.
//

#import "ViewController.h"
#import "InfoXMLElement.h"

#define FONT_SIZE 18.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface ViewController ()

@end

@implementation ViewController

@synthesize parser;
@synthesize currentAttribute;
@synthesize xmlElementObjects;
@synthesize greekLetters;
@synthesize ayaArray;
@synthesize tempElement;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
    
    xmlElementObjects = [[NSMutableArray alloc] init];
    ayaArray = [[NSMutableArray alloc] init];
    self.greekLetters = @[@"Alpha", @"Beta"];
    
    
    
    //Parse Local XML File which is located in the same project
    NSString *xmlFilePath = [[NSBundle mainBundle] pathForResource:@"Alkahf-Surah" ofType:@"xml"];
    NSData *mydata = [[NSData alloc] initWithContentsOfFile:xmlFilePath];
    parser = [[NSXMLParser alloc] initWithData:mydata];
    
    [parser setDelegate:self];
	[parser parse];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if(![elementName compare:@"quran"])
	{
        NSLog(@"Root/Contact comparison has just started!");
	}
    
    else if(![elementName compare:@"sura"])
	{
		NSLog(@"ContactInfo comparison has just started!");
		tempElement = [[InfoXMLElement alloc] init];
	}
	
	else if(![elementName compare:@"aya"])
	{
		currentAttribute = [NSMutableString string];
        
        NSString * name = [attributeDict objectForKey:@"text"];
        
        // ... get the other attributes
        
        // when we have our various attributes, you can add them to your arrays
        //[m_NameArray addObject:name];
        NSLog(@"Aya: %@", name);
        [self.ayaArray addObject:name];
	}
	
	else if(![elementName compare:@"SecondName"])
	{
		currentAttribute = [NSMutableString string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
	if(![elementName compare:@"sura"])
	{
		[xmlElementObjects addObject:tempElement];
	}
	
	else if(![elementName compare:@"aya"])
	{
	    NSLog(@"First Name: %@", currentAttribute);
        
        NSString *FirstName = [[NSString alloc] initWithString:currentAttribute];
        [tempElement setFirstName:FirstName];
        
        
	}
	
	else if(![elementName compare:@"SecondName"])
	{
		NSLog(@"Second Name: %@", currentAttribute);
		
		[tempElement setSecondName:currentAttribute];
	}
	
	else if(![elementName compare:@"Contacts"])
	{
		NSLog(@"Root/Contacts comparison ended.");
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if(self.currentAttribute)
	{
		[self.currentAttribute appendString:string];
 	}
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Number of elements in section is: %d with %@", [self.ayaArray count], self.ayaArray[1]);
    return [self.ayaArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText    = @"some text which is part of cell display";
    UIFont *cellFont      = [UIFont fontWithName:@"KFGQPCUthmanicScriptHAFS" size:22];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize      = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    int buffer  = 20;
    return labelSize.height + buffer;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *SimpleIdentifier = @"SimpleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleIdentifier];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        

        cell.textLabel.numberOfLines = 0;
        [[cell textLabel] setNumberOfLines:0];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        [cell.textLabel setMinimumFontSize:8];
        [cell.textLabel setAdjustsFontSizeToFitWidth:NO];
        cell.textLabel.font = [UIFont fontWithName:@"KFGQPCUthmanicScriptHAFS" size:12];

    }
    NSLog(@"%@",self.ayaArray[indexPath.row]);
    cell.textLabel.text = self.ayaArray[indexPath.row];
    
    /*
    
    UITableViewCell *cell;
    //UILabel *label = nil;
    UITextView *label = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"Cell"];
        
        label = [[UITextView alloc] initWithFrame:CGRectZero];
        label.editable = NO;
        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.contentSize.width, label.contentSize.height);
        label.scrollEnabled = NO;
        //[label linebr:NSLineBreakByWordWrapping];
        [label setTextAlignment:UITextAlignmentCenter];
        //[label setMinimumFontSize:FONT_SIZE];
        
        //[label setNumberOfLines:0];
        [label setFont:[UIFont fontWithName:@"KFGQPCUthmanicScriptHAFS" size:FONT_SIZE]];
        [label setTag:1];
        
        [[label layer] setBorderWidth:0.0f];
        
        [[cell contentView] addSubview:label];
        
    }
    NSString *text = [ayaArray objectAtIndex:[indexPath row]];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    if (!label)
    label = (UILabel*)[cell viewWithTag:1];
    
    [label setText:text];
    [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
    
    return cell;*/
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
