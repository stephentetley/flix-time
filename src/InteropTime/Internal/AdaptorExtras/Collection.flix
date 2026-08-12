/*
 * Copyright 2026 Stephen Tetley
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


// This is a trial module. The functions here are experiments to see
// if the make writing Java invoking code significantly more succinct.
// Do not use outside of `InteropTime`.

pub mod InteropTime.Internal.AdaptorExtras.Collection {

    import java.util.{Iterator => JIterator}
    import java.lang.{Iterable => JIterable}
    import java.util.{Collection => JCollection}
    import java.util.{List => JList}
    import java.util.{ArrayList => JArrayList}
    import java.util.{Set => JSet}
    import java.util.{HashSet => JHashSet}
    import java.util.{Vector => JVector}
    import java.util.{Map => JMap}
    import java.util.{Map$Entry => JMapEntry}
    import java.util.{HashMap => JHashMap}
    import java.util.function.{BiConsumer => JBiConsumer}

    pub enum LeftFold[ac: Type, jx: Type, a: Type, b: Type, ef1: Eff, ef2: Eff, ef3: Eff] {
        case LeftFold(jx -> a \ ef1, ac -> a -> ac \ ef2, ac, ac -> b \ ef3)
    }


    pub def leftFold(lf: LeftFold[ac, jx, a, b, ef1, ef2, ef3], 
                        jiter: JIterator[jx]): b \ ef1 + ef2 + ef3 = 
        let LeftFold.LeftFold(convert1, step, start, final) = lf;
        @Tailrec
        def loop(ac) = {
            let more = unsafe IO as { ef1 + ef2 + ef3} { jiter.hasNext() };
            if (more) {
                let jx: jx = unsafe IO as { ef1 + ef2 + ef3 } { jiter.next() };
                let x = convert1(jx);
                let ac1 = step(ac, x);
                loop(ac1)
            } else final(ac)
        };
        loop(start)


    pub def toList(jiter: JIterator[jx],
                    convert: jx -> a \ ef1): List[a] \ ef1 = 
        let lf = LeftFold.LeftFold(convert, (f, x) -> (ks -> List.cons(x, ks)) >> f, ks -> ks, ks -> ks(Nil));
        leftFold(lf, jiter)

    pub def toSet(jiter: JIterator[jx],
                    convert: jx -> a \ ef1): Set[a] \ ef1 with Order[a]= 
        let lf = LeftFold.LeftFold(convert, (ac, x) -> Set.insert(x, ac), Set.empty(), identity);
        leftFold(lf, jiter)

    // // toMap can use entrySet()
    pub def toMap(mobj: JMap[kx, vx]    ,
                    convertKey: kx -> k \ ef1,
                    convertValue: vx -> v \ ef2): Map[k, v] \ ef1 + ef2 with Order[k] = 
        def convert(e: JMapEntry[kx, vx]): (k, v) \ ef1 + ef2 = {
            let kx: kx = e.getKey();
            let vx: vx = e.getValue();
            let k: k = convertKey(kx);
            let v: v = convertValue(vx);
            (k, v)
        };
        def step(ac, es) = match es {
            case (k, v) => Map.insert(k, v, ac)
        };
        let entryset: JSet[JMapEntry[kx, vx]] = unsafe IO { mobj.entrySet() };
        let oiter: JIterable[JMapEntry[kx, vx]] = unchecked_cast(entryset as JIterable[JMapEntry[kx, vx]]);
        let jiter: JIterator[JMapEntry[kx, vx]] = unsafe IO as { ef1 + ef2} { oiter.iterator() };
        let lf = LeftFold.LeftFold(convert, step, Map.empty(), identity);
        leftFold(lf, jiter)



    // toMutMap can use JMap.forEach because it can mutate the MutMap supplied by the closure
    pub def toMutMap(rc: Region[r],
                    mobj: JMap[kx, vx],
                    convertKey: kx -> k \ ef1,
                    convertValue: vx -> v \ ef2): MutMap[k, v, r] \ ef1 + ef2 + r with Order[k] = 
        let flixmap = MutMap.empty(rc);
        def action(): JBiConsumer[kx, vx] = { 
            new JBiConsumer[kx, vx] {
                def accept(_this: JBiConsumer[kx, vx], kx: kx, vx: vx): Unit \ r + ef1 + ef2 = 
                    let k = convertKey(kx);
                    let v = convertValue(vx);
                    MutMap.put(k, v, flixmap)
            }
        };
        unsafe IO as { ef1 + ef2 + r} { mobj.forEach(action())};
        flixmap

    // ToJava


    // via ArrayList
    pub def toJCollection(xs: t,
                    convert: Iterable.Elm[t] -> x \ ef): JCollection[x] \ ef + Iterable.Aef[t] with Iterable[t] = region rc {
        let flixiter = Iterable.iterator(rc, xs);
        let jlist: JCollection[x] = checked_cast(unsafe IO { new JArrayList() });
        Iterator.forEach(et -> { let x = convert(et); unsafe IO { discard jlist.add(x) }}, flixiter);
        jlist
    }


    // via ArrayList
    pub def toJList(xs: t,
                    convert: Iterable.Elm[t] -> x \ ef): JList[x] \ ef + Iterable.Aef[t] with Iterable[t] = region rc {
        let flixiter = Iterable.iterator(rc, xs);
        let jlist: JList[x] = checked_cast(unsafe IO { new JArrayList() });
        Iterator.forEach(et -> { let x = convert(et); unsafe IO { jlist.addLast(x) }}, flixiter);
        jlist
    }

    // via HashSet
    pub def toJSet(xs: t,
                    convert: Iterable.Elm[t] -> x \ ef): JSet[x] \ ef + Iterable.Aef[t] with Iterable[t] = region rc {
        let flixiter = Iterable.iterator(rc, xs);
        let jset:JSet[x] = checked_cast(unsafe IO { new JHashSet() });
        Iterator.forEach(et -> { let x = convert(et); discard unsafe IO { jset.add(x) }}, flixiter);
        jset
    }

    pub def toJVector(xs: t,
                      convert: Iterable.Elm[t] -> x \ ef): JVector[x] \ ef + Iterable.Aef[t] with Iterable[t] = region rc {
        let flixiter = Iterable.iterator(rc, xs);
        let jvec = unsafe IO { new JVector() };
        Iterator.forEach(et -> { let x = convert(et); discard unsafe IO { jvec.add(x) }}, flixiter);
        jvec
    }

    // via HashMap
    pub def toJMap(map: t,
                   convertKey: k -> kx \ ef1,
                   convertValue: v -> vx \ ef2): JMap[kx, vx] \ ef1 + ef2 + Iterable.Aef[t] with Iterable[t] where Iterable.Elm[t] ~ (k, v) = region rc {
        let flixiter = Iterable.iterator(rc, map);
        let jmap:JMap[kx, vx] = checked_cast(unsafe IO { new JHashMap() });
        Iterator.forEach(match (k, v) -> { let kx = convertKey(k); let vx = convertValue(v); discard unsafe IO { jmap.put(kx, vx) }}, flixiter);
        jmap
    }


}

