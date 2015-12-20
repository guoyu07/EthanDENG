Windows环境下安装pip，方便你的开发

1.在以下地址下载最新的PIP安装文件：http://pypi.python.org/pypi/pip#downloads
[pip-1.5.6.tar.gz (md5, pgp)](https://pypi.python.org/pypi?:action=show_md5&digest=01026f87978932060cc86c1dc527903e)

2.解压

3.下载Windows的easy installer，然后安装：http://pypi.python.org/pypi/setuptools

[Chinese Simplified](https://bootstrap.pypa.io/ez_setup.py)

4.安装setuptools工具

5.命令行工具cd切换到pip的目录，找到setup.py文件，然后输入python setup.py install，运行即可（之所以能运行这步，是因为之前安装的setuptools工具，以后就可以随意安装python的库了，只要找对setup.py文件的路径，运行上述命令，就可以方便的安装了）

6.把python的安装路径添加到环境变量path中，例如G:\python2.6\Scripts

7.完成！


另：安装完pip和easy_installer工具后，以后再安装python其他库就方便了

例如：
easy_install redis

    or
pip install redis （推荐）
