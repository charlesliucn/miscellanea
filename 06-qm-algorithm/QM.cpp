/*Q-M�㷨��ʵ��*/
#include<iostream>
using namespace std;

int Pow(int a,int b)//�����������ݺ���(ʹ��VS�Դ���powʱ���ֿ��ܳ��ָ������)
{
	int num=1;
	for(int i=0;i<b;i++)//����a��b�η���a��b��Ϊ����
		num*=a;
	return num;
}
int num_prime_implicant=0;//��¼��ԭ�̺������Ŀ

class Term//��ʾ����࣬���ڴ洢��С����޹���
{ 
public:
	Term(){next=NULL;}//���캯��
	void Newt(int n,int num);//���ã���������һ������
	int Get_One()		{	return  num_of_ones;	}
	void Set_com(Term *t,int *mark,int n);
	void SetNULL(Term **t,int num);
	int *binary;//binary�������ڴ�������Ķ����Ʊ�ʾ���á�-1����ʾ��-��
	Term *next;//ָ��1����Ŀ��ͬ����һ��Term��
	int num_of_ones;//num_of_ones���ڼ�¼�����Ʊ�ʾ�������к��е�1�ĸ���
	bool status;//true��ʾ����һ����ԭ�̺���
};

void Term::Newt(int n,int num)//�趨�µ����������
{
	binary=new int[n];//��̬�������飬���ڴ洢��Ķ�������ʽ���
	int temp=num,count=0;//countΪ������1����Ŀ
	for(int i=0;i<n;i++)//�����numת��Ϊ��������ʽ
	{
		binary[i]=temp%2;
		if(binary[i]==1) 
			count++;
		temp=temp/2;
	}
	num_of_ones=count;//�õ�1����Ŀ
	status=1;//�ȼ���Ϊ��ԭ�̺���
	next=NULL;//����ָ��NULL
}

void Term::Set_com(Term *t,int *mark,int n)//���úϲ���
{
	status=1;//�ȼ���ϲ���Ϊ��ԭ�̺���
	num_of_ones=t->num_of_ones;//t��1�ĸ�����Ϊ�ϲ����1�ĸ���
	next=NULL;
	binary=new int[n];
	for(int i=0;i<n;i++)//�Ƚ�t�Ķ�������ʽ�����ϲ���
		binary[i]=t->binary[i];
	binary[*mark]=-1;//�ٽ����˱�ǲ�ͬ����һbit��ֵΪ-1����ʾ-
}
void SetNULL(Term **t,int num)//��ÿ���ָ����ΪNULL
{
	for(int i=0;i<num;i++)
		t[i]=NULL;
}

void cout_binary(Term *t, int n)//�������
{
	for(int i=n-1;i>=0;i--)//�Ӹ�λ����λ����Ĳ��Ƕ�������ʽ
	{
		if(t->binary[i]==-1)//�����ʽ�����-��
			cout<<'-';
		else cout<<t->binary[i];
	}
}

int Compare(Term *t1,Term *t2,int n,int *mark)//�Ƚ����ͬ1�ĸ���������ȷ���Ƿ���Ժϲ�
{
	int count=0;//���ڼ���(t1��t2�в�ͬ��1�ĸ���)
	for(int j=0;j<n;j++)
	{
		if(t1->binary[j]!=t2->binary[j]) 
		{
			count++;
			*mark=j;//��ǲ�ͬ���Ǹ�bit
		}
	}
	return(count);//����ֵΪ1ʱ������a��b����ֻ��1bit��ͬ������Ժϲ�
}

void Linkterm(int i,Term *sameone,Term **head,Term **current)//ͨ��ָ�뽫������ͬ��1����С��(���޹���)����һ��i��ʾ��������ʽ��1�ĸ����������������н�������
{
	if(head[i]!=NULL) //�������Ϊ��
	{
		current[i]->next=sameone;//����������Ѵ���1�ĸ���Ϊi�������������
		current[i]=sameone;//��ǰָ��ָ���¼ӵ���
	}
	else//����Ϊ��ʱ
	{	//ͷָ��͵�ǰָ���ָ�����
		head[i]=sameone;
		current[i]=sameone;
	}
}

bool Check_UnREP(Term *t,Term**prime_implicant,int n)//���������ɵı�ԭ�̺����Ƿ����ظ�,�ظ�����false�����ظ�����true
{
	int *m=new int;
	if (num_prime_implicant==0) 
		return true;//��ʱû�б�ԭ�̺���
	for(int i=0;i<num_prime_implicant;i++)
	{
		if(Compare(t,prime_implicant[i],n,m)==0) 
			return false;//��ʱ�����ظ�
	}
	return true;//?
}

