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
    import java.util.{List => JList}

    pub enum LeftFold[ac: Type, jx: Type, a: Type, b: Type, ef1: Eff, ef2: Eff, ef3: Eff] {
        case LeftFold(jx -> a \ ef1, ac -> a -> ac \ ef2, ac, ac -> b \ ef3)
    }


    pub def leftFold(lf: LeftFold[ac, jx, a, b, ef1, ef2, ef3], 
                        xs: t[jx]): b \ ef1 + ef2 + ef3 = 
        let LeftFold.LeftFold(convert1, step, start, final) = lf;
        let xs1: JIterable[jx] = unchecked_cast(xs as JIterable[jx]);
        let jiter: JIterator[jx] = unsafe IO as { ef1 + ef2} { xs1.iterator() };
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


    pub def toList(xs: t[x],
                    convert: x -> a \ ef1): List[a] \ ef1 = 
        let lf = LeftFold.LeftFold(convert, (f, x) -> (ks -> List.cons(x, ks)) >> f, ks -> ks, ks -> ks(Nil));
        leftFold(lf, xs)

    pub def toset(xs: t[x],
                    convert: x -> a \ ef1): Set[a] \ ef1 with Order[a]= 
        let lf = LeftFold.LeftFold(convert, (ac, x) -> Set.insert(x, ac), Set.empty(), identity);
        leftFold(lf, xs)


}

