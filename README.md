# hexterm.lua

Get the xterm closest color to a hexadecimal color

## Installation

```bash
luarocks install hexterm
```

## Usage

```lua
local hexterm = require('hexterm')

hexterm('#ffffff') -- 15
hexterm("ffaa33") -- 215
```