bool Compare_Term(Term *t,Term *&head1,Term *&head2,Term**prime_implicant,int n)//�Ƚ���Ŀ���Ƿ񻹴����ܹ��ϲ�����
{
	int *mark=new int;
	Term *current1=head1;//current1ָ�������Աȵ���
	Term *current2=head2;//current2ָ�������ɵ���
	while(current2!=NULL&&current2->next!=NULL)//��current2�Ƶ���β
	{
		current2=current2->next;
	}
	while(current1->next!=NULL)//������������
	{
		if(Compare(t,current1,n,mark)==1)//������t�ͱ������Աȵ���current1���Ժϲ�����������Ǳ�ԭ�̺���
		{
			//���t��current1��Ǳ�ԭ�̺���
			t->status=0;
			current1->status=0;
			if(head2==NULL)//����head2Ϊ�գ������ɱ�ͷ��㣬��ǰָ��ָ���ͷ
			{
				head2=new Term;
				current2=head2;
			}
			else//����Ϊ��ʱ������β���������ǰָ��ָ������
			{
				current2->next=new Term;
				current2=current2->next;
			}
			current2->Set_com(t,mark,n);
		}
		current1=current1->next;
	}
	if(Compare(t,current1,n,mark)==1)//������t�ͱ������Աȵ���current1���Ժϲ�����������Ǳ�ԭ�̺���
	{
		//���t��current1��Ǳ�ԭ�̺���
		t->status=0;
		current1->status=0;
		if(head2==NULL)//����head2Ϊ�գ������ɱ�ͷ��㣬��ǰָ��ָ���ͷ
		{
			head2=new Term;
			current2=head2;
		}
		else//����Ϊ��ʱ������β���������ǰָ��ָ������
		{
			current2->next=new Term;
			current2=current2->next;
		}
		current2->Set_com(t,mark,n);
	}
	if(t->status==1)//��ԭ�̺���
	{
		if(Check_UnREP(t,prime_implicant,n))//��û���ظ���
		{
			prime_implicant[num_prime_implicant]=t;
			num_prime_implicant++;
		}
		return true;//����true ��ʾt�Ǳ�ԭ�̺���
	}
	else return false;
}

void Check_prime_implicant(Term *t,Term**prime_implicant,int n)//��鱾ԭ�̺������������
{
	while(t->next!=NULL)//��������
	{
		if(t->status==1&&Check_UnREP(t,prime_implicant,n))//�Ǳ�ԭ�̺����Ҳ������ظ�
		{
			prime_implicant[num_prime_implicant]=t;//���뱾ԭ�̺�������
			num_prime_implicant++;//����+1
		}
		t=t->next;//��һ�������
	}
	if(t->status==1&&Check_UnREP(t,prime_implicant,n))
	{
		prime_implicant[num_prime_implicant]=t;
		num_prime_implicant++;
	}
}

void QM(Term**t_head,Term**t_current,Term**prime_implicant,int n)
{
	bool flag=0;
	while(flag==0)//��ʾ���ڷǱ�ԭ�̺����Ҫ���кϲ�
	{
		flag=1;
		for(int i=0;i<=n;i++)//��������ͷָ��ָ����һ����
		{
			t_current[i]=t_head[i];
			t_head[i]=NULL;
		}
		for(int i=0;i<n;i++)
		{
			if(t_current[i]==NULL) 
				continue;//ָ��Ϊ�գ���������
			if(t_current[i+1]==NULL)
			{
				 Check_prime_implicant(t_current[i],prime_implicant,n);//����Ƿ�Ϊ��ԭ�̺���
				 continue;
			}
			while(t_current[i]->next!=NULL)//�Ƚ�ÿһ���Ƿ�Ϊ��ԭ�̺���
			{
				if(Compare_Term(t_current[i],t_current[i+1],t_head[i],prime_implicant,n)==0)//�������ܹ��ϲ�����
					flag=0;
				t_current[i]=t_current[i]->next;//����
			}
			if(Compare_Term(t_current[i],t_current[i+1],t_head[i],prime_implicant,n)==0)//�������ܹ��ϲ�����
				flag=0;
		}
	}
}

