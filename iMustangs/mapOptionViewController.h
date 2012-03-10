//
//  mapOptionViewController.h
//  iMustangs
//
//  Created by Eric Binnion on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mapOptionViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
    NSArray *pickerViewArray;
}
@property (retain, nonatomic) IBOutlet UIPickerView *picker;
@property (retain,nonatomic) IBOutlet NSArray *pickerViewArray;

@end
