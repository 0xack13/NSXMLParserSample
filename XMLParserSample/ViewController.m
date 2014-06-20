//
//  ViewController.m
//  XMLParserSample
//
//  Created by 0xack13 on 6/20/14.
//  Copyright (c) 2014 0xack13. All rights reserved.
//

#import "ViewController.h"
#import "InfoXMLElement.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize parser;
@synthesize currentAttribute;
@synthesize xmlElementObjects;

@synthesize tempElement;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    xmlElementObjects = [[NSMutableArray alloc] init];
    
    //Parse Local XML File which is located in the same project
    NSString *xmlFilePath = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"xml"];
    NSData *mydata = [[NSData alloc] initWithContentsOfFile:xmlFilePath];
    parser = [[NSXMLParser alloc] initWithData:mydata];
    
    [parser setDelegate:self];
	[parser parse];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if(![elementName compare:@"Contacts"])
	{
        NSLog(@"Root/Contact comparison has just started!");
	}
    
    else if(![elementName compare:@"ContactInfo"])
	{
		NSLog(@"ContactInfo comparison has just started!");
		tempElement = [[InfoXMLElement alloc] init];
	}
	
	else if(![elementName compare:@"FirstName"])
	{
		currentAttribute = [NSMutableString string];
	}
	
	else if(![elementName compare:@"SecondName"])
	{
		currentAttribute = [NSMutableString string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
	if(![elementName compare:@"ContactInfo"])
	{
		[xmlElementObjects addObject:tempElement];
	}
	
	else if(![elementName compare:@"FirstName"])
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
