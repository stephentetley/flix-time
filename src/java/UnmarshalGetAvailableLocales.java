package flix.runtime.library.time;

import java.time.ZoneId;
import java.util.Iterator;
import java.util.Set;

public class UnmarshalGetAvailableLocales {

    private Iterator<String> iter;

    public UnmarshalGetAvailableLocales() throws Exception {
        Set<String> zoneIds = ZoneId.getAvailableZoneIds();
        this.iter = zoneIds.iterator();
    }

    public boolean hasNext() {
        return this.iter.hasNext();
    }

    public String next() { return this.iter.next(); }

}
