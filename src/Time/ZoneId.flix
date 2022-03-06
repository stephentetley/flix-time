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

    instance FromString[ZoneId] {
        pub def fromString(s: String): Option[ZoneId] =
            import java.lang.String.strip(): String & Pure;
            import static java.time.ZoneId.of(String): ##java.time.ZoneId & Pure;
            try {
                Some(ZoneId(of(strip(s))))
            } catch {
                case _: ##java.time.DateTimeException => None
                case _: ##java.time.zone.ZoneRulesException => None
            }
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
    use Time.ZonePrefix;
    use Time.ZonePrefix.{ZonePrefix};
    use Time.ZoneOffset;
    use Time.ZoneOffset.{ZoneOffset};

    pub def new(prefix: Option[ZonePrefix], offset: ZoneOffset): ZoneId =
        import static java.time.ZoneId.ofOffset(String, ##java.time.ZoneOffset): ##java.time.ZoneId & Pure;
        let p1 = match prefix {
            case Some(ZonePrefix(s)) => s
            case _ => ""
        };
        let ZoneOffset(o1) = offset;
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
        import java.util.Set.iterator(): ##java.util.Iterator & Impure;
        try {
            let sjava = getAvailableZoneIds();
            let iter = iterator(sjava);
            let xs = iterateListOfString(iter, ks -> ks);
            List.toSet(xs)
        } catch {
            case _: ##java.lang.Exception => Set.empty()
        }


    def iterateListOfString(iter: ##java.util.Iterator, k: List[String] -> List[String]): List[String] & Impure =
        import java.util.Iterator.hasNext(): Bool & Impure;
        import java.util.Iterator.next(): ##java.lang.Object & Impure;
        if (hasNext(iter))
            let entry = next(iter) as String;
            iterateListOfString(iter, ks -> k(entry :: ks))
        else
            k(Nil)


}