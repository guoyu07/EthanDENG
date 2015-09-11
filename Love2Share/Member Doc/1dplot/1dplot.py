#!/usr/bin/env python
#coding=utf-8
import numpy as np
import matplotlib.pyplot as plt

datafile = raw_input("\nPlease input the name of datafile: ")
num = input('Please input the number of lines: ')
num = int(num)
predata = np.loadtxt(datafile, dtype=np.str, delimiter=",")
data = predata[1:,:num+1].astype(np.float)
for i in range(1,num+1):
	plt.plot(data[:,0],data[:,i],'-',label=predata[0,i],linewidth=2)
plt.xlabel("Time (fs)")
plt.ylabel("Population")
plt.legend()
plt.show()
