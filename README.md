# OS4 MATLAB2018a


This is a project aiming to get OS4 ready for testing fractional order controllers.

# Note that 
This work has been merged into: https://github.com/Fractional-order-controller/FOFC_Benchmark



## Citations:
```
@inproceedings{shang2018fractional_os4_icarcv,
  title={Fractional Order Flight Control of Quadrotor UAS: an OS4 Benchmark Environment and a Case Study(accepted)},
  author={Shang, Bo and Zhang, Yunzhou and Wu, Chengdong and Chen, YangQuan},
  booktitle={International Conference on Control, Automation, Robotics and Vision (ICARCV)},
  year={2018},
  organization={IEEE}
}
```
Bo Shang, Yunzhou Zhang, Chengdong Wu, YangQuan Chen. Fractional Order Flight Control of Quadrotor UAS: an OS4 Benchmark Environment and a Case Study. International Conference on Control, Automation, Robotics and Vision (ICARCV), 2018.

## Usage:
* Double click on the file "systema.slx";
* Run the model;
* Comment through the FOPD controller and comment out the IOPID controller;
* Re-run the model;
* Launch Simulation Data Inspector. Check the output to compare the curves;
* Linear model step response is in the folder of IRID;
* Linear model disturbance is also in the folder of IRID, but the git branch needs to be switched to "verify-impulse" first.

## References:
Bouabdallah, Samir. "Design and control of quadrotors with application to autonomous flying." PhD Thesis(2007).



## Contact:

cnpcshangbo@gmail.com
