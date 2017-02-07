//
//  SpeedDemoVC.h
//  SpeedometerDemo
//
//  Created by Suhani on 20/01/17.
//
//

#import <UIKit/UIKit.h>

@interface SpeedDemoVC : UIViewController
{
    UIImageView *needleImageView;
    float speedometerCurrentValue;
    float prevAngleFactor;
    float angle;
    NSTimer *speedometer_Timer;
    UILabel *speedometerReading;
    NSString *maxVal;
}

@property(nonatomic,retain) UIImageView *downPaymentNeedleImageView;
@property(nonatomic,retain) UIImageView *monthlyPaymentNeedleImageView;
@property(nonatomic,retain) UIImageView *termsNeedleImageView;
@property(nonatomic,assign) float downPaymentCurrentValue;
@property(nonatomic,assign) float monthlyPaymentCurrentValue;
@property(nonatomic,assign) float termsCurrentValue;
@property(nonatomic,assign) float downPayPrevAngleFactor;
@property(nonatomic,assign) float monthlyPayPrevAngleFactor;
@property(nonatomic,assign) float termsPrevAngleFactor;
@property(nonatomic,assign) float downPayAngle;
@property(nonatomic,assign) float monthlyPayAngle;
@property(nonatomic,assign) float termsAngle;
@property(nonatomic,assign) int tagValue;
@property(nonatomic,retain) NSTimer *speedometer_Timer;
@property(nonatomic,retain) UILabel *downPaymentReading;
@property(nonatomic,retain) UILabel *monthlyPaymentReading;
@property(nonatomic,retain) UILabel *termsReading;
@property(nonatomic,retain) NSString *downPaymentMaxVal;
@property(nonatomic,retain) NSString *monthlyPaymentMaxVal;
@property(nonatomic,retain) NSString *termsMaxVal;

@property(nonatomic,retain) UISlider *sliderView1;
@property(nonatomic,retain) UISlider *sliderView2;
@property(nonatomic,retain) UISlider *sliderView3;

-(void) addTerm;
-(void) addDownPayment;
-(void) addMonthlyPayment;
-(void) rotateIt:(float)angl;
-(void) rotateNeedle;
-(void) setSpeedometerCurrentValue;

@end
