//
//  SpeedDemoVC.m
//  SpeedometerDemo
//
//  Created by Suhani on 20/01/17.
//
//

#import "SpeedDemoVC.h"

@interface SpeedDemoVC ()

@end

@implementation SpeedDemoVC

@synthesize downPaymentNeedleImageView;
@synthesize monthlyPaymentNeedleImageView;
@synthesize termsNeedleImageView;
@synthesize downPaymentCurrentValue;
@synthesize monthlyPaymentCurrentValue;
@synthesize termsCurrentValue;
@synthesize downPayPrevAngleFactor;
@synthesize monthlyPayPrevAngleFactor;
@synthesize termsPrevAngleFactor;
@synthesize downPayAngle;
@synthesize monthlyPayAngle;
@synthesize termsAngle;
@synthesize tagValue;
@synthesize speedometer_Timer;
@synthesize downPaymentReading;
@synthesize monthlyPaymentReading;
@synthesize termsReading;
@synthesize downPaymentMaxVal;
@synthesize monthlyPaymentMaxVal;
@synthesize termsMaxVal;
@synthesize sliderView1;
@synthesize sliderView2;
@synthesize sliderView3;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    // Add Meter Contents //
    [self addDownPayment];
    [self addMonthlyPayment];
    [self addTerm];
    [self.navigationController setNavigationBarHidden:YES];
    [super viewDidLoad];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}
/*
- (void)dealloc {
    [maxVal release];
    [needleImageView release];
    [speedometer_Timer release];
    [speedometerReading release];
    [super dealloc];
}*/


#pragma mark -
#pragma mark Public Methods

-(void) addDownPayment
{
    CGFloat height = (([UIScreen mainScreen].bounds.size.height * 180) / 480);
    CGFloat width = (([UIScreen mainScreen].bounds.size.width * 180) / 320);

    UIImageView *meterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 70, width, height)];
    meterImageView.contentMode = UIViewContentModeScaleAspectFit;
    meterImageView.image = [UIImage imageNamed:@"DownPayment.png"];
    [self.view addSubview:meterImageView];
//    [meterImageView release];

    //  Needle //
    height = (([UIScreen mainScreen].bounds.size.height * 65) / 480);
    width = (([UIScreen mainScreen].bounds.size.width * 11) / 320);
    UIImageView *imgNeedle = [[UIImageView alloc]initWithFrame:CGRectMake(meterImageView.center.x-(width/2),meterImageView.center.y-(height/2), width, height)];
    imgNeedle.contentMode = UIViewContentModeScaleAspectFit;
    self.downPaymentNeedleImageView = imgNeedle;
//    [imgNeedle release];
    
    self.downPaymentNeedleImageView.layer.anchorPoint = CGPointMake(self.downPaymentNeedleImageView.layer.anchorPoint.x, self.downPaymentNeedleImageView.layer.anchorPoint.y*2);
    self.downPaymentNeedleImageView.backgroundColor = [UIColor clearColor];
    self.downPaymentNeedleImageView.image = [UIImage imageNamed:@"onlyPin.png"];
    [self.view addSubview:self.downPaymentNeedleImageView];
    
    // Needle Dot //
    height = (([UIScreen mainScreen].bounds.size.height * 30) / 480);
    width = (([UIScreen mainScreen].bounds.size.width * 30) / 320);
    UIImageView *meterImageViewDot = [[UIImageView alloc]initWithFrame:CGRectMake(meterImageView.center.x-(width/2), meterImageView.center.y-(height/2), width,height)];
    meterImageViewDot.image = [UIImage imageNamed:@"onlyRound.png"];
    meterImageViewDot.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:meterImageViewDot];
//    [meterImageViewDot release];

    // Speedometer Reading //
    height = (([UIScreen mainScreen].bounds.size.height * 20) / 480);
    width = (([UIScreen mainScreen].bounds.size.width * 50) / 320);
    UILabel *tempReading = [[UILabel alloc] initWithFrame:CGRectMake(meterImageView.center.x-(width/2), meterImageView.center.y + 50, width, height)];
    self.downPaymentReading = tempReading;
