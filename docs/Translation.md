# Functions
>### download ( language, f )
>| Parameter | Type | Required | Description |
>| :-: | :-: | :-: | - |
>| language | `enum.language` | ✔ | An enum from [language](Enum.md#language-string). (index or value) <sub>(default = en)</sub> |
>| f | `function` | ✕ | A function to be executed when the language is downloaded. |
>
>Downloads a Transformice language file.
>
>**Returns:**
>
>| Type | Description |
>| :-: | - |
>| `boolean`, `nil` | Whether the language has been downloaded. |
---
>### free ( language, whitelist, whitelistPattern )
>| Parameter | Type | Required | Description |
>| :-: | :-: | :-: | - |
>| language | `enum.language` | ✔ | An enum from [language](Enum.md#language-string) that was downloaded before with [download](#download--language-). |
>| whitelist | `table` | ✕ | A set ([index]=true) of indexes that must not be deleted. |
>| whitelistPattern | `string` | ✕ | A pattern to match various indexes at once, these indexes won't be deleted. |
>
>Deletes translation lines that are not going to be used. (Save process)<br>
>If the whitelist parameters are not set, it will delete the whole translation data.
>
>**Returns:**
>
>| Type | Description |
>| :-: | - |
>| `boolean`, `nil` | Whether the given data got deleted successfully. |
---
>### get ( language, index, raw )
>| Parameter | Type | Required | Description |
>| :-: | :-: | :-: | - |
>| language | `enum.language` | ✔ | An enum from [language](Enum.md#language-string) that was downloaded before with [download](#download--language-). |
>| index | `string` | ✕ | The code of the translation line. |
>| raw | `boolean` | ✕ | Whether the translation line must be sent in raw mode or filtered. <sub>(default = false)</sub> |
>
>Gets a translation line.
>
>**Returns:**
>
>| Type | Description |
>| :-: | - |
>| `string`, `table` | The translation line. If @index is nil, then it's the translation table (index = value). If @index exists, it may be the string, or @raw string, or a table if it has gender differences ({ male, female }). It may not exist. |
>| `boolean`, `nil` | If not @raw, the value is a boolean true if return #1 is table. |
---
>### set ( language, setPattern, f, isPlain )
>| Parameter | Type | Required | Description |
>| :-: | :-: | :-: | - |
>| language | `enum.language` | ✔ | An enum from [language](Enum.md#language-string) that was downloaded before with [download](#download--language-). |
>| setPattern | `string` | ✔ | The pattern to match all translation line codes that will be edited. |
>| f | `function` | ✔ | The function to be executed over the current translation line. Receives (value, code). |
>| isPlain | `boolean` | ✕ | Whether the pattern is plain (no pattern) or not. <sub>(default = false)</sub> |
>
>Hard-set the value of translation codes.
>
>**Returns:**
>
>| Type | Description |
>| :-: | - |
>| `boolean`, `nil` | Whether the given daata was set successfully. |