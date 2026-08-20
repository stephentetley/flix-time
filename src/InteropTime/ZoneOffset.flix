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


    use InteropTime.Internal.AdaptorExtras

    use InteropTime.Zone.ZoneRules.ZoneRules
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.OffsetTime.OffsetTime
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropTime.ZoneId


    import java.time.{ZoneId => JZoneId}
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
            let ZoneOffset.ZoneOffset(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[ZoneOffset] {
        pub def eq(x: ZoneOffset, y: ZoneOffset): Bool =
            let ZoneOffset.ZoneOffset(x1) = x;
            let ZoneOffset.ZoneOffset(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[ZoneOffset] {
        pub def hash(x: ZoneOffset): Int32 =
            let ZoneOffset.ZoneOffset(x1) = x;
            unsafe IO { x1.hashCode() }

    }

    instance Order[ZoneOffset] {
        pub def compare(x: ZoneOffset, y: ZoneOffset): Comparison =
            let ZoneOffset.ZoneOffset(x1) = x;
            let ZoneOffset.ZoneOffset(y1) = y;
            unsafe IO { x1.compareTo(y1) } |> Comparison.fromInt32
    }

    instance ToJava[ZoneOffset] {
        type Out = JZoneOffset
        pub def toJava(x: ZoneOffset): JZoneOffset = 
            let ZoneOffset.ZoneOffset(x1) = x;
            x1
    }

    instance ToFlix[ZoneOffset] {
        type In = JZoneOffset
        pub def toFlix(x: JZoneOffset): ZoneOffset = 
            ZoneOffset.ZoneOffset(x)
    }



    /// "abstract constructors" (e.g. `utc`)

    ///
    /// ___
    ///
    pub def utc(): ZoneOffset = ZoneOffset(unsafe IO { JZoneOffset.UTC })

    pub def min(): ZoneOffset = ZoneOffset(unsafe IO { JZoneOffset.MIN })

    pub def max(): ZoneOffset = ZoneOffset(unsafe IO { JZoneOffset.MAX })

    /// `of` functions

    pub def ofHours(hours: Int32): ZoneOffset =
        AdaptorExtras.of(() -> unsafe IO { JZoneOffset.ofHours(hours) })

    pub def ofHoursMinutes(hours: {hours = Int32}, 
                            minutes: {minutes = Int32}): ZoneOffset =
        AdaptorExtras.of(() -> unsafe IO { JZoneOffset.ofHoursMinutes(hours#hours, minutes#minutes) })

    pub def ofHoursMinutesSeconds(hours: {hours = Int32}, 
                                    minutes: {minutes = Int32}, 
                                    seconds: {seconds = Int32}): ZoneOffset =
        AdaptorExtras.of(() -> unsafe IO { JZoneOffset.ofHoursMinutesSeconds(hours#hours, minutes#minutes, seconds#seconds) })

    pub def ofTotalSeconds(seconds: Int32): ZoneOffset =
        AdaptorExtras.of(() -> unsafe IO { JZoneOffset.ofTotalSeconds(seconds) })


    
    /// ZoneOffset functions

    pub def getId(x: ZoneOffset): String =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getId() })

    pub def getRules(x: ZoneOffset): ZoneRules =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getRules() })

    pub def getTotalSeconds(x: ZoneOffset): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getTotalSeconds() })


    pub def getOffsetSeconds(x: ZoneOffset): Int32 =
        AdaptorExtras.extract(x, x1 -> {
            let field = unsafe IO { JChronoField.OFFSET_SECONDS };
            unsafe IO { x1.get(field) }
        })

    pub def getZoneId(x: ZoneOffset): ZoneId =
        AdaptorExtras.op(x, x1 -> unsafe IO { JZoneId.$from(x1) })
}

