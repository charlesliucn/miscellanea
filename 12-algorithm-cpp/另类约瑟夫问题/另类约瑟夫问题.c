/*����Լɪ������*/
#include<stdio.h>
#include<stdlib.h>
struct Node//�����ṹ�壬ÿһ���ṹ�������ֵ���ָ���򣬹�ͬ��ʾ�����е�һ�����
{
    int data;//�洢����
    struct Node *next;
};
void ex_Josephus(int All,int Start_Num,int Length)//AllΪ����N��Start_NumΪ��ʼ����LengthΪ����
{
    struct Node *pre,*curr,*head=NULL;//��������Ϊ��
    int i,temp;
    for(i=1;i<=All;i++)//�������н��
    {
        curr=(struct Node*)malloc(sizeof(struct Node));//����һ���µ������
        curr->data=i;//��ŵ�i�����ı��i
        if(head==NULL)
            head=curr;//����Ϊ��ʱ��ͷָ����Ϊ��ǰָ��
        else
			pre->next=curr;//����Ϊ��ʱ����ʾ��ǰָ��Ϊǰ��ָ��ĺ��ָ��
		pre=curr;//�ٽ�ǰ���ָ�����Ϊ��ǰָ��
    }//��ʵ���˵�����Ĵ�����ÿ�ζ�������ӳ���
	curr->next=head;//��ͷָ����Ϊ���һ�����ĺ�̽�㣬�Ӷ�����һ��ѭ������
    curr=head;//����ǰָ�������Ƶ�ͷָ��
    for(i=1;i<Start_Num;i++)//����ǰָ���Ƶ���������ʼ��
    {
        pre=curr;
		curr=curr->next;
    }
	while(curr->next!=curr)//�ж�����Ϊ���������Ƿ�ֻʣһ��
    {
        for(i=1;i<Length;i++)//�����ƶ�������ǰָ���ƶ�Length�����
        {
            pre=curr;
			curr=curr->next;
        }
		temp=curr->data;//tempΪ���м����
		curr->data=pre->data;
		pre->data=temp;
        pre->next=curr->next;//ɾ����������ĵ�Length�����
        free(curr);//�ͷű�ɾ�����Ŀռ�
        curr=pre->next;//��ǰָ��ָ����ɾ��������һ�����
    }//�����ظ�������ֱ����ǰָ��ָ��Ľ��ĺ�̽������������ֻ��һ����㣩
    printf("%d",curr->data);//������һ�����ı��
}
void EX_Josephus(int All,int Chosen,int Start_Num,int Length)
{
	struct Node *pre,*curr,*head=NULL;
	struct Node *insert;//������һ������Ľ��
	int i,k,temp;
	 for(i=1;i<=Chosen;i++)//���γɵ�������Ϊ��ѡ������M��
    {
        curr=(struct Node*)malloc(sizeof(struct Node));
        curr->data=i;
        if(head==NULL)
            head=curr;
        else
			pre->next=curr;
        pre=curr;
    }
	 curr->next=head;
	 curr=head;//��֮ǰһ�����γ��˳���ΪChosen(M)��ѭ������
	 for(i=1;i<Start_Num;i++)
    {
        pre=curr;
		curr=curr->next;
    }//��ǰָ���ƶ����趨����ʼ��
	k=Chosen+1;
	while(k<=All)
	{
		 for(i=1;i<Length+1;i++)
        {
            pre=curr;
			curr=curr->next;
        }//�ƶ���Length+1,��insert���뵽pre��curr֮��
		 insert=(struct Node*)malloc(sizeof(struct Node));//���붯̬�ڴ�
		 insert->data=k;//��insert������ֵ
		 pre->next=insert;
		 insert->next=curr;
		 curr=insert;
		 k++;//������һ�����´�������ֵʱ��1
	}
	while(curr->next!=curr)//��֮ǰ��ͬ��ɾ������
    {
        for(i=1;i<Length;i++)
        {
            pre=curr;
			curr=curr->next;
        }//pָ���m�����,rָ���m-1�����
		temp=curr->data;
		curr->data=pre->data;
		pre->data=temp;
        pre->next=curr->next;//ɾ����m�����
        free(curr);//�ͷű�ɾ�����Ŀռ�
        curr=pre->next;//pָ���µĳ������
    }
    printf("%d",curr->data);//������һ�����ı��
}
main()
{
    int All,Chosen,Start_Num,Length;
    scanf("%d%d%d%d",&All,&Chosen,&Start_Num,&Length);
	if(All==Chosen)
		 ex_Josephus(All,Start_Num,Length);
	else EX_Josephus(All,Chosen,Start_Num,Length);
}