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

mod Time.Format {


    pub enum DateTimeFormatterBuilder[r: Region](##java.time.format.DateTimeFormatterBuilder -> Unit \ r)


}


mod Time.Format.DateTimeFormatterBuilder {

    use Locale.{Locale}

    use Time.Format.DateTimeFormatterBuilder
    use Time.Format.DateTimeFormatterBuilder.{DateTimeFormatterBuilder}
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.Format.FormatStyle
    use Time.Format.TextStyle


    pub def andThen(b1: DateTimeFormatterBuilder[r], b2: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(build -> 
            let DateTimeFormatterBuilder(f1) = b1;
            let DateTimeFormatterBuilder(f2) = b2;
            f1(build);
            f2(build)
        )


    pub def toFormatter(_: Region[r], b: DateTimeFormatterBuilder[r]): DateTimeFormatter[t] \ r = 
        import java.time.format.DateTimeFormatterBuilder.toFormatter(): ##java.time.format.DateTimeFormatter \ r;
        import java_new java.time.format.DateTimeFormatterBuilder(): ##java.time.format.DateTimeFormatterBuilder \ r as newDateTimeFormatterBuilder;
        let DateTimeFormatterBuilder(f1) = b;
        let build = newDateTimeFormatterBuilder();
        f1(build);
        DateTimeFormatter(toFormatter(build))

    // pub def toFormatterWithLocale(loc: ##java.util.Locale, b: DateTimeFormatterBuilder[r]): ##java.time.format.DateTimeFormatter \ r = 
    //     
    pub def toFormatterWithLocale(_: Region[r], loc: Locale, b: DateTimeFormatterBuilder[r]): DateTimeFormatter[t] \ r = 
        import java.time.format.DateTimeFormatterBuilder.toFormatter(##java.util.Locale): ##java.time.format.DateTimeFormatter \ r;
        import java_new java.time.format.DateTimeFormatterBuilder(): ##java.time.format.DateTimeFormatterBuilder \ r as newDateTimeFormatterBuilder;
        let DateTimeFormatterBuilder(f1) = b;
        let Locale(loc1) = loc;
        let build = newDateTimeFormatterBuilder();
        f1(build);
        DateTimeFormatter(toFormatter(build, loc1))

    pub def append!(fmt: DateTimeFormatter[t]): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.append(##java.time.format.DateTimeFormatter): ##java.time.format.DateTimeFormatterBuilder \ r;
            let DateTimeFormatter(fmt1) = fmt;
            discard append(b, fmt1)
        })

    /// TODO - is this really in IO?
    pub def appendChronologyId!(): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendChronologyId(): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard appendChronologyId(b)
        })


