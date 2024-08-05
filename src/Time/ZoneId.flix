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

    ///
    /// A wrapper around a Java ZoneId.
    ///
    pub enum ZoneId(##java.time.ZoneId)

    ///
    /// Returns the given ZoneId `x` as a String.
    ///
    instance ToString[ZoneId] {
        pub def toString(x: ZoneId): String =
            import java.time.ZoneId.toString(): String \ {};
            let ZoneId(x1) = x;
            toString(x1)
    }

    instance Eq[ZoneId] {
        pub def eq(x: ZoneId, y: ZoneId): Bool =
            import java.time.ZoneId.equals(##java.lang.Object): Bool \ {};
            let ZoneId(x1) = x;
            let ZoneId(y1) = y;
            equals(x1, checked_cast(y1))
    }

    instance Hash[ZoneId] {
        pub def hash(x: ZoneId): Int32 =
            import java.time.ZoneId.hashCode(): Int32 \ {};
            let ZoneId(x1) = x;
            hashCode(x1)
    }

}

mod Time.ZoneId {


    use Time.ZoneId
    use Time.ZoneId.{ZoneId}
    
    use Time.Format.TextStyle
    use Time.Zone.ZoneRules
    use Time.Zone.ZoneRules.{ZoneRules}
    use Time.OffsetDateTime
    use Time.OffsetTime
    use Time.ZoneOffset
    use Time.ZoneOffset.{ZoneOffset}
    use Time.ZonedDateTime
    use Locale.{Locale}
    
    import java.time.{ZoneId => JZoneId}
    import java.time.{ZoneOffset => JZoneOffset}
    import java.time.temporal.{TemporalAccessor => JTemporalAccessor}
    import java.time.zone.{ZoneRules => JZoneRules}

    /// ## Unwrap

    pub def getZoneId(x: ZoneId): JZoneId = 
        let ZoneId(x1) = x;
        x1

    pub def fromJavaObject(o: ##java.lang.Object): ZoneId = 
        ZoneId(unchecked_cast(o as JZoneId))

    /// ## Constructors

    pub def zoneId(zoneId: {zoneId = String}): Result[String, ZoneId] =
        Result.tryCatch(_ -> {
            import static java.time.ZoneId.of(String): JZoneId \ {};
            ZoneId(of(zoneId#zoneId))
        })
        
    /// Ideally not in IO...
    pub def zoneIdWithAliases(zoneId: {zoneId = String}, aliases: Map[String, String]): Result[String, ZoneId] \ IO =
        Result.tryCatch(_ -> {
            import static java.time.ZoneId.of(String, ##java.util.Map): JZoneId \ {};
            let jmap = Adaptor.toMap(aliases);
            ZoneId(of(zoneId#zoneId, jmap))
        })


    /// ## "abstract constructors" (e.g. `utc`)

    pub def utc(): ZoneId = match zoneId(zoneId = "Z") {
        case Ok(z)  => z
        case Err(_) => bug!("ZoneId.utc() - failed")
    }

    pub def systemDefault(): Result[String, ZoneId] \ IO =
        Result.tryCatch(_ -> {
            import static java.time.ZoneId.systemDefault(): JZoneId \ IO;
            ZoneId(systemDefault())
        })


    /// ## `from` functions

    pub def fromOffset(r: {prefix = Option[String], offset = ZoneOffset}): ZoneId =
        import static java.time.ZoneId.ofOffset(String, JZoneOffset): JZoneId \ {};
        let p1 = match r#prefix {
            case Some(s) => s
            case _       => ""
        };
        let ZoneOffset(o1) = r#offset;
        ZoneId(ofOffset(p1, o1))

    /// `fromTemporalAccessor` specialized
    
    def fromTemporalAccessorHelper(x: JTemporalAccessor): ZoneId = 
        import static java.time.ZoneId.from(JTemporalAccessor): JZoneId \ {} as fromTA;
        try {
            ZoneId(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(checked_cast(ex)))
        }

    pub def fromOffsetDateTime(x: OffsetDateTime): ZoneId = 
        fromTemporalAccessorHelper(unchecked_cast(Time.OffsetDateTime.getOffsetDateTime(x) as JTemporalAccessor))

    pub def fromOffsetTime(x: OffsetTime): ZoneId = 
        fromTemporalAccessorHelper(unchecked_cast(Time.OffsetTime.getOffsetTime(x) as JTemporalAccessor))

    pub def fromZonedDateTime(x: ZonedDateTime): ZoneId = 
        fromTemporalAccessorHelper(unchecked_cast(Time.ZonedDateTime.getZonedDateTime(x) as JTemporalAccessor))

    pub def fromZoneOffset(x: ZoneOffset): ZoneId = 
        fromTemporalAccessorHelper(unchecked_cast(Time.ZoneOffset.getZoneOffset(x) as JTemporalAccessor))


    /// ## ZoneId functions

    pub def getDisplayName(style: TextStyle, locale: Locale, z: ZoneId): String =
        import java.time.ZoneId.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String \ {};
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        let ZoneId(z1) = z;
        getDisplayName(z1, style1, locale1)

    ///
    /// Returns the unique ID of the time zone.
    ///
    pub def getTimeZoneId(x: ZoneId): String =
        import java.time.ZoneId.getId(): String \ {};
        let ZoneId(x1) = x;
        getId(x1)

    pub def getAvailableZoneIds(): Set[String] \ IO =
        import static java.time.ZoneId.getAvailableZoneIds(): ##java.util.Set \ IO;
        try {
            let s = getAvailableZoneIds();
            Adaptor.fromSet(s)
        } catch {
            case _: ##java.lang.Exception => Set.empty()
        }


    ///
    pub def getRules(x: ZoneId): Option[ZoneRules] =
        Result.tryCatch(_ -> {
            import java.time.ZoneId.getRules(): JZoneRules \ {};
            let ZoneId(x1) = x;
            ZoneRules(getRules(x1))
        }) |> Result.toOption

    ///
    pub def normalized(x: ZoneId): ZoneId =
        import java.time.ZoneId.normalized(): JZoneId \ {};
        let ZoneId(x1) = x;
        ZoneId(normalized(x1))


}
