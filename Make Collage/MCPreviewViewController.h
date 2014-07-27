//
//  MCPreviewViewController.h
//  Make Collage
//
//  Created by Tkachenko Dmitry on 27.07.14.
//  Copyright (c) 2014 deadpadre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface MCPreviewViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property UIImage *previewImage;

@end