//    [tempReading release];
    self.downPaymentReading.textAlignment = UITextAlignmentCenter;
    self.downPaymentReading.backgroundColor = [UIColor clearColor];
    self.downPaymentReading.adjustsFontSizeToFitWidth = YES;
    self.downPaymentReading.text= @"0";
    
    self.downPaymentReading.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
    [self.view addSubview:self.downPaymentReading ];

    // Set Progress Bar
    sliderView1 = [[UISlider alloc] init];
    sliderView1.tag = 1;
    sliderView1.frame = CGRectMake(40,meterImageView.frame.origin.y + meterImageView.frame.size.height,130,20);
    sliderView1.minimumValue = 0;
    sliderView1.minimumTrackTintColor = [UIColor redColor];
    sliderView1.maximumValue = 10000;
    sliderView1.maximumTrackTintColor = [UIColor blueColor];
    sliderView1.value = 0;
    [sliderView1 addTarget:self action:@selector(sliderValueChanged:) forControlEvents: UIControlEventValueChanged];
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapped:)];
//    [sliderView1 addGestureRecognizer:tapGestureRecognizer];
    [self.view addSubview:sliderView1];
    
    // Set Max Value //
    self.downPaymentMaxVal = @"10000";
    
    /// Set Needle pointer initialy at zero //
//    [self rotateIt:];
    [self.downPaymentNeedleImageView setTransform: CGAffineTransformMakeRotation((M_PI / 180) *-136)];

    // Set previous angle //
    self.downPayPrevAngleFactor = -136;

}

-(void) addMonthlyPayment
{
    CGFloat height = (([UIScreen mainScreen].bounds.size.height * 180) / 480);
    CGFloat width = (([UIScreen mainScreen].bounds.size.width * 180) / 320);
    UIImageView *meterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(70, self.view.center.y + 40, width, height)];
    meterImageView.contentMode = UIViewContentModeScaleAspectFit;
    meterImageView.image = [UIImage imageNamed:@"MonthlyPayment.png"];
    meterImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:meterImageView];
//    [meterImageView release];
    
    //  Needle //
    height = (([UIScreen mainScreen].bounds.size.height * 65) / 480);
    width = (([UIScreen mainScreen].bounds.size.width * 11) / 320);
    UIImageView *imgNeedle = [[UIImageView alloc]initWithFrame:CGRectMake(meterImageView.center.x-width/2,meterImageView.center.y-height/2, width, height)];
    imgNeedle.contentMode = UIViewContentModeScaleAspectFit;
    self.monthlyPaymentNeedleImageView= imgNeedle;
//    [imgNeedle release];
    
    self.monthlyPaymentNeedleImageView.layer.anchorPoint = CGPointMake(self.monthlyPaymentNeedleImageView.layer.anchorPoint.x, self.monthlyPaymentNeedleImageView.layer.anchorPoint.y*2);
    self.monthlyPaymentNeedleImageView.backgroundColor = [UIColor clearColor];
    self.monthlyPaymentNeedleImageView.image = [UIImage imageNamed:@"onlyPin.png"];
    [self.view addSubview:self.monthlyPaymentNeedleImageView];
    
    // Needle Dot //
    height = (([UIScreen mainScreen].bounds.size.height * 30) / 480);
    width = (([UIScreen mainScreen].bounds.size.width * 30) / 320);
    UIImageView *meterImageViewDot = [[UIImageView alloc]initWithFrame:CGRectMake(meterImageView.center.x-width/2, meterImageView.center.y-height/2, width, height)];
    meterImageViewDot.image = [UIImage imageNamed:@"onlyRound.png"];
    meterImageViewDot.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:meterImageViewDot];
//    [meterImageViewDot release];
    
    // Speedometer Reading //
    height = (([UIScreen mainScreen].bounds.size.height * 20) / 480);
    width = (([UIScreen mainScreen].bounds.size.width * 50) / 320);
    UILabel *tempReading = [[UILabel alloc] initWithFrame:CGRectMake(meterImageView.center.x-width/2, meterImageView.center.y + 60, width, height)];
    self.monthlyPaymentReading = tempReading;
