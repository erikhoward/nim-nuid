# NUID

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A Nim implemenation of the [NATS](https://nats.io/) unique identifier generator.

## Installation
```
nimble install https://github.com/erikhoward/nim-nuid@#main
`````

## Example

`````
import nuid

when isMainModule:
  var n = newNUID()
  echo n.next()
`````

## License

MIT

