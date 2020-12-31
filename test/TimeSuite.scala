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

package spt.newtime

import ca.uwaterloo.flix.util.{FlixTest, Options}
import org.scalatest.Suites

class TimeSuite extends Suites(
  new FlixTest("TestClock", "main/test/spt/newtime/TestClock.flix")(Options.TestWithLibrary),
  new FlixTest("TestDayOfWeek", "main/test/spt/newtime/TestDayOfWeek.flix")(Options.TestWithLibrary),
  new FlixTest("TestDuration", "main/test/spt/newtime/TestDuration.flix")(Options.TestWithLibrary),
  new FlixTest("TestInstant", "main/test/spt/newtime/TestInstant.flix")(Options.TestWithLibrary),
  new FlixTest("TestMonthDay", "main/test/spt/newtime/TestMonthDay.flix")(Options.TestWithLibrary),
  new FlixTest("TestTemporalIsoUnit", "main/test/spt/newtime/TestTemporalIsoUnit.flix")(Options.TestWithLibrary),
  new FlixTest("TestYear", "main/test/spt/newtime/TestYear.flix")(Options.TestWithLibrary),
)
