/*
 * Copyright 2020 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

use Time.Month;
use Time.Month.{January, February, March, April, May, June, July, August, September, October, November, December};

namespace Time {

    pub enum Month {
        case January,
        case February,
        case March,
        case April,
        case May,
        case June,
        case July,
        case August,
        case September,
        case October,
        case November,
        case December
    }

}

namespace Time/Month {

    pub def toInt32(x: Month): Int32 = match x {
        case January => 1
        case February => 2
        case March => 3
        case April => 4
        case May => 5
        case June => 6
        case July => 7
        case August => 8
        case September => 9
        case October => 10
        case November => 11
        case December => 12
    }

    pub def fromInt32(n: Int32): Month = match (n % 12) {
        case 1 => January
        case 2 => February
        case 3 => March
        case 4 => April
        case 5 => May
        case 6 => June
        case 7 => July
        case 8 => August
        case 9 => September
        case 10 => October
        case 11 => November
        case _ => December
    }


    // Wrapping `getDisplayName` a priority so we can experiment with Locale.

}