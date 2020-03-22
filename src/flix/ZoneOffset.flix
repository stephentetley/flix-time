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

///
/// A wrapper around a Java ZoneOffset.
///
opaque type ZoneOffset = ##java.time.ZoneOffset

namespace Time/ZoneOffset {

    pub def fromHours(hours: Int32): ZoneOffset =
        import java.time.ZoneOffset:ofHours(Int32);
        ZoneOffset(ofHours(hours)) as & Pure

    pub def fromHoursMinutes(hours: Int32, minutes: Int32): ZoneOffset =
        import java.time.ZoneOffset:ofHoursMinutes(Int32, Int32);
        ZoneOffset(ofHoursMinutes(hours, minutes)) as & Pure

    pub def fromHoursMinutesSeconds(hours: Int32, minutes: Int32, seconds: Int32): ZoneOffset =
        import java.time.ZoneOffset:ofHoursMinutesSeconds(Int32, Int32, Int32);
        ZoneOffset(ofHoursMinutesSeconds(hours, minutes, seconds)) as & Pure

    pub def fromTotalSeconds(seconds: Int32): ZoneOffset =
        import java.time.ZoneOffset:ofTotalSeconds(Int32);
        ZoneOffset(ofTotalSeconds(seconds)) as & Pure

    ///
    /// Returns the given ZoneOffset `x` as a String.
    ///
    pub def toString(x: ZoneOffset): String =
        import java.time.ZoneOffset.toString();
        let ZoneOffset(z) = x;
        z.toString() as & Pure

}
