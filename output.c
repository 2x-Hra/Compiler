{
int a, d = 2, b = 10;
int c = 2;
int t1 = 2 * 3;
int t2 = b + t1;
a = t2;
FOR_BEGIN_1:
{
a = 0;
FOR_CONDITION_1:
{
int t3 = a == b;
if(t3==0) goto FOR_END_1;
goto FOR_CODE_1;
}
FOR_STEP_1:
{
int t4 = a + 1;
a = t4;
goto FOR_CONDITION_1;
}
FOR_CODE_1:
{
int t5 = c * 10;
c = t5;

}
goto FOR_STEP_1;
}
FOR_END_1:
IF_BEGIN_1:
{
IF_CONDITION_1:
{
int t6 = a < 1;
if (t6==0) goto ELSE_CODE_1;
goto IF_CODE_1;
}
IF_CODE_1:
{
b = 4;

}
goto ELSE_END_1;
ELSE_CODE_1:
{
b = 5;

}
ELSE_END_1:
}

}
