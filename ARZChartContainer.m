//
//  ARZChartContainer.m
//  TestMyChart
//
//  Created by Arash Zeinoddini on 10/24/12.
//  Copyright (c) 2012 Arash Zeinoddini. All rights reserved.
//

#import "ARZChartContainer.h"
#import "ARZLineChart.h"

@implementation ARZChartContainer

- (id)initWithFrame:(CGRect)frame ChartType:(NSString *)chartType
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentSize=CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        self.showsHorizontalScrollIndicator=false;
        self.showsVerticalScrollIndicator=false;
        
        if (chartType==@"Line") {
            
            chartLine= [[ARZLineChart alloc]initWithFrame:self.bounds andDelegate:(id)self];
            [self addSubview:chartLine];
        
        }
    }
    return self;
}

- (void)setLineChartArray:(NSMutableArray *)array {
    if (chartLine!=nil) {
        [chartLine setDrawArray:array];
    }
    else {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please first alloc Line Chart and then send message to this method" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)setLineChartWidth:(int)width {
    if (chartLine!=nil) {
        [chartLine setLineWidth:width];
    }
    else {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please first alloc Line Chart and then send message to this method" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
        [alertView show];

    }
}

- (void)setLineChartColor:(float)red Green:(float) green Blue:(float) blue Alpha:(float) alpha {
    if (chartLine!=nil) {
        [chartLine setLineColor:red Green:green Blue:blue Alpha:alpha];
    }
    else {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please first alloc Line Chart and then send message to this method" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}

- (void)setLineChartIndicatorWidth:(int) width {
    if (chartLine!=nil) {
        [chartLine setLineIndicatorWidth:width];
    }
    else {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please first alloc Line Chart and then send message to this method" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}

- (void)setLineChartCircleIndicatorCenterSize:(int) size {
    if (chartLine!=nil) {
        [chartLine setCircleIndicatorCenterSize:size];
    }
    else {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please first alloc Line Chart and then send message to this method" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}

- (void)setLineChartCircleIndicatorCenterColor:(float)red Green:(float) green Blue:(float) blue Alpha:(float) alpha{
    if (chartLine!=nil) {
        [chartLine setCircleIndicatorCenterColor:red Green:green Blue:blue Alpha:alpha];
    }
    else {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please first alloc Line Chart and then send message to this method" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}

- (void)setLineChartUnderGraphColor:(float)red Green:(float) green Blue:(float) blue Alpha:(float) alpha {
    if (chartLine!=nil) {
        [chartLine setUnderGraphColor:red Green:green Blue:blue Alpha:alpha];
    }
    else {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please first alloc Line Chart and then send message to this method" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}

- (void)setLineChartBackgroundColor:(UIColor *)color {
    if (chartLine!=nil) {
        chartLine.backgroundColor=color;
    }
    else {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please first alloc Line Chart and then use this property" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}

- (void)setLineChartDynamicIndicatorToShow:(BOOL)show {
    if (chartLine!=nil) {
        chartLine.dynamicIndicator=show;
    }
    else {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please first alloc Line Chart and then use this property" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}

#pragma mark -
#pragma mark ARZChartLine Methods
-(void) valueLineChartChangedWith:(NSString *)value {
    
}

-(void) widthLineChartChanged:(int)width Height:(int)height {
    self.contentSize=CGSizeMake(width, height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
