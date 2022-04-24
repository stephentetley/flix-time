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

    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;


    ///
    /// A wrapper around a Java ZoneOffset.
    ///
    pub opaque type ZoneOffset = ##java.time.ZoneOffset

    ///
    /// Returns the given ZoneOffset `x` as a String.
    ///
    instance ToString[ZoneOffset] {
        pub def toString(x: ZoneOffset): String =
            import java.time.ZoneOffset.toString(): String & Pure;
            let ZoneOffset(x1) = x;
            toString(x1)
    }

    instance Eq[ZoneOffset] {
        pub def eq(x: ZoneOffset, y: ZoneOffset): Bool = Time/ZoneOffset.equals(x, y)
    }

    instance Hash[ZoneOffset] {
        pub def hash(x: ZoneOffset): Int32 = Time/ZoneOffset.hashCode(x)
    }

    instance Order[ZoneOffset] {
        pub def compare(x: ZoneOffset, y: ZoneOffset): Comparison =
            Time/ZoneOffset.compareTo(x,y) |> Comparison.fromInt32
    }


    instance LowerBound[ZoneOffset] {
        pub def minValue(): ZoneOffset = Time/ZoneOffset.min()
    }

    instance UpperBound[ZoneOffset] {
        pub def maxValue(): ZoneOffset = Time/ZoneOffset.max()
    }

    instance Boxable[ZoneOffset]

    instance TemporalAccessor[ZoneOffset] {
        pub def marshalToNativeTemporalAccessor(x: ZoneOffset): ##java.time.temporal.TemporalAccessor =         
            Time/ZoneOffset.getZoneOffset(x) as ##java.time.temporal.TemporalAccessor
        
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): ZoneOffset = 
            ZoneOffset(x as ##java.time.ZoneOffset)
    }

    instance TemporalAdjuster[ZoneOffset] {
        pub def marshalToNativeTemporalAdjuster(x: ZoneOffset): ##java.time.temporal.TemporalAdjuster =         
            Time/ZoneOffset.getZoneOffset(x) as ##java.time.temporal.TemporalAdjuster
        
        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): ZoneOffset = 
            ZoneOffset(x as ##java.time.ZoneOffset)
    }

}

