     .data 
str1:
     .asciiz "Use assembler language to solve the Eight Queens Problem\n"
str2:
     .asciiz "The number of the solutions is:\n"
     .text  
 
#main������
main:  
	li      $v0,4            #ϵͳ����syscall�Ĵ���4��print string��ӡ�ַ���
	la      $a0,str1    	 #��strl�ĵ�ַװ��print string��Ĭ�ϼĴ���$a0��
	syscall			 #��ӡ�ַ���str1
	
	addi    $sp,$sp,-32      #��ջָ��Ӹߵ�ַ�Ƶ���ַ���õ�8λ����Ŀռ�    
	addi    $s0,$sp,0        #$s0ָ������Ļ�ַloc[0]  
	#$a0��$a1=2����EightQueens�������õı���
	li 	$a0,0    	 #$a0��ʾn��nΪ�м���������õĵ�n���ʺ󣬸�$a0��ֵΪ0     
	li   	$a1,8  	 	 #&a1��ʾQn��QnΪ�ʺ���������ڰ˻ʺ������У�Qn=8����$a1��ֵΪ8
	li	$a2,0        	 #$a2��ʾnum��num��EightQueens�����м�¼��������ļ���������ʼ��Ϊ0
	jal     EightQueens       #����EightQueens����,��ð˻ʺ������ĸ���������ֵ������$v0��
	move    $a1,$v0        	 #��EightQueens�����ķ���ֵ$v0���븳��$a0 
	
	li      $v0,4            #ϵͳ����syscall�Ĵ���4��print string��ӡ�ַ���
	la      $a0,str2    	 #��str2�ĵ�ַװ��print string��Ĭ�ϼĴ���$a0��
	syscall
	move	$a0,$a1		#��$a1�е���ֵ���˻ʺ�����Ľ�ĸ�����װ��print string��Ĭ�ϼĴ���$a0��
	li      $v0,1          	#ϵͳ����syscall�Ĵ���1��print integer��ӡ����$a0�е�����  
	syscall 
	li      $v0,10          #ϵͳ����syscall�Ĵ���10���˳�����   
	syscall

#Judge_Chaos�����������жϷ��õ�n���ʺ�ʱ�Ƿ�����ѷ���Ļʺ�����ͻ
Judge_Chaos: 
	li	$t4,0     		#j=0,$t4���ڱ���ѭ��ʱ�Ĳ���j   
LOOP2:  
	slt  	$t0,$t4,$a0     	#��j��nСʱ��$t0=1 
	beq   	$t0,$zero,Return1  	#��$t0=0,��j>=nʱ����ת��Return1,����ֵΪ1����ʾû�����n���ʺ��ͻ���$t0=1ʱ������ִ����һ��
	#Ѱַ����С��n��ÿ��i����n�Ƚ�
	sll   	$t1,$a0,2        	#��$a0��n������λ�߼����ƣ���λ�����$t1�У���$t1=n*4   
	add   	$s1,$s0,$t1      	#$s0ָ��loc����Ļ�ַ��������ڵõ�loc[n]     
	sll   	$t2,$t4,2       	#��$t4��j������λ�߼����ƣ���λ�����$t2�У���$t2=j*4
  	add   	$t3,$s0,$t2      	#$s0ָ��loc����Ļ�ַ��������ڵõ�loc[j]  
	lw    	$t6,0($s1)       	#�ӵ�ַ�еõ���ֵ��$t6=loc[n]    
	lw    	$t7,0($t3)       	#�ӵ�ַ�еõ���ֵ��$t7=loc[j] 
	sub  	$t0,$t7,$t6      	#��������$t0=(loc[j]-loc[n]) 		
	abs   	$t0,$t0          	#$t0=(abs(loc[j]-loc[n]))    
	sub   	$t5,$a0,$t4      	#$t1=(n-j) 
	seq   	$t2,$t0,$t5      	#���abs(loc[j]-loc[n])=(n-j)����$t2=1
	bne   	$t2,$zero,Return0	#$t2����1��abs(loc[j]-loc[n])=(n-j)ʱ��ת��Return0������ִ����һָ��
	beq   	$t6,$t7,Return0    	#loc[n]=loc[j]ʱ��ת��Return0,����ִ����һָ��    
	addi  	$t4,$t4,1        	#���û������ѭ������j+1�����ѭ��    
	j     	LOOP2            	#����ѭ�� 
