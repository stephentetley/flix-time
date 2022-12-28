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
    /// `ka` is the continuation answer type
    ///
    pub enum DateTimeFormatterBuilder[r: Region, ka: Type, a: Type](MonadLib.MutStateError[r, ka, ##java.time.format.DateTimeFormatterBuilder, a])


    instance Functor[DateTimeFormatterBuilder[r, ka]] {
        pub def map(f: a -> b \ ef, ma: DateTimeFormatterBuilder[r, ka, a]): DateTimeFormatterBuilder[r, ka, b] \ ef = 
            Time/Format/DateTimeFormatterBuilder.map(f, ma)
    }


    instance Applicative[DateTimeFormatterBuilder[r, ka]] {
        pub def point(x: a): DateTimeFormatterBuilder[r, ka, a] =  Time/Format/DateTimeFormatterBuilder.point(x)

        pub def ap(mf: DateTimeFormatterBuilder[r, ka, a -> b \ ef], ma: DateTimeFormatterBuilder[r, ka, a]): DateTimeFormatterBuilder[r, ka, b] \ ef =
            Time/Format/DateTimeFormatterBuilder.ap(mf, ma)
    }

    instance Monad[DateTimeFormatterBuilder[r, ka]] {
        pub def flatMap(f: a -> DateTimeFormatterBuilder[r, ka,b] \ ef, ma: DateTimeFormatterBuilder[r, ka,a]): DateTimeFormatterBuilder[r, ka,b] \ ef =
            Time/Format/DateTimeFormatterBuilder.flatMap(f, ma)
    }

}


namespace Time/Format/DateTimeFormatterBuilder {

    use Interop/Util.Locale;

    use Time/Format.DateTimeFormatterBuilder;
    use Time/Format.DateTimeFormatterBuilder.{DateTimeFormatterBuilder};
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Format.FormatStyle;
    use Time/Format.TextStyle;
    use Time.ZoneId;

    pub def getDateTimeFormatterBuilder(x: DateTimeFormatterBuilder[r, ka, a]): MonadLib.MutStateError[r, ka, ##java.time.format.DateTimeFormatterBuilder, a] = 
        let DateTimeFormatterBuilder(x1) = x;
        x1

    pub def point(x: a): DateTimeFormatterBuilder[r, ka,a] =
        DateTimeFormatterBuilder(MonadLib/MutStateError.point(x))

    pub def map(f: a -> b \ ef, ma: DateTimeFormatterBuilder[r, ka,a]): DateTimeFormatterBuilder[r, ka,b] \ ef =
        DateTimeFormatterBuilder(MonadLib/MutStateError.map(f, getDateTimeFormatterBuilder(ma)))
        
    pub def ap(mf: DateTimeFormatterBuilder[r, ka,a -> b \ ef], ma: DateTimeFormatterBuilder[r, ka,a]): DateTimeFormatterBuilder[r, ka,b] \ ef =
        DateTimeFormatterBuilder(MonadLib/MutStateError.ap(getDateTimeFormatterBuilder(mf), getDateTimeFormatterBuilder(ma)))

    pub def flatMap(f: a -> DateTimeFormatterBuilder[r, ka,b] \ ef, ma: DateTimeFormatterBuilder[r, ka,a]): DateTimeFormatterBuilder[r, ka,b] \ ef =
        DateTimeFormatterBuilder(MonadLib/MutStateError.flatMap(f >> getDateTimeFormatterBuilder, getDateTimeFormatterBuilder(ma)))

    pub def throwError(msg: String): DateTimeFormatterBuilder[r, ka,a] = 
        DateTimeFormatterBuilder(MonadLib/MutStateError.throwError(msg))


    def liftSetter!(f: ##java.time.format.DateTimeFormatterBuilder -> ##java.time.format.DateTimeFormatterBuilder \ ef): DateTimeFormatterBuilder[r, ka, Unit] \ ef =
        DateTimeFormatterBuilder(MonadLib/MutStateError.liftSetter!(f)) |> Functor.ignore

    // def liftSetterResult(f: ##java.time.format.DateTimeFormatterBuilder -> Result[err, ##java.time.format.DateTimeFormatterBuilder,] \ ef): DateTimeFormatterBuilder[r, ka, Unit] \ ef with ToString[err] =
    //     DateTimeFormatterBuilder(MonadLib/MutStateError.liftSetterResult(f))



    ///
    /// Returns the result of applying `ma` to the initial state `s`.
    ///
    def runBuilder(r: Region[r], 
                        ma: DateTimeFormatterBuilder[r, a, a], 
                        s: ##java.time.format.DateTimeFormatterBuilder): Result[String, a] \ r = 
        MonadLib/MutStateError.runMutStateError(r, getDateTimeFormatterBuilder(ma), s)



    pub def toFormatter(r: Region[r], ma: DateTimeFormatterBuilder[r, a, a]): Result[String, DateTimeFormatter[ftype]] \ { Read(r), Write(r) } = 
        import new java.time.format.DateTimeFormatterBuilder(): ##java.time.format.DateTimeFormatterBuilder \ r as new1;
        import java.time.format.DateTimeFormatterBuilder.toFormatter(): ##java.time.format.DateTimeFormatter \ r as toJavaFormatter;
        let state1 = new1();
        match runBuilder(r, ma, state1) {
            case Err(msg) => Err(msg)
            case Ok(_)    => Ok(DateTimeFormatter(toJavaFormatter(state1)))
        }

    pub def toFormatterWithLocale(r: Region[r], loc: Locale, ma: DateTimeFormatterBuilder[r, a, a]): Result[String, DateTimeFormatter[ftype]] \ { Read(r), Write(r) } = 
        import new java.time.format.DateTimeFormatterBuilder(): ##java.time.format.DateTimeFormatterBuilder \ r as new1;
        import java.time.format.DateTimeFormatterBuilder.toFormatter(##java.util.Locale): ##java.time.format.DateTimeFormatter \ r as toJavaFormatter;
        let state1 = new1();
        let loc1 = Interop/Util/Locale.getHH(loc);
        match runBuilder(r, ma, state1) {
            case Err(msg) => Err(msg)
            case Ok(_)    => Ok(DateTimeFormatter(toJavaFormatter(state1, loc1)))
        }



    pub def append!(fmt: DateTimeFormatter[ftype]): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.append(##java.time.format.DateTimeFormatter): ##java.time.format.DateTimeFormatterBuilder \ r;
        let fmt1 = Time/Format/DateTimeFormatter.getDateTimeFormatter(fmt);
        liftSetter!(flip(append, fmt1))

    pub def appendChronologyId!(): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendChronologyId(): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(appendChronologyId)

    pub def appendChronologyText!(style: TextStyle): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendChronologyText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
        let style1 = Time/Format/TextStyle.marshal(style);
        liftSetter!(flip(appendChronologyText, style1))

    /// Java 16

    /// pub def appendDayPeriodText(style: TextStyle): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
    ///     import java.time.format.DateTimeFormatterBuilder.appendDayPeriodText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
    ///     let style1 = Time/Format/TextStyle.marshal(style);
    ///     liftSetter(flip(appendDayPeriodText, style1))


    pub def appendGenericZoneText!(style: TextStyle): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendGenericZoneText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
        let style1 = Time/Format/TextStyle.marshal(style);
        liftSetter!(flip(appendGenericZoneText, style1))

    pub def appendGenericZoneTextWithZones!(style: TextStyle, preferredZones: List[ZoneId]): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = region r1 {
        import java.time.format.DateTimeFormatterBuilder.appendGenericZoneText(##java.time.format.TextStyle, ##java.util.Set): ##java.time.format.DateTimeFormatterBuilder \ r;
        let style1 = Time/Format/TextStyle.marshal(style);
        let s1 = Interop/Util/HashSet.fromFoldable(r1, preferredZones) |> Interop/Util/SetZ.toSetHH;
        liftSetter!(bldr -> appendGenericZoneText(bldr, style1, s1))
    }

    pub def appendInstant!(): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendInstant(): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(appendInstant)

    pub def appendInstantWithFractionalDigits!(fractionalDigits: Int32): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendInstant(Int32): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(flip(appendInstant, fractionalDigits))

    pub def appendLiteralChar!(c: Char): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendLiteral(Char): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(flip(appendLiteral, c))

    pub def appendLiteralString!(s: String): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendLiteral(String): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(flip(appendLiteral, s))

    pub def appendLocalized!(r: {timeStyle = FormatStyle, dateStyle = FormatStyle}): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendLocalized(##java.time.format.FormatStyle, ##java.time.format.FormatStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
        let timeStyle1 = Time/Format/FormatStyle.marshal(r.timeStyle);
        let dateStyle1 = Time/Format/FormatStyle.marshal(r.dateStyle);
        liftSetter!(bldr -> appendLocalized(bldr, timeStyle1, dateStyle1))

    pub def appendLocalizedOffset!(style: TextStyle): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendLocalizedOffset(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
        let style1 = Time/Format/TextStyle.marshal(style);
        liftSetter!(flip(appendLocalizedOffset, style1))


    pub def appendOffset!(r: {pattern = String, noOffsetText = String}): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendOffset(String, String): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(bldr -> appendOffset(bldr, r.pattern, r.noOffsetText))

    pub def appendOffsetId!(): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendOffsetId(): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(appendOffsetId)

    pub def appendOptional!(fmt: DateTimeFormatter[ftype]): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendOptional(##java.time.format.DateTimeFormatter): ##java.time.format.DateTimeFormatterBuilder \ r;
        let fmt1 = Time/Format/DateTimeFormatter.getDateTimeFormatter(fmt);
        liftSetter!(flip(appendOptional, fmt1))

    pub def appendPattern!(patt: String): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendPattern(String): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(flip(appendPattern, patt))

    pub def appendZoneId!(): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneId(): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(appendZoneId)

    pub def appendZoneOrOffsetId!(): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneOrOffsetId(): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(appendZoneOrOffsetId)

    pub def appendZoneRegionId!(): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneRegionId(): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(appendZoneRegionId)

    pub def appendZoneText!(style: TextStyle): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
        let style1 = Time/Format/TextStyle.marshal(style);
        liftSetter!(flip(appendZoneText, style1))

    pub def appendZoneTextWithZones!(style: TextStyle, preferredZones: List[ZoneId]): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = region r1 {
        import java.time.format.DateTimeFormatterBuilder.appendZoneText(##java.time.format.TextStyle, ##java.util.Set): ##java.time.format.DateTimeFormatterBuilder \ r;
        let style1 = Time/Format/TextStyle.marshal(style);
        let s1 = Interop/Util/HashSet.fromFoldable(r1, preferredZones) |> Interop/Util/SetZ.toSetHH;
        liftSetter!(bldr -> appendZoneText(bldr, style1, s1))
    }

    pub def optionalStart!(): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.optionalStart(): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(optionalStart)

    pub def optionalEnd!(): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.optionalEnd(): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(optionalEnd)


    pub def padNext!(n: Int32): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.padNext(Int32): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(flip(padNext, n))

    pub def padNextWithChar!(n: Int32, c: Char): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.padNext(Int32, Char): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(bldr -> padNext(bldr, n, c))


    pub def parseCaseSensitive!(): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.parseCaseSensitive(): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(parseCaseSensitive)

    pub def parseCaseInsensitive!(): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.parseCaseInsensitive(): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(parseCaseInsensitive)

    pub def parseStrict!(): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.parseStrict(): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(parseStrict)

    pub def parseLenient!(): DateTimeFormatterBuilder[r, ka, Unit] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.parseLenient(): ##java.time.format.DateTimeFormatterBuilder \ r;
        liftSetter!(parseLenient)


}   