namespace Time/ZoneOffset {


    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalField;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};
    use Time/Zone.ZoneRules;
    use Time/Zone.ZoneRules.{ZoneRules};
    use Time.OffsetDateTime;
    use Time.OffsetTime;
    use Time.ZonedDateTime;


    pub def getZoneOffset(x: ZoneOffset): ##java.time.ZoneOffset = 
        let ZoneOffset(x1) = x;
        x1


    ///
    /// ___
    ///
    pub def utc(): ZoneOffset =
        import static get java.time.ZoneOffset.UTC: ##java.time.ZoneOffset & Pure as get_UTC;
        ZoneOffset(get_UTC())

    pub def min(): ZoneOffset =
        import static get java.time.ZoneOffset.MIN: ##java.time.ZoneOffset & Pure as get_MIN;
        ZoneOffset(get_MIN())

    pub def max(): ZoneOffset =
        import static get java.time.ZoneOffset.MAX: ##java.time.ZoneOffset & Pure as get_MAX;
        ZoneOffset(get_MAX())


    pub def fromHours(hours: Int32): ZoneOffset =
        import static java.time.ZoneOffset.ofHours(Int32): ##java.time.ZoneOffset & Pure;
        ZoneOffset(ofHours(hours))

    pub def fromHoursMinutes(r: {hours :: Int32, minutes :: Int32}): ZoneOffset =
        import static java.time.ZoneOffset.ofHoursMinutes(Int32, Int32): ##java.time.ZoneOffset & Pure;
        ZoneOffset(ofHoursMinutes(r.hours, r.minutes))

    pub def fromHoursMinutesSeconds(r: {hours :: Int32, minutes :: Int32, seconds :: Int32}): ZoneOffset =
        import static java.time.ZoneOffset.ofHoursMinutesSeconds(Int32, Int32, Int32): ##java.time.ZoneOffset & Pure;
        ZoneOffset(ofHoursMinutesSeconds(r.hours, r.minutes, r.seconds))

    pub def fromTotalSeconds(seconds: Int32): ZoneOffset =
        import static java.time.ZoneOffset.ofTotalSeconds(Int32): ##java.time.ZoneOffset & Pure;
        ZoneOffset(ofTotalSeconds(seconds))


    pub def equals(x: ZoneOffset, y: ZoneOffset): Bool =
        import java.time.ZoneOffset.equals(##java.lang.Object): Bool & Pure;
        let ZoneOffset(x1) = x;
        let ZoneOffset(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: ZoneOffset): Int32 =
        import java.time.ZoneOffset.hashCode(): Int32 & Pure;
        let ZoneOffset(x1) = x;
        hashCode(x1)


    pub def compareTo(x: ZoneOffset, y: ZoneOffset): Int32 =
        import java.time.ZoneOffset.compareTo(##java.time.ZoneOffset): Int32 & Pure;
        let ZoneOffset(x1) = x;
        let ZoneOffset(y1) = y;
        compareTo(x1, y1)

    pub def getId(x: ZoneOffset): String =
        import java.time.ZoneOffset.getId(): String & Pure;
        let ZoneOffset(x1) = x;
        getId(x1)

    pub def getRules(x: ZoneOffset): ZoneRules =
        import java.time.ZoneOffset.getRules(): ##java.time.zone.ZoneRules & Pure;
        let ZoneOffset(x1) = x;
        ZoneRules(getRules(x1))

    pub def getTotalSeconds(x: ZoneOffset): Int32 =
        import java.time.ZoneOffset.getTotalSeconds(): Int32 & Pure;
        let ZoneOffset(x1) = x;
        getTotalSeconds(x1)



    /// Generic 

    /// # `fromTemporalAccessor` specialized
    def fromHelper(x: ##java.time.temporal.TemporalAccessor): ZoneOffset = 
        import static java.time.ZoneOffset.from(##java.time.temporal.TemporalAccessor): ##java.time.ZoneOffset & Pure as fromTA;
        try {
            ZoneOffset(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def fromOffsetDateTime(x: OffsetDateTime): ZoneOffset = 
        fromHelper(Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromOffsetTime(x: OffsetTime): ZoneOffset = 
        fromHelper(Time/OffsetTime.getOffsetTime(x) as ##java.time.temporal.TemporalAccessor)
            
    pub def fromZonedDateTime(x: ZonedDateTime): ZoneOffset = 
        fromHelper(Time/ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor)


    /// # `adjustInto` specialized - this become `adjustZoneOffset` in the respective modules:
    /// OffsetDateTime
    /// ZonedDateTime

    
    /// # `getLong` specialized

    def getLongHelper(field: ##java.time.temporal.TemporalField, x: ZoneOffset): Int64 =
        import java.time.ZoneOffset.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        try {
            let ZoneOffset(x1) = x;
            getLong(x1, field)
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }

    pub def getOffsetSeconds(x: ZoneOffset): Int64 =
        import static get java.time.temporal.ChronoField.OFFSET_SECONDS: ##java.time.temporal.ChronoField & Pure as get_OFFSET_SECONDS;
        getLongHelper(get_OFFSET_SECONDS() as ##java.time.temporal.TemporalField, x)

    /// # `range` specialized
    
    def rangeHelper(f: ##java.time.temporal.TemporalField, x: ZoneOffset): ValueRange =
        import java.time.ZoneOffset.range(##java.time.temporal.TemporalField): ##java.time.temporal.ValueRange & Pure;         
        try {
            let ZoneOffset(x1) = x;
            ValueRange(range(x1, f))
        } catch {
            /// case _: ##java.time.temporal.UnsupportedTemporalTypeException => bug!("invalid temporalUnit")
            case ex: ##java.lang.Exception                                => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }


    pub def rangeOffsetSeconds(z: ZoneOffset): ValueRange =       
        import static get java.time.temporal.ChronoField.OFFSET_SECONDS: ##java.time.temporal.ChronoField & Pure as get_OFFSET_SECONDS;            
        rangeHelper(get_OFFSET_SECONDS() as ##java.time.temporal.TemporalField, z)


}
