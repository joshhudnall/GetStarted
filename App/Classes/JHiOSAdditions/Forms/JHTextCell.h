//
//  JHTextFieldCell.h
//
//  Created by Josh Hudnall on 5/29/14.
//
//

#import <UIKit/UIKit.h>
#import "JHFormCell.h"

@interface JHTextCell : JHFormCell <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

