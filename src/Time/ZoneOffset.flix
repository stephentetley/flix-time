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

    import java.lang.{Object}
    import java.time.{ZoneOffset => JZoneOffset}

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
            unsafe x1.toString()
    }

    instance Eq[ZoneOffset] {
        pub def eq(x: ZoneOffset, y: ZoneOffset): Bool =
            let ZoneOffset(x1) = x;
            let ZoneOffset(y1) = y;
            let obj = (checked_cast(y1) : Object);
            unsafe x1.equals(obj)
    }

    instance Hash[ZoneOffset] {
        pub def hash(x: ZoneOffset): Int32 = 
            let ZoneOffset(x1) = x;
            unsafe x1.hashCode()

    }

    instance Order[ZoneOffset] {
        pub def compare(x: ZoneOffset, y: ZoneOffset): Comparison =
            let ZoneOffset(x1) = x;
            let ZoneOffset(y1) = y;
            unsafe x1.compareTo(y1) |> Comparison.fromInt32
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
    import java.time.{ZoneOffset => JZoneOffset}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor, 
            TemporalField => JTemporalField, ChronoField => JChronoField}
    import java.time.zone.{ZoneRules => JZoneRules}
    import java.lang.{Object, Exception, Throwable}
    

    pub def getZoneOffset(x: ZoneOffset): JZoneOffset = 
        let ZoneOffset(x1) = x;
        x1

    pub def fromJavaObject(o: Object): ZoneOffset = 
        ZoneOffset(unchecked_cast(o as JZoneOffset))


    /// "abstract constructors" (e.g. `utc`)

    ///
    /// ___
    ///
    pub def utc(): ZoneOffset = ZoneOffset(unsafe JZoneOffset.UTC)

    pub def min(): ZoneOffset = ZoneOffset(unsafe JZoneOffset.MIN)

    pub def max(): ZoneOffset = ZoneOffset(unsafe JZoneOffset.MAX)

    /// `of` functions

    pub def ofHours(hours: Int32): ZoneOffset =
        ZoneOffset(unsafe JZoneOffset.ofHours(hours))

    pub def ofHoursMinutes(r: {hours = Int32, minutes = Int32}): ZoneOffset = 
        ZoneOffset(unsafe JZoneOffset.ofHoursMinutes(r#hours, r#minutes))

    pub def ofHoursMinutesSeconds(r: {hours = Int32, minutes = Int32, seconds = Int32}): ZoneOffset =
        ZoneOffset(unsafe JZoneOffset.ofHoursMinutesSeconds(r#hours, r#minutes, r#seconds))

    pub def ofTotalSeconds(seconds: Int32): ZoneOffset =
        ZoneOffset(unsafe JZoneOffset.ofTotalSeconds(seconds))

    /// `fromTemporalAccessor` specialized
    // Leave as is for now...
    def fromTemporalAccessorHelper(x: JTemporalAccessor): ZoneOffset = 
        import static java.time.ZoneOffset.from(JTemporalAccessor): JZoneOffset \ {} as fromTA;
        try {
            ZoneOffset(fromTA(x))
        } catch {
            case ex: Exception => 
                bug!(unsafe ex.getMessage())
        }

    pub def fromOffsetDateTime(x: OffsetDateTime): ZoneOffset = 
        fromTemporalAccessorHelper(unchecked_cast(Time.OffsetDateTime.getOffsetDateTime(x) as JTemporalAccessor))

    pub def fromOffsetTime(x: OffsetTime): ZoneOffset = 
        fromTemporalAccessorHelper(unchecked_cast(Time.OffsetTime.getOffsetTime(x) as JTemporalAccessor))
            
    pub def fromZonedDateTime(x: ZonedDateTime): ZoneOffset = 
        fromTemporalAccessorHelper(unchecked_cast(Time.ZonedDateTime.getZonedDateTime(x) as JTemporalAccessor))
    
    /// ZoneOffset functions

    pub def getId(x: ZoneOffset): String =
        let ZoneOffset(x1) = x;
        unsafe x1.getId()

    pub def getRules(x: ZoneOffset): ZoneRules =
        let ZoneOffset(x1) = x;
        ZoneRules(unsafe x1.getRules())

    pub def getTotalSeconds(x: ZoneOffset): Int32 =
        let ZoneOffset(x1) = x;
        unsafe x1.getTotalSeconds()




    pub def getOffsetSeconds(x: ZoneOffset): Int32 =
        import static java_get_field java.time.temporal.ChronoField.OFFSET_SECONDS: JChronoField \ {} as get_OFFSET_SECONDS;
        getHelper(unchecked_cast(get_OFFSET_SECONDS() as JTemporalField), x)


    /// generic helper functions

    def getHelper(field: JTemporalField, x: ZoneOffset): Int32 =
        try {
            let ZoneOffset(x1) = x;
            unsafe x1.get(field)
        } catch {
            case ex: Exception => 
                bug!(unsafe ex.getMessage())
        }



}
