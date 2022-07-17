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
    pub enum DateTimeFormatterBuilder[ka, a](##java.time.format.DateTimeFormatterBuilder -> 
        (a -> ##java.time.format.DateTimeFormatterBuilder -> Result[ka, String] & Impure) -> Result[ka, String] & Impure)


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

    use I18n.Locale;
    use I18n.Locale.{Locale};

    use Time/Format.DateTimeFormatterBuilder;
    use Time/Format.DateTimeFormatterBuilder.{DateTimeFormatterBuilder};
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Format.FormatStyle;
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
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex))
        }

    pub def toFormatterWithLocale(loc: Locale, ma: DateTimeFormatterBuilder[(##java.time.format.DateTimeFormatterBuilder, a), a]): Result[DateTimeFormatter[ftype], String] & Impure = 
        import new java.time.format.DateTimeFormatterBuilder(): ##java.time.format.DateTimeFormatterBuilder & Impure as new1;
        import java.time.format.DateTimeFormatterBuilder.toFormatter(##java.util.Locale): ##java.time.format.DateTimeFormatter & Impure as toJavaFormatter;
        try {
            let Locale(loc1) = loc;
            let jbuilder = new1();
            match runBuilder(ma, jbuilder) {
                case Err(msg)           => Err(msg)
                case Ok((jbuilder1, _)) => Ok(DateTimeFormatter(toJavaFormatter(jbuilder1, loc1)))
            }
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex))
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
                case ex: ##java.lang.Exception => 
                    import java.lang.Throwable.getMessage(): String & Pure;
                    Err(getMessage(ex))
            }            
        )

    /// Needed for `getLocalizedDateTimePattern` which is pending...
    /// def liftJvmBuilderAsks(f: ##java.time.format.DateTimeFormatterBuilder -> a & Impure): DateTimeFormatterBuilder[ka, a] = 
    ///     DateTimeFormatterBuilder((s, k) ->
    ///         try {
    ///             let a = f(s);
    ///             k(a, s)
    ///         } catch {
    ///             case ex: ##java.lang.Exception => Err(FlixSandbox/Marshal.unmarshalExceptionMessage(ex))
    ///         }            
    ///     )


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

    /// Java 16

    /// pub def appendDayPeriodText(style: TextStyle): DateTimeFormatterBuilder[ka, Unit] = 
    ///     import java.time.format.DateTimeFormatterBuilder.appendDayPeriodText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder & Impure;
    ///     let style1 = Time/Format/TextStyle.marshal(style);
    ///     liftJvmBuilderPrim(flip(appendDayPeriodText, style1))


    pub def appendGenericZoneText(style: TextStyle): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendGenericZoneText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder & Impure;
        let style1 = Time/Format/TextStyle.marshal(style);
        liftJvmBuilderPrim(flip(appendGenericZoneText, style1))

    pub def appendGenericZoneTextWithZones(style: TextStyle, preferredZones: List[ZoneId]): DateTimeFormatterBuilder[ka, Unit] = region r {
        import java.time.format.DateTimeFormatterBuilder.appendGenericZoneText(##java.time.format.TextStyle, ##java.util.Set): ##java.time.format.DateTimeFormatterBuilder & Impure;
        let style1 = Time/Format/TextStyle.marshal(style);
        let s1 = CollectionInterop/RawSet.fromListViaHashSet(r, preferredZones) |> CollectionInterop/RawSet.getRawSet;
        liftJvmBuilderPrim(bldr -> appendGenericZoneText(bldr, style1, s1))
    }

    pub def appendInstant(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendInstant(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(appendInstant)

    pub def appendInstantWithFractionalDigits(fractionalDigits: Int32): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendInstant(Int32): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(flip(appendInstant, fractionalDigits))

    pub def appendLiteralChar(c: Char): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendLiteral(Char): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(flip(appendLiteral, c))

    pub def appendLiteralString(s: String): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendLiteral(String): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(flip(appendLiteral, s))

    pub def appendLocalized(r: {timeStyle :: FormatStyle, dateStyle :: FormatStyle}): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendLocalized(##java.time.format.FormatStyle, ##java.time.format.FormatStyle): ##java.time.format.DateTimeFormatterBuilder & Impure;
        let timeStyle1 = Time/Format/FormatStyle.marshal(r.timeStyle);
        let dateStyle1 = Time/Format/FormatStyle.marshal(r.dateStyle);
        liftJvmBuilderPrim(bldr -> appendLocalized(bldr, timeStyle1, dateStyle1))

    pub def appendLocalizedOffset(style: TextStyle): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendLocalizedOffset(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder & Impure;
        let style1 = Time/Format/TextStyle.marshal(style);
        liftJvmBuilderPrim(flip(appendLocalizedOffset, style1))


    pub def appendOffset(r: {pattern :: String, noOffsetText :: String}): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendOffset(String, String): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(bldr -> appendOffset(bldr, r.pattern, r.noOffsetText))

    pub def appendOffsetId(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendOffsetId(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(appendOffsetId)

    pub def appendOptional(fmt: DateTimeFormatter[ftype]): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendOptional(##java.time.format.DateTimeFormatter): ##java.time.format.DateTimeFormatterBuilder & Impure;
        let fmt1 = Time/Format/DateTimeFormatter.getDateTimeFormatter(fmt);
        liftJvmBuilderPrim(flip(appendOptional, fmt1))

    pub def appendPattern(patt: String): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendPattern(String): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(flip(appendPattern, patt))

    pub def appendZoneId(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneId(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(appendZoneId)

    pub def appendZoneOrOffsetId(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneOrOffsetId(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(appendZoneOrOffsetId)

    pub def appendZoneRegionId(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneRegionId(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(appendZoneRegionId)

    pub def appendZoneText(style: TextStyle): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder & Impure;
        let style1 = Time/Format/TextStyle.marshal(style);
        liftJvmBuilderPrim(flip(appendZoneText, style1))

    pub def appendZoneTextWithZones(style: TextStyle, preferredZones: List[ZoneId]): DateTimeFormatterBuilder[ka, Unit] = region r {
        import java.time.format.DateTimeFormatterBuilder.appendZoneText(##java.time.format.TextStyle, ##java.util.Set): ##java.time.format.DateTimeFormatterBuilder & Impure;
        let style1 = Time/Format/TextStyle.marshal(style);
        let s1 = CollectionInterop/RawSet.fromListViaHashSet(r, preferredZones) |> CollectionInterop/RawSet.getRawSet;
        liftJvmBuilderPrim(bldr -> appendZoneText(bldr, style1, s1))
    }

    pub def optionalStart(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.optionalStart(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(optionalStart)

    pub def optionalEnd(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.optionalEnd(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(optionalEnd)


    pub def padNext(n: Int32): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.padNext(Int32): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(flip(padNext, n))

    pub def padNextWithChar(n: Int32, c: Char): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.padNext(Int32, Char): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(bldr -> padNext(bldr, n, c))


    pub def parseCaseSensitive(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.parseCaseSensitive(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(parseCaseSensitive)

    pub def parseCaseInsensitive(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.parseCaseInsensitive(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(parseCaseInsensitive)

    pub def parseStrict(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.parseStrict(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(parseStrict)

    pub def parseLenient(): DateTimeFormatterBuilder[ka, Unit] = 
        import java.time.format.DateTimeFormatterBuilder.parseLenient(): ##java.time.format.DateTimeFormatterBuilder & Impure;
        liftJvmBuilderPrim(parseLenient)


}   
