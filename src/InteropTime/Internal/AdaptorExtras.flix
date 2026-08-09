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
// Do not use outside of `InteropTime`

pub mod InteropTime.Internal.AdaptorExtras {

    pub def op(x: a, f: ToJava.Out[a] -> ToFlix.In[b] \ ef + ToJava.Aef[a] + ToFlix.Aef[b]): b \ ef + ToJava.Aef[a] + ToFlix.Aef[b] with ToJava[a], ToFlix[b] =
        let jx = ToJava.toJava(x);
        let ans = f(jx);
        ToFlix.toFlix(ans)

    pub def of(f: Unit -> ToFlix.In[a] \ ef + ToFlix.Aef[a]): a \ ef + ToFlix.Aef[a] with ToFlix[a] =
        let ans = f();
        ToFlix.toFlix(ans)

    pub def extract(x: a, f: ToJava.Out[a] -> b \ ef + ToJava.Aef[a]): b \ ef + ToJava.Aef[a] with ToJava[a] =
        let jx = ToJava.toJava(x);
        f(jx)

}
