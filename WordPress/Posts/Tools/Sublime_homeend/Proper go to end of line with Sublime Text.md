## Sublime Text 中的行首行末跳转问题
在 Sublime Text 中，在存在 word wrapping 的情况下，默认地，`Home` 和 `End` 并不能像我们想象中的那样跳转到真正的行首与行尾，实际上它会跳转到 wrap 之后（可看见的）的行首和行尾，有些时候这个会造成很大困扰。

## 解决方法
实际上，Sublime Text 中这个问题并不是 bug，而是设置问题，通过简单的设置，我们可以修正得到我们想要的真正的行首和行尾的跳转。

将下面的 Key Bindings 的配置放在 User 下即可，实际上就是覆写原来的快捷键。

<pre class="lang:json decode:true " >
// Very important fix
// Fix End of line
    { "keys": ["end"], "command": "move_to", "args": {"to": "hardeol", "extend": false} },
// Fix Beginning of line
    { "keys": ["home"], "command": "move_to", "args": {"to": "hardbol", "extend": false} },
// Fix end of line + select
    { "keys": ["shift+end"], "command": "move_to", "args": {"to": "hardeol", "extend": true} },
// Fix beginning of line + select
    { "keys": ["shift+home"], "command": "move_to", "args": {"to": "hardbol", "extend": true} },
</pre>

前两个配置是跳转而不选择中间的文字，而后面两个是跳转并且选中中间的文字。

## 参考文献
[Proper go to end of line with Sublime Text](http://wesbos.com/sublime-text-end-of-line-wrap/)
