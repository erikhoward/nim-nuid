import
  math, random, random/urandom, strutils

const
  PREFIX_LEN* = 12
  SEQ_LEN* = 10
  MIN_INC = 33
  MAX_INC = 333
  MAX_SEQ = 839_299_365_868_340_224
  BASE = 62
  TOTAL_LEN* = PREFIX_LEN + SEQ_LEN
  DIGITS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

type
  Nuid* = ref object of RootObj
    seq*: int64
    inc*: int64
    pre*: array[PREFIX_LEN, char]

proc resetSequential(n: Nuid) =
  n.seq = rand(Natural)
  n.inc = MIN_INC + rand(MAX_INC - MIN_INC)

proc randomizePrefix(n: Nuid) = 
  var rndBuf = urandom(PREFIX_LEN)

  for i in 0..PREFIX_LEN - 1:
      n.pre[i] = DIGITS[int(rndBuf[i]) mod BASE]

proc newNUID*(): Nuid =
  ## Creates a new NUID
  
  randomize()
  var nuid = Nuid()

  nuid.seq = rand(Natural)
  nuid.inc = MIN_INC + rand(MAX_INC - MIN_INC)

  randomizePrefix(nuid)
  nuid

proc next*(n: Nuid): string =
  ## Gets the next nuid

  n.seq += n.inc
  if n.seq >= MAX_SEQ:
    n.randomizePrefix()
    n.resetSequential()

  var
    seq = n.seq
    prefix = n.pre
    b: array[TOTAL_LEN, char]

  for i, elem in n.pre:
    b[i] = elem

  for i in PREFIX_LEN..TOTAL_LEN-1:
    b[i] = DIGITS[seq mod BASE]
    seq = floorDiv(seq, BASE)

  join(b)
