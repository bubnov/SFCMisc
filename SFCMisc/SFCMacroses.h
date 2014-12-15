//
//  SFCMacroses.h
//  SFCMisc
//
//  Created by bubnovslavik@gmail.com on 15.12.14.
//  Copyright (c) Bubnov Slavik, bubnovslavik@gmail.com. All rights reserved.
//

#define safe_cast(TYPE, object)  ([object isKindOfClass:[TYPE class]] ? object : nil)