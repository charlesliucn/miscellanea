#include<iostream>
#include<windows.h>
#define OperationNum 6
using namespace std;

//����ȫ�ֱ������ź�������ʵ��ͬ��
HANDLE trac = CreateSemaphore(NULL,0,OperationNum,NULL);	//�ź���trac,���һ���ڴ����������ͷţ�Tracker�߳������ʱ���ڴ���Ϣ
HANDLE allo = CreateSemaphore(NULL,0,OperationNum,NULL);	//�ź���allo,Tracker������ڴ���Ϣ���ͷţ�Allocator������һ���ڴ�������
LPVOID Mem_Addr;											//���ڴ洢�ڴ�ĵ�ַ
DWORD PAGE_SIZE;

void WINAPI Tracker(LPVOID lpParam)							//Tracker�̣߳������ڴ�������ڴ�״̬
{
	SYSTEM_INFO sysinfo;									//ϵͳ��Ϣ����
	GetSystemInfo(&sysinfo);								//ʹ��GetSystemInfo��ȡ��ǰϵͳ��Ϣ
	PAGE_SIZE = sysinfo.dwPageSize;							//Windows����ϵͳ��ҳ��С
	//�����ǰ����ϵͳ�������Ϣ
	cout<<"System Information:"<<endl<<endl;	
	cout<<"	OEM ID:"<<sysinfo.dwOemId<<endl;				//���OemId
	cout<<"	Number of Processors:"<<sysinfo.dwNumberOfProcessors<<endl;	//����߼���������Ŀ
	cout<<"	Page Size:"<<sysinfo.dwPageSize<<endl;						//���ҳ���С
	cout<<"	Processor Type:"<<sysinfo.dwProcessorType<<endl;			//�������������
	cout<<"	Processor Level:"<<sysinfo.wProcessorLevel<<endl;			//�������������
	cout<<"	Active Processor Mask:"<<sysinfo.dwActiveProcessorMask<<endl;				//�����Ծ�Ĵ�����(���)
	cout<<"	Minimum Application Address:"<<sysinfo.lpMinimumApplicationAddress<<endl;	//Ӧ�ó���Χ����С��ַ
	cout<<"	Maximum Application Address:"<<sysinfo.lpMaximumApplicationAddress<<endl;	//Ӧ�õ�ַ��Χ������ַ
	cout<<endl<<endl;

	MEMORY_BASIC_INFORMATION meminfo;		//��ȡ�ڴ������Ϣ
	char *allopro,*protect,*state,*type;	//�ַ��������ڴ�״̬��Ϣ�����
	for(int  i = 0;i < OperationNum;i++)	//6���ڴ�������
	{
		ReleaseSemaphore(allo,1,NULL);		//�ͷ��ź���allo
		if(WaitForSingleObject(trac,INFINITE) == WAIT_OBJECT_0)
		{
			VirtualQuery(Mem_Addr,&meminfo,sizeof(meminfo));		//��ѯ�ڴ���Ϣ
			cout<<"	Allocation Base:"<<meminfo.AllocationBase<<endl;//��ȡָ���ڴ������ַ��ָ��
			cout<<"	Base Address:"<<meminfo.BaseAddress<<endl;		//�ڴ�����Ļ�ַ
			cout<<"	Region Size:"<<meminfo.RegionSize<<endl;		//�ڴ�����Ĵ�С(�ֽ���)
			switch(meminfo.AllocationProtect)						//���ڴ����ı���תΪ�ַ���
			{
			case PAGE_EXECUTE:allopro = "EXECUTE";break;
			case PAGE_EXECUTE_READ:allopro = "EXECUTE_READ";break;
			case PAGE_EXECUTE_READWRITE:allopro = "EXECUTE_READWRITE";break;
			case PAGE_EXECUTE_WRITECOPY:allopro = "EXECUTE_WRITECOPY";break;
			case PAGE_GUARD:allopro = "GUARD";break;
			case PAGE_NOACCESS:allopro = "NOACCESS";break;
			case PAGE_NOCACHE:allopro = "NOCACHE";break;
			case PAGE_READONLY:allopro = "READONLY";break;
			case PAGE_READWRITE:allopro = "READWRITE";break;
			case PAGE_WRITECOPY:allopro = "WRITECOPY";break;
			case PAGE_WRITECOMBINE:allopro = "WRITECOMBINE";break;
			default: allopro = "Cannot Access!";
			}
			cout<<"	Allocation Protect:"<<allopro<<endl;			//����ڴ����ı�������
			switch(meminfo.Protect)									//�ڴ������ҳ���ʵı���
			{
			case PAGE_EXECUTE:protect = "EXECUTE";break;			
			case PAGE_EXECUTE_READ:protect = "EXECUTE_READ";break;
			case PAGE_EXECUTE_READWRITE:protect = "EXECUTE_READWRITE";break;
			case PAGE_EXECUTE_WRITECOPY:protect = "EXECUTE_WRITECOPY";break;
			case PAGE_GUARD:protect = "GUARD";break;
			case PAGE_NOACCESS:protect = "NOACCESS";break;
			case PAGE_NOCACHE:protect = "NOCACHE";break;
			case PAGE_READONLY:protect = "READONLY";break;
			case PAGE_READWRITE:protect = "READWRITE";break;
			case PAGE_WRITECOPY:protect = "WRITECOPY";break;
			case PAGE_WRITECOMBINE:protect = "WRITECOMBINE";break;
			default: protect = "Cannot Access!";
			}
			cout<<"	Protect:"<<protect<<endl;						//����ڴ������ҳ���ʵı���
			switch(meminfo.State)									//�ڴ�������ҳ��״̬
			{
			case MEM_COMMIT: state = "MEMORY COMMIT";break;
			case MEM_FREE: state = "MEMORY FREE";break;
			case MEM_RESERVE: state = "MEMORY RESERVE";break;
			default: state = "Cannot Access!";
			}
			cout<<"	State:"<<state<<endl;							//�����ǰ�ڴ�������ҳ��״̬
			switch(meminfo.Type)									//�ڴ�������ҳ������
			{
			case MEM_IMAGE: type = "MEMORY IMAGE";break;
			case MEM_MAPPED:type = "MEMORY MAPPED";break;
			case MEM_PRIVATE:type = "MEMORY PRIVATE";break;
			default:type = "Cannot Access!";
			}
			cout<<"	Type:"<<type<<endl<<endl<<endl;					//�����ǰ�ڴ������е�ҳ������
		}
	}
}

