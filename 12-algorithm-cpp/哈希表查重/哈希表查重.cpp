#include<iostream>
#include<cstdlib>
#include<cstring>
#define PARENT(i) (i)/2
#define LEFT(i) 2*(i)+1
#define RIGHT(i) 2*(i+1)
using namespace std;

struct String_Hash//�洢��ź�Hashֵ������������ʱ�Ų��������ŵĻ���
{
	int order;
	int Hash;
	int Hash2;
	int Hash3;
	int Hash4;
};

int Hash_Int(char *str)
{
     int b = 378551;
     int a = 63689;
	int hash = 0;
    while (*str)
    {
        hash = hash * a + (*str++);
        a *= b;
    }
    return (hash & 0x7FFFFFFF);
}

 int PJWHash(char *str)
{
   int BitsInUnignedInt = (int)(sizeof(int) * 8);
    int ThreeQuarters    = (int)((BitsInUnignedInt  * 3) / 4);
    int OneEighth = ( int)(BitsInUnignedInt / 8);
    int HighBits = (int)(0xFFFFFFFF) << (BitsInUnignedInt - OneEighth);
     int hash    = 0;
    int test    = 0;
    while (*str)
    {
        hash = (hash << OneEighth) + (*str++);
        if ((test = hash & HighBits) != 0)
        {
            hash = ((hash ^ (test >> ThreeQuarters)) & (~HighBits));
        }
    }
    return (hash & 0x7FFFFFFF);
}
//Hash����
int BKDRHash(char* str)  
{  
	int len=strlen(str);
   int seed = 13131; /* 31 131 1313 13131 131313 etc.. */  
   int hash = 0;  
   int i    = 0;  
   for(i = 0; i < len; str++, i++)  
   {  
      hash = (hash * seed) + (*str);  
   }  
   return (hash & 0x7FFFFFFF);
}  
//Hash2����
int ELFHash(char* str)  
{  
	int len=strlen(str);
   int hash = 0;  
   int x  = 0;  
   int i   = 0;  
   for(i = 0; i < len; str++, i++)  
   {  
      hash = (hash << 4) + (*str);  
      if((x = hash & 0xF0000000L) != 0)  
      {  
         hash ^= (x >> 24);  
      }  
      hash &= ~x;  
   }  
   return (hash & 0x7FFFFFFF);
}  

struct LNode
{
	 int data;
	 struct LNode * next;
};
typedef struct LNode *LinkList;

void InitList(LinkList &L)
{
	L=NULL;
}

void HeadInsert(LinkList &L,int n,int *a)
{
	LinkList p;
	L=new LNode;
	L=NULL;
	for(int i=0;i<n;i++)
	{
		p=new LNode;
		p->data=a[i];
		if(L!=NULL)
			p->next=L;
		else p->next=NULL;
		L=p;
	}
}

void ListTraverse(LinkList &L)
{
	LinkList p=L;
	 while(p != NULL)
	 {
		 cout<<p->data<<" ";
		 p = p->next;
	 }
	cout<<endl;
}

void HeapSort(String_Hash *String ,int size);
void BuildHeap(String_Hash *String ,int size);
void PercolateDown(String_Hash *String , int index,int size);
void Swap(String_Hash *String , int v, int u);
void HeapSort2(int *a ,int size);
void BuildHeap2(int *a ,int size);
void PercolateDown2(int *a, int index,int size);
void Swap2(int *a , int v, int u);

 void HeapSort2(int *a ,int size)
{
    int i;
    int iLength=size;
    BuildHeap2(a,size);// ����С����   
    for (i = iLength - 1; i >= 1; i--) {   
        Swap2(a, 0, i);// ����   
        size--;// ÿ����һ���ù�ģ����һ��   
        PercolateDown2(a, 0,size);// ���µ���Ԫ�����˲��� 
    }
}

void BuildHeap2(int *a ,int size) 
{ 
    int i; 
    for (i = size / 2 - 1; i >= 0; i--) {// ��ǰһ��Ľڵ㣨����Ϊ�������һ����Ҷ�ӽڵ㿪ʼ����ÿ�����ڵ㶼����Ϊ��С�ѡ�������һЩ��   
        PercolateDown2(a, i,size);// �������˲���
    }   
}   
void PercolateDown2(int *a, int index,int size)
{   
    int min;// ������Сָ���±�   
    while (index * 2 + 1<size) 
	{	// �����������ڵ㣬�������ڵ���С   
        min = index * 2 + 1;// ��ȡ��ڵ���±�   
        if (index * 2 + 2<size) 
		{// ������������ҽڵ�   
            if (a[min]> a[index * 2 + 2]) {// �ͺ���ڵ�ֳ���С��   
                min = index * 2 + 2;// ��ʱ�ҽڵ��С�������min��ָ���±�   
            }   
        }   
        // ��ʱ���и�������С�߽��бȽϣ�   
        if (a[index] < a[min]) 
		{// ���index��С��   
            break;// ֹͣ���˲���   
        } 
		else 
		{   
            Swap2(a, index, min);// �������������ô������³�   
            index = min;// ����index��ָ��   
        }   
    }// while   
}
void Swap2(int *a , int v, int u)
{  
    int temp =a[v];   
    a[v]=a[u];   
    a[u]=temp;  
}   

