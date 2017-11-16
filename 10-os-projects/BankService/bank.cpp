#include <iostream>
#include <windows.h>
#include <fstream>
#include <ctime>
#include <queue>
#define counter_num 4  
#define time_cycle 1000
using namespace std;

struct Customer			//Customer�ṹ�壬�洢�˿͵�һϵ����Ϣ
{
	int ID;				//�˿����
	int time_arrive;	//�˿ͽ������е�ʱ��
	int time_begin;		//�˿Ϳ�ʼ�����ʱ��
	int time_need;		//�˿ͷ��������ʱ��
	int time_over;		//�˿ͷ�������뿪���е�ʱ��
	int server_counter; //�˿ͽ��ܷ���Ĺ�̨��
};
int Get_Cust_Num()		//���ļ��л�ȡ�˿͵���Ŀ
{
	fstream input;						//�½��ļ���
	input.open("input.txt",ios::in);	//��"input.txt"�ļ���׼����������
	if(input == 0)						//input == 0ʱ���ļ���ʧ�ܣ���ʾ���˳�
	{
		cout<<"Sorry, cannot open the file!"<<endl;
		exit(0);
	}
	int cust_num = 0;					//�˿���Ŀ��ʼ��Ϊ0
	char str[100];						//����ÿ�е��ַ������ֵ���Դ��ж��ļ�������
	while(!input.eof())					//�ļ�����֮ǰ
	{
		input.getline(str,sizeof(str));	//ÿ����һ��,���˿���Ŀ����1
		cust_num++;
	}
	input.close();						//�ر�input�ļ���
	return cust_num;					//����ֵΪ�˿͵�����
}
void Input(Customer *cust)				//���ļ��е���Ϣ����Customer�ṹ������
{
	fstream input;						//�½��ļ���
	input.open("input.txt",ios::in);	//��"input.txt"�ļ���׼����������
	if(input == 0)						//input == 0ʱ���ļ���ʧ�ܣ���ʾ���˳�
	{
		cout<<"Sorry,cannot open the file!"<<endl;
		exit(0);
	}
	int i = 0;							//�ṹ��index��ʼ��
	while(!input.eof())					//���ж���˿͵����з���������Ϣ
	{
		//����Ϊ�˿���ţ��������е�ʱ�估��Ҫ�����ʱ��
		input>>cust[i].ID>>cust[i].time_arrive>>cust[i].time_need;
		i++;
	}
	input.close();						//�ر��ļ���
}
void Output(Customer *cust,int cust_num)//���˿������з����漰����Ϣ���
{
	ofstream output;					//����ļ���
	output.open("output.txt",ios::out);	//���ļ���׼��д������
	for(int i=0;i<cust_num;i++)			//���д����˿͵���Ϣ
	{
		//����Ϊ���˿���ţ���������ʱ�䣬��ʼ���ܷ���ʱ�䣬��������뿪����ʱ�䣬�Լ����ܷ���Ĺ�̨��
		output<<cust[i].ID<<" "<<cust[i].time_arrive<<" "<<cust[i].time_begin<<" "
			<<cust[i].time_over<<" "<<cust[i].server_counter<<endl;
	}
	output.close();						//�ر��ļ���
}

queue <Customer*> WaitingQueue;						//���У����ڷ��õȴ��Ĺ˿�
HANDLE Sema;										//����ͬ���ź����ľ������
HANDLE mutex = CreateMutex(NULL,FALSE,NULL);		//���������ź���
HANDLE *Service_Over;								//��������������ڱ�־�˿ͽ��ܷ����Ƿ����

void CustomerIntoQueue(Customer *cust)				//�˿ͽ���ȴ�����
{ 
	Customer* cust_in = cust;						//�������е�ĳһ�˿�
	Sleep(time_cycle*(cust_in->time_arrive));		//����ʱ�䵽�ù˿�Ӧ�õ����ʱ��
	//����ָ����ʱ����mutex�����ź�������������������WAIT_OBJECT_0��������ʱ�µĹ˿ͽ���ȴ�����
	if(WaitForSingleObject(mutex,INFINITE) == WAIT_OBJECT_0)
	{
		WaitingQueue.push(cust_in);					//�˿͵�������Ϣ����ȴ�����
		ReleaseSemaphore(Sema,1,NULL);				//V�������ͷ��ź������ȴ��Ĺ˿�������1
		ReleaseMutex(mutex);						//V�����������ź������ͷţ������ù˿ͽ������
	}
} 

