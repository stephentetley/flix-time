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

    use Time.ZoneId
    use Time.ZoneId.{ZoneId}

    import java.lang.{Object}
    import java.time.{ZoneId => JZoneId}

    ///
    /// A wrapper around a Java ZoneId.
    ///
    pub enum ZoneId(JZoneId)

    ///
    /// Returns the given ZoneId `x` as a String.
    ///
    instance ToString[ZoneId] {
        pub def toString(x: ZoneId): String =
            let ZoneId(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[ZoneId] {
        pub def eq(x: ZoneId, y: ZoneId): Bool =
            let ZoneId(x1) = x;
            let ZoneId(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[ZoneId] {
        pub def hash(x: ZoneId): Int32 =
            let ZoneId(x1) = x;
            unsafe IO { x1.hashCode() }
    }

}

mod Time.ZoneId {


    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    
    use Time.Format.TextStyle
    use Time.Zone.ZoneRules
    use Time.Zone.ZoneRules.{ZoneRules}
    use Time.OffsetDateTime
    use Time.OffsetDateTime.{OffsetDateTime}
    use Time.OffsetTime
    use Time.OffsetTime.{OffsetTime}
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}
    use Time.ZonedDateTime
    use Time.ZonedDateTime.{ZonedDateTime}
    use Locale.{Locale}
    
    import java.time.{ZoneId => JZoneId}
    import java.time.{ZoneOffset => JZoneOffset}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}
    import java.time.zone.{ZoneRules => JZoneRules}
    import java.lang.{Object, Exception, Throwable}

    /// Unwrap

    pub def getZoneId(x: ZoneId): JZoneId = 
        let ZoneId(x1) = x;
        x1

    pub def fromJavaObject(o: Object): ZoneId = 
        ZoneId(unchecked_cast(o as JZoneId))

    /// Constructors

    pub def zoneId(zoneId: {zoneId = String}): Result[String, ZoneId] =
        Result.tryCatch(_ -> ZoneId(unsafe IO { JZoneId.of(zoneId#zoneId) }))

    /// Ideally not in IO...
    pub def zoneIdWithAliases(zoneId: {zoneId = String}, aliases: Map[String, String]): Result[String, ZoneId] \ IO =
        Result.tryCatch(_ -> {
            let jmap = Adaptor.toMap(aliases);
            let ans = unsafe IO { JZoneId.of(zoneId#zoneId, jmap) };
            ZoneId(ans)
        })


    /// "abstract constructors" (e.g. `utc`)

    pub def utc(): ZoneId = match zoneId(zoneId = "Z") {
        case Ok(z)  => z
        case Err(_) => bug!("ZoneId.utc() - failed")
    }

    pub def systemDefault(): Result[String, ZoneId] \ IO =
        Result.tryCatch(_ -> ZoneId(JZoneId.systemDefault()))


    /// `from` functions

    pub def fromOffset(r: {prefix = Option[String], offset = ZoneOffset}): ZoneId =
        let p1 = match r#prefix {
            case Some(s) => s
            case _       => ""
        };
        let ZoneOffset(o1) = r#offset;
        ZoneId(unsafe IO { JZoneId.ofOffset(p1, o1) })

    /// `fromTemporalAccessor` specialized


    pub def fromOffsetDateTime(x: OffsetDateTime): ZoneId =
        let OffsetDateTime(x1) = x;
        let ans = unsafe IO { JZoneId.$from(x1) };
        ZoneId(ans)

    pub def fromOffsetTime(x: OffsetTime): ZoneId =
        let OffsetTime(x1) = x;
        let ans = unsafe IO { JZoneId.$from(x1) };
        ZoneId(ans)

    pub def fromZonedDateTime(x: ZonedDateTime): ZoneId =
        let ZonedDateTime(x1) = x;
        let ans = unsafe IO { JZoneId.$from(x1) };
        ZoneId(ans)

    pub def fromZoneOffset(x: ZoneOffset): ZoneId =
        let ZoneOffset(x1) = x;
        let ans = unsafe IO { JZoneId.$from(x1) };
        ZoneId(ans)


    /// ZoneId functions

    pub def getDisplayName(style: TextStyle, locale: Locale, z: ZoneId): String =
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        let ZoneId(z1) = z;
        unsafe IO { z1.getDisplayName(style1, locale1) }

    ///
    /// Returns the unique ID of the time zone.
    ///
    pub def getTimeZoneId(x: ZoneId): String =
        let ZoneId(x1) = x;
        unsafe IO { x1.getId() }

    pub def getAvailableZoneIds(): Set[String] \ IO =
        try {
            let s = JZoneId.getAvailableZoneIds();
            Adaptor.fromSet(s)
        } catch {
            case _: Exception => Set.empty()
        }


    ///
    pub def getRules(x: ZoneId): Option[ZoneRules] =
        Result.tryCatch(_ -> {
            let ZoneId(x1) = x;
            let ans = unsafe IO { x1.getRules() };
            ZoneRules(ans)
        }) |> Result.toOption


    pub def normalized(x: ZoneId): ZoneId =
        let ZoneId(x1) = x;
        let x2 = unsafe IO { x1.normalized() };
        ZoneId(x2)


}
