	
//ͷ�ļ���Class.h����Ҫ���������е��༰���Ա����
#include<iostream>
#include<fstream>//�ļ���
#include<string>//�ַ���ͳһ��C++��string��
#include<iomanip>// I/O��ʽ����
#define calculus_score	5 //����΢����ѧ��
#define linear_score	4 //�������Դ���ѧ��
#define discrete_score	3 //������ɢ��ѧѧ��
#define english_score	2 //����Ӣ��ѧ��
#define M 500//Ĭ�����ѧ������
#define N 20//Ĭ�Ͻ�ʦ����
using namespace std;
//Person����Ϊ������
class Person
{
public:
	virtual string GetName()=0;
	virtual int GetID()=0;
};
//School_Member����Ϊ����࣬���м̳�Person�࣬��������Student��Teacher�ࣻ
class School_Member: public Person
{
public:
	School_Member(string name,int id);
	School_Member();
	string GetName();//ȡ����
	int GetID();//ȡѧ�Ż�����
 protected:
	string Name;
	int ID;
};
School_Member::School_Member(string name,int id)
{
	Name=name;
	ID=id;
}
School_Member::School_Member()
{
	Name=" ";
	ID=0;
}
string School_Member::GetName()
{
	return Name;
}
int School_Member::GetID()
{
	return ID;
}
//ѧ���࣬���м̳������School_Member
class Student:virtual public School_Member
{
public:
	Student(string name,int id,double calculus,double linear,double discrete,double english,int code);
	Student();
	bool IsEmpty();//ѧ��״̬������true��ʾѧ�����ڣ�false��ʾѧ����ϢΪ��
	//����������ֿ��޸�ѧ���ɼ�
	void Alter_calculus();//�޸�΢���ֳɼ�
	void Alter_linear();//�޸����Դ����ɼ�
	void Alter_discrete();//�޸���ɢ��ѧ�ɼ�
	void Alter_english();//�޸�Ӣ��ɼ�
	int GetCode();//ȡ���루��¼ʱƥ�䣩
	//���������Ϊ�˵õ�ѧ���ĸ��Ƴɼ���GPA
	double GetCalculus();//ȡ΢���ֳɼ�
	double GetLinear_algebra();//ȡ���Դ����ɼ�
	double GetDicrete_Math();//ȡ��ɢ��ѧ�ɼ�
	double GetEnglish();//ȡӢ��ɼ�
	double GetGPA();//ȡGPA������GPA����
	void Delete();	//ɾ��ѧ����Ϣ
	void From_File(string name,int id,double caculus,double linear, 
		double discrete, double english,int code);//���ļ�����ѧ����Ϣ���ɼ�
	//Ϊ��������治ͬ������ʾ�ɼ�����Ҫ�����¸�����������ʾѧ���ɼ�����Ҫ
	void Display_Calculus();//��ʾ΢���ֳɼ�����
	void Display_Linear();//��ʾ���Դ����ɼ�����
	void Display_Discrete();//��ʾ��ɢ��ѧ�ɼ�����
	void Display_English();//��ʾӢ��ɼ�����
	void Display_All();//��ʾ���гɼ���GPA
	friend ostream & operator <<(ostream &out, Student &s);
		//���������أ����ѧ�����󼴿����������������Ϣ���ɼ�
protected://������Ա
	double Calculus,Linear_algebra,Discrete_math,English;
	int Code;
};
Student::Student(string name,int id,double calculus,double linear,double discrete,double english, int code)
{
	School_Member::School_Member(name,id);
	Calculus=calculus;
	Linear_algebra=linear;
	Discrete_math=discrete;
	English=english;
	Code=code;
}
Student::Student()
{
	School_Member::School_Member();
	Calculus=0.0;
	Linear_algebra=0.0;
	Discrete_math=0.0;
	English=0.0;
	Code=0;
}
bool Student::IsEmpty()
{
	if(ID==0)
		return true;
	else return false;
}
//������޸ĳɼ�
void Student::Alter_calculus()
{
	cout<<"������Ҫִ�еĲ����ǣ��޸�ѧ��΢���ֳɼ�"<<endl;
	double calculus;
	cout<<"������΢���ֳɼ�"<<endl;
	cin>>calculus;
	Calculus=calculus;
}
void Student::Alter_linear()
{
	cout<<"������Ҫִ�еĲ����ǣ��޸�ѧ�����Դ����ɼ�"<<endl;
	double linear;
	cout<<"���������Դ����ɼ�"<<endl;
	cin>>linear;
	Linear_algebra=linear;
}
void Student::Alter_discrete()
{
	cout<<"������Ҫִ�еĲ����ǣ��޸�ѧ����ɢ��ѧ�ɼ�"<<endl;
	double discrete;
	cout<<"��������ɢ��ѧ�ɼ�"<<endl;
	cin>>discrete;
	Discrete_math=discrete;
}
void Student::Alter_english()
{
	cout<<"������Ҫִ�еĲ����ǣ��޸�ѧ��Ӣ��ɼ�"<<endl;
	double english;
	cout<<"������Ӣ��ɼ�"<<endl;
	cin>>english;
	English=english;
}
//��ȡ����
int Student::GetCode()
{
	return Code;
}
//�������ȡ���Ƴɼ�
double Student::GetCalculus()
{
	return Calculus;
}
double Student::GetLinear_algebra()
{
	return Linear_algebra;
}
double Student::GetDicrete_Math()
{
	return Discrete_math;
}
double Student::GetEnglish()
{
	return English;
}
//��ȡGPA��������GPA�ļ��㣩
double Student::GetGPA()
{
	double sum_grade,sum_score,GPA;
	sum_grade=Calculus*calculus_score+Linear_algebra*linear_score
		+Discrete_math*discrete_score+English*english_score;
	sum_score=calculus_score+linear_score+discrete_score+english_score;
	GPA=sum_grade/sum_score;
	return GPA;
}
void Student::Delete()
{
	Name=" ";
	ID=0;
	Calculus=0.0;
	Linear_algebra=0.0;
	Discrete_math=0.0;
	English=0.0;
}
void Student::From_File(string name, int id, double calculus, double linear, double discrete, double english,int code)
{
	Name=name;
	ID=id;
	Calculus=calculus;
	Linear_algebra=linear;
	Discrete_math=discrete;
	English=english;
	Code=code;
}
//�������ʾѧ���ɼ���GPA
void Student::Display_Calculus()
{
	cout<<setiosflags(ios::left)<<setw(15)<<Name<<setw(12)<<ID<<setw(9)<<Calculus<<endl;
}
void Student::Display_Linear()
{
	cout<<setiosflags(ios::left)<<setw(15)<<Name<<setw(12)<<ID<<setw(9)<<Linear_algebra<<endl;
}
void Student::Display_Discrete()
{
	cout<<setiosflags(ios::left)<<setw(15)<<Name<<setw(12)<<ID<<setw(9)<<Discrete_math<<endl;
}
void Student::Display_English()
{
	cout<<setiosflags(ios::left)<<setw(15)<<Name<<setw(12)<<ID<<setw(9)<<English<<endl;
}
void Student::Display_All()
{
	cout<<setiosflags(ios::left)<<setw(15)<<Name<<setw(12)<<ID<<setw(9)
		<<Calculus<<setw(9)<<Linear_algebra<<setw(9)<<Discrete_math
		<<setw(9)<<English<<setw(9)<<GetGPA()<<endl;
}
ostream & operator << (ostream &out,Student &s)//��<<������������
{
	cout<<setiosflags(ios::left)<<setw(15)<<s.GetName()<<setw(12)<<s.GetID()<<setw(9)
		<<s.GetCalculus()<<setw(9)<<s.GetLinear_algebra ()<<setw(9)<<s.GetDicrete_Math()
		<<setw(9)<<s.GetEnglish()<<setw(9)<<s.GetGPA()<<endl;
	return out;
}
//��ʦ�๫�м̳������School_Member
class Teacher: virtual public School_Member
{
public:
	Teacher(string name,int id,string subject,int code);//���캯��
	Teacher();
	int GetCode();//��ȡ����
	string GetSubject();//��ȡ��ʦ�̵�ѧ��
	void From_File(string name,int id,string subject,int code);//���ļ������ʦ��Ϣ
	void In_Student_File();//��ϵͳ����Ĭ���ļ��е�ѧ����Ϣ���ɼ�
	void Add();//����ѧ����Ϣ���ɼ�
	void Delete();//ɾ��ѧ����Ϣ���ɼ�
	void Change();//�޸�ѧ����Ϣ���ɼ�
	void Search_Student();//ѧ�������ѯѧ���ɼ�	
	void Search_Teacher();//��ʦ�����ѯѧ���ɼ�	
	void Sort_Teacher();//��ʦ��ѧ�������ڡ�ѧ���ɼ�����
	double GetAverage();//ȡ���Ƴɼ���ƽ��ֵ
	void A_S_D();//��ʾϵͳ������ѧ�����п�Ŀ�ɼ�
	void All_Student_Display();//Ϊ�˶�ε��ã�����������ʾ��������Ϊһ����Ա����
	void In_File_Data();//��ϵͳ���ļ�����ѧ����Ϣ���ɼ�
	int GetNum();//ȡϵͳ�ڴ����ѧ����Ŀ
	friend ostream & operator <<(ostream &out, Teacher &t);//���ݸ����أ������ʦ��Ϣ
protected:
	Student STU[M];//ѧ���������ΪTeacher��ĳ�Ա
	int Num;
	int Code;
	string Subject;
};
Teacher::Teacher(string name,int id,string subject,int code)
{
	School_Member::School_Member(name,id);
	Code=code;
	Subject=subject;
}
Teacher::Teacher()
{
	School_Member::School_Member();
}
int Teacher::GetCode()//ȡ����
{
	return Code;
}
string Teacher::GetSubject()//ȡ��Ŀ
{
	return Subject;
}
void Teacher::From_File(string name,int id,string subject,int code)
{
	Name=name;
	ID=id;
	Subject=subject;
	Code=code;
}
void Teacher::In_Student_File()//����Ĭ���ļ��ڵ�ѧ����Ϣ
{
	ifstream in_File;
	string name;
	int i=0,id,code;
	double caculus, linear, discrete, english;
	in_File.open("G:\\student.txt",ios::in);
	if(in_File==0)
	{
		cout<<"�ļ���ʧ�ܣ�"<<endl;
		exit(0);
	}
	else	//���ļ���ѧ����Ϣ���ɼ���һ����
	{
		Num=0;
		while(in_File&&!in_File.eof())
		{
			in_File>>name>>id>>caculus>>linear>>discrete>>english>>code;
			STU[i].From_File(name,id,caculus,linear,discrete,english,code);
			Num++;
			i++;
		}
		in_File.close();//�ر��ļ�
	}
}
void Teacher::Add()//����ѧ����Ϣ���ɼ�
{
	int i,id;i=Num;
	Student ST;
	string _name;
	double calculus, linear, discrete,english;
	cout<<"********���ѧ����Ϣ���ɼ�******"<<endl;
	cout<<"ѧ���ɼ�����ϵͳ�����Ѵ���"<<i<<"��ѧ���ɼ���Ϣ"<<endl;
	cout<<"���������"<<i+1<<"��ѧ���ɼ���Ϣ";
	cout<<"������ѧ��������"<<endl;	cin>>_name;
	cout<<"������ѧ��ѧ�ţ�"<<endl;	cin>>id;
	cout<<"�����΢���ֳɼ���"<<endl;	cin>>calculus;
	cout<<"��������Դ����ɼ���"<<endl;	cin>>linear;
	cout<<"�������ɢ��ѧ�ɼ���"<<endl;	cin>>discrete;
	cout<<"�����Ӣ��ɼ���"<<endl;	cin>>english;
	ST.From_File(_name,id,calculus,linear,discrete,english,id);
	cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"΢����"
		<<setw(9)<<"���Դ���"<<setw(9)<<"��ɢ��ѧ"<<setw(9)<<"Ӣ��"<<setw(9)<<"GPA"<<endl;
	cout<<ST;
	cout<<"��Ϣ���ɼ������ϣ�"<<endl;
}
void Teacher::Delete()//ɾ��ѧ����Ϣ���ɼ�
{
	int id,i;
	cout<<"********ɾ��ѧ����Ϣ����ɼ�********"<<endl;
	cout<<"��������Ҫɾ����ѧ����ѧ��"<<endl;//ͨ��ѧ��ɾ��ѧ��
	cin>>id;
	for(i=0;i<M;i++)
	{
		if(!STU[i].IsEmpty()&&STU[i].GetID()==id)
		{
			STU[i].Delete();
			cout<<"ѧ��Ϊ"<<id<<"��ѧ���ɼ���������Ϣ����ɾ����ϣ�"<<endl;
			Num--;
		}
		break;
	}
}
void Teacher::Change()//�޸�ѧ����Ϣ���ɼ�
{
	In_Student_File();int i,id;
	cout<<"********����ѧ����Ϣ********"<<endl;
	cout<<"��������Ҫ�޸ĵ�ѧ����ѧ��"<<endl;
	cin>>id;
	for(i=0;i<Num;i++)
	{
		if(id==STU[i].GetID())
		{
			cout<<"��ѧ��ѧ��ԭ���ĳɼ��ǣ�"<<endl;
			cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"΢����"
				<<setw(9)<<"���Դ���"<<setw(9)<<"��ɢ��ѧ"<<setw(9)<<"Ӣ��"<<setw(9)<<"GPA"<<endl;
			cout<<STU[i];
			STU[i].Alter_calculus();//�޸�΢���ֳɼ�
			STU[i].Alter_linear();//�޸����Դ����ɼ�
			STU[i].Alter_discrete();//�޸���ɢ��ѧ�ɼ�
			STU[i].Alter_english();//�޸�Ӣ��ɼ�
			cout<<STU[i].GetName()<<"��ͬѧ�ĳɼ�������ϣ�"<<endl;
			cout<<"�޸ĺ����Ϣ���£�"<<endl;
			cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"΢����"
			    <<setw(9)<<"���Դ���"<<setw(9)<<"��ɢ��ѧ"<<setw(9)<<"Ӣ��"<<setw(9)<<"GPA"<<endl;
			cout<<STU[i];
		}
		break;
	}
	if(i==M)
		cout<<"�Բ����������ѧ���������֤��"<<endl;
}
void Teacher::Search_Student()//��ѯѧ���ɼ���ѧ���ͽ�ʦ���湲�ã�
{
	int i,command;
	int code;
	In_Student_File();
	cout<<"**************��ѯ���˳ɼ�**************"<<endl;
	cout<<"���ٴ�������������"<<endl;
	cin>>code;
	cout<<"************************************"<<endl;
	cout<<"1.��ѯ΢���ֳɼ�"<<endl;
	cout<<"2.��ѯ���Դ����ɼ�"<<endl;
	cout<<"3.��ѯ��ɢ��ѧ�ɼ�"<<endl;
	cout<<"4.��ѯӢ��ɼ�"<<endl;
	cout<<"5.�鿴GPA"<<endl;
	cout<<"6.�˳�"<<endl;
	for(i=0;i<M;i++)
	{
		if(STU[i].GetCode()==code)
		{
			cout<<"���������Ĳ�ѯ��ʽ"<<endl;
			cin>>command;
			switch(command)
			{
			case 1:
				cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"΢����"<<endl;
				STU[i].Display_Calculus();break;
			case 2:
				cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"���Դ���"<<endl;
				STU[i].Display_Linear();break;
			case 3:
				cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"��ɢ��ѧ"<<endl;
				STU[i].Display_Discrete();break;
			case 4:
				cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"Ӣ��"<<endl;
				STU[i].Display_English();break;
			case 5:
				cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"΢����"
					<<setw(9)<<"���Դ���"<<setw(9)<<"��ɢ��ѧ"<<setw(9)<<"Ӣ��"<<setw(9)<<"GPA"<<endl;
				cout<<STU[i];break;
			case 6:exit(0);break;
			default:
				cout<<"�Բ���������������"<<endl;
				system("cls");
				Search_Student();
			}
		}
	}
}
void Teacher::Search_Teacher()//��ѯѧ���ɼ���ѧ���ͽ�ʦ���湲�ã�
{
	int i,command;
	int id;
	In_Student_File();
	cout<<"**************��ѯѧ���ɼ�**************"<<endl;
	cout<<"��������Ҫ��ѯ��ѧ����ѧ�ţ�"<<endl;
	cin>>id;
	cout<<"************************************"<<endl;
	cout<<"1.��ѯ΢���ֳɼ�"<<endl;
	cout<<"2.��ѯ���Դ����ɼ�"<<endl;
	cout<<"3.��ѯ��ɢ��ѧ�ɼ�"<<endl;
	cout<<"4.��ѯӢ��ɼ�"<<endl;
	cout<<"5.�鿴GPA"<<endl;
	cout<<"6.�˳�"<<endl;
	for(i=0;i<M;i++)
	{
		if(STU[i].GetID()==id)
		{
			cout<<"���������Ĳ�ѯ��ʽ"<<endl;
			cin>>command;
			switch(command)
			{
			case 1:
				cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"΢����"<<endl;
				STU[i].Display_Calculus();break;
			case 2:
				cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"���Դ���"<<endl;
				STU[i].Display_Linear();break;
			case 3:
				cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"��ɢ��ѧ"<<endl;
				STU[i].Display_Discrete();break;
			case 4:
				cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"Ӣ��"<<endl;
				STU[i].Display_English();break;
			case 5:
				cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"΢����"
					<<setw(9)<<"���Դ���"<<setw(9)<<"��ɢ��ѧ"<<setw(9)<<"Ӣ��"<<setw(9)<<"GPA"<<endl;
				cout<<STU[i];break;
			case 6:exit(0);break;
			default:
				cout<<"�Բ���������������"<<endl;
				system("cls");
				Search_Teacher();
			}
		}
	}
}
//��ע�⡿Ϊ��һ���̶��ϱ���������˽����ʾ����ʱ����ʾ������ֻ��ʾѧ��
void Teacher::Sort_Teacher()//��ʦ��ѧ�������ڡ�ѧ���ɼ������ܡ�
{
	int command;
	Student *Stu[M],*s;//ʹ��ָ����Ķ����ָ�룬�����ɼ�������
	In_Student_File();//�ȴ��ļ��е���ѧ����Ϣ���ɼ�
	for(int z=0;z<Num;z++)//ָ��ָ�����
		Stu[z]=&STU[z];
	cout<<"********ѧ���ɼ�����********"<<endl;
	cout<<"����������ѡ��"<<endl;
	cout<<"1.΢���ֳɼ�����"<<endl;
	cout<<"2.���Դ����ɼ�����"<<endl;
	cout<<"3.��ɢ��ѧ�ɼ�����"<<endl;
	cout<<"4.Ӣ��ɼ�����"<<endl;
	cout<<"5.GPA����"<<endl;
	cout<<"6.�˳�"<<endl;
	cin>>command;
	if(command==1)//΢��������
	{
		int i,j,flag;
        for(i=1; i<Num; i++) 
		{
			flag=0; 
            for(j=0;j<Num-i;j++) 
				if(Stu[j]->GetCalculus()<Stu[j+1]->GetCalculus()) 
				{
					s=Stu[j];Stu[j]=Stu[j+1];Stu[j+1]=s;
					flag=1; 
				}
			if(!flag)	break;
		}
		cout<<"����΢���ֳɼ��Ӹߵ������򣬽��Ϊ��"<<endl;
		cout<<setiosflags(ios::left)<<setw(6)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"΢����"<<endl;
		for(i=0;i<Num;i++)
		{
			cout<<setw(6)<<i+1;
			cout<<setw(12)<<Stu[i]->GetID()<<setw(9)<<Stu[i]->GetCalculus()<<endl;
		}
	}
	else if(command==2)//���Դ�������
	{
		int i,j,flag;
        for(i=1; i<Num; i++) 
		{
			flag=0; 
            for(j=0;j<Num-i;j++) 
				if(Stu[j]->GetLinear_algebra()<Stu[j+1]->GetLinear_algebra()) 
				{
					s=Stu[j];Stu[j]=Stu[j+1];Stu[j+1]=s;
					flag=1; 
				}
			if(!flag)	break;
		}
		cout<<"�������Դ����ɼ��Ӹߵ������򣬽��Ϊ��"<<endl;
		cout<<setiosflags(ios::left)<<setw(6)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"���Դ���"<<endl;
		for(i=0;i<Num;i++)
		{
			cout<<setw(6)<<i+1;;
			cout<<setw(12)<<Stu[i]->GetID()<<setw(9)<<Stu[i]->GetLinear_algebra()<<endl;
		}
	}
	else if(command==3)//��ɢ��ѧ����
	{
		int i,j,flag;
        for(i=1; i<Num; i++) 
		{
			flag=0; 
            for(j=0;j<Num-i;j++) 
				if(Stu[j]->GetDicrete_Math()<Stu[j+1]->GetDicrete_Math())
				{
					s=Stu[j];Stu[j]=Stu[j+1];Stu[j+1]=s;
					flag=1; 
				}
			if(!flag)	break;
		}
		cout<<"������ɢ��ѧ�ɼ��Ӹߵ������򣬽��Ϊ��"<<endl;
		cout<<setiosflags(ios::left)<<setw(6)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"��ɢ��ѧ"<<endl;
		for(i=0;i<Num;i++)
		{
			cout<<setw(6)<<i+1;
			cout<<setw(12)<<Stu[i]->GetID()<<setw(9)<<Stu[i]->GetDicrete_Math()<<endl;
		}
	}
	else if(command==4)//Ӣ��ɼ�����
	{
		int i,j,flag;
        for(i=1; i<Num; i++) 
		{
			flag=0; 
            for(j=0;j<Num-i;j++) 
				if(Stu[j]->GetEnglish()<Stu[j+1]->GetEnglish()) 
				{
					s=Stu[j];Stu[j]=Stu[j+1];Stu[j+1]=s;
					flag=1; 
				}
			if(!flag)	break;
		}
		cout<<"����Ӣ��ɼ��Ӹߵ������򣬽��Ϊ��"<<endl;
		cout<<setiosflags(ios::left)<<setw(6)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"Ӣ��"<<endl;
		for(i=0;i<Num;i++)
		{
			cout<<setw(6)<<i+1;
			cout<<setw(12)<<Stu[i]->GetID()<<setw(9)<<Stu[i]->GetEnglish()<<endl;
		}
	}
	else if(command==5)//GPA����
	{
		int i,j,flag;
        for(i=1; i<Num; i++) 
		{
			flag=0; 
            for(j=0;j<Num-i;j++) 
				if(Stu[j]->GetGPA()<Stu[j+1]->GetGPA()) 
				{
					s=Stu[j];Stu[j]=Stu[j+1];Stu[j+1]=s;
					flag=1; 
				}
			if(!flag)	break;
		}
		cout<<"����GPA�Ӹߵ�������(��ʾ����)�����Ϊ��"<<endl;
		cout<<setiosflags(ios::left)<<setw(6)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"΢����"
			<<setw(9)<<"���Դ���"<<setw(9)<<"��ɢ��ѧ"<<setw(9)<<"Ӣ��"<<setw(9)<<"GPA"<<endl;
		for(i=0;i<Num;i++)
		{
			cout<<setw(6)<<i+1;
			cout<<setw(12)<<Stu[i]->GetID()<<setw(9)<<Stu[i]->GetCalculus()<<setw(9)<<Stu[i]->GetLinear_algebra()
				<<setw(9)<<Stu[i]->GetDicrete_Math()<<setw(9)<<Stu[i]->GetEnglish()<<setw(9)<<Stu[i]->GetGPA()<<endl;
		}
	}
	else if(command==6)
		exit(0);
	else cout<<"�Բ�������������"<<endl;
}
double Teacher::GetAverage()//��ȡѧ�����ƻ���GPA��ƽ���ɼ�
{
	int i,command;
	double sum=0,average;
	In_Student_File();
	cout<<"********ѧ��ƽ���ɼ�********"<<endl;
	cout<<"���������ѯ��һ��(�ܷ�)��ƽ���ɼ�?"<<endl;
	cout<<"1.΢����"<<endl<<"2.���Դ���"<<endl<<"3.��ɢ��ѧ"<<endl<<"4.Ӣ��"<<endl<<"5.GPA"<<endl;
	cout<<"�����룺";	cin>>command;
	if(command==1)
	{
		for(i=0;i<Num;i++)
			sum+=STU[i].GetCalculus();
		average=sum/Num;
		return average;//΢����ƽ���ɼ�
	}
	else if(command==2)
	{
		sum=0.0;
		for(i=0;i<Num;i++)
			sum+=STU[i].GetLinear_algebra();
		average=sum/Num;
		return average;//���Դ���ƽ���ɼ�
	}
	else if(command==3)
	{
		sum=0.0;
		for(i=0;i<Num;i++)
			sum+=STU[i].GetDicrete_Math();
		average=sum/Num;
		return average;//��ɢ��ѧƽ���ɼ�
	}
	else if(command=4)
	{
		sum=0.0;
		for(i=0;i<Num;i++)
			sum+=STU[i].GetEnglish();
		average=sum/Num;
		return average;//Ӣ��ƽ���ɼ�
	}
	else if(command=5)
	{
		sum=0.0;
		for(i=0;i<Num;i++)
			sum+=STU[i].GetGPA();
		average=sum/Num;
		return average;//ƽ��GPA
	}
	else return 0;
}
void Teacher::A_S_D()//��ʾ���гɼ�����������
{
	cout<<"����������ѡ�"<<endl;
	int i,command;
	In_Student_File();//����ѧ����Ϣ���ɼ�
	cin>>command;
	//����������ʾ��������ʾ
	if(command==1)
	{
		cout<<"����ѧ����Ϣ������������ѧ�ţ�����:"<<endl;
		cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<endl;
		for(i=0;i<Num;i++)
			cout<<setiosflags(ios::left)<<setw(12)<<STU[i].GetName()<<setw(9)<<STU[i].GetID()<<endl;
		for(int i=0;i<50;i++)
		{cout<<"*";}
		cout<<endl;
	}
	else if(command==2)
	{
		cout<<"����ѧ����Ϣ��΢���ֳɼ����£�"<<endl;
		cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"΢����"<<endl;
		for(i=0;i<Num;i++)			
			STU[i].Display_Calculus();
		for(int i=0;i<50;i++)
		{cout<<"*";}
		cout<<endl;
	}
	else if(command==3)
	{
		cout<<"����ѧ����Ϣ�����Դ����ɼ����£�"<<endl;
		cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"���Դ���"<<endl;
		for(i=0;i<Num;i++)
			STU[i].Display_Linear();
		for(int i=0;i<50;i++)
		{cout<<"*";}
		cout<<endl;
	}
	else if(command==4)
	{
		cout<<"����ѧ����Ϣ����ɢ��ѧ�ɼ����£�"<<endl;
		cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"��ɢ��ѧ"<<endl;
		for(i=0;i<Num;i++)			
			STU[i].Display_Discrete();	
		for(int i=0;i<50;i++)
		{cout<<"*";}
		cout<<endl;
	}
	else if(command==5)
	{
		cout<<"����ѧ����Ϣ��Ӣ��ɼ����£�"<<endl;
		cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"Ӣ��"<<endl;
		for(i=0;i<Num;i++)
		{
			
			STU[i].Display_Linear();
		}
		for(int i=0;i<50;i++)
		{cout<<"*";}
		cout<<endl;
	}
	else if(command==6)
	{
		cout<<"����ѧ����Ϣ�����Ƴɼ����£�"<<endl;
		cout<<setiosflags(ios::left)<<setw(15)<<"����"<<setw(12)<<"ѧ��"<<setw(9)<<"΢����"
				<<setw(9)<<"���Դ���"<<setw(9)<<"��ɢ��ѧ"<<setw(9)<<"Ӣ��"<<setw(9)<<"GPA"<<endl;
		for(i=0;i<Num;i++)
			cout<<STU[i];		
		for(int i=0;i<50;i++)
		{cout<<"*";}
		cout<<endl;
	}
	else if(command==7)
		exit(0);
	else
	{
		cout<<"�밴��ʾ��ȷ���룡"<<endl;
		cin.get();
	}
	A_S_D();//ѭ�����ã��������µ�¼ϵͳ�����ϵͳЧ��
}
void Teacher::All_Student_Display()//��ʾ���гɼ�����ʾ����
{
	
	cout<<"********��ʾϵͳ������ѧ���ɼ�********"<<endl;
	cout<<"1.��ʾ����ѧ����Ϣ������������ѧ�ţ�"<<endl;
	cout<<"2.��ʾ����ѧ����Ϣ��΢���ֳɼ�"<<endl;
	cout<<"3.��ʾ����ѧ����Ϣ�����Դ����ɼ�"<<endl;
	cout<<"4.��ʾ����ѧ����Ϣ����ɢ��ѧ�ɼ�"<<endl;
	cout<<"5.��ʾ����ѧ����Ϣ��Ӣ��ɼ�"<<endl;
	cout<<"6.��ʾ����ѧ���ĸ��Ƴɼ�"<<endl;
	cout<<"7.�˳�"<<endl;
	A_S_D();
}
void Teacher::In_File_Data()//���ⲿ�ļ�����ѧ����Ϣ���ɼ�
{
	ifstream in_File;
	char name[20];
	int i=0,id,code;
	char File_Name[20];
	double calculus, linear, discrete, english;
	cout<<"*******���ļ�����ѧ����Ϣ���ɼ�*******"<<endl;
	cout<<"��������Ҫ������ļ���ַ���ļ���"<<endl;
	cin>>File_Name;//����Ҫ������ļ���׼ȷ��ַ&�ļ���
	in_File.open(File_Name,ios::out);
	if(in_File==0)
	{
		cout<<"�ļ���ʧ�ܣ�"<<endl;
		exit(0);
	}
	else
	{
		Num=0;
		cout<<File_Name<<"�򿪳ɹ������ڴ��ļ�����..."<<endl;
		while(in_File&&!in_File.eof())
		{
			in_File>>name>>id>>calculus>>linear>>discrete>>english>>code;
			STU[i].From_File(name,id,calculus,linear,discrete,english,code);
			cout<<"***��"<<i+1<<"��ѧ����Ϣ���ɼ�����ɹ�***"<<endl;
			Num++;
			i++;
		}
		cout<<"���ι�����"<<Num<<"��ѧ����Ϣ"<<endl;
		in_File.close();//�ر��ļ�
	}
}
int Teacher::GetNum()//��ȡĿǰϵͳ��ѧ������Ŀ
{
	return Num;
}
ostream & operator <<(ostream &out, Teacher &t)//����������
{
	cout<<setiosflags(ios::left)<<setw(15)<<t.GetName()<<setw(12)<<t.GetID()<<setw(9)
		<<t.GetSubject()<<endl;
	return out;
}
//Manage�����࣬��Ҫ����ѧ���ĵ�¼������ѧ�����ܵ�ʵ����Teacher�����Ѱ���
class Manage: virtual public Student,virtual public Teacher
{
public:
	Manage(string name,int ID,double caculus,double linear,double discrete,double english,int code);
	Manage();
	void Login_Student();//ѧ����¼��Ա����
};
Manage::Manage(string name,int ID,double caculus,double linear,double discrete,double english,int code)
{
	Student::Student(name,ID,caculus,linear,discrete,english,code);
};

