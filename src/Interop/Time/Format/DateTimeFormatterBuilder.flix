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

 namespace Interop/Time/Format {

    /// Class / Mutable

    pub enum DateTimeFormatterBuilder[_: Region](##java.time.format.DateTimeFormatterBuilder)


}

 namespace Interop/Time/Format/DateTimeFormatterBuilder {

    use Interop/Time/Format.DateTimeFormatterBuilder
    use Interop/Time/Format.DateTimeFormatterBuilder.DateTimeFormatterBuilder

    /// ## Unwrap
    pub def getHH(x: DateTimeFormatterBuilder[r]): ##java.time.format.DateTimeFormatterBuilder = 
        let DateTimeFormatterBuilder(x1) = x;
        x1

    pub def new(_: Region[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import new java.time.format.DateTimeFormatterBuilder(): ##java.time.format.DateTimeFormatterBuilder \ Write(r) as new1;
        new1() |> DateTimeFormatterBuilder

    pub def toFormatter(b: DateTimeFormatterBuilder[r]): ##java.time.format.DateTimeFormatter \ Read(r) = 
        import java.time.format.DateTimeFormatterBuilder.toFormatter(): ##java.time.format.DateTimeFormatter \ r;
        let DateTimeFormatterBuilder(b1) = b;
        toFormatter(b1)

    pub def toFormatterWithLocale(loc: ##java.util.Locale, b: DateTimeFormatterBuilder[r]): ##java.time.format.DateTimeFormatter \ Read(r) = 
        import java.time.format.DateTimeFormatterBuilder.toFormatter(##java.util.Locale): ##java.time.format.DateTimeFormatter \ r;
        let DateTimeFormatterBuilder(b1) = b;
        toFormatter(b1, loc)

    pub def append!(fmt: ##java.time.format.DateTimeFormatter, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.append(##java.time.format.DateTimeFormatter): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        append(b1, fmt) |> DateTimeFormatterBuilder

    pub def appendChronologyId!(b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendChronologyId(): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendChronologyId(b1) |> DateTimeFormatterBuilder


    pub def appendChronologyText!(style: ##java.time.format.TextStyle, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendChronologyText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendChronologyText(b1, style) |> DateTimeFormatterBuilder      

    /// Java 16

    // pub def appendDayPeriodText(style: ##java.time.format.TextStyle, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
    //     import java.time.format.DateTimeFormatterBuilder.appendDayPeriodText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
    //     let DateTimeFormatterBuilder(b1) = b;
    //     appendDayPeriodText(b1, style) |> DateTimeFormatterBuilder


    pub def appendGenericZoneText!(style: ##java.time.format.TextStyle, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendGenericZoneText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendGenericZoneText(b1, style) |> DateTimeFormatterBuilder

    pub def appendGenericZoneTextWithZones!(style: ##java.time.format.TextStyle, preferredZones: ##java.util.Set, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) =
        import java.time.format.DateTimeFormatterBuilder.appendGenericZoneText(##java.time.format.TextStyle, ##java.util.Set): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendGenericZoneText(b1, style, preferredZones) |> DateTimeFormatterBuilder


    pub def appendInstant!(b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendInstant(): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendInstant(b1) |> DateTimeFormatterBuilder

    pub def appendInstantWithFractionalDigits!(fractionalDigits: Int32, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendInstant(Int32): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendInstant(b1, fractionalDigits) |> DateTimeFormatterBuilder

    pub def appendLiteralChar!(ch: Char, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendLiteral(Char): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendLiteral(b1, ch) |> DateTimeFormatterBuilder

    pub def appendLiteralString!(s: String, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendLiteral(String): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendLiteral(b1, s) |> DateTimeFormatterBuilder

    pub def appendLocalized!(timeStyle: {timeStyle = ##java.time.format.FormatStyle}, 
                                dateStyle: {dateStyle = ##java.time.format.FormatStyle}, 
                                b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendLocalized(##java.time.format.FormatStyle, ##java.time.format.FormatStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendLocalized(b1, timeStyle.timeStyle, dateStyle.dateStyle) |> DateTimeFormatterBuilder

    pub def appendLocalizedOffset!(style: ##java.time.format.TextStyle, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendLocalizedOffset(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendLocalizedOffset(b1, style) |> DateTimeFormatterBuilder


    pub def appendOffset!(pattern: {pattern = String}, 
                            noOffsetText: {noOffsetText = String}, 
                            b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendOffset(String, String): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendOffset(b1, pattern.pattern, noOffsetText.noOffsetText) |> DateTimeFormatterBuilder

    pub def appendOffsetId!(b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendOffsetId(): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendOffsetId(b1) |> DateTimeFormatterBuilder

    pub def appendOptional!(fmt: ##java.time.format.DateTimeFormatter, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendOptional(##java.time.format.DateTimeFormatter): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendOptional(b1, fmt) |> DateTimeFormatterBuilder

    pub def appendPattern!(patt: String, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendPattern(String): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendPattern(b1, patt) |> DateTimeFormatterBuilder

    pub def appendZoneId!(b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneId(): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendZoneId(b1) |> DateTimeFormatterBuilder

    pub def appendZoneOrOffsetId!(b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneOrOffsetId(): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendZoneOrOffsetId(b1) |> DateTimeFormatterBuilder

    pub def appendZoneRegionId!(b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneRegionId(): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendZoneRegionId(b1) |> DateTimeFormatterBuilder

    pub def appendZoneText!(style: ##java.time.format.TextStyle, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneText(##java.time.format.TextStyle): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendZoneText(b1, style) |> DateTimeFormatterBuilder

    pub def appendZoneTextWithZones!(style: ##java.time.format.TextStyle, preferredZones: ##java.util.Set, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.appendZoneText(##java.time.format.TextStyle, ##java.util.Set): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        appendZoneText(b1, style, preferredZones) |> DateTimeFormatterBuilder


    pub def optionalStart!(b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.optionalStart(): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        optionalStart(b1) |> DateTimeFormatterBuilder

    pub def optionalEnd!(b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.optionalEnd(): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        optionalEnd(b1) |> DateTimeFormatterBuilder


    pub def padNext!(n: Int32, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.padNext(Int32): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        padNext(b1, n) |> DateTimeFormatterBuilder

    pub def padNextWithChar!(n: Int32, ch: Char, b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.padNext(Int32, Char): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        padNext(b1, n, ch) |> DateTimeFormatterBuilder


    pub def parseCaseSensitive!(b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.parseCaseSensitive(): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        parseCaseSensitive(b1) |> DateTimeFormatterBuilder

    pub def parseCaseInsensitive!(b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.parseCaseInsensitive(): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        parseCaseInsensitive(b1) |> DateTimeFormatterBuilder

    pub def parseStrict!(b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.parseStrict(): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        parseStrict(b1) |> DateTimeFormatterBuilder

    pub def parseLenient!(b: DateTimeFormatterBuilder[r]): DateTimeFormatterBuilder[r] \ Write(r) = 
        import java.time.format.DateTimeFormatterBuilder.parseLenient(): ##java.time.format.DateTimeFormatterBuilder \ r;
        let DateTimeFormatterBuilder(b1) = b;
        parseLenient(b1) |> DateTimeFormatterBuilder


}
