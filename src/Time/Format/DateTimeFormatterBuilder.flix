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


    /// Is API is too large to use Setter from flix-interop?

    use Interop/Time/Format.{DateTimeFormatterBuilder => PrimBuilder}

    /// 
    /// `ka` is the continuation answer type
    ///
    pub enum DateTimeFormatterBuilder[r: Region, ka: Type, ef: Bool, a: Type](Graded.Builder[ka, PrimBuilder[r], ef, a])


    instance GradedFunctor[DateTimeFormatterBuilder[r, ka]] {
        pub def map(f: a -> b \ ef1, ma: DateTimeFormatterBuilder[r, ka, ef, a]): DateTimeFormatterBuilder[r, ka, ef and ef1, b] = 
            Time/Format/DateTimeFormatterBuilder.map(f, ma)
    }


    instance GradedApplicative[DateTimeFormatterBuilder[r, ka]] {
        pub def point(x: a): DateTimeFormatterBuilder[r, ka, ef, a] =  Time/Format/DateTimeFormatterBuilder.point(x)

        pub def ap(mf: DateTimeFormatterBuilder[r, ka, ef1, a -> b \ ef2], 
                    ma: DateTimeFormatterBuilder[r, ka, ef, a]): DateTimeFormatterBuilder[r, ka, ef and ef1 and ef2, b] =
            Time/Format/DateTimeFormatterBuilder.ap(mf, ma)
    }

    instance GradedMonad[DateTimeFormatterBuilder[r, ka]] {
        pub def flatMap(f: a -> DateTimeFormatterBuilder[r, ka, ef1, b] \ ef2, 
                        ma: DateTimeFormatterBuilder[r, ka, ef, a]): DateTimeFormatterBuilder[r, ka, ef and ef1 and ef2, b] =
            Time/Format/DateTimeFormatterBuilder.flatMap(f, ma)
    }

}


namespace Time/Format/DateTimeFormatterBuilder {

    use Interop/Util.Locale;


    use Interop/Time/Format.{DateTimeFormatterBuilder => PrimBuilder}
    
    use Time/Format.DateTimeFormatterBuilder;
    use Time/Format.DateTimeFormatterBuilder.{DateTimeFormatterBuilder};
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Format.FormatStyle;
    use Time/Format.TextStyle;
    use Time.ZoneId;

    pub def getDateTimeFormatterBuilder(x: DateTimeFormatterBuilder[r, ka, ef, a]): Graded.Builder[ka, PrimBuilder[r], ef, a] = 
        let DateTimeFormatterBuilder(x1) = x;
        x1

    pub def point(x: a): DateTimeFormatterBuilder[r, ka, ef, a] =
        DateTimeFormatterBuilder(Graded/Builder.point(x))

    pub def map(f: a -> b \ ef1, 
                ma: DateTimeFormatterBuilder[r, ka, ef, a]): DateTimeFormatterBuilder[r, ka, ef and ef1, b] =
        DateTimeFormatterBuilder(Graded/Builder.map(f, getDateTimeFormatterBuilder(ma)))
        
    pub def ap(mf: DateTimeFormatterBuilder[r, ka, ef1, a -> b \ ef2], 
                ma: DateTimeFormatterBuilder[r, ka, ef, a]): DateTimeFormatterBuilder[r, ka, ef and ef1 and ef2, b] =
        DateTimeFormatterBuilder(Graded/Builder.ap(getDateTimeFormatterBuilder(mf), getDateTimeFormatterBuilder(ma)))

    pub def flatMap(f: a -> DateTimeFormatterBuilder[r, ka, ef1, b] \ ef2, 
                    ma: DateTimeFormatterBuilder[r, ka, ef, a]): DateTimeFormatterBuilder[r, ka, ef and ef1 and ef2, b] =
        DateTimeFormatterBuilder(Graded/Builder.flatMap(f >> getDateTimeFormatterBuilder, getDateTimeFormatterBuilder(ma)))

    pub def throwError(msg: String): DateTimeFormatterBuilder[r, ka, ef, a] = 
        DateTimeFormatterBuilder(Graded/Builder.throwError(msg))


    def liftSetter!(f: PrimBuilder[r] -> PrimBuilder[r] \ {ef, Write(r)}): DateTimeFormatterBuilder[r, ka, r and ef, Unit] =
        DateTimeFormatterBuilder(Graded/Builder.liftSetter!(f)) |> GradedFunctor.ignore

    // def liftSetterResult(f: ##java.time.format.DateTimeFormatterBuilder -> Result[err, ##java.time.format.DateTimeFormatterBuilder,] \ ef): DateTimeFormatterBuilder[r, ka, r and ef, Unit] with ToString[err] =
    //     DateTimeFormatterBuilder(Graded/Builder.liftSetterResult(f))



    ///
    /// Returns the result of applying `ma` to the initial state `s`.
    ///
    def runBuilder(ma: DateTimeFormatterBuilder[r, a, ef, a], 
                    s: PrimBuilder[r]): Result[String, a] \ ef = 
        Graded/Builder.runBuilder(getDateTimeFormatterBuilder(ma), s)



