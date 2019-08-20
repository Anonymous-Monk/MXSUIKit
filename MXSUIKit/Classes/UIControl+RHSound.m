//
//  UIControl+RHSound.m
//  RHBaseModule
//
//  Created by aicai on 2018/7/9.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import "UIControl+RHSound.h"
#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>

static char const * const rh_kSoundsKey = "rh_kSoundsKey";

@implementation UIControl (RHSound)

- (void)rh_setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent
{
    // Remove the old UI sound.
    NSString *oldSoundKey = [NSString stringWithFormat:@"%lu", (unsigned long)controlEvent];
    AVAudioPlayer *oldSound = [self rh_sounds][oldSoundKey];
    [self removeTarget:oldSound action:@selector(play) forControlEvents:controlEvent];
    
    // Set appropriate category for UI sounds.
    // Do not mute other playing audio.
    [[AVAudioSession sharedInstance] setCategory:@"AVAudioSessionCategoryAmbient" error:nil];
    
    // Find the sound file.
    NSString *file = [name stringByDeletingPathExtension];
    NSString *extension = [name pathExtension];
    NSURL *soundFileURL = [[NSBundle mainBundle] URLForResource:file withExtension:extension];
    
    NSError *error = nil;
    
    // Create and prepare the sound.
    AVAudioPlayer *tapSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
    NSString *controlEventKey = [NSString stringWithFormat:@"%lu", (unsigned long)controlEvent];
    NSMutableDictionary *sounds = [self rh_sounds];
    [sounds setObject:tapSound forKey:controlEventKey];
    [tapSound prepareToPlay];
    if (!tapSound) {
        NSLog(@"Couldn't add sound - error: %@", error);
        return;
    }
    
    // Play the sound for the control event.
    [self addTarget:tapSound action:@selector(play) forControlEvents:controlEvent];
}


#pragma mark - Associated objects setters/getters

- (void)setrh_sounds:(NSMutableDictionary *)sounds
{
    objc_setAssociatedObject(self, rh_kSoundsKey, sounds, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)rh_sounds
{
    NSMutableDictionary *sounds = objc_getAssociatedObject(self, rh_kSoundsKey);
    
    // If sounds is not yet created, create it.
    if (!sounds) {
        sounds = [[NSMutableDictionary alloc] initWithCapacity:2];
        // Save it for later.
        [self setrh_sounds:sounds];
    }
    
    return sounds;
}

@end
