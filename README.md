# tia-autohotkeys
Autohotkey collection for the TIA Engineering Portal
This Autohotkey project is intended to help maximize speed and efficiency of development in the TIA Portal environment through inserting and wrapping code into snippets mostly used in SCL programming language. This is mostly intended to expand functionality that is mostly available in other GUI code editors, which strangely enough has not been included in TIA Portal yet.


## To use this ahk file, you obviously need Autohotkey, which can be downloaded [here](https://www.autohotkey.com/)
If you don't know how Autohotkey works, go read the documentation [here](https://www.autohotkey.com/docs/AutoHotkey.htm)


## Following functions are actually included in this project:

* Wrap selected code around a REGION by pressing SHIFT+WIN+R:

![](https://github.com/short-circuit/tia-autohotkeys/blob/master/gif/region.gif)

* Wrap selected code around a IF by pressing SHIFT+WIN+I:

![](https://github.com/short-circuit/tia-autohotkeys/blob/master/gif/if.gif)

* Wrap selected code around a CASE by pressing SHIFT+WIN+C:

![](https://github.com/short-circuit/tia-autohotkeys/blob/master/gif/case.gif)

* Wrap selected code around a FOR by pressing SHIFT+WIN+F: 

![](https://github.com/short-circuit/tia-autohotkeys/blob/master/gif/for.gif)

* Wrap selected code around a WHILE by pressing SHIFT+WIN+W: 

![](https://github.com/short-circuit/tia-autohotkeys/blob/master/gif/while.gif)

* Wrap selected code around a REPEAT by pressing SHIFT+WIN+Q: 

![](https://github.com/short-circuit/tia-autohotkeys/blob/master/gif/repeat.gif)

* Comment and uncomment selected code by pressing SHIFT+WIN+M:

![](https://github.com/short-circuit/tia-autohotkeys/blob/master/gif/comment.gif)

* Invert selected assignment row by pressing SHIFT+WIN+-: 

![](https://github.com/short-circuit/tia-autohotkeys/blob/master/gif/invert.gif)

* Wrap selected code in parenthesis by pressing SHIFT+WIN+9

* Close current Tab with WIN+W
* Format SCL code with CTRL+SHIFT+F
* Comment/Uncomment SCL line with CTRL+/


### This project helps you bootstrap your own code wrapping functionalities, since it includes a function that generally works with any kind of Text passed to its parameters.

```ahk
WrapClipText(Left, Right)
```

Just replace the Left and Right parameters with your desired text as a new hotkey entry at the bottom of the file, inside the WinActive condition, like so:

```ahk
#+HOTKEY::WrapClipText("YOURTEXTLEFT", "YOURTEXTRIGHT")
```
