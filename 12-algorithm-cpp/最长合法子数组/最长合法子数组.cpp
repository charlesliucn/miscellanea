#include <iostream>
#include <cmath>
#define Num 2000000//����Num
using namespace std;

struct Element//��ʾ�����һ��Ԫ�أ�����ֵ��λ�ù���
{
  int data;
  int pos;
};

struct Queue//����
{
  int head;
  int tail;
  Element n[Num];
};

static Queue Max, Min;//��̬ȫ�ֱ���

void Max_Queue(int pos, int data) //��ÿ������������ݽ����ж�֮����뵽�洢Max������֮�д˴���MaxΪ����ֵ��
{
  while (1) 
  {
    if (Max.head != Max.tail)//�Ƚ�֮������Ƿ�������֮��
	{
		if (Max.n[Max.tail-1].data< data) 
		Max.tail--;
		else
		{
			Max.n[Max.tail].data = data;
			Max.n[Max.tail].pos = pos;
			Max.tail++;
			break;
		}
	}
    else //�������Ϊ�գ�ֱ�ӽ��²���������ڶ�����
	{
		Max.n[Max.tail].data = data;
		Max.n[Max.tail].pos = pos;
		Max.tail++;
		break;
    }
  }
}
void Min_Queue(int pos, int data)//��ÿ������������ݽ����ж�֮����뵽�洢Min������֮�д˴���MinΪ��Сֵ��
{
  while (1)
  {
    if (Min.head!=Min.tail)//�Ƚ�֮������Ƿ�������֮��
	{
		if (Min.n[Min.tail - 1].data> data) 
			Min.tail--;
		else 
		{
			Min.n[Min.tail].data = data;
			Min.n[Min.tail].pos = pos;
			Min.tail++;
			break;
		}
	}
    else //�������Ϊ�գ�ֱ�ӽ��²���������ڶ�����
	{
       Min.n[Min.tail].data = data;
	   Min.n[Min.tail].pos = pos;
	   Min.tail++;
	   break;
    }
  }
}

int main()
{
  int N,m,data;
  int count=0, Mincount=Num, Maxcount = 0;
  cin>>N>>m;
  int *mark=new int[2];
  int i=0;
  for(i=0;i<2;i++)
  {
	  cin>>data;
	  mark[i]=data;
  }
  if(abs(mark[0]-mark[1])>=m)
  {
		for(i=2;i<N;i++)
		{
			 cin>>data;
		}
		cout<<1<<endl<<0;
  }
  else
  {
	  for(i=0;i<2;i++)
	  {
		  data=mark[i];
		  count++;
		  Max_Queue(i,data);
		  Min_Queue(i,data);
		  if(Max.n[Max.head].data-Min.n[Min.head].data >= m)
		  {
			  while (Max.n[Max.head].data-Min.n[Min.head].data >= m && count>0) 
			  {
				  if (Mincount>count) 
					  Mincount =count;
				  count--;
				  while (Max.n[Max.head].pos <= i-count) 
					  Max.head++;
				  while (Min.n[Min.head].pos <= i-count)
					  Min.head++;
			  }
		  }
		  else
		  {
			  if (Maxcount < count) 
				  Maxcount = count;
		  }
	  }
	  for(i=2;i<N;i++)
	  {
		  cin>>data;
		  count++;
		  Max_Queue(i,data);
		  Min_Queue(i,data);
		  if (Max.n[Max.head].data-Min.n[Min.head].data >= m)
		  {
			  while (Max.n[Max.head].data-Min.n[Min.head].data >= m && count>0) 
			  {
				  if (Mincount>count) 
					  Mincount =count;
				  count--;
				  while (Max.n[Max.head].pos <= i-count) 
					  Max.head++;
				  while (Min.n[Min.head].pos <= i-count)
					  Min.head++;
			  }
		  }
		  else
		  {
			  if (Maxcount < count) 
				  Maxcount = count;
		  }
	  }
	  if (Mincount == Num) 
		  Mincount = 0;
	  cout<<Mincount<<endl;
	  cout<<Maxcount<<endl;
  }
}