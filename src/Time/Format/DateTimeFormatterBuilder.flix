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

    import java.time.format.{DateTimeFormatterBuilder => JDateTimeFormatterBuilder}

    pub struct DateTimeFormatterBuilder[r: Region]{
        builder: JDateTimeFormatterBuilder
    }
}


mod Time.Format.DateTimeFormatterBuilder {

    use Locale.{Locale}

    use Time.Format.DateTimeFormatterBuilder
    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.Format.FormatStyle
    use Time.Format.TextStyle

    import java.time.format.{DateTimeFormatterBuilder => JDateTimeFormatterBuilder}

    pub def newDateTimeFormatterBuilder(rc: Region[r]): DateTimeFormatterBuilder[r] \ r =
        let builder1 = unsafe new JDateTimeFormatterBuilder();
        new DateTimeFormatterBuilder @ rc { builder = builder1 }

    pub def toFormatter(builder: DateTimeFormatterBuilder[r]): DateTimeFormatter[t] \ r = 
        let builder1 = builder->builder;
        let ans = unsafe builder1.toFormatter();
        DateTimeFormatter(ans)

    pub def toFormatterWithLocale(loc: Locale, builder: DateTimeFormatterBuilder[r]): DateTimeFormatter[t] \ r = 
        let builder1 = builder->builder;
        let Locale(loc1) = loc;
        let ans = unsafe builder1.toFormatter(loc1);
        DateTimeFormatter(ans)

    // TODO: some builder functions are probably locale sensitive if so they should be in IO...

    pub def append(fmt: DateTimeFormatter[t], builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let DateTimeFormatter(fmt1) = fmt;
        let _ = unsafe builder1.append(fmt1);
        ()



    pub def appendChronologyId(builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.appendChronologyId();
        ()


    pub def appendChronologyText(style: TextStyle, builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let _ = unsafe builder1.appendChronologyText(style1);
        ()

    // Java 16

    pub def appendDayPeriodText(style: TextStyle, builder: DateTimeFormatterBuilder[r]): Unit \ r  = 
        let builder1 = builder->builder;
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let _ = unsafe builder1.appendDayPeriodText(style1);
        ()


    pub def appendGenericZoneText(style: TextStyle, builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let _ = unsafe builder1.appendGenericZoneText(style1);
        ()

    // pub def appendGenericZoneTextWithZones(style: ##java.time.format.TextStyle, preferredZones: ##java.util.Set, builder: DateTimeFormatterBuilder[r]): Unit \ r \ r =
    //     import java.time.format.DateTimeFormatterBuilder.appendGenericZoneText(##java.time.format.TextStyle, ##java.util.Set): ##java.time.format.DateTimeFormatterBuilder \ r;
    //     let DateTimeFormatterBuilder(b1) = b;
    //     appendGenericZoneText(b1, style, preferredZones) |> DateTimeFormatterBuilder


    pub def appendInstant(builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.appendInstant();
        ()

    pub def appendInstantWithFractionalDigits(fractionalDigits: Int32, builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.appendInstant(fractionalDigits);
        ()

    pub def appendLiteralChar(ch: Char, builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.appendLiteral(ch);
        ()

    pub def appendLiteralString(s: String, builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.appendLiteral(s);
        ()

    pub def appendLocalized(timeStyle: {timeStyle = FormatStyle}, 
                                dateStyle: {dateStyle = FormatStyle}, 
                                builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let timeStyle1 = Time.Format.FormatStyle.marshalFormatStyle(timeStyle#timeStyle);
        let dateStyle1 = Time.Format.FormatStyle.marshalFormatStyle(dateStyle#dateStyle);
        let _ = unsafe builder1.appendLocalized(timeStyle1, dateStyle1);
        ()

    pub def appendLocalizedOffset(style: TextStyle, builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let _ = unsafe builder1.appendLocalizedOffset(style1);
        ()


    pub def appendOffset(pattern: {pattern = String}, 
                            noOffsetText: {noOffsetText = String}, 
                            builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.appendOffset(pattern#pattern, noOffsetText#noOffsetText);
        ()


    pub def appendOffsetId(builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.appendOffsetId();
        ()

    pub def appendOptional(fmt: DateTimeFormatter[t], builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder; 
        let DateTimeFormatter(fmt1) = fmt;
        let _ = unsafe builder1.appendOptional(fmt1);
        ()

    pub def appendPattern(patt: String, builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.appendPattern(patt);
        ()

    pub def appendZoneId(builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.appendZoneId();
        ()


    pub def appendZoneOrOffsetId(builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.appendZoneOrOffsetId();
        ()

    pub def appendZoneRegionId(builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.appendZoneRegionId();
        ()

    pub def appendZoneText(style: TextStyle, builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let _ = unsafe builder1.appendZoneText(style1);
        ()


    // pub def appendZoneTextWithZones(style: ##java.time.format.TextStyle, preferredZones: ##java.util.Set, builder: DateTimeFormatterBuilder[r]): Unit \ r = 
    //     import java.time.format.DateTimeFormatterBuilder.appendZoneText(##java.time.format.TextStyle, ##java.util.Set): ##java.time.format.DateTimeFormatterBuilder \ r;
    //     let DateTimeFormatterBuilder(b1) = b;
    //     appendZoneText(b1, style, preferredZones) |> DateTimeFormatterBuilder


    pub def optionalStart(builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.optionalStart();
        ()

    pub def optionalEnd(builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.optionalEnd();
        ()


    pub def padNext(n: Int32, builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.padNext(n);
        ()

    pub def padNextWithChar(n: Int32, ch: Char, builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.padNext(n, ch);
        ()

    pub def parseCaseSensitive(builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.parseCaseSensitive();
        ()

    pub def parseCaseInsensitive(builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.parseCaseInsensitive();
        ()

    pub def parseStrict(builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.parseStrict();
        ()

    pub def parseLenient(builder: DateTimeFormatterBuilder[r]): Unit \ r = 
        let builder1 = builder->builder;
        let _ = unsafe builder1.parseLenient();
        ()

}