void HeapSort(String_Hash *String ,int size)
{
    int i;
    int iLength=size;
    BuildHeap(String,size);// ����С����   
    for (i = iLength - 1; i >= 1; i--) {   
        Swap(String, 0, i);// ����   
        size--;// ÿ����һ���ù�ģ����һ��   
        PercolateDown(String, 0,size);// ���µ���Ԫ�����˲��� 
    }
}

void BuildHeap(String_Hash *String ,int size) { 
    int i; 
    for (i = size / 2 - 1; i >= 0; i--) {// ��ǰһ��Ľڵ㣨����Ϊ�������һ����Ҷ�ӽڵ㿪ʼ����ÿ�����ڵ㶼����Ϊ��С�ѡ�������һЩ��   
        PercolateDown(String, i,size);// �������˲���
    }   
}   
void PercolateDown(String_Hash *String , int index,int size)
{   
    int min;// ������Сָ���±�   
    while (index * 2 + 1<size) 
	{// �����������ڵ㣬�������ڵ���С   
        min = index * 2 + 1;// ��ȡ��ڵ���±�   
        if (index * 2 + 2<size) 
		{// ������������ҽڵ�   
            if (String[min].Hash > String[index * 2 + 2].Hash) {// �ͺ���ڵ�ֳ���С��   
                min = index * 2 + 2;// ��ʱ�ҽڵ��С�������min��ָ���±�   
            }   
        }   
        // ��ʱ���и�������С�߽��бȽϣ�   
        if (String[index].Hash < String[min].Hash) 
		{// ���index��С��   
            break;// ֹͣ���˲���   
        } else 
		{   
            Swap(String, index, min);// �������������ô������³�   
            index = min;// ����index��ָ��   
        }   
    }// while   
}
void Swap(String_Hash *String , int v, int u)
{  
	String_Hash temp;
	temp=String[v];
	String[v]=String[u];
	String[u]=temp;
}   

void MaxHeapAjust3(LinkList *L, int i, int len)            //�����ڵ�i������������
{
    int l = 2*i;
    int r = 2*i+1;
    int largest;
	LinkList tmp;
	if (l <= len &&L[l - 1]->data > L[i - 1]->data)
    {
        largest = l;
    }
    else
    {
        largest = i;
    }
	if (r <= len && L[r - 1]->data> L[largest - 1]->data)
    {
        largest = r;
    }

    if (i != largest)
    {
		tmp = L[i - 1];                        
		L[i - 1]=L[largest - 1];
		L[largest - 1]= tmp;
        MaxHeapAjust3(L, largest, len);
    }
}

void BuildMaxHeap3(LinkList *L, int len)                    //��������
{
    for (int i = len / 2; i > 0; i--)
    {
        MaxHeapAjust3(L, i, len);
    }
}

void HeapSort3(LinkList *L, int len)                        //������
{
    LinkList tmp;
    BuildMaxHeap3(L, len);
    for (int i = len; i > 1; i--)
    {
		tmp = L[i - 1];
		L[i - 1]= L[0];
		L[0]= tmp;
        MaxHeapAjust3(L, 1, i - 1);
    }
}

int main()
{
	int i,Num,flag=0,k,piece=0;
	cin>>Num;
	String_Hash *String=new String_Hash[Num];
	for(i=0;i<Num;i++)
	{
		String[i].order=i;
		char *temp=new char[1000000];
		cin>>temp;
		String[i].Hash=BKDRHash(temp);
		String[i].Hash2=ELFHash(temp);
		String[i].Hash3=Hash_Int(temp);
		String[i].Hash4=PJWHash(temp);
		delete []temp;
	}
	HeapSort(String ,Num);
	/*for(i=0;i<Num;i++)
		cout<<String[i].order<<" ";
	cout<<endl;
	for(i=0;i<Num;i++)
		cout<<String[i].Hash<<" ";
	cout<<endl;
	for(i=0;i<Num;i++)
		cout<<String[i].Hash2<<" ";
	for(i=0;i<Num;i++)
		cout<<String[i].Hash3<<" ";
	cout<<endl;*/
	LinkList *L=new LinkList[Num];
	for(int s=0;s<Num;s++)
		InitList(L[s]);
//�ҵ�ÿ��Ƭ���������򣬴浽��������õ��������飬deleteԭ����String����.�ٸ���ͷָ���С�����������������
	i=1;
	while(i<Num)
	{
		if(String[i-1].Hash!=String[i].Hash||String[i-1].Hash2!=String[i].Hash2||String[i-1].Hash3!=String[i].Hash3||String[i-1].Hash4!=String[i].Hash4)
		{
			flag+=0;
			i++;
		}
		else
		{
			flag=1;
			k=2;
			while(i+k-1<Num)
			{
				if(String[i].Hash==String[i+k-1].Hash&&String[i].Hash2==String[i+k-1].Hash2&&String[i].Hash3==String[i+k-1].Hash3&&String[i].Hash4==String[i+k-1].Hash4)
					k++;
				else break;
			}
			int *m=new int[k];
			for(int f=0;f<k;f++)
				m[f]=String[i+f-1].order;
			HeapSort2(m ,k);
			for(int f=0;f<k;f++)
			{
				HeadInsert(L[piece],k,m);
			}
			delete []m;
			i+=k;
			piece++;
		}
	}
	delete[]String;
	if(flag==0)
		cout<<-1;
	HeapSort3(L,piece);
	for(int l=0;l<piece;l++)
			ListTraverse(L[l]);
}