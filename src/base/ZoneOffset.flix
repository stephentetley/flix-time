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

namespace Time {

    ///
    /// A wrapper around a Java ZoneOffset.
    ///
    pub opaque type ZoneOffset = ##java.time.ZoneOffset

    ///
    /// Returns the given ZoneOffset `x` as a String.
    ///
    instance ToString[ZoneOffset] {
        pub def toString(x: ZoneOffset): String =
            import java.time.ZoneOffset.toString();
            let ZoneOffset(x1) = x;
            toString(x1) as & Pure
    }
    
    instance FromString[ZoneOffset] {
        pub def fromString(x: String): Option[ZoneOffset] =
            import java.lang.String.strip();
            import java.time.ZoneOffset:of(String);
            try {
                let x1 = strip(x) as & Pure;
                Some(ZoneOffset(of(x1))) as & Pure
            } catch {
                case _: ##java.time.format.DateTimeParseException => None
            }
    }

    
    instance Eq[ZoneOffset] {
        pub def eq(x: ZoneOffset, y: ZoneOffset): Bool = Time/ZoneOffset.equals(x, y)
    }

    instance Hash[ZoneOffset] {
        pub def hash(x: ZoneOffset): Int = Time/ZoneOffset.hashCode(x)
    }

    instance Order[ZoneOffset] {
        pub def compare(x: ZoneOffset, y: ZoneOffset): Comparison = 
            Time/ZoneOffset.compareTo(x,y) |> Comparison.fromInt
    }
    

    instance LowerBound[ZoneOffset] {
        pub def minValue(): ZoneOffset = Time/ZoneOffset.min()
    }

    instance UpperBound[ZoneOffset] {
        pub def maxValue(): ZoneOffset = Time/ZoneOffset.max()
    }

    instance Boxable[ZoneOffset]


}

namespace Time/ZoneOffset {


    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    ///
    /// ___
    ///
    pub def utc(): ZoneOffset =
        import get java.time.ZoneOffset:UTC as getUTC;
        ZoneOffset(getUTC()) as & Pure

    pub def min(): ZoneOffset =
        import get java.time.ZoneOffset:MIN as getMIN;
        ZoneOffset(getMIN()) as & Pure

    pub def max(): ZoneOffset =
        import get java.time.ZoneOffset:MAX as getMAX;
        ZoneOffset(getMAX()) as & Pure


    pub def ofHours(hours: Int32): ZoneOffset =
        import java.time.ZoneOffset:ofHours(Int32);
        ZoneOffset(ofHours(hours)) as & Pure

    pub def ofHoursMinutes(hours: Int32, minutes: Int32): ZoneOffset =
        import java.time.ZoneOffset:ofHoursMinutes(Int32, Int32);
        ZoneOffset(ofHoursMinutes(hours, minutes)) as & Pure

    pub def ofHoursMinutesSeconds(hours: Int32, minutes: Int32, seconds: Int32): ZoneOffset =
        import java.time.ZoneOffset:ofHoursMinutesSeconds(Int32, Int32, Int32);
        ZoneOffset(ofHoursMinutesSeconds(hours, minutes, seconds)) as & Pure

    pub def ofTotalSeconds(seconds: Int32): ZoneOffset =
        import java.time.ZoneOffset:ofTotalSeconds(Int32);
        ZoneOffset(ofTotalSeconds(seconds)) as & Pure


    pub def equals(x: ZoneOffset, y: ZoneOffset): Bool =
        import java.time.ZoneOffset.equals(##java.lang.Object);
        let ZoneOffset(x1) = x;
        let ZoneOffset(y1) = y;
        equals(x1, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: ZoneOffset): Int32 = 
        import java.time.ZoneOffset.hashCode();
        let ZoneOffset(x1) = x;
        hashCode(x1) as & Pure


    pub def compareTo(x: ZoneOffset, y: ZoneOffset): Int32 =
        import java.time.ZoneOffset.compareTo(##java.time.ZoneOffset);
        let ZoneOffset(x1) = x;
        let ZoneOffset(y1) = y;
        compareTo(x1, y1) as & Pure

    pub def getId(x: ZoneOffset): String =
        import java.time.ZoneOffset.getId();
        let ZoneOffset(x1) = x;
        getId(x1) as & Pure
        
}
