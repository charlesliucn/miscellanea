#include <iostream>
#include<cstdlib>
#include<cstring>
using namespace std;
struct BTreeNode//�������Ľ��
{
	int  data;//��ֵ��
	char left;//�ж������Ƿ�Ϊ�գ������Ҫ�������
	char right;//�ж��ҽ���Ƿ�Ϊ�գ������Ҫ�������
	BTreeNode *Left;//ָ������
	BTreeNode *Right;//ָ���ҽ��
	BTreeNode():data(0),left('0'),right('0'),Left(NULL),Right(NULL){};//Ĭ�Ϲ��캯��
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
			root->left='0';
			root->right='0';
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
	//�����߳��ȴ���0
	if (Left_Length > 0)
	{
		//����������
		root->Left=ConstructTree(PreorderBT_start+1,Left_Preorder_end,InorderBT_start,InorderRoot-1);
		root->left='1';
	}
	else root->left='0';
	if (Left_Length < PreorderBT_end-PreorderBT_start)
	{
		//����������
		root->Right=ConstructTree(Left_Preorder_end+1,PreorderBT_end,InorderRoot+1,InorderBT_end);
		root->right='1';
	}
	else root->right='0';
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

void MarkTree(BTreeNode *BT)//�ݹ���������̬����
{	
	if(BT!=NULL)
	{
		BT->data=2;//���ʸ����
		MarkTree(BT->Left);
		MarkTree(BT->Right);
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
void ClearStack(SeqStack &S)//���ջ
{
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
 BTreeNode* GetTop(SeqStack &S)//����ջ��ֵ��������ջ
{
	if(S.top==-1)
	{
		cerr<<"ջ�ѿգ�"<<endl;
		exit(1);
	}
	return S.stack[S.top];
}

bool EmptyStack(SeqStack &S)//�ж��Ƿ�Ϊ��
{
	return S.top==-1;
}
bool FullStack(SeqStack &S)//�ж��Ƿ�����
{
	return S.top==S.Maxsize-1;
}

void PreOrder(BTreeNode *BT,int NodeNum,char *mark)     //��ջ����ǰ�����
{
	SeqStack S;
	InitStack(S,3*NodeNum+3);
    BTreeNode *p=BT;
	BTreeNode *q;
	int i=0;
    while((p!=NULL||!(EmptyStack(S))&&i<NodeNum+1))
    {
        if(p!=NULL)
		{
			Push(S,p);
            p=p->Left;
        }
		else
		{
		  q=GetTop(S);
		  mark[3*i+2]=q->left;
		  mark[3*i+1]=q->right;
		  mark[3*i]=q->data;
		  p=Pop(S);
		  p=p->Right;
		}
	}
}
/*void PreorderBT(BTreeNode *BT,int length,char *mark)//������������̬������
{
	static int i=0;
	if(BT!=NULL&&i<length)
	{
		mark[3*i]=char(BT->data);//ǿ������ת��
		mark[3*i+1]=BT->left;
		mark[3*i+2]=BT->right;
		PreorderBT(BT->Left,length, mark);
		PreorderBT(BT->Right,length, mark);
	}
	i++;
}*/

int Judge_POS(char *str1,char *str2)
{
	int Position;
	char *temp;
	temp=strstr(str1,str2);
	Position=temp-str1+1;
	return Position;
}

int main()
{
	int NodeNum1,NodeNum2,Pos_Root;
	cin>>NodeNum1;
	int *BTreeA_Preorder=new int[NodeNum1];
	int *BTreeA_Inorder=new int[NodeNum1];
	for(int i=0;i<NodeNum1;i++)
		cin>>BTreeA_Preorder[i];
	for(int i=0;i<NodeNum1;i++)
		cin>>BTreeA_Inorder[i];
	cin>>NodeNum2;
	int *BTreeB_Preorder=new int[NodeNum2];
	int *BTreeB_Inorder=new int[NodeNum2];
	for(int i=0;i<NodeNum2;i++)
		cin>>BTreeB_Preorder[i];
	for(int i=0;i<NodeNum2;i++)
		cin>>BTreeB_Inorder[i];
	BTreeNode *BTreeA=ConstructBT(BTreeA_Preorder,BTreeA_Inorder,NodeNum1);
	BTreeNode *BTreeB=ConstructBT(BTreeB_Preorder,BTreeB_Inorder,NodeNum2);
	char *MarkA=new char[3*NodeNum1];
	char *MarkB=new char[3*NodeNum2];
	MarkTree(BTreeA);
	MarkTree(BTreeB);
	PreOrder(BTreeA,NodeNum1,MarkA);
	PreOrder(BTreeB,NodeNum2,MarkB);
	Pos_Root=Judge_POS(MarkA,MarkB);
	int k=(3*NodeNum1-Pos_Root-3*NodeNum2+5)/3;
	//int k=Pos_Root/3;
	cout<<BTreeA_Preorder[k];
}