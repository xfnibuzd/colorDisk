//
//  ViewController.m
//  ColorDisk
//
//  Created by liuxiaofeng on 16/8/26.
//  Copyright © 2016年 my. All rights reserved.
//

#import "ViewController.h"
#import "ColorDisk.h"

@interface ViewController ()

@end

@implementation ViewController

{
    ColorDisk *disk;
    UIImageView *colorImg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    disk = [[ColorDisk alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    disk.center = CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height*0.5);
    [self.view addSubview:disk];
    [disk addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventValueChanged];

    colorImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
    colorImg.center = CGPointMake(self.view.bounds.size.width*0.5, 120);
    [self.view addSubview:colorImg];
}


- (void)changeColor{
    colorImg.backgroundColor = disk.selectedColor;
}

@end
