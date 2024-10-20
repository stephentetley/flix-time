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


    pub eff DateTimeFormatterBuilder {
        pub def currentDateTimeFormatterBuilder(): JDateTimeFormatterBuilder
        pub def fail(msg: String): Void
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
    import java.time.format.{DateTimeFormatter => JDateTimeFormatter}
    import java.util.{Set => JSet}

    def runHelper(build: Unit -> a \ DateTimeFormatterBuilder + ef, 
                    builderToFormatter: JDateTimeFormatterBuilder -> JDateTimeFormatter): Result[String, DateTimeFormatter[t]] \ ef =
        let builder = unsafe new JDateTimeFormatterBuilder();
        let ans = try {
            Ok(build())
        } with DateTimeFormatterBuilder {
            def currentDateTimeFormatterBuilder(k) = {
                k(builder)
            }
            def fail(msg, _k) = {
                checked_ecast(Err(msg))
            }
        };
        match ans {
            case Ok(_)    => Ok(DateTimeFormatter(builderToFormatter(builder)))
            case Err(msg) => Err(msg)
        }

    pub def run(build: Unit -> a \ DateTimeFormatterBuilder + ef): Result[String, DateTimeFormatter[t]] \ ef =
        runHelper(build, builder -> unsafe builder.toFormatter())

    pub def toFormatterWithLocale(loc: Locale, build: Unit -> a \ DateTimeFormatterBuilder + ef): Result[String, DateTimeFormatter[t]] \ ef = 
        let Locale(loc1) = loc;
        runHelper(build, builder -> unsafe builder.toFormatter(loc1))

    // // TODO: some builder functions are probably locale sensitive if so they should be in IO...

    pub def append(fmt: DateTimeFormatter[t]): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let DateTimeFormatter(fmt1) = fmt;
        let _ = unsafe builder.append(fmt1);
        ()



    pub def appendChronologyId(): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.appendChronologyId();
        ()


    pub def appendChronologyText(style: TextStyle): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let _ = unsafe builder.appendChronologyText(style1);
        ()

    // Java 16

    pub def appendDayPeriodText(style: TextStyle): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let _ = unsafe builder.appendDayPeriodText(style1);
        ()


    pub def appendGenericZoneText(style: TextStyle): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let _ = unsafe builder.appendGenericZoneText(style1);
        ()

    // TODO use wrapped types
    pub def appendGenericZoneTextWithZones(style:TextStyle, preferredZones: JSet): Unit \ DateTimeFormatterBuilder =
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let _ = unsafe builder.appendGenericZoneText(style1, preferredZones);
        ()

    pub def appendInstant(): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.appendInstant();
        ()

    pub def appendInstantWithFractionalDigits(fractionalDigits: Int32): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.appendInstant(fractionalDigits);
        ()

    pub def appendLiteralChar(ch: Char): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.appendLiteral(ch);
        ()

    pub def appendLiteralString(s: String): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.appendLiteral(s);
        ()

    pub def appendLocalized(timeStyle: {timeStyle = FormatStyle}, 
                                dateStyle: {dateStyle = FormatStyle}): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let timeStyle1 = Time.Format.FormatStyle.marshalFormatStyle(timeStyle#timeStyle);
        let dateStyle1 = Time.Format.FormatStyle.marshalFormatStyle(dateStyle#dateStyle);
        let _ = unsafe builder.appendLocalized(timeStyle1, dateStyle1);
        ()

    pub def appendLocalizedOffset(style: TextStyle): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let _ = unsafe builder.appendLocalizedOffset(style1);
        ()


    pub def appendOffset(pattern: {pattern = String}, 
                            noOffsetText: {noOffsetText = String}): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.appendOffset(pattern#pattern, noOffsetText#noOffsetText);
        ()


    pub def appendOffsetId(): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.appendOffsetId();
        ()

    pub def appendOptional(fmt: DateTimeFormatter[t]): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder(); 
        let DateTimeFormatter(fmt1) = fmt;
        let _ = unsafe builder.appendOptional(fmt1);
        ()

    pub def appendPattern(patt: String): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.appendPattern(patt);
        ()

    pub def appendZoneId(): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.appendZoneId();
        ()


    pub def appendZoneOrOffsetId(): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.appendZoneOrOffsetId();
        ()

    pub def appendZoneRegionId(): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.appendZoneRegionId();
        ()

    pub def appendZoneText(style: TextStyle): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let _ = unsafe builder.appendZoneText(style1);
        ()

    // TODO use wrapped types
    pub def appendZoneTextWithZones(style: TextStyle, preferredZones: JSet): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let _ = unsafe builder.appendZoneText(style1, preferredZones);
        ()

    pub def optionalStart(): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.optionalStart();
        ()

    pub def optionalEnd(): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.optionalEnd();
        ()


    pub def padNext(n: Int32): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.padNext(n);
        ()

    pub def padNextWithChar(n: Int32, ch: Char): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.padNext(n, ch);
        ()

    pub def parseCaseSensitive(): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.parseCaseSensitive();
        ()

    pub def parseCaseInsensitive(): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.parseCaseInsensitive();
        ()

    pub def parseStrict(): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.parseStrict();
        ()

    pub def parseLenient(): Unit \ DateTimeFormatterBuilder = 
        let builder = Time.Format.DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
        let _ = unsafe builder.parseLenient();
        ()

}

