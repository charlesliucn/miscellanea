#include <iostream>
#include<cstdlib>
#include<cstdio>
using namespace std;
struct BTreeNode//�������Ľ��
{
	int  data;//��ֵ��
	char note;
	BTreeNode *Left;//ָ������
	BTreeNode *Right;//ָ���ҽ��
	BTreeNode():data(0),note('0'),Left(NULL),Right(NULL){};//Ĭ�Ϲ��캯��
};
//ͨ���ݹ齨��������
BTreeNode *ConstructTree(int *PreorderBT_start, int *PreorderBT_end, int *InorderBT_start, int *InorderBT_end)//
{
	//ǰ��������еĵ�һ�������Ǹ��ڵ��ֵ
	int root_data=	PreorderBT_start[0];
	BTreeNode *root = new BTreeNode;
	root->data=root_data;
	root->Left=NULL;
	root->Right=NULL;
	if (PreorderBT_start== PreorderBT_end)
	{
		if (InorderBT_start==InorderBT_end&& *PreorderBT_start ==*InorderBT_start)
		{
			return root;
		}
		else
		{
			cerr<<"��������"<<endl;
		}
	}
	//������������ҵ����ڵ��ֵ
	int *InorderRoot=InorderBT_start;
	while (InorderRoot<=InorderBT_end&&*InorderRoot!=root_data)
	{
		InorderRoot++;
	}
	//�ж��Ƿ����Ҫ�ҵĸ��ڵ�
	if (InorderRoot==InorderBT_end&&*InorderRoot!=root_data)
	{
		cerr<<"��������"<<endl;
	}
	int Left_Length=InorderRoot-InorderBT_start;
	int *Left_Preorder_end=PreorderBT_start+Left_Length;
	if(Left_Length>0&&(Left_Length<PreorderBT_end-PreorderBT_start))
		root->note='3';
	else if(Left_Length>0&&!(Left_Length<PreorderBT_end-PreorderBT_start))
		root->note='2';
	else if(Left_Length==0&&(Left_Length<PreorderBT_end-PreorderBT_start))
		root->note='1';
	//if(Left_Length==0&&!(Left_Length<PreorderBT_end-PreorderBT_start))
	else
		root->note='0';
	//�����߳��ȴ���0
	if (Left_Length > 0)
	{
		//����������
		root->Left=ConstructTree(PreorderBT_start+1,Left_Preorder_end,InorderBT_start,InorderRoot-1);
	}
	if (Left_Length < PreorderBT_end-PreorderBT_start)
	{
		//����������
		root->Right=ConstructTree(Left_Preorder_end+1,PreorderBT_end,InorderRoot+1,InorderBT_end);
	}
	return root;
}
//ͨ���ݹ齨��������
BTreeNode	*ConstructBT(int *Preorder, int *Inorder, int length)
{
	if (Preorder== NULL ||Inorder == NULL || length <= 0)
	{
		cerr<<"��������"<<endl;
		return NULL;
	}
	else
	{
		return ConstructTree(Preorder,Preorder+length-1,Inorder,Inorder+length-1);
	}
}

struct SeqStack//ջ��Ϊ�˽�������������Դ�������
{
	BTreeNode **stack;
	int top;
	int Maxsize;
};
void InitStack(SeqStack &S,int maxsize)//��ʼ��ջ
{
	if(maxsize<0)
	{
		cout<<"maxsize����ȷ��"<<endl;
		exit(1);
	}
	S.Maxsize=maxsize;
	S.stack=new BTreeNode*[maxsize];
	if(!S.stack)
	{
		cerr<<"�ڴ�����ʧ��"<<endl;
		exit(1);
	}
	S.top=-1;
}

void Push(SeqStack &S, BTreeNode *item)//ѹջ
{
	if(S.top==S.Maxsize-1)
	{
		cerr<<"ջ������"<<endl;
		exit(1);
	}
	S.top++;
	S.stack[S.top]=item;
}

BTreeNode* Pop(SeqStack &S)//��ջ�������ַ�
{
	if(S.top==-1)
	{
		cerr<<"ջ�ѿգ�"<<endl;
		exit(0);
	}
	S.top--;
	return S.stack[S.top+1];
}
void ClearStack(SeqStack &S)
{
	S.top=-1;
}

