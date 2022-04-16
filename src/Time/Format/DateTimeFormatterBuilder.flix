/*
 * Copyright 2022 Stephen Tetley
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

namespace Time/Format {



    ///
    /// State and Codensity(Error) monad
    /// 
    /// `ka` is the continuation answer type
    ///
    pub opaque type DateTimeFormatterBuilder[ka, a] = ##java.time.format.DateTimeFormatterBuilder -> (a -> ##java.time.format.DateTimeFormatterBuilder -> Result[ka, String] & Impure) -> Result[ka, String] & Impure


    instance Functor[DateTimeFormatterBuilder[ka]] {
        pub def map(f: a -> b & ef, ma: DateTimeFormatterBuilder[ka, a]): DateTimeFormatterBuilder[ka, b] & ef = 
            Time/Format/DateTimeFormatterBuilder.map(f, ma)
    }


    instance Applicative[DateTimeFormatterBuilder[ka]] {
        pub def point(x: a): DateTimeFormatterBuilder[ka, a] =  Time/Format/DateTimeFormatterBuilder.point(x)
        pub def ap(mf: DateTimeFormatterBuilder[ka, a -> b & ef], ma: DateTimeFormatterBuilder[ka, a]): DateTimeFormatterBuilder[ka, b] & ef =
            Time/Format/DateTimeFormatterBuilder.ap(mf, ma)
    }

    instance Monad[DateTimeFormatterBuilder[ka]] {
        pub def flatMap(f: a -> DateTimeFormatterBuilder[ka, b] & ef, ma: DateTimeFormatterBuilder[ka, a]): DateTimeFormatterBuilder[ka, b] & ef =
            Time/Format/DateTimeFormatterBuilder.flatMap(f, ma)
    }

}


namespace Time/Format/DateTimeFormatterBuilder {

    use Time/Format.DateTimeFormatterBuilder;
    use Time/Format.DateTimeFormatterBuilder.{DateTimeFormatterBuilder};
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Format.TextStyle;
    use Time.ZoneId;

    ///
    /// Helper function for the implementation of `map` and `ap` etc.
    ///
    def apply1(ma: DateTimeFormatterBuilder[ka, a], 
                st: ##java.time.format.DateTimeFormatterBuilder, 
                k: a -> ##java.time.format.DateTimeFormatterBuilder -> Result[ka, String] & Impure): Result[ka, String] & Impure =
        let DateTimeFormatterBuilder(ma1) = ma;
        ma1(st, k)

    pub def toFormatter(ma: DateTimeFormatterBuilder[(##java.time.format.DateTimeFormatterBuilder, a), a]): Result[DateTimeFormatter[ftype], String] & Impure = 
        import new java.time.format.DateTimeFormatterBuilder(): ##java.time.format.DateTimeFormatterBuilder & Impure as new1;
        import java.time.format.DateTimeFormatterBuilder.toFormatter(): ##java.time.format.DateTimeFormatter & Impure as toJavaFormatter;
        try {
            let jbuilder = new1();
            match runBuilder(ma, jbuilder) {
                case Err(msg)           => Err(msg)
                case Ok((jbuilder1, _)) => Ok(DateTimeFormatter(toJavaFormatter(jbuilder1)))
            }
        } catch {
            case ex: ##java.lang.Exception => Err(FlixSandbox/Marshal.unmarshalExceptionMessage(ex))
        }

    ///
    /// Returns the result (new state and answer) of applying `ma` to the initial state `st`.
    ///
    def runBuilder(ma: DateTimeFormatterBuilder[(##java.time.format.DateTimeFormatterBuilder, a), a], st: ##java.time.format.DateTimeFormatterBuilder): Result[(##java.time.format.DateTimeFormatterBuilder, a), String] & Impure =
        let DateTimeFormatterBuilder(f) = ma;
        let cont = (a, s) -> Ok(s, a) as & Impure;
        f(st, cont)

    pub def point(x: a): DateTimeFormatterBuilder[ka, a] =
        DateTimeFormatterBuilder((s, k) -> k(x, s))

    pub def map(f: a -> b & ef, ma: DateTimeFormatterBuilder[ka, a]): DateTimeFormatterBuilder[ka, b] & ef =
        DateTimeFormatterBuilder((s, k) ->
            apply1(ma, s, (a, s1) -> k(f(a) as & Impure, s1))
        ) as & ef
        
    pub def ap(mf: DateTimeFormatterBuilder[ka, a -> b & ef], ma: DateTimeFormatterBuilder[ka, a]): DateTimeFormatterBuilder[ka, b] & ef =
        DateTimeFormatterBuilder((s, k) ->
            apply1(mf, s, (f, s1) ->
                apply1(ma, s1, (a, s2) ->
                    k(f(a) as & Impure, s2)))
        ) as & ef

    pub def flatMap(f: a -> DateTimeFormatterBuilder[ka, b] & ef, ma: DateTimeFormatterBuilder[ka, a]): DateTimeFormatterBuilder[ka, b] & ef =
        DateTimeFormatterBuilder((s, k) ->
            apply1(ma, s, (a, s1) ->
                apply1(f(a) as & Impure, s1, (b, s2) ->
                    k(b, s2)))
        ) as & ef

    pub def throwError(msg: String): DateTimeFormatterBuilder[ka, a] = 
        DateTimeFormatterBuilder((_, _) -> Err(msg) as & Impure)


    def liftJvmBuilderPrim(f: ##java.time.format.DateTimeFormatterBuilder -> ##java.time.format.DateTimeFormatterBuilder & Impure): DateTimeFormatterBuilder[ka, Unit] = 
        DateTimeFormatterBuilder((s, k) ->
            try {
                let s1 = f(s);
                k((), s1)
            } catch {
                case ex: ##java.lang.Exception => Err(FlixSandbox/Marshal.unmarshalExceptionMessage(ex))
            }            
        )

    pub def append(fmt: DateTimeFormatter[ftype]): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.append(##java.time.format.DateTimeFormatter): ##java.time.format.DateTimeFormatterBuilder & Impure;
        let fmt1 = Time/Format/DateTimeFormatter.getDateTimeFormatter(fmt);
        liftJvmBuilderPrim(flip(append, fmt1))

    pub def appendChronologyId(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendChronologyId(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(appendChronologyId)

    pub def appendChronologyText(style: TextStyle): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendChronologyText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder & Impure;
        let style1 = Time/Format/TextStyle.marshal(style);
        liftJvmBuilderPrim(flip(appendChronologyText, style1))


    pub def appendDayPeriodText(style: TextStyle): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendDayPeriodText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder & Impure;
        let style1 = Time/Format/TextStyle.marshal(style);
        liftJvmBuilderPrim(flip(appendDayPeriodText, style1))


    pub def appendGenericZoneText(style: TextStyle): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendGenericZoneText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder & Impure;
        let style1 = Time/Format/TextStyle.marshal(style);
        liftJvmBuilderPrim(flip(appendGenericZoneText, style1))

    pub def appendGenericZoneTextWithZones(style: TextStyle, preferredZones: List[ZoneId]): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendGenericZoneText(##java.time.format.TextStyle, ##java.util.Set): ##java.time.format.DateTimeFormatterBuilder & Impure;
        let style1 = Time/Format/TextStyle.marshal(style);
        let s1 = FlixSandbox/Marshal.marshalListToSet(z -> Time/ZoneId.getZoneId(z) as ##java.lang.Object, preferredZones) as & Pure;
        liftJvmBuilderPrim(bldr -> appendGenericZoneText(bldr, style1, s1))


    pub def optionalStart(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.optionalStart(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(optionalStart)

    pub def optionalEnd(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.optionalEnd(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(optionalEnd)


}   
