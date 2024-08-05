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
    import java.lang.{Exception, Throwable}

    /// ## Unwrap

    pub def getZoneId(x: ZoneId): JZoneId = 
        let ZoneId(x1) = x;
        x1

    pub def fromJavaObject(o: ##java.lang.Object): ZoneId = 
        ZoneId(unchecked_cast(o as JZoneId))

    /// ## Constructors

    pub def zoneId(zoneId: {zoneId = String}): Result[String, ZoneId] =
        Result.tryCatch(_ -> ZoneId(unsafe JZoneId.of(zoneId#zoneId)))
        
    /// Ideally not in IO...
    pub def zoneIdWithAliases(zoneId: {zoneId = String}, aliases: Map[String, String]): Result[String, ZoneId] \ IO =
        Result.tryCatch(_ -> {
            let jmap = Adaptor.toMap(aliases);
            ZoneId(unsafe JZoneId.of(zoneId#zoneId, jmap))
        })


    /// ## "abstract constructors" (e.g. `utc`)

    pub def utc(): ZoneId = match zoneId(zoneId = "Z") {
        case Ok(z)  => z
        case Err(_) => bug!("ZoneId.utc() - failed")
    }

    pub def systemDefault(): Result[String, ZoneId] \ IO =
        Result.tryCatch(_ -> ZoneId(JZoneId.systemDefault()))


    /// ## `from` functions

    pub def fromOffset(r: {prefix = Option[String], offset = ZoneOffset}): ZoneId =
        let p1 = match r#prefix {
            case Some(s) => s
            case _       => ""
        };
        let ZoneOffset(o1) = r#offset;
        ZoneId(unsafe JZoneId.ofOffset(p1, o1))

    /// `fromTemporalAccessor` specialized
    
    def fromTemporalAccessorHelper(x: JTemporalAccessor): ZoneId = 
        import static java.time.ZoneId.from(JTemporalAccessor): JZoneId \ {} as fromTA;
        try {
            ZoneId(fromTA(x))
        } catch {
            case ex: Exception => 
                bug!(unsafe ex.getMessage())
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
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        let ZoneId(z1) = z;
        unsafe z1.getDisplayName(style1, locale1)

    ///
    /// Returns the unique ID of the time zone.
    ///
    pub def getTimeZoneId(x: ZoneId): String =
        let ZoneId(x1) = x;
        unsafe x1.getId()

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
            ZoneRules(unsafe x1.getRules())
        }) |> Result.toOption

    //
    // pub def normalized(x: ZoneId): ZoneId =
    //     let ZoneId(x1) = x;
    //     let x2 = unsafe x1.normalized();
    //     ZoneId(x2)


}
