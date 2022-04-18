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
    pub opaque type ZoneId = ##java.time.ZoneId

    ///
    /// Returns the given ZoneId `x` as a String.
    ///
    instance ToString[ZoneId] {
        pub def toString(x: ZoneId): String =
            import java.time.ZoneId.toString(): String & Pure;
            let ZoneId(x1) = x;
            toString(x1)
    }

    instance Eq[ZoneId] {
        pub def eq(x: ZoneId, y: ZoneId): Bool = Time/ZoneId.equals(x, y)
    }

    instance Hash[ZoneId] {
        pub def hash(x: ZoneId): Int32 = Time/ZoneId.hashCode(x)
    }

    pub opaque type ZonePrefix = String

}

namespace Time/ZoneId {

    use X.Cursor;
    use X.Cursor.{Cursor};

    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    use Time/Temporal.TemporalAccessor;
    use Time.ZonePrefix;
    use Time.ZonePrefix.{ZonePrefix};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    pub def getZoneId(x: ZoneId): ##java.time.ZoneId = 
        let ZoneId(x1) = x;
        x1

    /// NOTE - maybe this should return Option [/ Result] ?
    pub def fromTemporalAccessor(x: a): ZoneId with TemporalAccessor[a] = 
        import static java.time.ZoneId.from(##java.time.temporal.TemporalAccessor): ##java.time.ZoneId & Pure as fromTA;
        let x1 = Time/Temporal/TemporalAccessor.marshalToNativeTemporalAccessor(x);
        ZoneId(fromTA(x1))



    pub def ofZoneId(zoneId: {zoneId :: String}): Result[ZoneId, String] =
        import static java.time.ZoneId.of(String): ##java.time.ZoneId & Pure;
        import java.lang.Throwable.getMessage(): String & Pure;
        try {
            Ok(ZoneId(of(zoneId.zoneId)))
        } catch {
            case ex: ##java.time.DateTimeException       => Err(getMessage(ex as ##java.lang.Throwable))
            case ex: ##java.time.zone.ZoneRulesException => Err(getMessage(ex as ##java.lang.Throwable))
        }
        

    pub def ofZoneIdWithAliases(zoneId: {zoneId :: String}, aliases: Map[String, String]): Result[ZoneId, String] =
        import static java.time.ZoneId.of(String, ##java.util.Map): ##java.time.ZoneId & Pure;
        import java.lang.Throwable.getMessage(): String & Pure;
        try {
            let m1 = FlixSandbox/Marshal.marshalMap(s1 -> s1 as ##java.lang.Object, s2 -> s2 as ##java.lang.Object, aliases) as & Pure;
            Ok(ZoneId(of(zoneId.zoneId, m1)))
        } catch {
            case ex: ##java.time.DateTimeException       => Err(getMessage(ex as ##java.lang.Throwable))
            case ex: ##java.time.zone.ZoneRulesException => Err(getMessage(ex as ##java.lang.Throwable))
        }


    pub def ofOffset(r: {prefix :: Option[ZonePrefix], offset :: ZoneOffset}): ZoneId =
        import static java.time.ZoneId.ofOffset(String, ##java.time.ZoneOffset): ##java.time.ZoneId & Pure;
        let p1 = match r.prefix {
            case Some(ZonePrefix(s)) => s
            case _ => ""
        };
        let ZoneOffset(o1) = r.offset;
        ZoneId(ofOffset(p1, o1))

    pub def gmt(): ZonePrefix = ZonePrefix("GMT")

    pub def utc(): ZonePrefix = ZonePrefix("UTC")

    pub def ut(): ZonePrefix = ZonePrefix("UT")


    pub def systemDefault(): Option[ZoneId] & Impure =
        import static java.time.ZoneId.systemDefault(): ##java.time.ZoneId & Impure;
        try {
            Some(ZoneId(systemDefault()))
        } catch {
            case _: ##java.time.DateTimeException => None
            case _: ##java.time.zone.ZoneRulesException => None
        }

    pub def equals(x: ZoneId, y: ZoneId): Bool =
        import java.time.ZoneId.equals(##java.lang.Object): Bool & Pure;
        let ZoneId(x1) = x;
        let ZoneId(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: ZoneId): Int32 =
        import java.time.ZoneId.hashCode(): Int32 & Pure;
        let ZoneId(x1) = x;
        hashCode(x1)


    ///
    /// Returns the unique ID of the time zone.
    ///
    pub def getTimeZoneId(x: ZoneId): String =
        import java.time.ZoneId.getId(): String & Pure;
        let ZoneId(x1) = x;
        getId(x1)

    pub def getAvailableZoneIds(): Set[String] & Impure =
        import static java.time.ZoneId.getAvailableZoneIds(): ##java.util.Set & Impure;
        try {
            let s1 = getAvailableZoneIds();
            FlixSandbox/Marshal.unmarshalSet(o -> o as String, s1)
        } catch {
            case _: ##java.lang.Exception => Set.empty()
        }

}
