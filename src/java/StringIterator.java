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

// Add this to your Flix sandbox with the path:
// main/src/flix/runtime/spt/newtime

// Used by Time/ZoneId

package flix.runtime.spt.newtime;

import java.time.ZoneId;
import java.util.Iterator;
import java.util.Set;

public class StringIterator {

    private Iterator<String> iter;

    protected StringIterator(Iterator<String> iter1) { this.iter = iter1; }

    public static StringIterator newGetAvailableZoneIdsIterator() throws Exception {
        Set<String> zoneIds = ZoneId.getAvailableZoneIds();
        return new StringIterator(zoneIds.iterator());
    }

    public boolean hasNext() {
        return this.iter.hasNext();
    }

    public String next() { return this.iter.next(); }

}
