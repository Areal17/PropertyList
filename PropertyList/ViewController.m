//
//  ViewController.m
//  PropertyList
//
//  Created by Ingo Wiederoder on 19.06.15.
//  Copyright (c) 2015 Ingo Wiederoder. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UISlider) NSArray *colorSlider;

@property (strong, nonatomic) DocumentManager *docManager;
@property (strong, nonatomic) NSDictionary *plistValues;

@end


//
// setupSlider

@implementation ViewController

// customGetter


- (DocumentManager *)docManager {
    if (_docManager) {
        return _docManager;
    }
    _docManager = [[DocumentManager alloc] initWithPlistName:PLIST_NAME];
    return _docManager;
}

- (NSDictionary *)plistValues {
    if (_plistValues) {
        return _plistValues;
    }
    _plistValues = [self.docManager getValuesFromPlist];
    return _plistValues;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPropertyValues];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(applicationEnterBackground:) name:UIApplicationDidEnterBackgroundNotification  object:nil];
}


- (void)setupPropertyValues {
    NSArray *colorItem = [self.plistValues objectForKey:OBJECT_KEY];
    for (NSUInteger i = 0; i < self.colorSlider.count; i++) {
        UISlider *slider = self.colorSlider[i];
        slider.tag = i +1; // +1: to avoid 0 as tag
        slider.value = [colorItem[i] floatValue];
    }
    UIColor *bgColor = [UIColor colorWithRed:[colorItem[0] floatValue] green:[colorItem[1] floatValue] blue: [colorItem[1] floatValue] alpha:1.0];
    self.view.backgroundColor = bgColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action

- (IBAction)changeColorValue:(UISlider *)sender {
    UISlider *currentSlider = sender;
    NSMutableArray *colorItems = [self.plistValues objectForKey:OBJECT_KEY];
    NSNumber *newColorNum = [NSNumber numberWithFloat:currentSlider.value];
    NSInteger index = currentSlider.tag - 1;
    colorItems[index] = newColorNum;
    
    [self.plistValues setValue:colorItems forKey:OBJECT_KEY];
    UIColor *newColor = [UIColor colorWithRed:[colorItems[0] floatValue] green:[colorItems[1] floatValue] blue:[colorItems[2] floatValue] alpha:1.0];
    self.view.backgroundColor = newColor;
}



#pragma mark Notification

- (void)applicationEnterBackground:(NSNotification *)notification
{
    [self.docManager saveValues:self.plistValues error:nil];
}

@end
