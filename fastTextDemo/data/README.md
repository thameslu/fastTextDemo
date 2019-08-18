####  dbpedia.train/dbpedia.test文件的获取

由于这两个文件加起来两百多兆，所以不加到git版本管理中，可以通过以下方式获取：

1. 在Mac通过[fastText](https://github.com/facebookresearch/fastText)github上的步骤安装fastText

2. 运行`fastText-0.9.1/classification-example.sh`

3. 在`fastText-0.9.1/data`目录下获取dbpedia.train/dbpedia.test这两个文件

   *如果你没有安装wget，则会报错，安装完wget后重新运行`fastText-0.9.1/classification-example.sh`之前，先把`fastText-0.9.1/data/dbpedia.train`文件删掉，否则无法下载正确的dbpedia.train文件*
