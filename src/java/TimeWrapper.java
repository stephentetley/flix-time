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

package flix.runtime.spt.newtime;

import java.time.Instant;
import java.time.chrono.HijrahEra;
import java.time.format.TextStyle;
import java.time.temporal.TemporalField;
import java.time.temporal.ValueRange;
import java.util.Locale;


public class TimeWrapper {
    // `range` causes Flix to throw parse errors in "import java...." statements
    public static ValueRange instantRange(Instant i, TemporalField field) throws Exception {
        return i.range(field);
    }

    // `getDisplayName` causes same parse error
    public static String hijrahEraGetDisplayName(HijrahEra x, TextStyle style, Locale locale) {
        return x.getDisplayName(style, locale);
    }
}