void CounterCallCustomer(int *counter_ID)			//��ʾ��̨�к�
{ 
	time_t time_base,time_begin;					//��ȡʱ�䣬����Ϊ��ʼ����׼��ʱ��Ϳ�ʼ���ܷ����ʱ��
	time(&time_base);								//��ȡ�����ʼ��ʱ��
	int* counter_id = counter_ID;					//��ȡ��̨���
	while(1)
	{ 
		//���Sema�ź�����mutex�����ź���ͬʱ�������������еȴ��Ĺ˿ͣ�ͬʱ��̨���п��У�����ʹ��P����������ͬ��
		if(WaitForSingleObject(Sema,INFINITE) ==WAIT_OBJECT_0 && WaitForSingleObject(mutex,INFINITE) == WAIT_OBJECT_0)
		{
			Customer* cust_out=WaitingQueue.front();//���е��Ĺ˿������Ƚ�����У��������úŵĹ˿�
			WaitingQueue.pop();						//�����кŵĹ˿ʹӶ�����pop��
			ReleaseMutex(mutex);					//V������ȡ�����кŵĹ˿�֮�󣬵ȴ�������Ҫ�ͷŻ����ź���
			cust_out->server_counter=*counter_id;	//Ϊ�ù˿ͷ���Ĺ�̨��
			time(&time_begin);						//��ȡ���кţ���ʼ���񣩵�ʱ��
			cust_out->time_begin =int(time_begin) - time_base;	//��ʼ�����ʱ�䣨����ڻ�׼ʱ�䣩
			Sleep(time_cycle*cust_out->time_need);	//Sleepֱ���ù˿ͷ������
			cust_out->time_over = cust_out->time_begin + cust_out->time_need;	//�˿ͷ���������뿪���У���ʱ��
			SetEvent(Service_Over[cust_out->ID-1]);	//�˴�������һ���¼��źţ����˿���ɷ���֮�󴥷������ź�
		}
	} 
} 

int main()
{
	/**********************************׼������********************************/
	int counter_ID[counter_num];					//�����̨��
	for(int i = 0;i < counter_num; i++)				//���ζԹ�̨���
	{
		counter_ID[i] = i+1;			
	}	
	int cust_num = Get_Cust_Num();					//���ļ���ȡ�˿͵���Ŀ
	Customer *cust = new Customer[cust_num];		//�����˿ͽṹ������
	Sema = CreateSemaphore(NULL, 0, cust_num, NULL);//���������Դ��Ϊ�˿��������ź���������ͬ��
	HANDLE *customer_thread = new HANDLE[cust_num];	//ÿ���˿�Ҳ��Ϊһ���߳�
	HANDLE *counter_thread = new HANDLE[counter_num];//ÿ����̨��Ϊһ���߳�
	Service_Over = new HANDLE[cust_num];			//ÿ���˿Ͷ�Ӧһ��������󣬷������ʱ�����ź�

	/****************************�˿������з���Ĺ���**************************/
	Input(cust);									//���˿͸�����Ϣ����ṹ������
	for (int i = 0;i<cust_num;i++)
	{
		//Ϊÿ���˿ʹ���һ���̣߳����е�����������ʾ��i���˿ͽ������к�ĺ���(����ȴ�����)
		customer_thread[i]=CreateThread(NULL,0,(LPTHREAD_START_ROUTINE)(CustomerIntoQueue),&(cust[i]),0,NULL);
		//Ϊÿ���˿ʹ���һ���¼��źŶ��󣬵ȴ��ù˿ͷ������
		Service_Over[i]=CreateEvent(NULL,FALSE,FALSE,NULL);	
	} 
	for(int i = 0;i < counter_num;i++)	
	{
		//Ϊÿ����̨����һ�����̣����У�������������ʾ�ù�̨�кŵĹ��̣�����ʱ���ȴ����У��ȴ��������ź�������1ʱ�кţ�
		counter_thread[i] = CreateThread(NULL,0,(LPTHREAD_START_ROUTINE)(CounterCallCustomer),&(counter_ID[i]),0,NULL);
	}	
	WaitForMultipleObjects(cust_num,customer_thread,TRUE,INFINITE);	//�ȴ����߳�ȫ�����
	WaitForMultipleObjects(cust_num,Service_Over,TRUE,INFINITE);	//�ȴ�ÿ���˿ͷ�����Ϻ���¼��ź�
	Output(cust,cust_num);							//������˿ͽ��ܷ���������Ϣ
	cout<<"�����input.txt�ļ�ͬһĿ¼�µ�output.txt�ļ��鿴������"<<endl;

	/**********************************��β����******************************/
	//��ն�̬���鼰�ź���
	delete cust;							
	delete customer_thread;
	delete counter_thread;
	delete Service_Over;
	CloseHandle(Sema);
	CloseHandle(mutex);
} 