//    [tempReading release];
    self.monthlyPaymentReading.textAlignment = UITextAlignmentCenter;
    self.monthlyPaymentReading.backgroundColor = [UIColor clearColor];
    self.monthlyPaymentReading.text= @"0";
    self.monthlyPaymentReading.adjustsFontSizeToFitWidth = YES;
    self.monthlyPaymentReading.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
    [self.view addSubview:self.monthlyPaymentReading ];
    
    // Set Progress Bar
    sliderView2 = [[UISlider alloc] init];
    sliderView2.tag = 2;
    sliderView2.frame = CGRectMake(100,meterImageView.frame.origin.y + meterImageView.frame.size.height - 10,130,20);
    sliderView2.minimumValue = 0;
    sliderView2.minimumTrackTintColor = [UIColor redColor];
    sliderView2.maximumValue = 1000;
    sliderView2.maximumTrackTintColor = [UIColor blueColor];
    sliderView2.value = 0;
    [sliderView2 addTarget:self action:@selector(sliderValueChanged:) forControlEvents: UIControlEventValueChanged];
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapped:)];
//    [sliderView2 addGestureRecognizer:tapGestureRecognizer];
    [self.view addSubview: sliderView2];

    // Set Max Value //
    self.monthlyPaymentMaxVal = @"1000";
    
    /// Set Needle pointer initialy at zero //
    [self.monthlyPaymentNeedleImageView setTransform: CGAffineTransformMakeRotation((M_PI / 180) *-136)];

    // Set previous angle //
    self.monthlyPayPrevAngleFactor = -136;
}

-(void) addTerm
{
    CGFloat height = (([UIScreen mainScreen].bounds.size.height * 120) / 480);
    CGFloat width = (([UIScreen mainScreen].bounds.size.width * 120) / 320);
    UIImageView *meterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x - self.view.center.x/3 , self.view.center.y - self.view.center.y/4, width, height)];
    meterImageView.contentMode = UIViewContentModeScaleAspectFit;
    meterImageView.image = [UIImage imageNamed:@"TermMeter.png"];
    meterImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:meterImageView];
//    [meterImageView release];
    
    //  Needle //
    height = (([UIScreen mainScreen].bounds.size.height * 43) / 480);
    width = (([UIScreen mainScreen].bounds.size.width * 10) / 320);
    UIImageView *imgNeedle = [[UIImageView alloc]initWithFrame:CGRectMake(meterImageView.center.x-width/2, meterImageView.center.y-height/2, width, height)];
    imgNeedle.contentMode = UIViewContentModeScaleAspectFit;
    self.termsNeedleImageView = imgNeedle;
//    [imgNeedle release];
    
    self.termsNeedleImageView.layer.anchorPoint = CGPointMake(self.termsNeedleImageView.layer.anchorPoint.x, self.termsNeedleImageView.layer.anchorPoint.y*2);
    self.termsNeedleImageView.backgroundColor = [UIColor clearColor];
    self.termsNeedleImageView.image = [UIImage imageNamed:@"onlyPin.png"];
    [self.view addSubview:self.termsNeedleImageView];
    
    // Needle Dot //
    height = (([UIScreen mainScreen].bounds.size.height * 20) / 480);
    width = (([UIScreen mainScreen].bounds.size.width * 20) / 320);
    UIImageView *meterImageViewDot = [[UIImageView alloc]initWithFrame:CGRectMake(meterImageView.center.x-width/2, meterImageView.center.y-height/2, width, height)];
    meterImageViewDot.image = [UIImage imageNamed:@"onlyRound.png"];
    meterImageViewDot.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:meterImageViewDot];
//    [meterImageViewDot release];
    
    // Speedometer Reading //
    height = (([UIScreen mainScreen].bounds.size.height * 20) / 480);
    width = (([UIScreen mainScreen].bounds.size.width * 25) / 320);
    UILabel *tempReading = [[UILabel alloc] initWithFrame:CGRectMake(meterImageView.center.x-width/2, meterImageView.center.y + 30, width, height)];
    self.termsReading = tempReading;
