//
//  ViewController.m
//  day19_jsonAssignment
//
//  Created by Student 01 on 11/10/17.
//  Copyright © 2017 mohini. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mydata=[[NSMutableData alloc]init];
    self.myArray=[[NSMutableArray alloc]init];
    self.nameArray=[[NSMutableArray alloc]init];
    NSString *urlString=@"https://raw.githubusercontent.com/opendatajson/football.json/master/2015-16/en.1.clubs.json";
    NSURL *url=[NSURL URLWithString:urlString];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"Get"];
    [NSURLConnection connectionWithRequest:request delegate:self];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.mydata setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.mydata appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%@",self.mydata);
    NSDictionary *outerDictionary=[NSJSONSerialization JSONObjectWithData: self.mydata options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"Dictionary:%@",outerDictionary);
   NSArray *clubArray=[outerDictionary valueForKey:@"clubs"];
    NSLog(@"%@",clubArray);
    for(NSDictionary *Dic in clubArray )
    {
        NSString *keyString=[Dic valueForKey:@"key"];
        [self.myArray addObject:keyString];
        NSString *nameString=[Dic valueForKey:@"name"];
        [self.nameArray addObject:nameString];
      
    }
    NSLog(@"%@",self.myArray);
    NSLog(@"%@",self.nameArray);
    
    if(self.myArray.count > 0)
    {
        NSLog(@"Old Array %@",self.myArray);
        [self.myArray removeObjectIdenticalTo:[NSNull null]];
        NSLog(@"New Array %@",self.myArray);
         [self.myTableView reloadData];
    }
     else  if(self.nameArray.count > 0)
    {
        NSLog(@"Old Array %@",self.nameArray);
        [self.nameArray removeObjectIdenticalTo:[NSNull null]];
        NSLog(@"New Array %@",self.nameArray);
        [self.myTableView reloadData];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.myArray.count > 0)
    {
        return  self.myArray.count;
    }
    else
    {
        return 0;
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text=[self.myArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[self.nameArray objectAtIndex:indexPath.row];
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