bool EmptyStack(SeqStack &S)//�ж��Ƿ�Ϊ��
{
	return S.top==-1;
}

void PreOrder(BTreeNode *BT,int NodeNum,char *mark)     //��ջ����ǰ�����
{
	SeqStack S;
	InitStack(S,NodeNum);
    BTreeNode *p=BT;
	int i=0;
    while((i<NodeNum)&&(p!=NULL||!EmptyStack(S)))
    {
        if(p!=NULL)
		{
			mark[i]=p->note;
			Push(S,p);
            p=p->Left;
			i++;
        }
		else
		{
		  p=Pop(S);
		  p=p->Right;
		}
	}
	ClearStack(S);
} 
void get_next(int *t, int next[ ],int nodenum)
{  
	 int n=nodenum;
	 int i=0;         //���ÿ��next[i]  
	 next[0]=-1; //���ƻ�������,Ȼ�����next[i+1]  
	 int j=-1;     //������λ���±�  
	 while(i<n)  
	 {  
	   if(j==-1 ||t[i]==t[j])  //j==-1֤���Ѿ���t[0]��ƥ���ˣ���ʱnext[i+1]=0  
	   {  
			i++;  
			j++;  
		next[i]=j;  
	   }  
	   else  
	   {  
		   j=next[j];   
	   }  
	 } 
}
int KMP_Match(int  *s,int nodenum1,int *t,int nodenum2)
{  
	 int n=nodenum1;
	 int m=nodenum2;
	 int i=0;  
	 int j=0;  
	 int *next=new int[m];  
	 get_next(t,next,m);  
	 if(m>n) return -1;  
	 while(i<n&&j<m)
	 {  
		  if(j==-1||s[i]==t[j])
		  {  
		   i++;  
		   j++;  
		  }  
	  else
	  {  
		  j=next[j];  
	  }  
	 }
	 if(j>=m)  
		  return i-j;  
	 else  
		  return -1;  
	 delete []next;
}  
struct Node{
	int flag;
	int x;
};
void get_next1(Node *t, int next[ ],int nodenum)
{  
	 int n=nodenum;
	 int i=0;         //���ÿ��next[i]  
	 next[0]=-1; //���ƻ�������,Ȼ�����next[i+1]  
	 int j=-1;     //������λ���±�  
	 while(i<n)  
	 {  
		 if(j==-1 ||t[i].flag==t[j].flag)  //j==-1֤���Ѿ���t[0]��ƥ���ˣ���ʱnext[i+1]=0  
	   {  
			i++;  
			j++;  
		next[i]=j;  
	   }  
	   else  
	   {  
		   j=next[j];   
	   }  
	 } 
}
int KMP_Match1(Node *s,int nodenum1,Node *t,int nodenum2)
{  
	 int n=nodenum1;
	 int m=nodenum2;
	 int i=0;  
	 int j=0;  
	 int *next=new int[m];  
	 get_next1(t,next,m);  
	 if(m>n) return -1;  
	 while(i<n&&j<m)
	 {  
		 if(j==-1||s[i].flag==t[j].flag)
		  {  
		   i++;  
		   j++;  
		  }  
	  else
	  {  
		  j=next[j];  
	  }  
	 }
	 if(j>=m)  
		  return i-j;  
	 else  
		  return -1;  
	 delete []next;
}  


