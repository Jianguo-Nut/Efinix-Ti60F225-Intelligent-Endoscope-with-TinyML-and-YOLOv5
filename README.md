毕业设计课题：  
基于易灵思FPGA的便携智能肠道内窥镜  

硬件：  
奥唯思VF-Ti60F225开发板  

开发环境：  
Efinity IDE v2025.1.110.5.9  
Efinity RISC-V Embedded Software IDE v2024.2

触摸屏驱动SoC源码路径：embedded_sw\touch_soc\software\standalone\gpio\gpioDemo  
模型推理SoC源码路径：embedded_sw\sapphire_soc\software\standalone\evsoc_tinyml_ypd  
YOLO模型文件路径：embedded_sw\sapphire_soc\software\standalone\evsoc_tinyml_ypd\src\model\best_int8_fixed.tflite  
FPGA源码路径：src

基于Ti60F225，实现艾庐a2020内窥模组驱动与ISP(自动曝光、Gamma校正与白平衡调整)部署Efinix TinyML Accelerator用于神经网络加速，并部署两颗Sapphire SoC，分别负责YOLO模型推理与IIC触摸屏驱动。模型基于YOLOv5构建，对模拟肠道病灶的线椒籽进行识别。  

![实物图](https://github.com/Jianguo-Nut/Efinix-Ti60F225-Intelligent-Endoscope-with-TinyML-and-YOLOv5/blob/main/a.png)

![采集](https://github.com/Jianguo-Nut/Efinix-Ti60F225-Intelligent-Endoscope-with-TinyML-and-YOLOv5/blob/main/capture.png)
