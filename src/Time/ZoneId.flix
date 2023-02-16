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
            equals(x1, unsafe_cast y1 as ##java.lang.Object)
    }

    instance Hash[ZoneId] {
        pub def hash(x: ZoneId): Int32 =
            import java.time.ZoneId.hashCode(): Int32 \ {};
            let ZoneId(x1) = x;
            hashCode(x1)
    }

    instance Interop/Flix.Marshal[ZoneId] {
        pub def toJavaObject(x: ZoneId): ##java.lang.Object =
            let ZoneId(x1) = x;
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): ZoneId = 
            ZoneId(unsafe_cast o as ##java.time.ZoneId)
    }

}

namespace Time/ZoneId {

    use Interop/Util.Locale;

    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    
    use Time/Format.TextStyle;
    use Time/Zone.ZoneRules;
    use Time/Zone.ZoneRules.{ZoneRules};
    use Time.OffsetDateTime;
    use Time.OffsetTime;
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};
    use Time.ZonedDateTime;

    /// ## Unwrap

    pub def getZoneId(x: ZoneId): ##java.time.ZoneId = 
        let ZoneId(x1) = x;
        x1


    /// ## Constructors

    pub def zoneId(zoneId: {zoneId = String}): Result[String, ZoneId] =
        import static java.time.ZoneId.of(String): ##java.time.ZoneId \ {};
        try {
            Ok(ZoneId(of(zoneId.zoneId)))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
        

    pub def zoneIdWithAliases(zoneId: {zoneId = String}, aliases: Map[String, String]): Result[String, ZoneId] = region rc {
        import static java.time.ZoneId.of(String, ##java.util.Map): ##java.time.ZoneId \ {};
        try {
            let jmap = Interop/Util/HashMap.fromFlixMap(rc, aliases) |> Interop/Util/MapZ.toMapHH(rc);
            Ok(ZoneId(of(zoneId.zoneId, jmap)))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
    }

    /// ## "abstract constructors" (e.g. `utc`)

    pub def utc(): ZoneId = match zoneId(zoneId = "Z") {
        case Ok(z)  => z
        case Err(_) => bug!("ZoneId.utc() - failed")
    }

    pub def systemDefault(): Result[String, ZoneId] \ IO =
        import static java.time.ZoneId.systemDefault(): ##java.time.ZoneId \ IO;
        try {
            Ok(ZoneId(systemDefault()))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }


    /// ## `from` functions

    pub def fromOffset(r: {prefix = Option[String], offset = ZoneOffset}): ZoneId =
        import static java.time.ZoneId.ofOffset(String, ##java.time.ZoneOffset): ##java.time.ZoneId \ {};
        let p1 = match r.prefix {
            case Some(s) => s
            case _       => ""
        };
        let ZoneOffset(o1) = r.offset;
        ZoneId(ofOffset(p1, o1))

    /// `fromTemporalAccessor` specialized
    
    def fromTemporalAccessorHelper(x: ##java.time.temporal.TemporalAccessor): ZoneId = 
        import static java.time.ZoneId.from(##java.time.temporal.TemporalAccessor): ##java.time.ZoneId \ {} as fromTA;
        try {
            ZoneId(fromTA(x))
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String \ {};
                bug!(getMessage(ex))
        }

    pub def fromOffsetDateTime(x: OffsetDateTime): ZoneId = 
        fromTemporalAccessorHelper(unsafe_cast Time/OffsetDateTime.getOffsetDateTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromOffsetTime(x: OffsetTime): ZoneId = 
        fromTemporalAccessorHelper(unsafe_cast Time/OffsetTime.getOffsetTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromZonedDateTime(x: ZonedDateTime): ZoneId = 
        fromTemporalAccessorHelper(unsafe_cast Time/ZonedDateTime.getZonedDateTime(x) as ##java.time.temporal.TemporalAccessor)

    pub def fromZoneOffset(x: ZoneOffset): ZoneId = 
        fromTemporalAccessorHelper(unsafe_cast Time/ZoneOffset.getZoneOffset(x) as ##java.time.temporal.TemporalAccessor)


    /// ## ZoneId functions

    pub def getDisplayName(style: TextStyle, locale: Locale, z: ZoneId): String =
        import java.time.ZoneId.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String \ {};
        let style1 = Time/Format/TextStyle.marshal(style);
        let locale1 = Interop/Util/Locale.getHH(locale);
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
            getAvailableZoneIds()  |> Interop/Util/SetZ.wrapHH(Static) |> Interop/Util/SetZ.toFlixSet
        } catch {
            case _: ##java.lang.Exception => Set.empty()
        }


    ///
    pub def getRules(x: ZoneId): Option[ZoneRules] =
        import java.time.ZoneId.getRules(): ##java.time.zone.ZoneRules \ {};
        try {
            let ZoneId(x1) = x;
            Some(ZoneRules(getRules(x1)))
        } catch {
            case _: ##java.lang.Exception => None
        }

    ///
    pub def normalized(x: ZoneId): ZoneId =
        import java.time.ZoneId.normalized(): ##java.time.ZoneId \ {};
        let ZoneId(x1) = x;
        ZoneId(normalized(x1))


}
