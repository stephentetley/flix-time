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



pub mod InteropTime.ZoneId {

    
    use InteropTime.Internal.AdaptorExtras

    use InteropTime.Format.TextStyle.TextStyle
    use InteropTime.Zone.ZoneRules.ZoneRules
    use InteropTime.OffsetDateTime.OffsetDateTime
    use InteropTime.OffsetTime.OffsetTime
    use InteropTime.ZoneOffset.ZoneOffset
    use InteropTime.ZonedDateTime.ZonedDateTime
    use InteropLocale.Locale.Locale
    
    import java.time.{ZoneId => JZoneId}
    import java.time.{ZoneOffset => JZoneOffset}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}
    import java.time.zone.{ZoneRules => JZoneRules}
    import java.lang.{Object, Throwable}
    import java.lang.{Exception => JException}

    ///
    /// A wrapper around a Java ZoneId.
    ///
    pub enum ZoneId(JZoneId)

    ///
    /// Returns the given ZoneId `x` as a String.
    ///
    instance ToString[ZoneId] {
        pub def toString(x: ZoneId): String =
            let ZoneId.ZoneId(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance Eq[ZoneId] {
        pub def eq(x: ZoneId, y: ZoneId): Bool =
            let ZoneId.ZoneId(x1) = x;
            let ZoneId.ZoneId(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[ZoneId] {
        pub def hash(x: ZoneId): Int32 =
            let ZoneId.ZoneId(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance ToJava[ZoneId] {
        type Out = JZoneId
        pub def toJava(x: ZoneId): JZoneId = 
            let ZoneId.ZoneId(x1) = x;
            x1
    }

    instance ToFlix[ZoneId] {
        type In = JZoneId
        pub def toFlix(x: JZoneId): ZoneId = 
            ZoneId.ZoneId(x)
    }

    /// Constructors

    pub def zoneId(zone: {zone = String}): Result[String, ZoneId] =
        AdaptorExtras.ofWithResult(() -> unsafe IO { JZoneId.of(zone#zone) })

    /// Ideally not in IO...
    pub def zoneIdWithAliases(zone: {zone = String}, 
                                aliases: Map[String, String]): Result[String, ZoneId] =
        AdaptorExtras.ofWithResult(() -> {
            let jmap = InteropTime.Internal.AdaptorExtras.Collection.toJMap(aliases, identity, identity);
            unsafe IO { JZoneId.of(zone#zone, jmap) }
        })


    /// "abstract constructors" (e.g. `utc`)

    pub def utc(): ZoneId = match zoneId(zone = "Z") {
        case Ok(z)  => z
        case Err(_) => bug!("ZoneId.utc() - failed")
    }

    pub def systemDefault(): Result[String, ZoneId] \ IO =
        AdaptorExtras.ofWithResult(() -> JZoneId.systemDefault())



    /// `from` functions

    pub def fromOffset(prefix: {prefix = Option[String]}, 
                        offset: ZoneOffset): ZoneId =
        let prefix1 = Option.getWithDefault("", prefix#prefix);
        AdaptorExtras.op(offset, offset1 -> unsafe IO { JZoneId.ofOffset(prefix1, offset1) })

    /// `fromTemporalAccessor` specialized


    pub def fromOffsetDateTime(x: OffsetDateTime): ZoneId =
        AdaptorExtras.op(x, x1 -> unsafe IO { JZoneId.$from(x1) })

    pub def fromOffsetTime(x: OffsetTime): ZoneId =
        AdaptorExtras.op(x, x1 -> unsafe IO { JZoneId.$from(x1) })

    pub def fromZonedDateTime(x: ZonedDateTime): ZoneId =
        AdaptorExtras.op(x, x1 -> unsafe IO { JZoneId.$from(x1) })

    pub def fromZoneOffset(x: ZoneOffset): ZoneId =
        AdaptorExtras.op(x, x1 -> unsafe IO { JZoneId.$from(x1) })


    /// ZoneId functions


    pub def getAvailableZoneIds(): Set[String] \ IO =
        try {
            let s = JZoneId.getAvailableZoneIds();
            Adaptor.fromSet(s)
        } catch {
            case _: JException => Set.empty()
        }

    pub def getDisplayName(style: TextStyle, locale: Locale, zone: ZoneId): String =
        AdaptorExtras.extract3(style, locale, zone, (style1, locale1, zone1) -> 
            unsafe IO { zone1.getDisplayName(style1, locale1) }
        )

    ///
    /// Returns the unique ID of the time zone.
    ///
    pub def getId(x: ZoneId): String =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getId() })

    ///
    pub def getRules(x: ZoneId): Option[ZoneRules] =
        AdaptorExtras.opWithOption(x, x1 -> unsafe IO { x1.getRules() })

    pub def normalized(x: ZoneId): ZoneId =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.normalized() })


}
