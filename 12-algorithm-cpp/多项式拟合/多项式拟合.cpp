//����ʽ��������ֽ�
#include<iostream>
#include<cmath>
using namespace std;
void QR(double **M,int n,int m,double *y)
{
	double cond,U,V,W;
	double* v=new double[n];
	for(int i=0;i<m;i++)//������һ����m����Ҫ�������
	{
		cond=0;//�洢ÿ�������Ķ��η���(ģ)		
		for(int j=i;j<n;j++)
		{
			cond+=M[i][j]*M[i][j];
		}
		cond=sqrt(cond);
		if(M[i][i]>0)//Ԫ��ֵ����0ʱ��ѡ��ģ�ĸ��������Ա��ⲻ��Ҫ�ľ�����ʧ
			cond=-cond;
		v[i]=M[i][i]+cond;
		V=v[i]*v[i];
		for(int j=i+1;j<n;j++)
		{
			v[j]=M[i][j];
			V+=v[j]*v[j];
		}
		for(int j=i;j<m;j++)//Household�������i��֮�������
		{
			U=0;
			for(int k=i;k<n;k++)//�����˾�����˵�˳�򣬱����þ���ļ�����
			{
				U+=v[k]*M[j][k];
			}
			for(int k=i;k<n;k++)
			{
				M[j][k]-=2*U*v[k]/V;
			}
		}
		W=0;
		for(int j=i;j<n;j++)
			W+=v[j]*y[j];
		for(int j=i;j<n;j++)
			y[j]-=2*W*v[j]/V;
	}
	for(int i=m-1;i>=0;i--)
	{
		for(int j=i+1;j<m;j++)
		{
			y[i]-=M[j][i]*y[j];
		}
		y[i]/=M[i][i];
	}
}

int main()
{
	int n,m;
	cin>>n>>m;//�����������Ҫ��ϳ����Ķ���ʽ�Ĵ���
	double* x=new double[n];//�洢x���꣬�Ա���
	double* y=new double[n];//�洢y���꣬����ֵ
	double** M=new double*[m];//M���������������ݵõ��ľ���
	for(int i=0;i<m;i++)//����m*n����
	{
		M[i]=new double[n];
	}
	for(int i=0;i<n;i++)//��������n������
	{
		cin>>x[i]>>y[i];
	}
	for(int i=0;i<m;i++)
	{
		for(int j=0;j<n;j++)//�Ա������ݴ�������
		{
			M[i][j]=pow(x[j],i);
		}
	}
	QR(M,n,m,y);//QR�ֽ�
	for(int i=0;i<m;i++)//�����������Ƿ�����Ľ�
	{
		cout<<int(0.5+y[i])<<endl;
	}
}