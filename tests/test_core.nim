##
## Tests core functionality of nuid.nim
## 
## (c) 2020 Erik Howard <erikhoward@pm.me>
##
import sets, unittest

import nuid

suite "Nuid Module Tests":

  test "newNUID() creates a well-formed Nuid object":
    var n = newNUID()

    check n.seq > 0
    check n.inc > 0
    check n.pre.len == PREFIX_LEN

  test "multiple instances of Nuid have different init values":
    var
      n1 = newNUID()
      n2 = newNUID()

    check n1.seq != n2.seq
    check n1.inc != n2.inc
    check n1.pre != n2.pre
    
  test "next() creates unique values":
    var
      n = newNUID()
      h: HashSet[string]

    for i in 1..100_000:
      h.incl(n.next())

    check len(h) == 100_000

  test "next() creates unique values between instances":
    var
      n1 = newNUID()
      n2 = newNUID()

      s1: HashSet[string]
      s2: HashSet[string]

    for i in 1..100_000:
      s1.incl(n1.next())
      s2.incl(n2.next())

    #var c = intersection(s1, s2)
    check len(intersection(s1, s2)) == 0
