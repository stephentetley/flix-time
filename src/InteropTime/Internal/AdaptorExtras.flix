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

pub mod InteropTime.Internal.AdaptorExtras {

    import java.lang.{Exception => JException}

    pub def op(x: a, f: ToJava.Out[a] -> ToFlix.In[ans] \ ef + ToJava.Aef[a] + ToFlix.Aef[ans]): ans \ ef + ToJava.Aef[a] + ToFlix.Aef[ans] with ToJava[a], ToFlix[ans] =
        let x1 = ToJava.toJava(x);
        let ans = f(x1);
        ToFlix.toFlix(ans)

    pub def opWithResult(x: a, f: ToJava.Out[a] -> ToFlix.In[ans] \ ef + ToJava.Aef[a] + ToFlix.Aef[ans]): Result[String, ans] \ ef + ToJava.Aef[a] + ToFlix.Aef[ans] with ToJava[a], ToFlix[ans] = 
        try {
            let x1 = ToJava.toJava(x);
            let ans = f(x1);
            Ok(ToFlix.toFlix(ans))
        } catch {
            case ex: JException => Err(ex.getMessage())
        }

    pub def opWithOption(x: a, f: ToJava.Out[a] -> ToFlix.In[ans] \ ef + ToJava.Aef[a] + ToFlix.Aef[ans]): Option[ans] \ ef + ToJava.Aef[a] + ToFlix.Aef[ans] with ToJava[a], ToFlix[ans] = 
        try {
            let x1 = ToJava.toJava(x);
            let ans = f(x1);
            if (not Object.isNull(ans)) Some(ToFlix.toFlix(ans)) else None
        } catch {
            case _: JException => None
        }

    pub def op2(x: a, 
                y: b, 
                f: ToJava.Out[a] -> ToJava.Out[b] -> ToFlix.In[ans] \ ef + ToJava.Aef[a] + ToJava.Aef[b] + ToFlix.Aef[ans]): ans \ ef + ToJava.Aef[a] + ToJava.Aef[b] + ToFlix.Aef[ans] with ToJava[a], ToJava[b], ToFlix[ans] =
        let x1 = ToJava.toJava(x);
        let y1 = ToJava.toJava(y);
        let ans = f(x1, y1);
        ToFlix.toFlix(ans)
    
    pub def op3(x: a, 
                y: b, 
                z: c, 
                f: ToJava.Out[a] -> ToJava.Out[b] -> ToJava.Out[c] -> ToFlix.In[ans] \ ef + ToJava.Aef[a] + ToJava.Aef[b] + ToJava.Aef[c] + ToFlix.Aef[ans]): ans \ ef + ToJava.Aef[a] + ToJava.Aef[b] + ToJava.Aef[c] + ToFlix.Aef[ans] with ToJava[a], ToJava[b], ToJava[c], ToFlix[ans] =
        let x1 = ToJava.toJava(x);
        let y1 = ToJava.toJava(y);
        let z1 = ToJava.toJava(z);
        let ans = f(x1, y1, z1);
        ToFlix.toFlix(ans)


    pub def of(f: Unit -> ToFlix.In[ans] \ ef + ToFlix.Aef[ans]): ans \ ef + ToFlix.Aef[ans] with ToFlix[ans] =
        let ans = f();
        ToFlix.toFlix(ans)

    pub def ofWithResult(f: Unit -> ToFlix.In[ans] \ ef + ToFlix.Aef[ans]): Result[String, ans] \ ef + ToFlix.Aef[ans] with ToFlix[ans] =
        try {
            let ans = f();
            if (not Object.isNull(ans)) Ok(ToFlix.toFlix(ans)) else Err("ofWithResult-null")
        } catch {
            case ex: JException => Err(ex.getMessage())
        }

    pub def ofWithOption(f: Unit -> ToFlix.In[ans] \ ef + ToFlix.Aef[ans]): Option[ans] \ ef + ToFlix.Aef[ans] with ToFlix[ans] =
        try {
            let ans = f();
            if (not Object.isNull(ans)) Some(ToFlix.toFlix(ans)) else None
        } catch {
            case _: JException => None
        }

    // No need for higher arity versions of `of` (obviously)

    pub def extract(x: a, f: ToJava.Out[a] -> ans \ ef + ToJava.Aef[a]): ans \ ef + ToJava.Aef[a] with ToJava[a] =
        let x1 = ToJava.toJava(x);
        f(x1)

    pub def extractWithResult(x: a, f: ToJava.Out[a] -> b \ ef + ToJava.Aef[a]): Result[String, b] \ ef + ToJava.Aef[a] with ToJava[a] =
        try {
            let x1 = ToJava.toJava(x);
            Ok(f(x1))
        } catch {
            case ex: JException => Err(ex.getMessage())
        }

    pub def extractWithOption(x: a, f: ToJava.Out[a] -> b \ ef + ToJava.Aef[a]): Option[b] \ ef + ToJava.Aef[a] with ToJava[a] =
        try {
            let x1 = ToJava.toJava(x);
            Some(f(x1))
        } catch {
            case _: JException => None
        }

    pub def extract2(x: a, y: b, f: ToJava.Out[a] -> ToJava.Out[b] -> ans \ ef + ToJava.Aef[a] + ToJava.Aef[b]): ans \ ef + ToJava.Aef[a] + ToJava.Aef[b] with ToJava[a], ToJava[b] =
        let x1 = ToJava.toJava(x);
        let y1 = ToJava.toJava(y);
        f(x1, y1)

    pub def extract3(x: a, y: b, z: c, f: ToJava.Out[a] -> ToJava.Out[b] -> ToJava.Out[c] -> ans \ ef + ToJava.Aef[a] + ToJava.Aef[b] + ToJava.Aef[c]): ans \ ef + ToJava.Aef[a] + ToJava.Aef[b] + ToJava.Aef[c] with ToJava[a], ToJava[b], ToJava[c] =
        let x1 = ToJava.toJava(x);
        let y1 = ToJava.toJava(y);
        let z1 = ToJava.toJava(z);
        f(x1, y1, z1)


}

