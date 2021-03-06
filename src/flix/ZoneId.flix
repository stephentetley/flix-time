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
            import java.time.ZoneId.toString();
            let ZoneId(z) = x;
            z.toString() as & Pure
    }

    instance FromString[ZoneId] {
        pub def fromString(zoneIdentifier: String): Option[ZoneId] =
            import java.lang.String.strip();
            import java.time.ZoneId:of(String) as of;
            try {
                Some(ZoneId(zoneIdentifier.strip().of())) as & Pure
            } catch {
                case _: ##java.time.DateTimeException => None
                case _: ##java.time.zone.ZoneRulesException => None
            }
    }


    instance Eq[ZoneId] {
        pub def eq(x: ZoneId, y: ZoneId): Bool =
            import java.time.ZoneId.equals(##java.lang.Object);
            let ZoneId(x1) = x;
            let ZoneId(y1) = y;
            x1.equals(y1 as ##java.lang.Object) as & Pure

        pub def neq(x: ZoneId, y: ZoneId): Bool = not (x == y)
    }


    instance Hash[ZoneId] {
        pub def hash(x: ZoneId): Int = Time/ZoneId.hashCode(x)
    }

    pub opaque type ZonePrefix = String

}

namespace Time/ZoneId {

    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    use Time.ZonePrefix;
    use Time.ZonePrefix.{ZonePrefix};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    pub def new(prefix: Option[ZonePrefix], offset: ZoneOffset): ZoneId =
        import java.time.ZoneId:ofOffset(String, ##java.time.ZoneOffset);
        let p1 = match prefix {
            case Some(p) => { let ZonePrefix(s) = p; s }
            case None => ""
        };
        let ZoneOffset(o1) = offset;
        ZoneId(ofOffset(p1, o1)) as & Pure

    pub def gmt(): ZonePrefix = ZonePrefix("GMT")

    pub def utc(): ZonePrefix = ZonePrefix("UTC")

    pub def ut(): ZonePrefix = ZonePrefix("UT")


    pub def systemDefault(): Option[ZoneId] & Impure =
        import java.time.ZoneId:systemDefault() as systemDefaultZoneId;
        try {
            Some(ZoneId(systemDefaultZoneId()))
        } catch {
            case _: ##java.time.DateTimeException => None
            case _: ##java.time.zone.ZoneRulesException => None
        }


    pub def hashCode(x: ZoneId): Int32 = 
        import java.time.ZoneId.hashCode();
        let ZoneId(x1) = x;
        hashCode(x1) as & Pure


    ///
    /// Returns the unique ID of the time zone.
    ///
    pub def getTimeZoneId(x: ZoneId): String =
        import java.time.ZoneId.getId();
        let ZoneId(x1) = x;
        x1.getId() as & Pure


    pub def getAvailableZoneIds(): Set[String] & Impure = 
        import new flix.runtime.spt.newtime.UnmarshalGetAvailableLocales() as newIter;
        import flix.runtime.spt.newtime.UnmarshalGetAvailableLocales.hasNext();
        import flix.runtime.spt.newtime.UnmarshalGetAvailableLocales.next();
        let iter = newIter();
        let step = () ->
            if (iter.hasNext() == false)
                None
            else {
                let s = iter.next();
                Some(s)
                };
        List.unfoldWithIter(step) |> List.toSet


}