//    [tempReading release];
    self.termsReading.textAlignment = UITextAlignmentCenter;
    self.termsReading.backgroundColor = [UIColor clearColor];
    self.termsReading.text= @"24";
    self.termsReading.adjustsFontSizeToFitWidth = YES;
    self.termsReading.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
    [self.view addSubview:self.termsReading];
    
    // Set Progress Bar
    sliderView3 = [[UISlider alloc] init];
    sliderView3.tag = 3;
    sliderView3.transform = CGAffineTransformMakeRotation(M_PI_2);
    sliderView3.frame = CGRectMake(280,meterImageView.frame.origin.y + meterImageView.frame.size.height,20,120);
    sliderView3.minimumValue = 24;
    sliderView3.minimumTrackTintColor = [UIColor redColor];
    sliderView3.maximumValue = 110;
    sliderView3.maximumTrackTintColor = [UIColor blueColor];
    sliderView3.value = 0;
    [sliderView3 addTarget:self action:@selector(sliderValueChanged:) forControlEvents: UIControlEventValueChanged];
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapped:)];
//    [sliderView3 addGestureRecognizer:tapGestureRecognizer];
    [self.view addSubview: sliderView3];
    
    // Set Max Value //
    self.termsMaxVal = @"110";
    
    /// Set Needle pointer initialy at zero //
    [self.termsNeedleImageView setTransform: CGAffineTransformMakeRotation((M_PI / 180) *-136)];
    
    // Set previous angle //
    self.termsPrevAngleFactor = -136;
}

#pragma mark -
#pragma mark calculateDeviationAngle Method

-(void) calculateDeviationAngle
{
        if (tagValue==1){
            if([self.downPaymentMaxVal floatValue]>0){
               self.downPayAngle = ((self.downPaymentCurrentValue *271)/[self.downPaymentMaxVal floatValue])-136;  // 237.4 - Total angle between 0 - 10000 //
            } else {
                self.downPayAngle = 0;
            }
            if(self.downPayAngle<=-136)
            {
                self.downPayAngle = -136;
            }
            if(self.downPayAngle>=137)
            {
                self.downPayAngle = 137;
            }
            // If Calculated angle is greater than 180 deg, to avoid the needle to rotate in reverse direction first rotate the needle 1/3 of the calculated angle and then 2/3. //
            if(abs((int)(self.downPayAngle-self.downPayPrevAngleFactor)) >180)
            {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5f];
                [self rotateIt:self.downPayAngle/3];
                [UIView commitAnimations];
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5f];
                [self rotateIt:(self.downPayAngle*2)/3];
                [UIView commitAnimations];
                
            }
            self.downPayPrevAngleFactor = self.downPayAngle;
        } else if (tagValue==2) {
            if([self.monthlyPaymentMaxVal floatValue]>0){
                self.monthlyPayAngle = ((self.monthlyPaymentCurrentValue *271)/[self.monthlyPaymentMaxVal floatValue])-136;  // 237.4 - Total angle between 0 - 1000 //
            } else {
                self.monthlyPayAngle = 0;
            }
            if(self.monthlyPayAngle<=-136)
            {
                self.monthlyPayAngle = -136;
            }
            if(self.monthlyPayAngle>=137)
            {
                self.monthlyPayAngle = 137;
            }
            // If Calculated angle is greater than 180 deg, to avoid the needle to rotate in reverse direction first rotate the needle 1/3 of the calculated angle and then 2/3. //
            if(abs((int)(self.monthlyPayAngle-self.monthlyPayPrevAngleFactor)) >180)
            {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5f];
                [self rotateIt:self.monthlyPayAngle/3];
                [UIView commitAnimations];
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5f];
                [self rotateIt:(self.monthlyPayAngle*2)/3];
                [UIView commitAnimations];
            }
            self.monthlyPayPrevAngleFactor = self.monthlyPayAngle;
        } else if (tagValue==3) {
            if([self.termsMaxVal floatValue]>0){
                self.termsAngle = ((self.termsCurrentValue *271)/[self.termsMaxVal floatValue])-136;  // 237.4 - Total angle between 0 - 100 //
            } else {
                self.termsAngle = 0;
            }
            if(self.termsAngle<=-136)
            {
                self.termsAngle = -136;
            }
            if(self.termsAngle>=137)
            {
                self.termsAngle = 137;
            }
            // If Calculated angle is greater than 180 deg, to avoid the needle to rotate in reverse direction first rotate the needle 1/3 of the calculated angle and then 2/3. //
            if(abs((int)(self.termsAngle-self.termsPrevAngleFactor)) >180)
            {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5f];
                [self rotateIt:self.termsAngle/3];
                [UIView commitAnimations];
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5f];
                [self rotateIt:(self.termsAngle*2)/3];
                [UIView commitAnimations];
            }
            self.termsPrevAngleFactor = self.termsAngle;
        }
    // Rotate Needle //
    [self rotateNeedle];
 
}

