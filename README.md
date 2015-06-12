# sVPO

[![Build Status](https://travis-ci.org/unlucio/svpo.svg?branch=master)](https://travis-ci.org/unlucio/svpo)

#### Value/path helper library for NSDictionaries in swift

sVpo is a swift porting of [vpo](https://github.com/unlucio/vpo). It's a set of simple functions that let you query your NDSdictionary content using dot notation expressed paths.

## How to get it:

Either:

```
git clone git://github.com/unlucio/svpo.git
```

Open the cloned folder, and simply drang 'n drop the xcode project in yours, setting up the sVpo.framework under "Builds Phases" -> "Link Binary Libraries" in your target.

## Examples:

Given the following dummy object:

```swift
var baseObj: NSDictionary = [
  "key1": [
    "foo1": [
      "bar1": "bao",
      "bar2": "bao"
    ],
    "foo2": [
      "bar2": "bao"
    ],
    "foo3": [
      "bar3": "bao"
    ]
  ],
  "key2": [
    "foo1": [
      "bar1": "bao",
      "bar2": "bao"
    ],
    "foo2": [
      "bar2": "bao"
    ],
    "foo3": [
      "bar3": "bao"
    ]
  ]
]
```

Create a new vpo object:

```swift
import sVpo

var vpo:sVpo = sVpo(dict: baseObj)
```

getting a value:

```swift
vpo.get('key1.foo2.bar2');
```

getting a value od a default value:

```swift
vpo.get('key1.foo2.bar2', faultback: "Default");
```

getting a value from a list of possible paths:

```swift
vpo.some(['ke5.foo2.bar2', 'key1.foo2.bar2']);
```

getting a value from a list of possible paths:

```swift
vpo.some(['ke5.foo2.bar2', 'key1.foo2.bar2'], faultback: "Default");
```