Return0: 
	li	$v1,0       		#Judge_Chaos�����ķ���ֵΪ0��$v1=0 
 	jr   	$ra			#��ת���Ĵ���ָ���ĵ�ַ
Return1: 
	li	$v1,1			#Judge_Chaos�����ķ���ֵΪ1��$v1=1     
	jr   	$ra 			#��ת���Ĵ���ָ���ĵ�ַ
	
#EightQueens����
EightQueens: 
	addi  	$sp,$sp,-24      	#�ƶ�ջָ�룬����6λ���ֿռ�    
	sw   	$ra,20($sp)     	#EightQueens�������ص�ַ$ra��ջ   
	sw   	$v0,16($sp)     	#�˻ʺ�����������ֵ$v0��ջ   
	sw    	$a0,12($sp)     	#$a0��ջ    
	sw  	$a2,8($sp)       	#$a2��ջ   
	sw   	$s1,4($sp)      	#$s1��ջ
	#�ݹ�ķ������˻ʺ�����       
	bne   	$a0,$a1,Recursion    	#n������Qnʱ�����ݹ麯��Recursion���飻n����Qnʱ����ʾ�Ѿ������е�8���ʺ�ȫ���޳�ͻ������ϣ�����ִ����һָ��   
	addi  	$a2,$a2,1       	#�ⷨ��Ŀnum=num+1��
	sw    	$a2,8($sp)     		#���µõ�num�ٴ���$a2  
 	jal     Return         		#ֱ������Return���õ�����ֵ
Recursion:      
	li    	$s2,1     		#��$s2����ֵ1 
	sw    	$s2,0($sp)      	#$s2=iֵ��ջ
	jal	LOOP1			#��ת��LOOP1���еݹ����
LOOP1: 
	lw    	$a0,12($sp)      	#��ջ��nֵ������$a0    
	sle   	$t0,$s2,$a1      	#��i<=Qnʱ����$t0=1 
	beq  	$t0,$zero,Return  	#��$t0=0��i>Qnʱ����ת��Return;�������ִ����һָ��
	#ʵ��loc[n]=i
	sll   	$t1,$a0,2        	#��n������λ�߼����ƣ���λ�����$t1�У���$t1=n*4   
	add  	$s1,$s0,$t1      	#�������ַ��loc[0]������loc[n]��
	sw   	$s2,0($s1)       	#��loc[n]���浽i��
	jal   	Judge_Chaos           	#���ú���Judge_Chaos(n),�жϷ����n���ʺ�ʱ��ᷢ����ͻ������ֵ����$v1 
	beq  	$v1,$0,EXIT     	#������ֵ$v1=0����˵��������ͻ�����ܷ����n���ʺ���ת��EXIT�����Է����n���ʺ󣬼���ִ����һָ��    
	addi  	$a0,$a0,1        	#�����n���ʺ�֮�󣬼��������n+1��
	jal   	EightQueens      	#�ݹ����EightQueens������ֱ���ܹ����ؽ��
	move  	$a2,$v0   		#�������Ŀnum����$a2    
	sw    	$a2,8($sp)       	#��$a2ѹ��ջ�� 
		
EXIT:  #�����ǰ����Ļʺ��޷����ã�������ͻ��ʱ��������һ�ʺ����·���
	lw   	$s2,0($sp)       	#��ջ�ж�ȡ�����iֵ����$s2��    
	addi  	$s2,$s2,1        	#��i��1��������һλ��
	sw   	$s2,0($sp)       	#ͬʱ��ջ�е�iҲ����   
	jal     LOOP1            	#���½���LOOP1����������
	
Return: 
	lw    	$ra,20($sp)      	#$ra��ջ
	addi  	$sp,$sp,24       	#ջָ��ָ� 
	move  	$v0,$a2          	#��EightQueens�����ķ���ֵ��������num����$v0 
	jr    	$ra              	#��ת����ת�Ĵ���ָ��ĵ�ַ