#pragma mark -
#pragma mark adjust Slider Method
-(void) sliderValueChanged:(UISlider *)sender{
    
    if (sender.tag==1){
        self.downPaymentCurrentValue = sender.value;
        self.tagValue = 1;
    } else if (sender.tag==2){
        self.monthlyPaymentCurrentValue = sender.value;
        self.tagValue = 2;
    } else if (sender.tag==3){
        self.termsCurrentValue = sender.value;
        self.tagValue = 3;
    }
    // Set Speedometer Value //
    [self setSpeedometerCurrentValue];
}

-(void)sliderTapped:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.tagValue==1){
        CGPoint pointTapped = [gestureRecognizer locationInView:self.view];
        CGPoint positionOfSlider = sliderView1.frame.origin;
        CGFloat widthOfSlider = sliderView1.frame.size.width;
        CGFloat newValue = ((pointTapped.x - positionOfSlider.x) * (sliderView1.maximumValue) / widthOfSlider);
        [sliderView1 setValue: newValue animated: true];
        self.downPaymentCurrentValue = newValue;
    } else if (self.tagValue==2){
        CGPoint pointTapped = [gestureRecognizer locationInView:self.view];
        CGPoint positionOfSlider = sliderView2.frame.origin;
        CGFloat widthOfSlider = sliderView2.frame.size.width;
        CGFloat newValue = ((pointTapped.x - positionOfSlider.x) * (sliderView2.maximumValue) / widthOfSlider);
        [sliderView2 setValue: newValue animated: true];
        self.monthlyPaymentCurrentValue = newValue;
    } else if (self.tagValue==3){
        CGPoint pointTapped = [gestureRecognizer locationInView:self.view];
        CGPoint positionOfSlider = sliderView3.frame.origin;
        CGFloat widthOfSlider = sliderView3.frame.size.width;
        CGFloat newValue = ((pointTapped.x - positionOfSlider.x) * (sliderView3.maximumValue) / widthOfSlider);
        [sliderView3 setValue: newValue animated: true];
        self.termsCurrentValue = newValue;
    }
    [self setSpeedometerCurrentValue];
}

#pragma mark -
#pragma mark rotateNeedle Method
-(void) rotateNeedle
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    if (tagValue==1){
        [self.downPaymentNeedleImageView setTransform: CGAffineTransformMakeRotation((M_PI / 180) * self.downPayAngle)];
    } else if (tagValue==2){
        [self.monthlyPaymentNeedleImageView setTransform: CGAffineTransformMakeRotation((M_PI / 180) * self.monthlyPayAngle)];
    } else if (tagValue==3){
        [self.termsNeedleImageView setTransform: CGAffineTransformMakeRotation((M_PI / 180) * self.termsAngle)];
    }
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark setSpeedometerCurrentValue

-(void) setSpeedometerCurrentValue
{
    if(self.speedometer_Timer)
    {
        [self.speedometer_Timer invalidate];
        self.speedometer_Timer = nil;
    }
    
    if (self.tagValue==1){
        downPaymentReading.text = [NSString stringWithFormat:@"%.2f",self.downPaymentCurrentValue];
    } else if (self.tagValue==2){
        monthlyPaymentReading.text = [NSString stringWithFormat:@"%.2f",self.monthlyPaymentCurrentValue];
    } else if (self.tagValue==3){
        termsReading.text = [NSString stringWithFormat:@"%.2f",self.termsCurrentValue];
    }
    // Calculate the Angle by which the needle should rotate //
    [self calculateDeviationAngle];
}

#pragma mark -
#pragma mark Speedometer needle Rotation View Methods

-(void) rotateIt:(float)angl
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01f];
    if (tagValue==1){
        [self.downPaymentNeedleImageView setTransform: CGAffineTransformMakeRotation((M_PI / 180) *angl)];
    } else if (tagValue==2){
        [self.monthlyPaymentNeedleImageView setTransform: CGAffineTransformMakeRotation((M_PI / 180) *angl)];
    } else if (tagValue==3){
        [self.termsNeedleImageView setTransform: CGAffineTransformMakeRotation((M_PI / 180) *angl)];
    }
    [UIView commitAnimations];
}

@end

