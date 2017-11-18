#include<iostream>
#include<cstdlib>
#include<cstdio>//ע����ΪҪ������ı��ʽ�ַ�����һ�������벢�����жϺʹ������ʹ��getchar()�����ȽϺã���Ҫ����C���Ե�ͷ�ļ�
using namespace std;
struct Expression//�洢һ���ַ�����ʾ���ʽ�����е�һ�����
{
	char character;//��ֵ�򣬴洢һ���ַ�
	Expression *next;//ָ����ָ����һ���
	Expression(char c='0',Expression *n=NULL)//�Խ����г�ʼ��
	{
		character=c;
		next=n;
	}
};
struct BiDirect_List//˫�������洢һ������ı��ʽ����������˽���Ԫ�أ��ַ����������
{
	Expression *Left;//Ŀǰ���ʽ����߽���ָ��
	Expression  *Right;//Ŀǰ���ʽ���ұ߽���ָ��
	BiDirect_List *Next;//ָ����һ��������ʽ
	char Operator_Rank;//�洢������������ں���ĺ����и��ݲ����������ȼ����Ĳ�ͬ�������
	BiDirect_List(Expression *L=NULL,Expression *R=NULL,char operator_rank='0',BiDirect_List *N=NULL)//��˫��������г�ʼ��
	{
		Left=L;
		Right=R;
		Next=N;
		Operator_Rank=operator_rank;
	}
};
void Add_Left(struct BiDirect_List *BL,char c)//�����б��ʽ��������һ���ַ�
{
	if(BL->Left==NULL)//�ÿ�ʼ������ָ��Ϊ��ʱ������ָ��ָ��Ľ��������ַ�
	{
		BL->Left=new Expression;//��������ڴ�ռ�
		BL->Right=BL->Left;//��ָ�����ָ��ָ��ͬһ���
		BL->Left->character=c;//����ָ��ָ�������ֵ��ֵ���ַ���
	}
	else//��˫������Ϊ��ʱ��ʹ˫��������������
	{
		Expression *temp=BL->Left;
		BL->Left=new Expression;//��������ڴ�ռ�
		BL->Left->character=c;
		BL->Left->next=temp;
	}//ʵ���ǽ���ָ��ָ���������Ľ�㣬ԭ�����������ַ�
}
void Add_Right(struct BiDirect_List *BL,char c)//�����б��ʽ���ұ����һ���ַ�
{
	if(BL->Right==NULL)
	{
		BL->Left=new Expression;//��������ڴ�ռ�
		BL->Right=BL->Left;//��ָ�����ָ��ָ��ͬһ���
		BL->Left->character=c;//����ָ��ָ�������ֵ��ֵ���ַ���
	}
	else
	{
		Expression *temp=BL->Right;
		BL->Right=new Expression;//��������ڴ�ռ�
		BL->Right->character=c;
		temp->next=BL->Right;
	}//ʵ���ǽ���ָ��ָ���������Ľ�㣬ԭ�����������ַ�
}
void print(struct BiDirect_List *BL)//��˳����������е������ַ�
{
	Expression *temp=BL->Left;//��˫��������������
	while(temp!=NULL)
	{
		cout<<temp->character;//��������е��ַ�
		temp=temp->next;//ָ����һ�ַ�
	}
}

struct All_List//�洢���������ı��ʽ
{
	BiDirect_List *head;//ͷָ��
	All_List(BiDirect_List *h=NULL)//��All_List���г�ʼ��
	{
		head=h;
	}
};
void In_Operator(struct All_List *AL,char c)//��һ��������������
{
	if(AL->head==NULL)
	{
		AL->head=new BiDirect_List;//����������Ϊ��ʱ������һ����С���ʽ�����
		Add_Right(AL->head,c);
	} 
	else
	{
		BiDirect_List *temp=new BiDirect_List;
		Add_Left(temp,c);
		temp->Next=AL->head;
		AL->head=temp;
	}
}
void Out_Operand(struct All_List *AL,char c)//ȡ����ǰ�������������������c�������㣬���c�ǽ׳˾�ֻȡһ��
{
	if(c=='!') 
	{
		if(AL->head->Operator_Rank=='0'||AL->head->Operator_Rank=='!') 
			Add_Right(AL->head,c);
		else 
		{
			Add_Left(AL->head,'(');
			Add_Right(AL->head,')');
			Add_Right(AL->head,c);
		}
		AL->head->Operator_Rank=c;
	}
	else if(c=='+'||c=='-')
	{
		if(AL->head->Operator_Rank=='+'||AL->head->Operator_Rank=='-') 
		{
			Add_Left(AL->head,'(');
			Add_Right(AL->head,')');}
			BiDirect_List *temp=AL->head;
			Add_Right(AL->head->Next,c);
			AL->head->Next->Right->next=AL->head->Left;
			AL->head->Next->Right=AL->head->Right;
			AL->head=AL->head->Next;
			AL->head->Operator_Rank=c;
			delete []temp;
		}
		else
		{
			if(AL->head->Operator_Rank!='0'&&AL->head->Operator_Rank!='!') 
			{
				Add_Left(AL->head,'(');
				Add_Right(AL->head,')');
			}
			if(AL->head->Next->Operator_Rank=='+'||AL->head->Next->Operator_Rank=='-')
			{
				Add_Left(AL->head->Next,'(');
				Add_Right(AL->head->Next,')');
			}
			BiDirect_List *temp=AL->head;
			Add_Right(AL->head->Next,c);
			AL->head->Next->Right->next=AL->head->Left;
			AL->head->Next->Right=AL->head->Right;
			AL->head=AL->head->Next;
			AL->head->Operator_Rank=c;
			delete []temp;
	}
}
int main()
{
	char c;
	All_List al, *AL;
	AL=&al;
	c=getchar();
	while((c>='a'&&c<='z')||c=='+'||c=='-'||c=='*'||c=='/'||c=='!')
	{
		if(c>='a'&&c<='z') 
			In_Operator(AL,c);
		else 
			Out_Operand(AL,c);
	    c=getchar();
	}
	print(AL->head);
}