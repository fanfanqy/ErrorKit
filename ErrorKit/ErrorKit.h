// ErrorKit.h
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

#ifndef _ERRORKIT_H
#define _ERRORKIT_H

#import "MRErrorBuilder.h"

#import "MRErrorFormatter.h"

#import "NSError+ErrorKit.h"

#import "UIAlertView+ErrorKit.h"

#ifndef _COREDATADEFINES_H
#import "MRErrorBuilder_CoreData.h"
#import "NSError_CoreData.h"
#endif

#ifndef _AFNETWORKING_
#import "MRErrorBuilder_AFNetworking.h"
#import "NSError_AFNetworking.h"
#endif

#ifndef MRLogError
#define MRLogError(error)                                                    \
    do {                                                                     \
        NSError *mr_##error##_ = error;                                      \
        if ([mr_##error##_ isKindOfClass:NSError.class]) {                   \
            NSLog(@"%s [Line %d]: %@ (code: %d, domain:%@)"                  \
                                      , __PRETTY_FUNCTION__                  \
                                      , __LINE__                             \
                                      , [mr_##error##_ localizedDescription] \
                                      , [mr_##error##_ code]                 \
                                      , [mr_##error##_ domain]);             \
        }                                                                    \
    } while(0)
#endif

#ifndef MRNotErrorAssert
#ifndef NS_BLOCK_ASSERTIONS
#define MRNotErrorAssert(error)                                    \
    do {                                                           \
        NSAssert(![(error) isKindOfClass:NSError.class]            \
                , @"%@ (code: %d, domain:%@)"                      \
                , [error localizedDescription]                     \
                , [error code]                                     \
                , [error domain]);                                 \
    } while(0)
#else
#define MRNotErrorAssert(error)
#endif
#endif

#endif