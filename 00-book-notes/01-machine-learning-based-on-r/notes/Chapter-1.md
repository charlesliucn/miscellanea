# 机器学习与R语言---Chapter 1: 机器学习简介
### 1. 机器学习的定义
如果机器能够获取经验并且能够利用它们，在以后的类似经验中提高它的表现，该机器就可以实现机器学习。

### 2. 机器学习与数据挖掘的比较
+ 机器学习的研究领域是发明计算机算法，把数据转化为智能行为；
+ 数据挖掘涉及从大型的数据库中产生新的洞察；
+ 机器学习侧重执行一个已知的任务；数据挖掘侧重寻找有价值的信息；例：机器学习---教机器人开车；数据挖掘---哪种类型的车最安全；
+ 机器学习是数据挖掘的先期准备：可以应用机器学习完成不涉及数据挖掘的任务；但是应用数据挖掘时，几乎必然用到机器学习。

### 3. 机器学习的相关概念
+ 训练：用一个特定的模型拟合数据集的过程。
+ 过度拟合：尝试使用模型拟合噪声是过度拟合问题的基础。


### 4. 机器和人脑学习的一般过程
1. 数据输入
2. 抽象化：当模型被训练之后，数据转换为汇总了原始信息的抽象形式。
3. 一般化：将抽象化的知识转换成可以用于实际行动的形式。

### 5. 机器学习的伦理考虑
+ 获取和分析数据时，要小心谨慎，避免违法、违反服务条例或数据使用协议；
+ 避免滥用人们的信任；
+ 避免侵犯公众的隐私。

### 6. 机器学习应用于数据中的步骤
1. 收集数据；
2. 探索数据和准备数据；(机器学习80%的努力花费在数据上)
3. 基于数据训练模型；
4. 评价模型的性能；
5. 改进模型的性能。

### 7. 选择机器学习算法
1.[没有免费午餐定理](http://www.no-free-lunch.org)：没有一种机器学习算法对所有环境都是最好的。

2. 输入的数据：
	+ 以案例和特征组成的表格来呈现。
	+ 矩阵格式的数据是目前机器学习最常用的数据形式。
		+ 案例：被学习概念的示例性实例；
		    - 观察单位：被测量的案例的单位；
		+ 特征：案例的一个属性或特性；
		    - 数值型特征：用数值衡量；
		    - 分类变量：用一组类别表示特征；
			    * 有序变量：衣服尺码、顾客满意度等。

3. 机器学习算法的类型：
	+ 有监督学习算法：用于建立预测模型：
	    - 预测模型：用数据集中的其他值预测另一个值。
	    - 预测模型不一定预测未来的事件，也可以“预测”过去的事件。
	    - 有监督：监督并不是需要人为的干预，而是让目标值担任监督的角色，让目标值告诉学习者学习的任务。
	    - 常规的有监督学习任务：
		    + 分类：预测案例属于哪个类别；
		    + 数值型预测：拟合输入数据的线性回归模型；
		    + 两者之间的界限不是很严格
	
	+ 无监督学习算法：用于建立描述模型：
		- 描述模型：没有一个要学习的目标，模型的各属性之间同等重要；
		- 常规的无监督学习任务：
			+ 模式发现：识别数据之间联系的紧密性；
			+ 聚类：将数据按照相同类型分组；

