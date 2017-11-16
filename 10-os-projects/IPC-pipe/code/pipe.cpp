#include <iostream>
#include <windows.h>
using namespace std;

DWORD num_of_bytes = sizeof(int);   //ReadFile��WriteFile�����еĲ�������ʾҪ��ȡ��д����ֽ�����
HANDLE HREAD_fF;					//f��F֮��Ĺܵ������
HANDLE HWRITE_fF;					//f��F֮��Ĺܵ�д���
HANDLE HREAD_gF;					//g��F֮��Ĺܵ������
HANDLE HWRITE_gF;					//g��F֮��Ĺܵ�д���

//f����(�����Ǽ���׳ˣ�
int Func_f(int m)
{
	if( m == 1 )
		return 1;
	else return ( m*Func_f(m-1) );
}
//g����(쳲���������)
int Func_g(int n)
{
	if( n ==1 || n ==2 )
		return 1;
	else return (Func_g(n-1) + Func_g(n-2));
}

//f������F����֮����1���ܵ�
//��f��˵��f��F���������൱����ܵ�д������;f��F�õ������൱�ڴӹܵ���������
void WINAPI f_PIPE_RW(PVOID pvParam)	//ʵ��f�����ӹܵ���ȡ����ܵ�д������
{
	DWORD read_dword,write_dword;			//����ʵ�ʶ�ȡ��д����ֽ���
	int para_m;							//�ܵ��ڵ����ݣ���Ϊ����m
	while(!ReadFile(HREAD_fF,&para_m,num_of_bytes,&read_dword,NULL));	//�ӹܵ��ж�ȡ����m��ʹ��while��ʾ�ȴ�����ֱ���ɹ�����
	int f_result = Func_f(para_m);		//�Զ�ȡ�Ĳ���mʹ��f�������õ����
	while(!WriteFile(HWRITE_fF,&f_result,num_of_bytes,&write_dword,NULL)); //��f�����Ľ��д��ܵ���ʹ��while��ʾֱ���ɹ�д��
}

//ͬ����g������F����֮����1���ܵ�
//��g��˵��g��F���������൱����ܵ�д������;g��F�õ������൱�ڴӹܵ���������
void WINAPI g_PIPE_RW(PVOID pvParam)	//ʵ��g�����ӹܵ���ȡ����ܵ�д������
{
	DWORD read_dword,write_dword;		//����ʵ�ʶ�ȡ��д����ֽ���
	int para_n;							//�ܵ��ڵ�����,��Ϊ����n
	while(!ReadFile(HREAD_gF,&para_n,num_of_bytes,&read_dword,NULL));	//�ӹܵ��ж�ȡ����n��ʹ��while��ʾ�ȴ�����ֱ���ɹ�����
	int g_result = Func_g(para_n);		//�Զ�ȡ�Ĳ���nʹ��g�������õ����
	while(!WriteFile(HWRITE_gF,&g_result,num_of_bytes,&write_dword,NULL));//��g�����Ľ��д��ܵ���ʹ��while��ʾֱ���ɹ�д��
}

//��F��˵��F��f���������൱����ܵ�д������;F��f�õ������൱�ڴӹܵ���������(�˴��ܵ�ָf��F֮��Ĺܵ�)
//��F��˵��F��g���������൱����ܵ�д������;F��g�õ������൱�ڴӹܵ���������(�˴��ܵ�ָg��F֮��Ĺܵ�)
void WINAPI F_PIPE_RW(PVOID pvParam)	//ʵ��F�����������ܵ��ж�ȡ���ݣ��Լ��������ܵ�д������	
{
	int *para = (int*)pvParam;			//������Ӧm��n����F����Ҫд��ܵ�������
	//��ȫ�Բ�������
	SECURITY_ATTRIBUTES safF,sagF;		//��Ӧ�������ܵ��İ�ȫ��
	//��ȫ�ԵĲ�������,����f��F֮��Ĺܵ�
	safF.nLength = sizeof(SECURITY_ATTRIBUTES);	
	safF.lpSecurityDescriptor = NULL;
	safF.bInheritHandle = TRUE;
	CreatePipe(&HREAD_fF,&HWRITE_fF,&safF,0);
	//��ȫ�ԵĲ�������,����g��F֮��Ĺܵ�
	sagF.nLength = sizeof(SECURITY_ATTRIBUTES);
	sagF.lpSecurityDescriptor = NULL;
	sagF.bInheritHandle = TRUE;
	CreatePipe(&HREAD_gF,&HWRITE_gF,&sagF,0);

	//���������������д��ܵ�
	int m = para[0];
	int n = para[1];
	DWORD dword_fF,dword_gF;			//����ʵ�ʶ�����ֽ���
	while(!WriteFile(HWRITE_fF,&m,num_of_bytes,&dword_fF,NULL));//F������ܵ�д��f�����Ĳ���m
	while(!WriteFile(HWRITE_gF,&n,num_of_bytes,&dword_gF,NULL));//F������ܵ�д��g�����Ĳ���n
	HANDLE f_thread = CreateThread(NULL,0,(LPTHREAD_START_ROUTINE)(f_PIPE_RW),NULL,0,NULL);//����f������д���߳�
	HANDLE g_thread = CreateThread(NULL,0,(LPTHREAD_START_ROUTINE)(g_PIPE_RW),NULL,0,NULL);//����g������д���߳�
	WaitForSingleObject(f_thread,INFINITE);//f_thread�߳̽���ʱ���Ѿ���f(m)��ֵд��ܵ�
	WaitForSingleObject(g_thread,INFINITE);//g_thread�߳̽���ʱ���Ѿ���g(n)��ֵд��ܵ�

	int f_result,g_result;	//�ֱ��ʾf������g�����ķ���ֵ
	while(!ReadFile(HREAD_fF,&f_result,num_of_bytes,&dword_fF,NULL));	//F�����ӹܵ��ж�ȡf�����ķ���ֵ
	while(!ReadFile(HREAD_gF,&g_result,num_of_bytes,&dword_gF,NULL));	//F�����ӹܵ��ж�ȡg�����ķ���ֵ

	int F_result = f_result + g_result;		//F(m,n)=f(m)+g(n)
	cout<<endl<<"**************������**************"<<endl
		<<"F("<<para[0]<<","<<para[1]<<")="<<F_result<<endl<<endl;		//������յļ�����
	//�ر����еľ��
	CloseHandle(f_thread);		CloseHandle(g_thread);
	CloseHandle(HREAD_fF);		CloseHandle(HWRITE_fF);
	CloseHandle(HREAD_gF);		CloseHandle(HWRITE_gF);
}

int main() 
{ 
	int para[2];							//�����Ĳ���
	cout<<"********������������Ȼ��m��n********"<<endl;	//�������
	cin>>para[0]>>para[1];					//������������
	if(para[0]<=0 || para[0]<=0)			//�жϲ����Ƿ�Ϻ�Ҫ��
	{
		cout<<"Error:��������������������Ȼ��!"<<endl;
		exit(0);
	}
	HANDLE F_thread = CreateThread(NULL,0,(LPTHREAD_START_ROUTINE)(F_PIPE_RW),&para,0,NULL);
	WaitForSingleObject(F_thread,INFINITE);	//F�������߳̽���ʱ���Ѿ�����˺�������ֵ
	CloseHandle(F_thread);					//�رվ��
	return 0; 
} 