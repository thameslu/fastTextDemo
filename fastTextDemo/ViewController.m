//
//  ViewController.m
//  fastTextDemo
//
//  Created by thameslu on 2019/8/18.
//  Copyright © 2019年 thames. All rights reserved.
//

#import "ViewController.h"
#import <iomanip>
#import <iostream>
#import <queue>
#import <stdexcept>
#import "args.h"
#import "fasttext.h"

using namespace fasttext;

#define FastText_Command_Train @"fastText supervised -input %@ -output %@ -dim 10 -lr 0.1 -wordNgrams 2 -minCount 1 -bucket 10000000 -epoch 5 -thread 4"

@interface ViewController ()

- (IBAction)train:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 参考main.cc：`void train(const std::vector<std::string> args)`
- (IBAction)train:(id)sender {
    
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *resultDirectory = [libraryDirectory stringByAppendingPathComponent:@"result"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:resultDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:resultDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    // 请运行classification-example.sh以获取fastText-0.9.1/data/dbpedia.train和dbpedia.test文件
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"dbpedia.train" ofType:nil];
    NSString *outputPath = [resultDirectory stringByAppendingPathComponent:@"dbpedia"];
    NSLog(@"modelPath:%@", modelPath);
    NSLog(@"outputPath:%@", outputPath);
    
    std::vector<std::string> args;
    NSString *command = [NSString stringWithFormat:FastText_Command_Train, modelPath, outputPath];
    for (NSString *component in [command componentsSeparatedByString:@" "]) {
        args.push_back([component UTF8String]);
    }
    
    Args a = Args();
    a.parseArgs(args);
    FastText fasttext;
    std::string outputFileName(a.output + ".bin");
    std::ofstream ofs(outputFileName);
    if (!ofs.is_open()) {
        throw std::invalid_argument(
                                    outputFileName + " cannot be opened for saving.");
    }
    ofs.close();
    fasttext.train(a);
    fasttext.saveModel(outputFileName);
    fasttext.saveVectors(a.output + ".vec");
    if (a.saveOutput) {
        fasttext.saveOutput(a.output + ".output");
    }
}
@end
