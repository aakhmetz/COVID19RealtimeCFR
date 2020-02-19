# Real-time assessment of the risk of death from novel coronavirus (COVID-19) infection

Supplementary Materials for Jung, S.-M.; Akhmetzhanov, A.R.; Hayashi, K.; Linton, N.M.; Yang, Y.; Yuan, B.; Kobayashi, T.; Kinoshita, R.; Nishiura, H. Real-Time Estimation of the Risk of Death from Novel Coronavirus (COVID-19) Infection: Inference Using Exported Cases. J. Clin. Med. **2020**, 9, 523. ([doi:10.3390/jcm9020523](http://dx.doi.org/10.3390/jcm9020523))
 
**Pre-processing the data**</br>(R version 3.6.1)
* [A. Preparing the data - notebook version of the Rscript.ipynb](https://nbviewer.jupyter.org/github/aakhmetz/WuhanCFR2020/blob/master/scripts/A.%20Preparing%20the%20data%20-%20notebook%20version%20of%20the%20Rscript.ipynb)
 
**Main analysis**</br>([PyMC3](https://docs.pymc.io/) version 3.8 in Python)
* [C1a. Analysis in PyMC3 - Scenario 1.ipynb](https://nbviewer.jupyter.org/github/aakhmetz/WuhanCFR2020/blob/master/scripts/C1a.%20Analysis%20in%20PyMC3%20-%20Scenario%201.ipynb)
* [C1b. Analysis in PyMC3 - Scenario 2.ipynb](https://nbviewer.jupyter.org/github/aakhmetz/WuhanCFR2020/blob/master/scripts/C1b.%20Analysis%20in%20PyMC3%20-%20Scenario%202.ipynb)

**Sensitivity analysis**</br>([PyMC3](https://docs.pymc.io/) version 3.8 in Python)
* [D1. Sensitivity for t0.ipynb](https://nbviewer.jupyter.org/github/aakhmetz/WuhanCFR2020/blob/master/scripts/D1.%20Sensitivity%20for%20t0.ipynb)
* [D2a. Sensitivity for CUTOFF_TIME - Scenario 1.ipynb](https://nbviewer.jupyter.org/github/aakhmetz/WuhanCFR2020/blob/master/scripts/D2a.%20Sensitivity%20for%20CUTOFF_TIME%20-%20Scenario%201.ipynb)
* [D3a. Sensitivity for WuhanPop - Scenario 1.ipynb](https://nbviewer.jupyter.org/github/aakhmetz/WuhanCFR2020/blob/master/scripts/D3a.%20Sensitivity%20for%20WuhanPop%20-%20Scenario%201.ipynb)
* [D3b. Sensitivity for WuhanPop - Scenario 2.ipynb](https://nbviewer.jupyter.org/github/aakhmetz/WuhanCFR2020/blob/master/scripts/D3b.%20Sensitivity%20for%20WuhanPop%20-%20Scenario%202.ipynb)
* [D4a. Sensitivity for Tdetection - Scenario 1.ipynb](https://nbviewer.jupyter.org/github/aakhmetz/WuhanCFR2020/blob/master/scripts/D4a.%20Sensitivity%20for%20Tdetection%20-%20Scenario%201.ipynb)
* [D4b. Sensitivity for Tdetection - Scenario 2.ipynb](https://nbviewer.jupyter.org/github/aakhmetz/WuhanCFR2020/blob/master/scripts/D4b.%20Sensitivity%20for%20Tdetection%20-%20Scenario%202.ipynb)

**Generating the figures**</br>(R version 3.6.1 with use of ggplot2 package)
* [E1. Figure 1.ipynb](https://nbviewer.jupyter.org/github/aakhmetz/WuhanCFR2020/blob/master/scripts/E1.%20Figure%201.ipynb)
* [E2. Figure - sensitivity for t0.ipynb](https://nbviewer.jupyter.org/github/aakhmetz/WuhanCFR2020/blob/master/scripts/E2.%20Figure%20-%20sensitivity%20for%20t0.ipynb)
* [E3a. Figure - sensitivity for CUTOFF_TIME - Scenario 1.ipynb](https://nbviewer.jupyter.org/github/aakhmetz/WuhanCFR2020/blob/master/scripts/E3a.%20Figure%20-%20sensitivity%20for%20CUTOFF_TIME%20-%20Scenario%201.ipynb)


 
------
**Thank you for your interest to our work.**

Words of caution: We would like to note that our code is not supposed to work out of box, because our main intent was to show the relevance of the methods used in our paper.
