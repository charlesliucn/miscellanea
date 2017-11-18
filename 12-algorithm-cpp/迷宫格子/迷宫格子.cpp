#include<iostream>
#define INF 2147483647
using namespace std;

int length=0,NodeNum,begin;
class Graph
{
public://���г�Ա����main����
	int *Position,*func,*weight,*heap;//����Ȩֵ��Ѱ�����·���Ķ�
	bool *visited;//����ÿ�������Ƿ񱻱�����bool��
	Graph();//���캯��
	~Graph();//��������
	void Weight_Swap(int l);//����Ȩֵ
	void heapAdd(int l,int price);//���������
	int heapOut();//�Ӷ���ȡ��
};

Graph::Graph()//���캯������̬��������
{
	heap=new int[NodeNum+1];
	visited=new bool[NodeNum+1];
	visited[0]=true;
	Position=new int[NodeNum+1];
	Position[0]=0;
	func=new int[NodeNum+1];
	func[0]=0;
	weight=new int[NodeNum+1];
	weight[0]=0;
}
Graph::~Graph()//�����������ͷŶ�̬�ڴ�
{
	delete []heap;
	delete []visited;
	delete []Position;
	delete []func;
	delete []weight;
}

void Graph::Weight_Swap(int l)//����Ȩֵ
{
	int vec=l;
	bool flag=true;
	int swap,min;
	while(vec/2>=1&&flag)
	{
		if(heap[vec/2]>heap[vec])
		{
			swap=heap[vec/2];//����Ȩֵ
			heap[vec/2]=heap[vec];
			heap[vec]=swap;
			swap=func[Position[vec]];//����Position��heap
			func[Position[vec]]=func[Position[vec/2]];
			func[Position[vec/2]]=swap;
			swap=Position[vec/2];//����heap��Position
			Position[vec/2]=Position[vec];
			Position[vec]=swap;
			vec=vec/2;
			flag=true;
		}
		else flag=false;
	}
	flag=true;
	while(vec*2<=length&&flag)
	{
		min=vec*2;
		if(min+1<=length&&heap[min+1]<heap[min]) 
			min++;
		if(heap[vec]>heap[min])
		{
			swap=heap[min];//����Ȩֵ
			heap[min]=heap[vec];
			heap[vec]=swap;
			swap=func[Position[vec]];//����Positionition->heap
			func[Position[vec]]=func[Position[min]];
			func[Position[min]]=swap;
			swap=Position[min];//����heap->Positionition
			Position[min]=Position[vec];
			Position[vec]=swap;
			vec=min;
			flag=true;
		}
		else flag=false;
	}
}
void  Graph::heapAdd(int l,int price)
{  
	Position[length]=l;
	func[l]=length;
	Weight_Swap(length);
	length++;
	heap[length]=price;
}
int Graph::heapOut()
{
	int vec;
	begin=Position[1];
	visited[begin]=true;
	vec=heap[1];
	heap[1]=heap[length];
	func[Position[length]]=1;
	Position[1]=Position[length];
	length--;
	Weight_Swap(1);
	return vec;//return min weight
}
int main()
{
	int vec,end,price,Num,edge,i=1;
	bool flag=true;
	cin>>Num;
	edge=Num;
	NodeNum=Num*Num;
	cin>>begin;
	cin>>end;
	Graph G;
	for(i=1;i<=NodeNum;i++)//���䵽NodeNum���洢���е�����
	{
		G.visited[i]=false;
		G.func[i]=i;
		G.Position[i]=i;
	}
	for(i=1;i<=NodeNum;i++)//��ÿ�������Χ�����Ȩֵ��������
	{
		cin>>vec;
		if(vec>0) 
			G.weight[i]=vec;//Ȩֵ������������
		else if(vec==0)//ȨֵΪ��Ҫ�������һ����ֵ������ֵ��ʾ������Ծ���Ķ���
		{
			cin>>vec;
			G.weight[i]=(-1)*vec;
		}
		else G.weight[i]=0;//���������Ϊvec=-1�����ʾ�ø�������ǽ���޷�ͨ��
	}
	length=NodeNum;
	if(G.weight[end]==0) //������յ��ȨֵΪ����ʾ�õ���ǽ���޷��ﵽ
		cout<<INF;//������ֵ
	else G.weight[end]=0;//���յ�Ȩֵ��Ϊ����Ϊ0
	for(int i=1;i<=begin-1;i++)//������ʼ��֮�⣬���������Ϊ0
		G.heap[i]=INF;
	for(int i=begin+1;i<=NodeNum;i++)
		G.heap[i]=INF;
	if(G.func[begin]==0) G.heap[begin]=0;//��ʼ��������Ծ�ĵ�
	else G.heap[begin]=G.weight[begin];//������Ҳ����ʼ��Ȩֵ
	G.Weight_Swap(begin);
	while(length)
	{
		price=G.heapOut();
		//�������Ĳ�ͬλ�ã��������ۣ����������ǣ��ö�����Χ�м����ڽӵĶ��㣩
		if(begin==end)//Դ�����յ���ͬ
		{
			cout<<price;
			return 0;
		}
		if(G.weight[begin]<0&&!G.visited[-1*G.weight[begin]])
		{
			if(G.weight[(-1)*G.weight[begin]]<0&&price<G.heap[G.func[(-1)*G.weight[begin]]]) 
			{
				G.heap[G.func[(-1)*G.weight[begin]]]=price;
				G.Weight_Swap(G.func[(-1)*G.weight[begin]]);
			}
			else if((G.weight[(-1)*G.weight[begin]]>0||(-1)*G.weight[begin]==end)&&price+G.weight[(-1)*G.weight[begin]]<G.heap[G.func[(-1)*G.weight[begin]]])
			{
					G.heap[G.func[(-1)*G.weight[begin]]]=price+G.weight[(-1)*G.weight[begin]];
					G.Weight_Swap(G.func[(-1)*G.weight[begin]]);
			}
		}
		if(begin%edge!=1&&!G.visited[begin-1])
		{
			if((G.weight[begin-1]>0||begin-1==end)&&G.weight[begin-1]+price<G.heap[G.func[begin-1]])
			{
				G.heap[G.func[begin-1]]=G.weight[begin-1]+price;
				G.Weight_Swap(G.func[begin-1]);
			}
			else if(G.weight[begin-1]<0&&price<G.heap[G.func[begin-1]])
			{
				G.heap[G.func[begin-1]]=price;
				G.Weight_Swap(G.func[begin-1]);
			}
		}
		if(begin%edge!=0&&!G.visited[begin+1])
		{
			if((G.weight[begin+1]>0||begin+1==end)&&G.weight[begin+1]+price<G.heap[G.func[begin+1]])
			{
				G.heap[G.func[begin+1]]=G.weight[begin+1]+price;
				G.Weight_Swap(G.func[begin+1]);
			}
			else if(G.weight[begin+1]<0&&price<G.heap[G.func[begin+1]])
			{
					G.heap[G.func[begin+1]]=price;
					G.Weight_Swap(G.func[begin+1]);
			}
		}
		if(begin-edge>0&&!G.visited[begin-edge])
		{
			if((G.weight[begin-edge]>0||begin-edge==end)&&G.weight[begin-edge]+price<G.heap[G.func[begin-edge]])
			{
					G.heap[G.func[begin-edge]]=G.weight[begin-edge]+price;
					G.Weight_Swap(G.func[begin-edge]);
			}
			else if(G.weight[begin-edge]<0&&price<G.heap[G.func[begin-edge]])
			{
					G.heap[G.func[begin-edge]]=price;
					G.Weight_Swap(G.func[begin-edge]);
			}
		}
		if(begin+edge<=NodeNum&&!G.visited[begin+edge])
		{
			if((G.weight[begin+edge]>0||begin+edge==end)&&G.weight[begin+edge]+price<G.heap[G.func[begin+edge]])
			{
					G.heap[G.func[begin+edge]]=G.weight[begin+edge]+price;
					G.Weight_Swap(G.func[begin+edge]);
			}
			else if(G.weight[begin+edge]<0&&price<G.heap[G.func[begin+edge]])
			{
				G.heap[G.func[begin+edge]]=price;
				G.Weight_Swap(G.func[begin+edge]);
			}
		}
	}
	}