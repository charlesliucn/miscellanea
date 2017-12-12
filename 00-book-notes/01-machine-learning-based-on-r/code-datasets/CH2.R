usedcars = read.csv("usedcars.csv")
str(data)  # ��ʾ���ݿ�Ļ�����Ϣ
summary(usedcars$year) # �������ֳ����ݵ�year��������Ϣ
range(usedcars$price)  # �鿴���ݵ�ȡֵ��Χ
diff(usedcars$price)   # �鿴���������Сֵ֮��
IRQ(usedcars$price)    # �鿴���ݵ��ķ�λ��
quantile(usedcars$price) # �鿴���ķ�λ��
quantile(usedcars$price, probs = c(0.1,0.9))# ѡ��ͬ�ķָ��

boxplot(usedcars$price,main = "Boxplot of Used Cars Prices",ylab = "price($)")
# ������ͼ����ͼ�Ŀ���������ģ���������������(notch��width�����޸���״�Ϳ���)

hist(usedcars$mileage, main = "Histogram of Used Cars Mileage",xlab = "Mileage")
var(usedcars$price)  #�����
sd(usedcars$mileage) #��׼���
# ��̬�ֲ���68-95-99.7׼��

# �������
table(usedcars$model)
tableA = table(usedcars$color)
table(usedcars$transmission)
# ����ɫΪ��
tablere = prop.table(tableA)*100
colorper = round(tablere,digits = 1) # ����С�����һλ
sort(colorper)

mode(usedcars$year)  # ��ñ���������

# ̽��Price��Mileage֮��Ĺ�ϵ
library(ggplot2)
ggplot(usedcars,aes(x = mileage, y = price)) + geom_point() + 
  labs(title="Used Car Price v.s. Mileage", x="Used Car Mileage", y="Used Car Price")+
  theme(plot.title = element_text(hjust = 0.5))

# ˫�򽻲�����������֮��Ĺ�ϵ
usedcars$conser = usedcars$color %in% c("Black","Gray","Silver","White")
# �����ֳ�color�����Ƿ���������
table(usedcars$conser)  #��ȡ����/�����ص���Ŀ
CrossTable(usedcars$model,usedcars$conser,chisq = T)  # ��������ֱ�Ϊ�к���
# �����ÿ������������ݱ�ʾ��
# 1. �ø��Ӷ�Ӧ��������Ŀ
# 2. �õ�Ԫ��Ŀ���ͳ����(Ƥ��ɭ���������Լ���)������Խ�ͣ������������������Խ��
# 3. �õ�Ԫ����������ռ�ı���
# 4. �õ�Ԫ����������ռ�ı���
# 5. �õ�Ԫ�������������еı���
# 6. ���Ŀ�������pԽ�󣬱��������Խ����żȻ�Ŀ�����Խ��