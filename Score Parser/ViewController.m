//
//  ViewController.m
//  Score Parser
//
//  Created by Sony Theakanath on 5/8/14.
//  Copyright (c) 2014 Sony Theakanath. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    //Change your URL here
    NSString *urlstring = @"http://www.bcp.org/athletics/teampage.aspx?TeamID=538";
    
    //Parsing the Bellarmine Website for the data
    NSArray *opponent = [[[NSString alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]] encoding: NSASCIIStringEncoding] componentsSeparatedByString:@"<td class=\"team-schedule-opponent\">"];
    NSMutableArray *teamname = [[NSMutableArray alloc] init];
     NSMutableArray *scores = [[NSMutableArray alloc] init];
   for(int x = 0; x < [opponent count]-1; x++) {
       [teamname addObject:[[[[[opponent objectAtIndex:x+1] componentsSeparatedByString:@"\">"] objectAtIndex:1]componentsSeparatedByString:@"</a>"] objectAtIndex:0]];
       [scores addObject:[[[[[opponent objectAtIndex:x+1] componentsSeparatedByString:@"<td class=\"team-schedule-result\" nowrap=\"nowrap\">"] objectAtIndex:1] componentsSeparatedByString:@"</td>"] objectAtIndex:0]];
    }
    
    //Outputting the data into a CSV file; Column 1 is Opposing Team Name, Column 2 is Score
    NSString *csvString = @"";
    for (int x = 0; x < [teamname count]; x++)
        csvString = [csvString stringByAppendingFormat:@"%@,%@\n", [teamname objectAtIndex:x], [scores objectAtIndex:x]];
    NSLog(@"Document is Located Here: %@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.csv", @"scoredata"]];
    [[NSFileManager defaultManager] createFileAtPath:fullPath contents:[csvString dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
}

@end
