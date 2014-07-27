//
//  MCPreviewViewController.m
//  Make Collage
//
//  Created by Tkachenko Dmitry on 27.07.14.
//  Copyright (c) 2014 deadpadre. All rights reserved.
//

#import "MCPreviewViewController.h"

@interface MCPreviewViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

@end

@implementation MCPreviewViewController

- (IBAction)shareViaEmail:(UIBarButtonItem *)sender {
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"MakeCollage. How do you like it?"];
    
    UIImage *image = self.previewImageView.image;
    NSData *myData = UIImagePNGRepresentation(image);
    [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"MakeCollage.png"];
    
    NSString *emailBody = @"Image is attached";
    [picker setMessageBody:emailBody isHTML:NO];
    [self presentViewController:picker animated:YES completion:^{}];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.previewImageView.image = self.previewImage;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: failed");
            break;
        default:
            NSLog(@"Result: not sent");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
