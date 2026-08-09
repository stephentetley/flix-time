/*
 * Copyright 2025 Stephen Tetley
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

pub mod InteropTime.Internal.AdaptorExtras {

    import java.lang.{Exception => JException}
    import java.util.{Iterator => JIterator}
    import java.util.{List => JList}

    pub def op(x: a, f: ToJava.Out[a] -> ToFlix.In[ans] \ ef + ToJava.Aef[a] + ToFlix.Aef[ans]): ans \ ef + ToJava.Aef[a] + ToFlix.Aef[ans] with ToJava[a], ToFlix[ans] =
        let jx = ToJava.toJava(x);
        let ans = f(jx);
        ToFlix.toFlix(ans)

    pub def opWithResult(x: a, f: ToJava.Out[a] -> ToFlix.In[ans] \ ef + ToJava.Aef[a] + ToFlix.Aef[ans]): Result[String, ans] \ ef + ToJava.Aef[a] + ToFlix.Aef[ans] with ToJava[a], ToFlix[ans] = 
        try {
            let jx = ToJava.toJava(x);
            let ans = f(jx);
            Ok(ToFlix.toFlix(ans))
        } catch {
            case ex: JException => Err(ex.getMessage())
        }

    pub def op2(x: a, 
                y: b, 
                f: ToJava.Out[a] -> ToJava.Out[b] -> ToFlix.In[ans] \ ef + ToJava.Aef[a] + ToJava.Aef[b] + ToFlix.Aef[ans]): ans \ ef + ToJava.Aef[a] + ToJava.Aef[b] + ToFlix.Aef[ans] with ToJava[a], ToJava[b], ToFlix[ans] =
        let jx = ToJava.toJava(x);
        let jy = ToJava.toJava(y);
        let ans = f(jx, jy);
        ToFlix.toFlix(ans)
    
    pub def op3(x: a, 
                y: b, 
                z: c, 
                f: ToJava.Out[a] -> ToJava.Out[b] -> ToJava.Out[c] -> ToFlix.In[ans] \ ef + ToJava.Aef[a] + ToJava.Aef[b] + ToJava.Aef[c] + ToFlix.Aef[ans]): ans \ ef + ToJava.Aef[a] + ToJava.Aef[b] + ToJava.Aef[c] + ToFlix.Aef[ans] with ToJava[a], ToJava[b], ToJava[c], ToFlix[ans] =
        let jx = ToJava.toJava(x);
        let jy = ToJava.toJava(y);
        let jz = ToJava.toJava(z);
        let ans = f(jx, jy, jz);
        ToFlix.toFlix(ans)


    pub def of(f: Unit -> ToFlix.In[ans] \ ef + ToFlix.Aef[ans]): ans \ ef + ToFlix.Aef[ans] with ToFlix[ans] =
        let ans = f();
        ToFlix.toFlix(ans)

    pub def ofWithResult(f: Unit -> ToFlix.In[ans] \ ef + ToFlix.Aef[ans]): Result[String, ans] \ ef + ToFlix.Aef[ans] with ToFlix[ans] =
        try {
            let ans = f();
            Ok(ToFlix.toFlix(ans))
        } catch {
            case ex: JException => Err(ex.getMessage())
        }

    // No need for higher arity versions of `of` (obviously)

    pub def extract(x: a, f: ToJava.Out[a] -> ans \ ef + ToJava.Aef[a]): ans \ ef + ToJava.Aef[a] with ToJava[a] =
        let jx = ToJava.toJava(x);
        f(jx)

    pub def extractWithResult(x: a, f: ToJava.Out[a] -> b \ ef + ToJava.Aef[a]): Result[String, b] \ ef + ToJava.Aef[a] with ToJava[a] =
        try {
            let jx = ToJava.toJava(x);
            Ok(f(jx))
        } catch {
            case ex: JException => Err(ex.getMessage())
        }

    pub def extract2(x: a, y: b, f: ToJava.Out[a] -> ToJava.Out[b] -> ans \ ef + ToJava.Aef[a] + ToJava.Aef[b]): ans \ ef + ToJava.Aef[a] + ToJava.Aef[b] with ToJava[a], ToJava[b] =
        let jx = ToJava.toJava(x);
        let jy = ToJava.toJava(y);
        f(jx, jy)

    pub def extract3(x: a, y: b, z: c, f: ToJava.Out[a] -> ToJava.Out[b] -> ToJava.Out[c] -> ans \ ef + ToJava.Aef[a] + ToJava.Aef[b] + ToJava.Aef[c]): ans \ ef + ToJava.Aef[a] + ToJava.Aef[b] + ToJava.Aef[c] with ToJava[a], ToJava[b], ToJava[c] =
        let jx = ToJava.toJava(x);
        let jy = ToJava.toJava(y);
        let jz = ToJava.toJava(z);
        f(jx, jy, jz)


    ///
    /// Returns all elements in the given Java List as a Flix List converting each element wit `ToFlix.toFlix`.
    ///
    pub def fromListOf(l: JList[ToFlix.In[a]]): List[a] \ ToFlix.Aef[a] with ToFlix[a] = region rc {
        let iter1 = Adaptor.fromListToIterator(rc, l);
        Iterator.map(ToFlix.toFlix, iter1) |> Iterator.toList
    }

    pub def fromListWith(l: JList[a], f: a -> b \ ef): List[b] \ ef = region rc {
        let iter1 = Adaptor.fromListToIterator(rc, l);
        Iterator.map(f, iter1) |> Iterator.toList
    }


}