Manage::Manage()
{
	Student::Student();
}

void Manage::Login_Student()
{
	int i,id,code;
	Teacher::In_Student_File();
	cout<<"*********�����ȵ�¼ϵͳ*********"<<endl;
	cout<<"����������ѧ�ţ�"<<endl;
	cout<<"ѧ��:";
	cin>>id;
	cout<<"����:";
	cin>>code;
	for(i=0;i<Teacher::GetNum();i++)
	{
		if(Teacher::STU[i].GetID()==id&&Teacher::STU[i].GetCode()==code)//ѧ��ѧ�ź�����ƥ��֮����ܽ���ϵͳ
		{
			cout<<"��ϲ���ɹ���½!"<<endl;
			system("cls");//��������ѧ��ģ��Ļ�ӭ����
			cout<<"****************************************************************************"<<endl;
			cout<<"*********************          "<<Teacher::STU[i].GetName()<<"ͬѧ,���ã�        *********************"<<endl;
			break;
		}
	}
	if(i==Teacher::GetNum())
	{
		cout<<"�Բ��������û�������������"<<endl;
		system("cls");
		cout<<"�����µ�¼��"<<endl;
		Login_Student();
	}
}
class Director//Director����Ҫ�����ʦ��¼ϵͳ
{
public:
	Director(string name);
	Director();
	void In_Teacher_File();//��Ĭ���ļ������ʦ��Ϣ
	void Login_Teacher();//��ʦ��¼
private:
	int Count;//��ʦ����
	Teacher TEA[N];//��ʦ��Ķ�������
	string Name;
};
Director::Director(string name)
{
	Name=name;
}
Director::Director()
{
	Name=" ";
}
void Director::In_Teacher_File()
{
	ifstream in_File;
	string name;
	int i=0,id,code;
	string subject;
	in_File.open("G:\\teacher.txt",ios::in);
	if(in_File==0)
	{
		cout<<"�ļ���ʧ�ܣ�"<<endl;
		exit(0);
	}
	else
	{
		Count=0;
		while(in_File&&!in_File.eof())
		{
			in_File>>name>>id>>subject>>code;
			TEA[i].From_File(name,id,subject,code);
			Count++;
			i++;
		}
		in_File.close();
	}
}

void Director::Login_Teacher()
{
	int i,id,code;
	In_Teacher_File();
	system("cls");
	cout<<"*********�����ȵ�¼ϵͳ*********"<<endl;
	cout<<"���������Ĺ����ţ�"<<endl;
	cout<<"������:";
	cin>>id;
	cout<<"����:";
	cin>>code;
	for(i=0;i<Count;i++)
	{
		if(TEA[i].GetID()==id&&TEA[i].GetCode()==code)
		{
			cout<<"��ϲ���ɹ���½!"<<endl;
			system("cls");
			cout<<"****************************************************************************"<<endl;
			cout<<"*********************       "<<TEA[i].GetSubject()<<"  "<<TEA[i].GetName()<<"��ʦ,���ã�   *********************"<<endl;
			break;
		}
	}
	if(i==Count)
	{
		cout<<"�Բ��������û�������������"<<endl;
		system("cls");
		cout<<"�����µ�¼��"<<endl;
		Login_Teacher();
	}
}