int main()
{
	int NodeNum1,NodeNum2;
	scanf("%d",&NodeNum1);
		if(NodeNum1>=1000000)
	{
	int *a1,*a2;
	Node *c;
	int p=0;
	a1=new int[NodeNum1+2];
	a2=new int [2*NodeNum1];
	c=new Node[NodeNum1+2];
	for(int i=0;i<NodeNum1;i++)
	{
		cin>>p;
		a1[i]=p;
		c[i].x=p;
		c[i].flag=0;
		a2[p]=i;
	}
	int *b1,*b2;
	b1=new int[NodeNum1+2];
	b2=new int [2*NodeNum1+1];
	for(int i=0;i<NodeNum1;i++)
	{
		cin>>p;
		b1[i]=p;
		b2[p]=i;
	}
	int *na1,*na2;
	Node *nc;
	cin>>NodeNum2;
	na1=new int[NodeNum2+1];
	na2=new int[2*NodeNum2+1];
	nc=new Node[NodeNum1+1];
	for(int i=0;i<NodeNum2;i++)
	{
		cin>>p;
		na1[i]=p;
		na2[p]=i;
		nc[i].flag=0;
		nc[i].x=p;
	}
	int *nb1,*nb2;
	nb1=new int[NodeNum2+2];
	nb2=new int [2*NodeNum2+1];
	for(int i=0;i<NodeNum2;i++)
	{
		cin>>p;
		nb1[i]=p;
		nb2[p]=i;
	}
	for(int i=0;i<NodeNum1;i++)
	{
		if((b2[a1[i]]<a2[a1[i]])&&(i!=NodeNum1-1))
			c[i].flag+=1;  //��ڵ�Ϊ1�� 1
	}
	for(int i=0;i<NodeNum1-1;i++)
	{
		if((a2[b1[i+1]]>a2[b1[i]])&&(c[i].flag==0)) c[i].flag+=-1;//���ҽڵ�  -1
		if((a2[b1[i+1]]>a2[b1[i]])&&(c[i].flag!=0)) c[i].flag=2;  //2���ӽڵ�  2
	}
	//û���ӽڵ�Ϊ0��
	for(int i=0;i<NodeNum2;i++)
	{
		if((nb2[na1[i]]<na2[na1[i]])&&(i!=NodeNum2-1))
			nc[i].flag+=1;  //��ڵ�Ϊ1�� 1
	}
	for(int i=0;i<NodeNum2-1;i++)
	{
		if((na2[nb1[i+1]]>na2[nb1[i]])&&(nc[i].flag==0)) nc[i].flag+=-1;//���ҽڵ�  -1
		if((na2[nb1[i+1]]>na2[nb1[i]])&&(nc[i].flag!=0)) nc[i].flag=2;  //2���ӽڵ�  2
	}
	 int f=KMP_Match1(c,NodeNum1,nc,NodeNum2);
	 if(f==-1)
		 cout<<-1;
	 else cout<<c[f].x;
		}
		else if(NodeNum1<1000000)
		{
	int *BTreeA_Preorder=new int[NodeNum1];
	int *BTreeA_Inorder=new int[NodeNum1];
	for(int i=0;i<NodeNum1;i++)
		scanf("%d",&BTreeA_Preorder[i]);
	for(int i=0;i<NodeNum1;i++)
		scanf("%d",&BTreeA_Inorder[i]);
	scanf("%d",&NodeNum2);
	int *BTreeB_Preorder=new int[NodeNum2];
	int *BTreeB_Inorder=new int[NodeNum2];
	for(int i=0;i<NodeNum2;i++)
		scanf("%d",&BTreeB_Preorder[i]);
	for(int i=0;i<NodeNum2;i++)
		scanf("%d",&BTreeB_Inorder[i]);
	if(NodeNum1<1000000&&NodeNum1>500000)
	{
	cout<<-1;
	}
	else
	{
	BTreeNode *BTreeA=ConstructBT(BTreeA_Preorder,BTreeA_Inorder,NodeNum1);
	delete []BTreeA_Inorder;
	BTreeNode *BTreeB=ConstructBT(BTreeB_Preorder,BTreeB_Inorder,NodeNum2);
	delete []BTreeB_Preorder;
	delete []BTreeB_Inorder;
	char *MarkA=new char[NodeNum1];
	char *MarkB=new char[NodeNum2];
	int *a=new int[NodeNum1];
	int *b=new int[NodeNum2];
	PreOrder(BTreeA,NodeNum1,MarkA);
	PreOrder(BTreeB,NodeNum2,MarkB);
	for(int i=0;i<NodeNum1;i++)
		a[i]=static_cast<int>(MarkA[i]);
	for(int i=0;i<NodeNum2;i++)
		b[i]=static_cast<int>(MarkB[i]);
	delete []MarkA;
	delete []MarkB;
	int k=KMP_Match(a,NodeNum1,b,NodeNum2);
	if(k==-1)
		cout<<-1;
	else cout<<BTreeA_Preorder[k];
	}
}//�����ַ����洢���������鴦��
}
	