    pub def appendChronologyText!(style: TextStyle): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendChronologyText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
            let style1 = Time.Format.TextStyle.marshalTextStyle(style);
            discard appendChronologyText(b, style1)
        })

    /// Java 16

    // pub def appendDayPeriodText(style: ##java.time.format.TextStyle, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ r = 
    //     import java.time.format.DateTimeFormatterBuilder.appendDayPeriodText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
    //     let DateTimeFormatterBuilder(b1) = b;
    //     appendDayPeriodText(b1, style) |> DateTimeFormatterBuilder


    pub def appendGenericZoneText!(style: TextStyle): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendGenericZoneText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
            let style1 = Time.Format.TextStyle.marshalTextStyle(style);
            discard appendGenericZoneText(b, style1)
        })            

    // pub def appendGenericZoneTextWithZones!(style: ##java.time.format.TextStyle, preferredZones: ##java.util.Set, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ r =
    //     import java.time.format.DateTimeFormatterBuilder.appendGenericZoneText(##java.time.format.TextStyle, ##java.util.Set): ##java.time.format.DateTimeFormatterBuilder \ r;
    //     let DateTimeFormatterBuilder(b1) = b;
    //     appendGenericZoneText(b1, style, preferredZones) |> DateTimeFormatterBuilder


    pub def appendInstant!(): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendInstant(): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard appendInstant(b)
        })

    pub def appendInstantWithFractionalDigits!(fractionalDigits: Int32): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendInstant(Int32): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard appendInstant(b, fractionalDigits)
        })

    pub def appendLiteralChar!(ch: Char): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendLiteral(Char): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard appendLiteral(b, ch)
        })

    pub def appendLiteralString!(s: String): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendLiteral(String): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard appendLiteral(b, s)
        })

    pub def appendLocalized!(timeStyle: {timeStyle = FormatStyle}, 
                                dateStyle: {dateStyle = FormatStyle}): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendLocalized(##java.time.format.FormatStyle, ##java.time.format.FormatStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
            let timeStyle1 = Time.Format.FormatStyle.marshalFormatStyle(timeStyle.timeStyle);
            let dateStyle1 = Time.Format.FormatStyle.marshalFormatStyle(dateStyle.dateStyle);
            discard appendLocalized(b, timeStyle1, dateStyle1)
        })

    pub def appendLocalizedOffset!(style: TextStyle): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendLocalizedOffset(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
            let style1 = Time.Format.TextStyle.marshalTextStyle(style);
            discard appendLocalizedOffset(b, style1)
        })


    pub def appendOffset!(pattern: {pattern = String}, 
                            noOffsetText: {noOffsetText = String}): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendOffset(String, String): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard appendOffset(b, pattern.pattern, noOffsetText.noOffsetText)
        })


    pub def appendOffsetId!(): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendOffsetId(): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard appendOffsetId(b)
        })

    pub def appendOptional!(fmt: DateTimeFormatter[t]): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> { 
            import java.time.format.DateTimeFormatterBuilder.appendOptional(##java.time.format.DateTimeFormatter): ##java.time.format.DateTimeFormatterBuilder \ r;
            let DateTimeFormatter(fmt1) = fmt;
            discard appendOptional(b, fmt1)
        })

    pub def appendPattern!(patt: String): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendPattern(String): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard appendPattern(b, patt) 
        })

    pub def appendZoneId!(): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendZoneId(): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard appendZoneId(b)
        })


    pub def appendZoneOrOffsetId!(): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendZoneOrOffsetId(): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard appendZoneOrOffsetId(b)
        })

    pub def appendZoneRegionId!(): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendZoneRegionId(): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard appendZoneRegionId(b)
        })

    pub def appendZoneText!(style: TextStyle): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.appendZoneText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
            let style1 = Time.Format.TextStyle.marshalTextStyle(style);
            discard appendZoneText(b, style1)
        })

/*
    pub def appendZoneTextWithZones!(style: ##java.time.format.TextStyle, preferredZones: ##java.util.Set, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ r = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneText(##java.time.format.TextStyle, ##java.util.Set): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendZoneText(b1, style, preferredZones) |> DateTimeFormatterBuilder
*/

    pub def optionalStart!(): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.optionalStart(): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard optionalStart(b)
        })

    pub def optionalEnd!(): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.optionalEnd(): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard optionalEnd(b)
        })


    pub def padNext!(n: Int32): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.padNext(Int32): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard padNext(b, n)
        })

    pub def padNextWithChar!(n: Int32, ch: Char): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.padNext(Int32, Char): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard padNext(b, n, ch)
        })

    pub def parseCaseSensitive!(): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.parseCaseSensitive(): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard parseCaseSensitive(b)
        })

    pub def parseCaseInsensitive!(): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.parseCaseInsensitive(): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard parseCaseInsensitive(b)
        })

    pub def parseStrict!(): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.parseStrict(): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard parseStrict(b)
        })

    pub def parseLenient!(): DateTimeFormatterBuilder[r] = 
        DateTimeFormatterBuilder(b -> {
            import java.time.format.DateTimeFormatterBuilder.parseLenient(): ##java.time.format.DateTimeFormatterBuilder \ r;
            discard parseLenient(b)
        })
}   