void CreateMatrix(bool**minimum,Term*prime_implicant,int *num_m,int m,int n,int row)//�����б�ԭ�̺�����ɾ��󣨱�ԭ�̺�ͼ��
{
	int count=0,num_of_ones=1,sum=0,c;//countΪ��-���ĸ�����sumΪ�ǡ�-��Ԫ�صĺ�
	for(int i=0;i<n;i++)
	{
		if(prime_implicant->binary[i]==-1) 
			count++;//����
		else sum+=prime_implicant->binary[i]*Pow(2,i);//תΪʮ���ƣ�sumΪ�ǡ�-��Ԫ�صĺ�
	}
	num_of_ones=Pow(2,count);//��ʾ�˺ϲ���ϲ�����С������޹�����ܸ���
	int *one=new int[num_of_ones];	//��¼��ԭ�̺�������������С��޹���ʮ���Ʊ��
	int *a=new int[count];//��¼��-������ľ�����ֵ
	int j=0;
	for(int i=0;i<n;i++)
	{
		if(prime_implicant->binary[i]==-1)
		{
			a[j]=Pow(2,i);
			j++;
		}
	}
	int *help=new int[count];
	for(int i=0;i<num_of_ones;i++)
	{
		c=i;
		one[i]=0;
		for(j=0;j<count;j++)
		{
			one[i]=one[i]+(c%2)*a[j];
			c=c/2;
		}
		one[i]=one[i]+sum;
	}
	for(int i=0;i<num_of_ones;i++)
	{
		for(j=0;j<m;j++)
		{
			if(one[i]==num_m[j]) 
				minimum[row][j]=1;
		}
	}
}
int Matrix_Column(bool**minimum,int column,int &row)
{
	int count=0;
	for(int i=0;i<num_prime_implicant;i++)//��ԭ�̺����γɾ��󣨱�ԭ�̺�ͼ���е�column��ֻ��1��
	{
		if(minimum[i][column]==1) 
		{
			count++;
			row=i;
		}
	}
	return(count);
}

void Mini_Cover(bool**minimum,Term**minicover,Term**prime_implicant,int m,int &num)//Ѱ����С����
{
	int row=0;
	bool *flag=new bool[m];//��¼��ǰ����С���Ƿ񱻸���
	for(int i=0;i<m;i++)//�Ƚ����е���С��ȫ���Ϊδ������
		flag[i]=0;
	for(int i=0;i<m;i++)
	{
		if(flag[i]==0&&Matrix_Column(minimum,i,row)==1)//�ھ���(��ԭ�̺�ͼ)�У���һ���н���һ����ǳ���ʱ���ñ�ԭ�̺�����Ǳ��ʱ�ԭ�̺���
		{
			minicover[num]=prime_implicant[row];
			num++;
			for(int j=0;j<m;j++)
			{
				if(minimum[row][j]==1) 
					flag[j]=1;
			}
		}
	}
	for(int i=0;i<m;i++)//��һ���н���һ����ǳ���ʱ���ñ�ԭ�̺�����Ǳ��ʱ�ԭ�̺���
	{
		if(flag[i]==0)
		{
			Matrix_Column(minimum,i,row);
			minicover[num]=prime_implicant[row];
			num++;
			for(int j=0;j<m;j++)
			{
				if(minimum[row][j]==1)
					flag[j]=1;
			}
		}
	}
	delete flag;
}

void Delete_REP(Term**minicover,Term **mini_com,int *num_m,int m,int n,int num1,int &num2)
{
	bool **min=new bool*[num1];
	for(int i=0;i<num1;i++)
	{
		min[i]=new bool[m];
	}
	for(int i=0;i<num1;i++)//���Ƚ�����ֵΪ0
	{	
		for(int j=0;j<m;j++)
		{
			min[i][j]=0;
		}
	}
	for(int i=0;i<num1;i++)
	{
		CreateMatrix(min,minicover[i],num_m,m,n,i);//ʹ��ÿһ����ԭ�̺�������д����
	}
	bool *flag=new bool[m];//flag���ڼ�¼��ǰ����С���Ƿ��Ѿ�������
	for(int i=0;i<num1;i++)
	{
		for(int j=0;j<m;j++)//���Ƚ����б����Ϊ0
		{
			flag[j]=0;
		}
		for(int k=0;k<num1;k++)
		{
			if(k!=i)
			{
				for(int j=0;j<m;j++)//��ȥ��ǰ��������⣬�����������һ�����
				{
					if(min[k][j]==1)
						flag[j]=1;
				}
			}
		}
		for(int j=0;j<m;j++)
		{
			if(flag[j]==0) 
			{
				mini_com[num2]=minicover[i];
				num2++;
				break;
			}
		}
	}
}



