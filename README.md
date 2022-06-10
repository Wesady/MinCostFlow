# MinCostFlow
解决最小费用流问题的迭代算法

Iterative algorithms for minimum cost flow problem solving

`MinCostFlow`是根据1961年`Busacker`和`Gowan`提出的求最小费用流的迭代法编写的，编写时主要参考了`司守奎, 孙兆亮主编. 数学建模算法与应用. 第3版[M]. 国防工业出版社, 2021.`中的算法描述。由于书中的代码是使用优化工具箱求解的，故编写了此代码以使用迭代法求解。

## 输入 Inputs

主函数为mincost函数，输入的内容为

``` yaml
G1: 边权为网络的容量的图（digraph对象）
G2: 边权为网络的单位运费的图（digraph对象）
vs: 发点（字符串类型）
vt: 收点（字符串类型）
pl: 是否可视化最小费用最大流图（布尔类型）
```

测试时使用了`司守奎, 孙兆亮主编. 数学建模算法与应用. 第3版[M]. 国防工业出版社, 2021.`一个示例中的数据，存储在[data.mat](https://github.com/IceBreakerW/MinCostFlow/blob/main/data.mat)文件中。使用该数据求解得到的结果与该书中使用优化工具箱求解的结果一致。

## 输出 Outputs

输出的结果保存在变量`G`和`fee`中，`G`为最小费用最大流图，`fee`为最小费用。
