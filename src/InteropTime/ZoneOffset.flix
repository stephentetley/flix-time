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


pub mod InteropTime.ZoneOffset {


    use InteropTime.ZoneOffset.ZoneOffset
    use InteropTime.ZoneOffset.ZoneOffset.{ZoneOffset}

    use InteropTime.Zone.ZoneRules.ZoneRules
    use InteropTime.Zone.ZoneRules.ZoneRules.{ZoneRules}
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.OffsetDateTime.OffsetDateTime.{OffsetDateTime}
    use InteropTime.OffsetTime.OffsetTime
    use InteropTime.OffsetTime.OffsetTime.{OffsetTime}
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZonedDateTime.ZonedDateTime.{ZonedDateTime}

    import java.time.{ZoneOffset => JZoneOffset}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor, 
            TemporalField => JTemporalField, ChronoField => JChronoField}
    import java.time.zone.{ZoneRules => JZoneRules}
    import java.lang.{Object, Exception, Throwable}
    

    ///
    /// A wrapper around a Java ZoneOffset.
    ///
    pub enum ZoneOffset(JZoneOffset)

    ///
    /// Returns the given ZoneOffset `x` as a String.
    ///
    instance ToString[ZoneOffset] {
        pub def toString(x: ZoneOffset): String =
            let ZoneOffset(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[ZoneOffset] {
        pub def eq(x: ZoneOffset, y: ZoneOffset): Bool =
            let ZoneOffset(x1) = x;
            let ZoneOffset(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[ZoneOffset] {
        pub def hash(x: ZoneOffset): Int32 =
            let ZoneOffset(x1) = x;
            unsafe IO { x1.hashCode() }

    }

    instance Order[ZoneOffset] {
        pub def compare(x: ZoneOffset, y: ZoneOffset): Comparison =
            let ZoneOffset(x1) = x;
            let ZoneOffset(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }


    // TODO - do we need this for interring into Java collections?
    pub def fromJavaObject(o: Object): ZoneOffset = 
        let ans = unchecked_cast(o as JZoneOffset);
        ZoneOffset(ans)


    /// "abstract constructors" (e.g. `utc`)

    ///
    /// ___
    ///
    pub def utc(): ZoneOffset = ZoneOffset(unsafe IO { JZoneOffset.UTC })

    pub def min(): ZoneOffset = ZoneOffset(unsafe IO { JZoneOffset.MIN })

    pub def max(): ZoneOffset = ZoneOffset(unsafe IO { JZoneOffset.MAX })

    /// `of` functions

    pub def ofHours(hours: Int32): ZoneOffset =
        let ans = unsafe IO { JZoneOffset.ofHours(hours) };
        ZoneOffset(ans)

    pub def ofHoursMinutes(hours: {hours = Int32}, 
                            minutes: {minutes = Int32}): ZoneOffset =
        let ans = unsafe IO { JZoneOffset.ofHoursMinutes(hours#hours, minutes#minutes) };
        ZoneOffset(ans)

    pub def ofHoursMinutesSeconds(hours: {hours = Int32}, 
                                    minutes: {minutes = Int32}, 
                                    seconds: {seconds = Int32}): ZoneOffset =
        let ans = unsafe IO { JZoneOffset.ofHoursMinutesSeconds(hours#hours, minutes#minutes, seconds#seconds) };
        ZoneOffset(ans)

    pub def ofTotalSeconds(seconds: Int32): ZoneOffset =
        let ans = unsafe IO { JZoneOffset.ofTotalSeconds(seconds) };
        ZoneOffset(ans)

    // `from(TemporalAccessor x)` has problems - instead we can write the functions 
    // we want by calling the respective object

    pub def fromOffsetDateTime(x: OffsetDateTime): ZoneOffset =
        let OffsetDateTime(x1) = x;
        let ans = unsafe IO { x1.getOffset() };
        ZoneOffset(ans)

    pub def fromOffsetTime(x: OffsetTime): ZoneOffset =
        let OffsetTime(x1) = x;
        let ans = unsafe IO { x1.getOffset() };
        ZoneOffset(ans)
            
    pub def fromZonedDateTime(x: ZonedDateTime): ZoneOffset =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { x1.getOffset() };
        ZoneOffset(ans)
    
    /// ZoneOffset functions

    pub def getId(x: ZoneOffset): String =
        let ZoneOffset(x1) = x;
        unsafe IO { x1.getId() }

    pub def getRules(x: ZoneOffset): ZoneRules =
        let ZoneOffset(x1) = x;
        let ans = unsafe IO { x1.getRules() };
        ZoneRules(ans)

    pub def getTotalSeconds(x: ZoneOffset): Int32 =
        let ZoneOffset(x1) = x;
        unsafe IO { x1.getTotalSeconds() }




    pub def getOffsetSeconds(x: ZoneOffset): Int32 =
        let ZoneOffset(x1) = x;
        let f1 = unsafe IO { JChronoField.OFFSET_SECONDS };
        unsafe IO { x1.get(f1) }



}
