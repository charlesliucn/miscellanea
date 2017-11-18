//ͷ�ļ���Class.h�����������е��༰��Ա����
#include<iostream>
#include<iomanip>//���������ʽ
#include<cstdlib>
#include<string>//�����������е��ַ���ʹ��C++�Դ���string��
#include<fstream>//�ļ�������
#define M 500//����ϵͳ���鼮���������
#define N 10//ÿλ���߽���ͼ����Ŀ������
#define Q 20//ϵͳ�Ķ����û�����
using namespace std;
void BF()	//��Beautify�����������������ĺ���[�����������-�������в�θ�]
{
	for(int i=0;i<115;i++)//�˴����115��-�����������exe�ļ������Ҫ�ı�Ĭ�ϳ��ȣ�80��Ϊ150
		cout<<"-";
	cout<<endl;
}
class Base//���࣬������Book��Reader��
{
public:
	Base(){};
};
class Book:virtual public Base//Book��̳������
{
public:
	Book(string name,string author, string publisher,string subject,string isbn,string price,int year,int month);//���캯��
	Book();//Ĭ�Ϲ��캯��
	void From_File(string name,string author, string publisher,string subject,string isbn,string price,int year,int month);//���ļ��а�˳����ͼ����Ϣ
	string GetName();//��ȡͼ�������
	string GetSubject();//��ȡͼ��������ѧ��
	string GetISBN();//��ȡͼ��ISBN��
	string GetAuthor();//��ȡͼ�����ߵ�����
	string GetPublisher();//��ȡ��Ӧ������
	string GetPrice();//��ȡͼ��۸�
	int GetYear();//��ȡ�������
	int GetMonth();//��ȡ�����·�
	int GetStatus();//��ȡͼ��״̬��ͨ��ͼ���״̬��ʾ�Ƿ���Խ��ģ�
	void Delete();//��ͼ�����ɾ������
	friend ostream & operator << (ostream &out, Book const &book);//ͨ����Ԫ�������С�<<�����������أ�һ�������Book�����������Ϣ
private://˽�г�Ա�������⵽����
	string Name,Author,Publisher,Price,Subject,ISBN;
	int Year,Month;
	int status;//ָʾͼ��ϵͳ���Ƿ��и���
};
Book::Book(string name,string author,string publisher,string subject,string isbn, string price,int year,int month)
{
	Name=name;		Author=author;	Publisher=publisher;
	Subject=subject;	ISBN=isbn;			Price=price;
	Year=year;			Month=month;		status=1;
}
Book::Book()//Ĭ�Ϲ��캯����û��ͼ����Ϣ
{
	Name=" ";			Author=" ";			Publisher=" ";
	Subject=" ";			ISBN=" ";				Price=" ";
	Year=0;				Month=0;				status=0;
}
void Book::From_File(string name,string author, string publisher,string subject,string isbn,string price,int year,int month)
{
	Name=name;		Author=author;	Publisher=publisher;
	Subject=subject;	ISBN=isbn;			Price=price;
	Year=year;			Month=month;		status=1;
}
string Book::GetName()
{
	return Name;
}
string Book::GetSubject()
{
	return Subject;
}
string Book::GetISBN()
{
	return ISBN;
}
string Book::GetAuthor()
{
	return Author;
}
string Book::GetPublisher()
{
	return Publisher;
}
string Book::GetPrice()
{
	return Price;
}
int Book::GetYear()
{
	return Year;
}
int Book::GetMonth()
{
	return Month;
}
int Book::GetStatus()
{
	return status;
}
void Book::Delete()
{
	status=0;//��״̬������Ϊ0,��ʾ��ͼ���Ѿ�������ϵͳ��
}
ostream & operator << (ostream &out, Book &book)//���ͼ���������Ϣ
{
	cout<<setiosflags(ios::left)<<setw(25)<<book.GetName()<<setw(20)<<book.GetAuthor()<<setw(20)<<book.GetPublisher()<<setw(8)<<book.GetSubject()
		<<setw(20)<<book.GetISBN()<<setw(10)<<book.GetPrice()<<setw(4)<<book.GetYear()<<"��"<<setw(2)<<book.GetMonth()<<"��"<<endl;
	return out;
}
class Manage_Book//����ͼ���࣬������Ա�а��� Book��Ķ�������
{
public:
	Manage_Book(){};//Ĭ�Ϲ��캯��
	void In_Book_File();//��ͼ����Ϣ���ļ��е���ϵͳ
	void Add();//���ͼ����Ϣ
	void Search();//��ѯͼ��
	void Display();//��ʾϵͳ������ͼ��
	void Delete();//ɾ��ͼ����Ϣ
	void All_Clear();//ɾ��ϵͳ������ͼ��
	int Borrow(string isbn);//��ISBN��Ϊ�βν����鼮
	void Return(string isbn);//��ISBN��Ϊ�βι黹�鼮
	void Show(string isbn);//��ISBN��Ϊ�β���ʾͼ����Ϣ
	int GetNum();//��ȡϵͳ��Ŀǰ��ͼ����Ŀ
protected:
	int Num;
	Book book[M];//Book��Ķ���������Ϊ������Ա
};
void Manage_Book::In_Book_File()
{
	ifstream In_Book;
	string name,author,	 publisher,subject,isbn,price;
	int year,month;
	In_Book.open("E:\\book.txt",ios::out);//���ļ� &   E����book.txt�ļ���ΪĬ�ϵ�ͼ����Ϣ����·��
	if(In_Book==0)
	{
		cout<<"*****************ϵͳ��ͼ�����ʧ�ܣ�����ϵ������Ա*****************"<<endl;
		exit(0);
	}
	else 
	{
		Num=0;
		while(In_Book&&!In_Book.eof()&&Num<M)
		{
			In_Book>>name>>author>>publisher>>subject>>isbn>>price>>year>>month;//����ͼ����Ϣ
			book[Num].From_File(name,author,publisher,subject,isbn,price,year,month);//�����������
			Num++;
		}
		In_Book.close();//�ر��ļ�
	}
}
void Manage_Book::Add()//���ͼ����Ϣ
{
	if(Num==M)
	{		
		cout<<"******�Բ���ϵͳ�����������޶���洢�ռ䣡�볢����������******"<<endl;
		exit(0);
	}
	else
	{
		Num=Num+1;
		int i=0 ,year,month;		char command;
		In_Book_File();//����ͼ����Ϣ
		string name,author,publisher,subject,isbn,price;
		cout<<"***************************         ���ͼ��        *************************"<<endl;
		cout<<"�밴�����²��������Ŀ��"<<endl;
		cout<<"****������������";		cin>>name;
		cout<<"****���������ߣ�";		cin>>author;
		cout<<"****����������磺";	cin>>publisher;
		cout<<"****������ѧ�����"<<endl<<"��ע�⡿��ǰ�����У���ѧ����ᡢ��Ȼ����������������������������Ӧ���"<<endl;
		cin>>subject;
		cout<<"****������ISBN�ţ�";		cin>>isbn;
		cout<<"****������۸�";		cin>>price;
		cout<<"****��������ݣ�";		cin>>year;
		cout<<"****�������·ݣ�";		cin>>month;
		book[Num-1].From_File(name,author,publisher,subject,isbn,price,year,month);//�µ�Book�����
		cout<<"��Ŀ��ӳɹ���"<<endl;
		BF();//���һ�С�-����������
		cout<<setiosflags(ios::left)<<setw(25)<<"����/��Ŀ"<<setw(20)<<"����"<<setw(20)<<"������"<<setw(8)<<"ѧ��"
			<<setw(20)<<"ISBN��"<<setw(10)<<"�۸�"<<setw(4)<<"��������"<<endl;
		BF();//���һ�С�-����������
		cout<<book[Num-1];
	    BF();//���һ�С�-����������
		cout<<"�������ͼ��ô����������Y����������N"<<endl;
		cin>>command;
		if(command=='s'||command=='S')
			Add();
		else exit(0);
	}
}
void Manage_Book::Search()//��ѯ/����ͼ��
{
	int command,i=0,flag=0;
	char Next;
	string a;
	In_Book_File();//����ͼ����Ϣ�ļ�
	cout<<"***************************            ������Ŀ       *************************"<<endl;
	cout<<"***************************           1.��ȷ��ѯ      *************************"<<endl;
	cout<<"***************************           2.ģ����ѯ      *************************"<<endl;
	cout<<"****���������Ĳ�ѯ��ʽ:";
	cin>>command;
	if(command==1)
	{
		cout<<"***************************            ��ȷ��ѯ       *************************"<<endl;
		cout<<"****��������Ҫ��ѯ�����ISBN��"<<endl;
		cin>>a;
		cout<<"****��ѯ�����"<<endl;
		BF();//����
		cout<<setiosflags(ios::left)<<setw(25)<<"����/��Ŀ"<<setw(20)<<"����"<<setw(20)<<"������"<<setw(8)<<"ѧ��"
				<<setw(20)<<"ISBN��"<<setw(10)<<"�۸�"<<setw(4)<<"��������"<<endl;
		BF();//����
		for(i=0;i<Num;i++)
		{
			if(book[i].GetISBN()==a)
				cout<<book[i];
			flag=1;
			break;
		}
		BF();//����
		if(flag==0)
			cout<<"δ�鵽���飡"<<endl;
		cout<<"������ѯ������Y���˳�����N"<<endl;
		cin>>Next;
		if(Next=='Y'||Next=='y')
			Search();
		else exit(0);
	}
	else if(command==2)
	{
		int command2;
		cout<<"***************************	     ģ����ѯ         *************************"<<endl;
		cout<<"***************************      1.����������ѯ       *************************"<<endl;
		cout<<"***************************      2.�������߲�ѯ       *************************"<<endl;
		cout<<"***************************      3.���ݳ������ѯ     *************************"<<endl;
		cout<<"***************************      4.����ѧ�Ʋ�ѯ       *************************"<<endl;
		cout<<"***************************      5.���ݳ������²�ѯ   *************************"<<endl;
		cout<<"****����������ѡ�";
		cin>>command2;
		switch(command2)
		{
		case 1://����������ѯ
			flag=0;
			cout<<"****������������"<<endl;	cin>>a;
			cout<<"****��ѯ�����"<<endl;
			for(i=0;i<Num;i++)
			{
				if(book[i].GetName()==a)
				{	
					BF();//����
					cout<<setiosflags(ios::left)<<setw(25)<<"����/��Ŀ"<<setw(20)<<"����"<<setw(20)<<"������"<<setw(8)<<"ѧ��"
							<<setw(20)<<"ISBN��"<<setw(10)<<"�۸�"<<setw(4)<<"��������"<<endl;
					cout<<book[i];
					BF();//����
					flag=1;
				}
				break;
			}
			BF();//����
			if(flag==0)
				cout<<"δ�鵽�����Ŀ"<<endl;
			cout<<"������ѯ������Y���˳�����N"<<endl;
			cin>>Next;
			if(Next=='Y'||Next=='y')
				Search();
			else exit(0);
			break;
		case 2://�������߲�ѯ
			flag=0;
			cout<<"****��������������"<<endl;		cin>>a;
			cout<<"****��ѯ�����"<<endl;			
			BF();//����
			cout<<setiosflags(ios::left)<<setw(25)<<"����/��Ŀ"<<setw(20)<<"����"<<setw(20)<<"������"<<setw(8)<<"ѧ��"
						<<setw(20)<<"ISBN��"<<setw(10)<<"�۸�"<<setw(4)<<"��������"<<endl;
			BF();//����
			for(i=0;i<Num;i++)
			{
				if(book[i].GetAuthor()==a)
					cout<<book[i];
				flag=1;
			}
			BF();//����
			if(flag==0)
				cout<<"δ�鵽�����Ŀ"<<endl;
			cout<<"������ѯ������Y���˳�����N"<<endl;
			cin>>Next;
			if(Next=='Y'||Next=='y')
				Search();
			else exit(0);
			break;
		case 3://���ݳ������ѯ
			flag=0;
			cout<<"������׼ȷ�ĳ��������ƣ�"<<endl;		cin>>a;
			cout<<"��ѯ�����"<<endl;
			BF();//����
			cout<<setiosflags(ios::left)<<setw(25)<<"����/��Ŀ"<<setw(20)<<"����"<<setw(20)<<"������"<<setw(8)<<"ѧ��"
					<<setw(20)<<"ISBN��"<<setw(10)<<"�۸�"<<setw(4)<<"��������"<<endl;
			BF();//����
			for(i=0;i<Num;i++)
			{
				if(book[i].GetPublisher()==a)
					cout<<book[i];
				flag=1;
			}
			BF();//����
			if(flag==0)
				cout<<"δ�鵽�����Ŀ"<<endl;
			cout<<"������ѯ������Y���˳�����N"<<endl;
			cin>>Next;
			if(Next=='Y'||Next=='y')
				Search();
			else exit(0);
			break;
		case 4://����ѧ�Ʋ�ѯ
			flag=0;
			cout<<"��ע�⡿��ǰ�����У���ѧ����ᡢ��Ȼ��������������������������Ҫ��ѯ�����:"<<endl;
			cin>>a;
			cout<<"��ѯ�����"<<endl;
			BF();//����
			cout<<setiosflags(ios::left)<<setw(25)<<"����/��Ŀ"<<setw(20)<<"����"<<setw(20)<<"������"<<setw(8)<<"ѧ��"
					<<setw(20)<<"ISBN��"<<setw(10)<<"�۸�"<<setw(4)<<"��������"<<endl;
			BF();//����
			for(i=0;i<Num;i++)
			{
				if(book[i].GetSubject()==a)
					cout<<book[i];
				flag=1;
			}
			BF();//����
			if(flag==0)
				cout<<"δ�鵽�����Ŀ"<<endl;
			cout<<"������ѯ������Y���˳�����N"<<endl;
			cin>>Next;
			if(Next=='Y'||Next=='y')
				Search();
			else exit(0);
			break;
		case 5://���ݳ������²�ѯ
			flag=0;
			int year,month;
			cout<<"�����������ݣ�";		cin>>year;
			cout<<"����������·ݣ�";		cin>>month;
			cout<<"��ѯ�����"<<endl;
			BF();//����
			cout<<setiosflags(ios::left)<<setw(25)<<"����/��Ŀ"<<setw(20)<<"����"<<setw(20)<<"������"<<setw(8)<<"ѧ��"
					<<setw(20)<<"ISBN��"<<setw(10)<<"�۸�"<<setw(4)<<"��������"<<endl;
			BF();//����
			for(i=0;i<Num;i++)
			{
				if(book[i].GetYear()==year&&book[i].GetMonth()==month)
					cout<<book[i];
				flag=1;
			}
			BF();//����
			if(flag==0)
				cout<<"δ�鵽�����Ŀ"<<endl;
			cout<<"������ѯ������Y���˳�����N"<<endl;
			cin>>Next;
			if(Next=='Y'||Next=='y')
				Search();
			else exit(0);
			break;
		default://���������
			system("cls");
			cout<<"�Բ������������������������룺"<<endl;
			Search();
		}
	}
	else
	{
		cout<<"�Բ������������������������룺"<<endl;
		Search();
	}
}
void Manage_Book::Display()//��ʾȫ��ͼ��
{
	int i=0;
	In_Book_File();
	cout<<"***************************         ȫ��ͼ��        *************************"<<endl;
	BF();//����
	cout<<setiosflags(ios::left)<<setw(25)<<"����/��Ŀ"<<setw(20)<<"����"<<setw(20)<<"������"<<setw(8)<<"ѧ��"
		<<setw(20)<<"ISBN��"<<setw(10)<<"�۸�"<<setw(4)<<"��������"<<endl;
	BF();//����
	i=0;
	while(i<Num&&book[i].GetStatus()==1)
	{	
		cout<<book[i];
		i++;
	}
	BF();//����
}
void Manage_Book::Delete()//ɾ��ͼ����Ϣ
{
	string isbn;
	int i=0,flag=0;
	In_Book_File();//����ͼ����Ϣ
	char command;
	cout<<"��������Ҫɾ����ͼ���ISBN�ţ�";
	cin>>isbn;
	for(i=0;i<Num;i++)
	{
		if(book[i].GetISBN()==isbn)
		{
			book[i].Delete();
			cout<<"��"<<book[i].GetName()<<"��"<<"ɾ����ϣ�"<<endl;
			flag=1;
		}
		break;
	}
	if(flag==0)
	{
		cout<<"ͼ�����ϵͳ��û�и��飡"<<endl;
		cout<<"****����ɾ��������Y���˳�������N"<<endl;
		cin>>command;
		if(command=='Y')
			Delete();
		else exit(0);
	}
}
void Manage_Book::All_Clear()//�������ͼ����Ϣ
{
	In_Book_File();
	cout<<"ɾ������ͼ����Ϣ"<<endl;
	for(int i=0;i<Num;i++)
	{
		cout<<"��"<<book[i].GetName()<<"��"<<"ɾ�����"<<endl;
		book[i].Delete();
	}
	cout<<"����ѿգ�"<<endl;
}
int Manage_Book::Borrow(string isbn)//����ISBN�Ž��鼮���
{
	int i=0,flag=0;
	In_Book_File();
	cout<<"***************************              ����          *************************"<<endl;
	for(i=0;i<Num;i++)
	{
		if(book[i].GetISBN()==isbn)
		{
			flag=1;return 1;
		}
	}
	if(flag==0)
		return 0;
	else return 0;
}
void Manage_Book::Return(string isbn)//����ISBN�Ž������ջأ����߹黹 ��
{
	int i=0,flag=0;
	In_Book_File();//����ȫ��ͼ����Ϣ
	cout<<"***************************             ����          *************************"<<endl;
	for(i=0;i<Num;i++)//ѭ��Ѱ��Ҫ������
	{	if(book[i].GetISBN()==isbn)
		{
			flag=1;
			cout<<"����ɹ���"<<endl;
		}
	}
	if(flag==0)
	{
		cout<<"�Բ����������"<<endl;
		exit(0);
	}
}
void Manage_Book::Show(string isbn)//����ISBN����ʾ�鼮��Ϣ
{
	int i=0,flag=0;
	In_Book_File();//�����鼮��Ϣ
	for(i=0;i<Num;i++)
	{
		cout<<setiosflags(ios::left)<<setw(25)<<"����/��Ŀ"<<setw(20)<<"����"<<setw(20)<<"������"<<setw(8)<<"ѧ��"
				<<setw(20)<<"ISBN��"<<setw(10)<<"�۸�"<<setw(4)<<"��������"<<endl;
		if(book[i].GetISBN()==isbn)
		{
			cout<<book[i];
			flag=1;	
			break;
		}
	}
	if(flag==0)
		cout<<"�Բ���û���ҵ����飡"<<endl;
}
int Manage_Book::GetNum()
{
	return Num;
}
class Reader:virtual public Base
{
public:
	Reader(string name,string id,string gender,string code);//���캯��
	Reader();//Ĭ�Ϲ��캯��
	void From_File(string name,string id,string gender,string code);//���ļ��е��������Ϣ
	int GetStatus();//��ȡ������ϵͳ�е�״̬��1��ʾ��ϵͳ�ڣ�0��ʾ�Ѵ�ϵͳ�����
	string GetCode();//��ȡ���ߵ�¼����
	string GetName();//��ȡ��������
	string GetID();//��ȡ����ID
	string GetGender();//��ȡ��������
	void Search();//���߲�ѯ�鼮��Ϣ
	void Borrow();//���߽���
	void Return();//���߻���
	void Display_Keeping();//��ʾĿǰ���ĵ��鼮
	void Delete();//ɾ��������Ϣ
	friend ostream & operator << (ostream &out, Reader const &r);//��Ԫ�������������أ���<<��ֱ�����������Ϣ
protected://������Ա
	string Name,ID,Gender,Code,Mybook[N];//ͼ���ȫ����Ϣ�Լ��Ѿ����ĵ�ͼ���ISBN��
	int Status,Num_Keeping;//״̬������Ŀǰ���ĵ�ͼ����Ŀ
};
Reader::Reader(string name,string id,string gender,string code)//���캯��
{
	Name=name;	ID=id;		Gender=gender;
	Code=code;		Status=1;	Num_Keeping=0;
}
Reader::Reader()//Ĭ�Ϲ��캯��
{
	Name=" ";	ID=" ";		Gender=" ";
	Code="0";	Status=0;	Num_Keeping=0;
}
void Reader::From_File(string name,string id,string gender,string code)//���ļ��ж��������Ϣ
{
	Name=name;	ID=id;		Gender=gender;
	Code=code;		Status=1;	Num_Keeping=0;
}
int Reader::GetStatus()//��ȡ�����û�״̬
{
	return Status;
}
string Reader::GetCode()//��ȡ��������
{
	return Code;
}
string Reader::GetName()//��ȡ��������
{
	return Name;
}
string Reader::GetID()//��ȡ����ID
{
	return ID;
}
string Reader::GetGender()//��ȡ�����Ա�
{
	return Gender;
}
void Reader::Search()//���ߵĲ�ѯͼ�鹦��
{
	Manage_Book MB;
	MB.Search();
}
void Reader::Borrow()//���鹦��
{
	if(Num_Keeping==N)
	{
		cout<<"�Բ������Ľ�����Ŀ�Ѿ��ﵽ�������"<<N<<"��"<<"���ܼ������顣"<<endl;
		exit(0);
	}
	else
	{
		string isbn;
		cout<<"��������Ҫ����鼮��ISBN�ţ�";
		cin>>isbn;
		Manage_Book MB;
		if(MB.Borrow(isbn)==1)
		{
			Num_Keeping++;
			Mybook[Num_Keeping-1]=isbn;//��������Ϊ���߽��ĵ���һ���� �浽���߽����鱾��string������
			cout<<"ISBN��Ϊ"<<isbn<<"��ͼ����ĳɹ���"<<endl;
			Display_Keeping();
		}
		else cout<<"�Բ��𣬸��鲻��ϵͳ�ڻ��ѱ����������δ�ɹ���"<<endl;
	}
}
void Reader::Return()//���鹦��
{
	if(Num_Keeping==0)
	{
		cout<<"�Բ�������ǰδ�����κ��鼮!"<<endl;
		exit(0);
	}
	else
	{
		string isbn;
		Manage_Book MB;
		cout<<"��������Ҫ����ͼ���ISBN�ţ�";
		cin>>isbn;
		MB.Return(isbn);
	}
}
void Reader::Display_Keeping()//��ʾĿǰ���ĵ��鼮
{
	Manage_Book MB;
	cout<<"Ŀǰ���ĵ������鼮�У�"<<endl;
	if(Num_Keeping==0)
		cout<<"û�н����鼮��"<<endl;
	else
	{
		for(int i=0;i<Num_Keeping;i++)
		MB.Show(Mybook[i]);
	}
}
void Reader::Delete()//ɾ��������Ϣ
{
	Status=0;
}
ostream & operator << (ostream &out, Reader &r)//��Ԫ�������������أ���<<��ֱ�����������Ϣ
{
	cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(15)<<"����֤��"<<setw(8)<<"�Ա�"<<endl;
	cout<<setiosflags(ios::left)<<setw(15)<<r.GetName()<<setw(15)<<r.GetID()<<setw(8)<<r.GetGender()<<endl;
	return out;
}
class Manage_Reader//������ߣ���ı�����Ա�а���Reader��Ķ�������
{
public:
	Manage_Reader(){};//���캯��
	void In_Reader_File();//���������Ϣ
	void Add();//��Ӷ�����Ϣ
	void Search();//��ѯ��������
	void Display();//��ʾ���ж��ߵ���Ϣ
	void Delete();//ɾ��������Ϣ
	void All_Clear();//������ж��ߵ���Ϣ
	void ShowOneself();//��ʾĳһ�����������Ϣ
	void Borrow();//����
	void Return();//����
	int GetCount();//��ȡĿǰϵͳ�洢�Ķ�����Ŀ
protected:
	Reader reader[Q];//Reader��Ķ���������Ϊ������Ա
	int Count;
};
void Manage_Reader::In_Reader_File()//���������Ϣ
{
	ifstream In_Reader;
	int i=0;
	string name,id,gender,code;
	In_Reader.open("E:\\reader.txt",ios::out);//������ϢĬ�ϴ洢���ı��ļ�E:\\reader.txt��
	if(In_Reader==0)
	{
		cout<<"ϵͳ�û�����ʧ�ܣ�"<<endl;
		exit(0);
	}
	else
	{
		Count=0;
		while(In_Reader&&!In_Reader.eof()&&Count<Q)//����˳�����ζ����ļ��еĶ�����Ϣ
		{
			In_Reader>>name>>id>>gender>>code;
			reader[i].From_File(name,id,gender,code);
			Count++;
			i++;
		}
		In_Reader.close();//�ر��ļ�
	}
}
void Manage_Reader::Add()//��Ӷ�����Ϣ
{
	In_Reader_File();//���������Ϣ
	if(Count==Q)
	{
		cout<<"�Բ����ݲ�֧�����û�ע��"<<endl;
		exit(0);
	}
	else
	{
		Count++;
		string name,id,gender,code;
		char command;
		cout<<"******����¶���******"<<endl;
		cout<<"�밴�����²�����Ӷ���"<<endl;//�������������Ϣ
		cout<<"������������";		cin>>name;
		cout<<"�������¼ID��";	cin>>id;
		cout<<"�������Ա�";		cin>>gender;
		cout<<"���������룺";		cin>>code;
		reader[Count-1].From_File(name,id,gender,code);
		cout<<"������Ϣ��ӳɹ���"<<endl;
		cout<<reader[Count-1];
		cout<<"������Ӷ���ô����������Y����������N"<<endl;
		cin>>command;
		if(command=='S'||command=='s')
			Add();//������Ӷ�����Ϣ
		else exit(0);
	}
}
void Manage_Reader::Search()
{
	int command,i=0,flag=0;
	string a;
	In_Reader_File();//���������Ϣ
	cout<<"******�����û�*******"<<endl;
	cout<<"1.��ȷ��ѯ"<<endl;
	cout<<"2.ģ����ѯ"<<endl;
	cout<<"���������Ĳ�ѯ��ʽ��";
	cin>>command;
	switch(command)
	{
	case 1://����ID���Ҷ����û�
		cout<<"��������Ҫ��ѯ���û���ID"<<endl;		cin>>a;
		cout<<"��ѯ�����"<<endl;
		for(i=0;i<Count;i++)
			if(reader[i].GetID()==a)
			{
				cout<<reader[i];
				reader[i].Display_Keeping();
				flag=1;
			}
		if(flag==0)
			cout<<"δ�鵽���û�!"<<endl;
		break;
	case 2:
		int command2;
		cout<<"1.����������ѯ��"<<endl;
		cout<<"2.�����Ա��ѯ��"<<endl;
		cout<<"����������ѡ�";
		cin>>command2;
		if(command2==1)//�����������Ҷ����û�
		{
			cout<<"��������Ҫ��ѯ�Ķ���������";
			cin>>a;
			cout<<"��ѯ���Ϊ��"<<endl;
			for(i=0;i<Count;i++)
			{
				if(reader[i].GetName()==a)
				{
					cout<<reader[i];
					reader[i].Display_Keeping();
					flag=1;
				}
			}
			if(flag==0)
				cout<<"δ�鵽���û���"<<endl;
		}
		else if(command2=2)//�����Ա��ѯ������Ϣ
		{
			cout<<"��������Ҫ��ѯ���Ա���/Ů����";
			cin>>a;
			cout<<"��ѯ���Ϊ��"<<endl;
			for(i=0;i<Count;i++)
			{
				if(reader[i].GetGender()==a)
				{
					cout<<reader[i];
					reader[i].Display_Keeping();
					flag=1;
				}
			}
			if(flag==0)
				cout<<"δ�鵽����û���"<<endl;
		}
		else
		{
			cout<<"�Բ���������������"<<endl;
			Search();
		};
		break;
	default:
		cout<<"�Բ���������������"<<endl;
		Search();//���������ѯ
	}
}
void Manage_Reader::Display()//��ʾ���еĶ�����Ϣ
{
	int i=0,k=0;
	In_Reader_File();//���ļ��е�����ߵ���Ϣ
	cout<<"��ʾ���ж����û������ĵ������鼮"<<endl;
	while(k<Count&&reader[k].GetStatus()==1)
	{
		BF();
		cout<<reader[k];
		reader[k].Display_Keeping();
		BF();
		k++;
	}
}
void Manage_Reader::Delete()//ɾ��ָ���Ķ�����Ϣ
{
	string id;	int i=0,flag=0;
	In_Reader_File();//���ļ��е��������Ϣ
	char command;
	cout<<"*******ɾ���û�*******"<<endl;
	cout<<"��������Ҫɾ���Ķ����û���ID��"<<endl;
	cin>>id;
	for(i=0;i<Count;i++)
	{
		if(reader[i].GetID()==id&&reader[i].GetStatus()==1)
		{
			reader[i].Delete();//ɾ���û���Ϣ
			cout<<"�û�"<<reader[i].GetName()<<"������Ϣɾ����ϣ�"<<endl;
			flag=1;
		}
		break;
	}
	if(flag==0)
	{
		cout<<"ͼ�����ϵͳ���޸��û�!"<<endl;
		cout<<"����ɾ�������롰Y�����˳������롰N��"<<endl;
		cin>>command;
		if(command=='Y')
			Delete();
		else	exit(0);
	}
}
void Manage_Reader::All_Clear()//���ȫ���û���Ϣ
{
	In_Reader_File();
	cout<<"***ɾ�������û���Ϣ*****"<<endl;
	for(int i=0;i<Count;i++)
	{
		cout<<"����ɾ����"<<i+1<<"λ�û�����Ϣ"<<endl;
		reader[i].Delete();//��һɾ��������Ϣ
	}
	cout<<"�����û���Ϣɾ����ϣ�"<<endl;
}
void Manage_Reader::ShowOneself()//��ʾ������Ϣ
{
	string code;
	int i=0,flag=0;
	In_Reader_File();//���������Ϣ
	cout<<"���ٴ������������룺"<<endl;
	cin>>code;
	BF();
	for(i=0;i<Count;i++)
	{
		if(reader[i].GetCode()==code&&reader[i].GetStatus()==1)
		{
			cout<<reader[i];
			reader[i].Display_Keeping();
			flag=1;
		}
		break;
	}
	BF();
	if(flag==0)
	{
		cout<<"�Բ������������������������룡"<<endl;
		ShowOneself();//������������
	}
}
void Manage_Reader::Borrow()//����
{
	string code;
	int i=0,flag=0;
	char command;
	In_Reader_File();
	cout<<"���ٴ�������������[ע�����ÿ����֮ǰ����Ҫ��������]��"<<endl;
	cin>>code;
	BF();
	for(i=0;i<Count;i++)
	{
		if(reader[i].GetCode()==code)
		{
			reader[i].Borrow();
			flag=1;
		}
		break;
	}
	BF();
	if(flag==0)
		cout<<"�Բ���������������"<<endl;
	cout<<"���������鼮����������A;���飿��������B;�˳�������N"<<endl;
	cin>>command;
	if(command=='A'||command=='a')
		Borrow();
	else if(command=='B'||command=='b')
		Return();
	else exit(0);
}
void Manage_Reader::Return()
{
	string code;
	int i=0,flag=0;
	char command;
	In_Reader_File();
	cout<<"���ٴ�������������[ע��黹ÿ����֮ǰ����Ҫ��������]��"<<endl;
	cin>>code;
	for(i=0;i<Count;i++)
	{
		if(reader[i].GetCode()==code)
		{
			reader[i].Return();
			flag=1;
		}
		break;
	}
	if(flag=0)
		cout<<"�Բ���������������"<<endl;
	cout<<"�����黹�鼮����������Y����������N"<<endl;
	cin>>command;
	if(command=='Y'||command=='y')
		Return();//����
	else exit(0);
}
int Manage_Reader::GetCount()
{
	return Count;
}
class Manage:public Manage_Book,public Manage_Reader//���ؼ̳У��̳�����������
{
public:
	Manage(){};//���캯��
	void Login_Reader();//������ߵĵ�¼
	void Login_Manage();//�������Ա�ĵ�¼
};
void Manage::Login_Reader()//���ߵ�¼
{
	int i=0,flag=0;
	string id,code;
	Manage_Reader::In_Reader_File();//���ļ�������ߵ���Ϣ
	cout<<"***********************************���ߵ�¼"<<"*********************************"<<endl;
	cout<<"�������û�ID�����룺"<<endl;
	cout<<"****ID:";			cin>>id;
	cout<<"**���룺";	cin>>code;
	for(i=0;i<Count;i++)
	{
		if(Manage_Reader::reader[i].GetCode()==code&&Manage_Reader::reader[i].GetID()==id)
		{
			flag=1;
			cout<<"ϵͳ��¼�ɹ���"<<endl;
			system("cls");
			cout<<"*******************   "<<Manage_Reader::reader[i].GetName();
			if(Manage_Reader::reader[i].GetGender()=="��")
				cout<<"����";
			else cout<<"Ůʿ";
			cout<<"�����ã���ӭʹ��ͼ�����ϵͳ��*******************"<<endl;
		}
		break;
	}
	if(flag==0)
	{
		system("cls");
		cout<<"�Բ���ID����������!�����µ�¼��"<<endl;
		Login_Reader();//���µ�¼
	}
}
void Manage::Login_Manage()//����Ա��¼
{
	string code;
	cout<<"���������Ա���룺"<<endl;
	cin>>code;
	if(code=="LIUQIAN")//Ĭ������ΪLIUQIAN
	{
		cout<<"ϵͳ��¼�ɹ���"<<endl;
		system("cls");
		cout<<"����Ա���ã���ӭʹ��ͼ�����ϵͳ��"<<endl;
	}
	else
	{
		system("cls");
		cout<<"���벻��ȷ�������µ�¼��"<<endl;
		Login_Manage();//���µ�¼
	}
}