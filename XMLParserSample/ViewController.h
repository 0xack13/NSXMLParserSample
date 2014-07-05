//
//  ViewController.h
//  XMLParserSample
//
//  Created by 0xack13 on 6/20/14.
//  Copyright (c) 2014 0xack13. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoXMLElement.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSXMLParser *parser;
    NSMutableArray *xmlElementObjects;
    NSMutableString *currentAttribute;
    
    InfoXMLElement *tempElement;
}

@property (nonatomic, retain) NSXMLParser *parser;
@property (nonatomic, retain) NSMutableArray *xmlElementObjects;
@property (nonatomic, retain) NSMutableString *currentAttribute;
@property (nonatomic, retain) InfoXMLElement *tempElement;
@property (nonatomic, retain) NSMutableArray *greekLetters;
@property (nonatomic, retain) NSMutableArray *ayaArray;

@end
