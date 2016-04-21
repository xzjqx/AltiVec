# 计算机设计与调试课程设计

## 课程任务

### 指令功能设计
采用C或C++语言，完成所要设计的5条指令的功能 -- [instruction_ops](https://github.com/xzjqx/AltiVec/tree/master/instruction_ops)
- vaddsws
- vsububm
- vavgsh
- vcmpequh
- vslb

### 模块设计
采用Verilog HDL，设计PowerPC协处理器AltiVec模块中部分VSFX指令 -- [vsfx](https://github.com/xzjqx/AltiVec/tree/master/vsfx)

### 顶层模块集成
将设计的VSFX指令模块与其他模块集成
看懂模块与模块之间的关系 -- [altivec_demo2](https://github.com/xzjqx/AltiVec/tree/master/altivec_demo2)

### 仿真验证
用Altivec汇编指令编写测试程序，通过汇编器生成机器码
在集成环境下，仿真验证设计的正确性 -- [altivec_demo3](https://github.com/xzjqx/AltiVec/tree/master/altivec_demo3)