    pub def toFormatter(rc: Region[r], ma: DateTimeFormatterBuilder[r, a, ef, a]): Result[String, DateTimeFormatter[ftype]] \ {ef, Write(r)} = 
        let state1 = Interop/Time/Format/DateTimeFormatterBuilder.new(rc);
        match runBuilder(ma, state1) {
            case Err(msg) => Err(msg)
            case Ok(_)    => Ok(DateTimeFormatter(Interop/Time/Format/DateTimeFormatterBuilder.toFormatter(state1)))
        }

    pub def toFormatterWithLocale(rc: Region[r], loc: Locale, ma: DateTimeFormatterBuilder[r, a, ef, a]): Result[String, DateTimeFormatter[ftype]] \ {ef, Write(r)} = 
        let state1 = Interop/Time/Format/DateTimeFormatterBuilder.new(rc);
        let loc1 = Interop/Util/Locale.getHH(loc);
        match runBuilder(ma, state1) {
            case Err(msg) => Err(msg)
            case Ok(_)    => Ok(DateTimeFormatter(Interop/Time/Format/DateTimeFormatterBuilder.toFormatterWithLocale(loc1, state1)))
        }



    pub def append!(fmt: DateTimeFormatter[ftype]): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        let fmt1 = Time/Format/DateTimeFormatter.getDateTimeFormatter(fmt);
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.append!(fmt1))

    pub def appendChronologyId!(): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendChronologyId!)


    pub def appendChronologyText!(style: TextStyle): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        let style1 = Time/Format/TextStyle.marshal(style);
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendChronologyText!(style1))

    /// Java 16

    /// pub def appendDayPeriodText(style: TextStyle): DateTimeFormatterBuilder[r, ka, r, Unit] = 
    ///     import java.time.format.DateTimeFormatterBuilder.appendDayPeriodText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ ef;
    ///     let style1 = Time/Format/TextStyle.marshal(style);
    ///     liftSetter(flip(appendDayPeriodText, style1))


    pub def appendGenericZoneText!(style: TextStyle): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        let style1 = Time/Format/TextStyle.marshal(style);
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendGenericZoneText!(style1))

    pub def appendGenericZoneTextWithZones!(style: TextStyle, preferredZones: List[ZoneId]): DateTimeFormatterBuilder[r, ka, r, Unit] = region rc {
        let style1 = Time/Format/TextStyle.marshal(style);
        let s1 = Interop/Util/HashSet.fromFoldable(rc, preferredZones) |> Interop/Util/SetZ.toSetHH;
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendGenericZoneTextWithZones!(style1, s1))
    }

    pub def appendInstant!(): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendInstant!)

    pub def appendInstantWithFractionalDigits!(fractionalDigits: Int32): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendInstantWithFractionalDigits!(fractionalDigits))

    pub def appendLiteralChar!(ch: Char): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendLiteralChar!(ch))

    pub def appendLiteralString!(s: String): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendLiteralString!(s))

    pub def appendLocalized!(timeStyle: {timeStyle = FormatStyle}, dateStyle: {dateStyle = FormatStyle}): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        let timeStyle1 = Time/Format/FormatStyle.marshal(timeStyle.timeStyle);
        let dateStyle1 = Time/Format/FormatStyle.marshal(dateStyle.dateStyle);
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendLocalized!(timeStyle = timeStyle1, dateStyle = dateStyle1))

    pub def appendLocalizedOffset!(style: TextStyle): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        let style1 = Time/Format/TextStyle.marshal(style);
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendLocalizedOffset!(style1))


    pub def appendOffset!(pattern: {pattern = String}, noOffsetText: {noOffsetText = String}): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendOffset!(pattern, noOffsetText))

    pub def appendOffsetId!(): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendOffsetId!)

    pub def appendOptional!(fmt: DateTimeFormatter[ftype]): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        let fmt1 = Time/Format/DateTimeFormatter.getDateTimeFormatter(fmt);
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendOptional!(fmt1))

    pub def appendPattern!(patt: String): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendPattern!(patt))

    pub def appendZoneId!(): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendZoneId!)

    pub def appendZoneOrOffsetId!(): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendZoneOrOffsetId!)

    pub def appendZoneRegionId!(): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendZoneRegionId!)

    pub def appendZoneText!(style: TextStyle): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        let style1 = Time/Format/TextStyle.marshal(style);
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendZoneText!(style1))

    pub def appendZoneTextWithZones!(style: TextStyle, preferredZones: List[ZoneId]): DateTimeFormatterBuilder[r, ka, r, Unit] = region rc {
        let style1 = Time/Format/TextStyle.marshal(style);
        let s1 = Interop/Util/HashSet.fromFoldable(rc, preferredZones) |> Interop/Util/SetZ.toSetHH;
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.appendZoneTextWithZones!(style1, s1))
    }


    pub def optionalStart!(): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.optionalStart!)

    pub def optionalEnd!(): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.optionalEnd!)

    pub def padNext!(n: Int32): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.padNext!(n))

    pub def padNextWithChar!(n: Int32, ch: Char): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.padNextWithChar!(n, ch))


    pub def parseCaseSensitive!(): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.parseCaseSensitive!)

    pub def parseCaseInsensitive!(): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.parseCaseInsensitive!)

    pub def parseStrict!(): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.parseStrict!)

    pub def parseLenient!(): DateTimeFormatterBuilder[r, ka, r, Unit] = 
        liftSetter!(Interop/Time/Format/DateTimeFormatterBuilder.parseLenient!)

}   