void WINAPI Allocator(LPVOID lpParam)			//Allocator�̣߳�����ģ���ڴ����
{
	//����һ������
	if(WaitForSingleObject(allo,INFINITE) == WAIT_OBJECT_0)
	{
		Mem_Addr = VirtualAlloc(NULL,PAGE_SIZE,MEM_RESERVE,PAGE_READWRITE);	//���ر����ڴ�����Ļ�ַ
		if(Mem_Addr == NULL)
			GetLastError();
		else
		{
			cout<<"Memory State After RESERVE:"<<endl<<endl;				//׼�����������һ�����򡱺���ڴ���Ϣ
			ReleaseSemaphore(trac,1,NULL);									//�ͷ��ź���trac,֪ͨTracker���̿�ʼ����ڴ���Ϣ
		}
	}

	//�ύһ������
	if(WaitForSingleObject(allo,INFINITE) == WAIT_OBJECT_0)
	{
		Mem_Addr = VirtualAlloc(NULL,PAGE_SIZE,MEM_COMMIT,PAGE_READWRITE);	//�����ύ�ڴ�����Ļ�ַ
		if(Mem_Addr == NULL)
			GetLastError();
		else
		{
			cout<<"Memory State After COMMIT:"<<endl<<endl;					//׼��������ύһ�����򡱺���ڴ���Ϣ
			ReleaseSemaphore(trac,1,NULL);									//�ͷ��ź���trac,֪ͨTracker���̿�ʼ����ڴ���Ϣ
		}
	}

	//����һ������
	if(WaitForSingleObject(allo,INFINITE) == WAIT_OBJECT_0)
	{
		if(VirtualLock(Mem_Addr,PAGE_SIZE) != 0)							//����һ������ɹ�
		{
			cout<<"Memory State After LOCK:"<<endl<<endl;					//׼�����������һ�����򡱺���ڴ���Ϣ
			ReleaseSemaphore(trac,1,NULL);									//�ͷ��ź���trac,֪ͨTracker���̿�ʼ����ڴ���Ϣ
		}
		else GetLastError();
	}
	
	//����һ������
	if(WaitForSingleObject(allo,INFINITE) == WAIT_OBJECT_0)
	{
		if(VirtualUnlock(Mem_Addr,PAGE_SIZE) != 0)							//����һ������ɹ�
		{
			cout<<"Memory State After UNLOCK:"<<endl<<endl;					//׼�����������һ�����򡱺���ڴ���Ϣ
			ReleaseSemaphore(trac,1,NULL);									//�ͷ��ź���trac,֪ͨTracker���̿�ʼ����ڴ���Ϣ
		}
		else GetLastError();
	}

	//����һ������
	if(WaitForSingleObject(allo,INFINITE) == WAIT_OBJECT_0)
	{
		if(	VirtualFree(Mem_Addr,PAGE_SIZE,MEM_DECOMMIT) != 0)				//����һ������ɹ�
		{
			cout<<"Memory State After DECOMMIT:"<<endl<<endl;				//׼�����������һ�����򡱺���ڴ���Ϣ
			ReleaseSemaphore(trac,1,NULL);									//�ͷ��ź���trac,֪ͨTracker���̿�ʼ����ڴ���Ϣ
		}
		else GetLastError();

	}

	//�ͷ�һ������
	if(WaitForSingleObject(allo,INFINITE) == WAIT_OBJECT_0)
	{
		if(VirtualFree(Mem_Addr,0,MEM_RELEASE) != 0)						//�ͷ�һ������ɹ�
		{
			cout<<"Memory State After RELEASE:"<<endl<<endl;				//׼��������ͷ�һ�����򡱺���ڴ���Ϣ
			ReleaseSemaphore(trac,1,NULL);									//�ͷ��ź���trac,֪ͨTracker���̿�ʼ����ڴ���Ϣ
		}
		else GetLastError();
	}
}

int main()
{
	HANDLE allohandle = CreateThread(NULL,0,LPTHREAD_START_ROUTINE(Allocator),NULL,0,NULL);	//����Allocator�߳�
	HANDLE trachandle = CreateThread(NULL,0,LPTHREAD_START_ROUTINE(Tracker),NULL,0,NULL);	//����Tracker�߳�
	WaitForSingleObject(trachandle,INFINITE);				//�ȴ�������Ϣ�����ϣ����򼴿ɽ���
	CloseHandle(allohandle);	CloseHandle(trachandle);	//�ر������߳̾��
	return 0;
}

