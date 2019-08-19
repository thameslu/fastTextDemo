# fastText

> [fastText](https://github.com/facebookresearch/fastText)是一个高效的学习词向量和句子分类的机器学习库。

通常来说，**fastText**在Mac OS或Linux上编译。编译需要使用C++11的特性，包括：

* (g++-4.7.2或更新)或者(clang-3.3或更新)

官方推荐用**make**脚本来编译，也可以用**cmake**(至少应是2.8.9版本)



## 编译

编译分为以下几个步骤：

* 下载代码
  * clone主干github仓库的代码
  * 在[latest stable release](https://github.com/facebookresearch/fastText/releases/latest)下载稳定的发布版本代码

* 编译
  * 用**make**编译

    ```shell
    $ wget https://github.com/facebookresearch/fastText/archive/v0.9.1.zip
    $ unzip v0.9.1.zip
    $ cd fastText-0.9.1
    $ make
    ```

  * 用**cmak**编译

    因为用cmake编译还不是发布版本的一部分，所以需要下载**master**分支的代码

    ```shell
    $ git clone https://github.com/facebookresearch/fastText.git
    $ cd fastText
    $ mkdir build && cd build && cmake ..
    $ make && make install
    ```

  * 编译**Python**版本

    编译Python版本现在也不是发布版本的一部分，所以需要下载**master**分支的代码

    ```shell
    $ git clone https://github.com/facebookresearch/fastText.git
    $ cd fastText
    $ pip install .
    ```

我在**macOS** High Sierra使用make脚本下编译通过，可以在命令行运行**fastText**(当然，要cd到编译结果目录下才有fastText二进制可以运行，没有修改~/.bash_profile文件)



## 在Xcode中引入fastText

facebook开源了fastText源码，fastText是用C++写的，所以可以在Xcode工程中直接使用：

* 在上一节**编译**中，我们已经下载了fastText的源码

* 库代码就放在`fastText-0.9.1/src`下，直接将其引入Xcode工程即可，但注意其中的`main.cc`文件不要勾到target中，否则工程会因为有两个入口函数而无法运行

  ```shell
  duplicate symbol _main in:
  ......
  ld: 1 duplicate symbol for architecture x86_64
  clang: error: linker command failed with exit code 1 (use -v to see invocation)
  ```

* 然后就可以使用库中的类了，具体用法可以参考`main.cc`(`main.cc`其实就是我们在macOS或Linux中编译出来的fastText二进制文件的入口)

