// MRErrorFormatter+VeriJSON.m
//
// Copyright (c) 2013 Héctor Marqués
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MRErrorFormatter+VeriJSON.h"
#import "ErrorKitImports.h"

#if  ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Either turn on ARC for the project or use -fobjc-arc flag
#endif


#ifdef ERROR_KIT_VERI_JSON

@implementation MRErrorFormatter (ErrorKit_VeriJSON)

+ (NSString *)debugStringWithVeriJSONCode:(NSInteger)code
{
    switch (code) {
        case VeriJSONErrorCodeInvalidPattern:
            return mr_stringize_error_code(VeriJSONErrorCodeInvalidPattern);
    }
    return @(code).stringValue;
}

+ (NSString *)stringWithVeriJSONCode:(NSInteger)code
{
    switch (code) {
        case VeriJSONErrorCodeInvalidPattern:
            return MRErrorKitString(@"Invalid JSON Pattern", nil);
    }
    return MRErrorKitString(@"JSON Error", nil);
}

@end

#endif
