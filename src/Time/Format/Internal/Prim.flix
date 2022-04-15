/*
 * Copyright 2021 Stephen Tetley
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


namespace Time/Format/Internal/Prim {

    use FlixSandbox/I18n.Locale;
    use FlixSandbox/I18n.Locale.{Locale};
    use Time/Format.DecimalStyle;
    use Time/Format.DecimalStyle.{DecimalStyle};
    use Time/Format.ResolverStyle;

    /// Should this be called `new`?
    pub def ofPattern(pattern: String): Option[##java.time.format.DateTimeFormatter] =
        import java.lang.String.strip(): String & Pure;
        import static java.time.format.DateTimeFormatter.ofPattern(String): ##java.time.format.DateTimeFormatter & Pure;
        try {
            Some(ofPattern(strip(pattern)))
        } catch {
            case _: ##java.lang.IllegalArgumentException => None
        }

    
    pub def getLocale(x: ##java.time.format.DateTimeFormatter): Locale =
        import java.time.format.DateTimeFormatter.getLocale(): ##java.util.Locale & Pure;
        Locale(getLocale(x))

    pub def withLocale(x: ##java.time.format.DateTimeFormatter, locale: Locale): ##java.time.format.DateTimeFormatter =
        import java.time.format.DateTimeFormatter.withLocale(##java.util.Locale): ##java.time.format.DateTimeFormatter & Pure;
        let Locale(locale1) = locale;
        withLocale(x, locale1)

    pub def getDecimalStyle(x: ##java.time.format.DateTimeFormatter): DecimalStyle =
        import java.time.format.DateTimeFormatter.getDecimalStyle(): ##java.time.format.DecimalStyle & Pure;
        DecimalStyle(getDecimalStyle(x))

    pub def withDecimalStyle(x: ##java.time.format.DateTimeFormatter, style: DecimalStyle):  ##java.time.format.DateTimeFormatter =
        import java.time.format.DateTimeFormatter.withDecimalStyle(##java.time.format.DecimalStyle): ##java.time.format.DateTimeFormatter & Pure;
        let DecimalStyle(style1) = style;
        withDecimalStyle(x, style1)

    pub def getResolverStyle(x: ##java.time.format.DateTimeFormatter): ResolverStyle =
        import java.time.format.DateTimeFormatter.getResolverStyle(): ##java.time.format.ResolverStyle & Pure;
        Time/Format/ResolverStyle.fromNative(getResolverStyle(x))

}
