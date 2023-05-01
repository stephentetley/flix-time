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

mod Time {

    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}

    ///
    /// A wrapper around a Java ZoneOffset.
    ///
    pub enum ZoneOffset(##java.time.ZoneOffset)

    ///
    /// Returns the given ZoneOffset `x` as a String.
    ///
    instance ToString[ZoneOffset] {
        pub def toString(x: ZoneOffset): String =
            import java.time.ZoneOffset.toString(): String \ {};
            let ZoneOffset(x1) = x;
            toString(x1)
    }

    instance Eq[ZoneOffset] {
        pub def eq(x: ZoneOffset, y: ZoneOffset): Bool =
            import java.time.ZoneOffset.equals(##java.lang.Object): Bool \ {};
            let ZoneOffset(x1) = x;
            let ZoneOffset(y1) = y;
            equals(x1, checked_cast(y1))
    }

    instance Hash[ZoneOffset] {
        pub def hash(x: ZoneOffset): Int32 = 
            import java.time.ZoneOffset.hashCode(): Int32 \ {};
            let ZoneOffset(x1) = x;
            hashCode(x1)

    }

    instance Order[ZoneOffset] {
        pub def compare(x: ZoneOffset, y: ZoneOffset): Comparison =
            import java.time.ZoneOffset.compareTo(##java.time.ZoneOffset): Int32 \ {};
            let ZoneOffset(x1) = x;
            let ZoneOffset(y1) = y;
            compareTo(x1, y1) |> Comparison.fromInt32
    }

    instance Interop.Flix.Marshal[ZoneOffset] {
        pub def toJavaObject(x: ZoneOffset): ##java.lang.Object =
            let ZoneOffset(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): ZoneOffset = 
            ZoneOffset(unchecked_cast(o as ##java.time.ZoneOffset))
    }

}

mod Time.ZoneOffset {


    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}

    use Time.Zone.ZoneRules
    use Time.Zone.ZoneRules.{ZoneRules}
    use Time.OffsetDateTime
    use Time.OffsetTime
    use Time.ZonedDateTime

    /// ## Unwrap

    pub def getZoneOffset(x: ZoneOffset): ##java.time.ZoneOffset = 
        let ZoneOffset(x1) = x;
        x1

    /// ## "abstract constructors" (e.g. `utc`)

    ///
    /// ___
    ///
    pub def utc(): ZoneOffset =
        import static get java.time.ZoneOffset.UTC: ##java.time.ZoneOffset \ {} as get_UTC;
        ZoneOffset(get_UTC())

    pub def min(): ZoneOffset =
        import static get java.time.ZoneOffset.MIN: ##java.time.ZoneOffset \ {} as get_MIN;
        ZoneOffset(get_MIN())

    pub def max(): ZoneOffset =
        import static get java.time.ZoneOffset.MAX: ##java.time.ZoneOffset \ {} as get_MAX;
        ZoneOffset(get_MAX())

    /// ## `of` functions

    pub def ofHours(hours: Int32): ZoneOffset =
        import static java.time.ZoneOffset.ofHours(Int32): ##java.time.ZoneOffset \ {};
        ZoneOffset(ofHours(hours))

    pub def ofHoursMinutes(r: {hours = Int32, minutes = Int32}): ZoneOffset =
        import static java.time.ZoneOffset.ofHoursMinutes(Int32, Int32): ##java.time.ZoneOffset \ {};
        ZoneOffset(ofHoursMinutes(r.hours, r.minutes))

    pub def ofHoursMinutesSeconds(r: {hours = Int32, minutes = Int32, seconds = Int32}): ZoneOffset =
        import static java.time.ZoneOffset.ofHoursMinutesSeconds(Int32, Int32, Int32): ##java.time.ZoneOffset \ {};
        ZoneOffset(ofHoursMinutesSeconds(r.hours, r.minutes, r.seconds))

    pub def ofTotalSeconds(seconds: Int32): ZoneOffset =
        import static java.time.ZoneOffset.ofTotalSeconds(Int32): ##java.time.ZoneOffset \ {};
        ZoneOffset(ofTotalSeconds(seconds))

    /// `fromTemporalAccessor` specialized
    def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): ZoneOffset = 
        import static java.time.ZoneOffset.from(##java.time.temporal.TemporalAccessor): ##java.time.ZoneOffset \ {} as fromTA;
        try {
            ZoneOffset(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }

    pub def fromOffsetDateTime(x: OffsetDateTime): ZoneOffset = 
        fromTemporalAccessorHelper(unchecked_cast(Time.OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor))

    pub def fromOffsetTime(x: OffsetTime): ZoneOffset = 
        fromTemporalAccessorHelper(unchecked_cast(Time.OffsetTime.getOffsetTime(x) as ##java.time.temporal.TemporalAccessor))
            
    pub def fromZonedDateTime(x: ZonedDateTime): ZoneOffset = 
        fromTemporalAccessorHelper(unchecked_cast(Time.ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor))
    
    /// ## ZoneOffset functions

    pub def getId(x: ZoneOffset): String =
        import java.time.ZoneOffset.getId(): String \ {};
        let ZoneOffset(x1) = x;
        getId(x1)

    pub def getRules(x: ZoneOffset): ZoneRules =
        import java.time.ZoneOffset.getRules(): ##java.time.zone.ZoneRules \ {};
        let ZoneOffset(x1) = x;
        ZoneRules(getRules(x1))

    pub def getTotalSeconds(x: ZoneOffset): Int32 =
        import java.time.ZoneOffset.getTotalSeconds(): Int32 \ {};
        let ZoneOffset(x1) = x;
        getTotalSeconds(x1)




    pub def getOffsetSeconds(x: ZoneOffset): Int32 =
        import static get java.time.temporal.ChronoField.OFFSET_SECONDS: ##java.time.temporal.ChronoField \ {} as get_OFFSET_SECONDS;
        getHelper(unchecked_cast(get_OFFSET_SECONDS() as ##java.time.temporal.TemporalField), x)


    /// ## generic helper functions

    def getHelper(field: ##java.time.temporal.TemporalField, x: ZoneOffset): Int32 =
        import java.time.ZoneOffset.get(##java.time.temporal.TemporalField): Int32 \ {};
        try {
            let ZoneOffset(x1) = x;
            get(x1, field)
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }



}