int main()
{
	int n,m1,m2,b;
	cout<<"�������Ա�������"<<endl;
	cin>>n;
	if(n<=0||n>10)//�Ƿ����봦��Ҫ���������С�ڵ���10
	{
		cout<<"��������������1~10֮���������"<<endl;
		system("pause");
		return 0;
	}
	cout<<"��������С����Ŀ��"<<endl;
	cin>>m1;
	if(m1<=0||m1>Pow(2,n))//�Ƿ����봦����С�������������2��n�η�
	{
		cout<<"��������"<<endl;
		system("pause");
		return 0;
	}
	int *num_m=new int[m1];
	cout<<"��������С�����б�"<<endl;
	for(int i=0;i<m1;i++)
	{
		cin>>num_m[i];
		if(num_m[i]<0||num_m[i]>=Pow(2,n))//�Ƿ����봦����С��ı�����Ϊ2��n�η�-1
		{
			cout<<"��������"<<endl;
			system("pause");
			return 0;
		}
	}
	cout<<"�������޹�����Ŀ��"<<endl;
	cin>>m2;
	int *num_d=new int[m2];//����num_d,num_m�������ڴ洢�޹������С�������
	if(m2<0||m2>Pow(2,n))//�Ƿ����봦����С�������������2��n�η�
	{
		cout<<"��������"<<endl;
		system("pause");
		return 0;
	}
	//���޹�����ĿΪ0ʱ���޹���ֲ����в�����
	else if(m2!=0)
	{
		cout<<"�������޹������б�"<<endl;
		for(int i=0;i<m2;i++)
		{
			cin>>num_d[i];
			if(num_d[i]<0||num_d[i]>=Pow(2,n))//�Ƿ����봦����С��ı�����Ϊ2��n�η�-1
			{
				cout<<"��������"<<endl;
				system("pause");
				return 0;
			}
		}
	}
	/*����Ϊ����ͶԷǷ�����Ĵ�����*/

	int Sum=m1+m2;
	int min_num=0;//���ڼ�¼ɾȥ�ظ�֮�����С���ǰ����ı��ʱ�ԭ�̺���ĸ���
	int num_cover=0;//��¼��С���Ǻ��е���ĸ���
	Term *init=new Term[Sum];//Term����init���ڴ�ų�ʼ��Term
	Term **prime_implicant=new Term*[Sum];//��̬����Termָ�룬��Ǻϲ�����֮��ı�ԭ�̺���
	Term **mincover=new Term*[m1];//��̬����Termָ�룬�����С������
	Term **t_head=new Term*[n+1];//a,b����ָ�������ںϲ������м�¼������ͬ1��Ŀ����Ŀ
	Term **t_current=new Term*[n+1];
	SetNULL(t_head,n+1);
	SetNULL(t_current,n+1);
	Term *current;
	for(int i=0;i<m1;i++)//Ϊ��ʼ����С������ֵ
	{
		init[i].Newt(n,num_m[i]);
		current=&init[i];
		b=init[i].Get_One();
		Linkterm(b,current,t_head,t_current);
	}
	for(int i=0;i<m2;i++)//Ϊ��ʼ���޹�������ֵ
	{
		init[i+m1].Newt(n,num_d[i]);
		current=&init[i+m1];
		b=init[i+m1].Get_One();
		Linkterm(b,current,t_head,t_current);//���޹���������С��֮��
	}
	QM(t_head,t_current,prime_implicant,n);//QM�㷨
	bool **min=new bool*[num_prime_implicant];//������С���Ǿ���,����Ϊ��ԭ�̺���ĸ���������Ϊ��С��ĸ�������һ�д����С������
	for(int i=0;i<num_prime_implicant;i++)
	{
		min[i]=new bool[m1];
	}
	for(int i=0;i<num_prime_implicant;i++)//���Ƚ�����ֵΪ0
	{	
		for(int j=0;j<m1;j++)
			min[i][j]=0;
	}
	for(int i=0;i<num_prime_implicant;i++)//ʹ�õõ��ĺϲ���Ծ�����и�ֵ
		CreateMatrix(min,prime_implicant[i],num_m,m1,n,i);
	Mini_Cover(min,mincover,prime_implicant,m1,num_cover);
	Term  **mini_com=new Term*[num_cover];//���ڼ�¼ɾȥ�ظ�֮�����С���ǰ����ı��ʱ�ԭ�̺���
	Delete_REP(mincover,mini_com,num_m,m1,n,num_cover,min_num);
	cout<<"����QM�㷨��������"<<endl;
	for(int i=0;i<min_num;i++)//������б�ԭ�̺���
	{
		cout_binary(mini_com[i],n);
		cout<<" ";
	}
	cout<<endl;
	system("pause");
}
