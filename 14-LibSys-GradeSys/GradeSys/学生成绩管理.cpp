
//ѧ���ɼ�����ϵͳ.cpp
#include"Class.h"
using namespace std;
void Student_Continue()
{
	int command;Teacher T;
	cout<<"��������Ҫִ�еĲ������"<<endl;
	cin>>command;
	switch(command)
	{
	case 1:
		T.Search_Student();break;
	case 2:
		T.Sort_Teacher();break;
	case 3:
		exit(0);break;
	default:
		cout<<"�Բ���������������"<<endl;
	}
	Student_Continue();
}
void Start_Student()
{
	Manage MA;
	MA.Login_Student();
	cout<<"*********************     ��ӭʹ��ѧ���ɼ�����ϵͳ    *********************"<<endl;
	cout<<"*********************              �� ��             *********************"<<endl;
	cout<<"*********************          1.��ѯ���˳ɼ�         *********************"<<endl;
	cout<<"*********************          2.ѧ���ɼ�����         *********************"<<endl;
	cout<<"*********************          3.�˳�   ϵͳ         *********************"<<endl;
	for(int i=0;i<76;i++)
		cout<<"*";
	cout<<endl;
	Student_Continue();	
}
void Continue_Teacher()
{
	Teacher T;
	int command;
	cout<<"��������Ҫִ�еĲ������"<<endl;
	cin>>command;
	switch(command)
	{
	case 1:
		T.In_Student_File();
		T.Add();
		break;
	case 2:
		int number;
		T.In_Student_File();
		cout<<"����Ҫɾ��������ͬѧ��"<<"����������"<<endl;
		cin>>number;
		if(number>T.GetNum())
			cout<<"�Բ���ϵͳ������ֻ������"<<T.GetNum()<<"λѧ������Ϣ���ɼ�"<<endl;
		else 
		{
			for(int i=0;i<number;i++)
				T.Delete();
		}	
		break;
	case 3:
		cout<<"******��ע�ⲻ���������޸ġ�*****"<<endl;
		T.Change();break;
	case 4:
		T.Search_Teacher();break;
	case 5:
		T.Sort_Teacher();break;
	case 6:
		T.In_File_Data();break;
	case 7:
		T.All_Student_Display();break;
	case 8:
		cout<<"ƽ���ɼ�Ϊ:"<<T.GetAverage()<<endl;	break;
	case 9:
		exit(0);break;
	default:cout<<"�Բ���������������"<<endl;
	}
	Continue_Teacher();
}
void Start_Teacher()
{
	Director A;
	A.Login_Teacher();
	cout<<"*********************     ��ӭʹ��ѧ���ɼ�����ϵͳ    *********************"<<endl;
	cout<<"*********************             �� ��              *********************"<<endl;
	cout<<"*********************         1.���ѧ���ɼ�          *********************"<<endl;
	cout<<"*********************         2.ɾ��ѧ���ɼ�          *********************"<<endl;
	cout<<"*********************         3.�޸�ѧ���ɼ�          *********************"<<endl;
	cout<<"*********************         4.��ѯѧ���ɼ�          *********************"<<endl;
	cout<<"*********************         5.ѧ���ɼ�����          *********************"<<endl;
	cout<<"*********************         6.�����ⲿ�ļ�          *********************"<<endl;
	cout<<"*********************         7.��ʾ���гɼ�          *********************"<<endl;
	cout<<"*********************         8.��ʾƽ���ɼ�          *********************"<<endl;
	cout<<"*********************         9.�˳�   ϵͳ          *********************"<<endl;
	for(int i=0;i<76;i++)
		cout<<"*";
	cout<<endl;
	Continue_Teacher();
}
int main()
{
	system("color 0E");
	char c;
	for(int i=0;i<76;i++)
		cout<<"*";
	cout<<endl;
	cout<<"**********************        ѧ���ɼ�����ϵͳ      ***********************"<<endl;
	cout<<"**********************          ��ӭ����ʹ��        ***********************"<<endl;
	for(int i=0;i<76;i++)
		cout<<"*";
	cout<<endl;
	cout<<"*********  �������������ѧ�������ǽ�ʦ��ѧ��������S����ʦ������T  *********"<<endl;
	cout<<"�����룺"<<endl;
	cin>>c;
	if(c=='S'||c=='s')
	{
		system("cls");
		Start_Student();
	}
	else if(c=='T'||c=='t')
	{	
		system("cls");
		Start_Teacher();
	}
	else
	{
		system("cls");
		cout<<"�Բ�����������"<<endl;
		main();
	}
}
