FFTDATA = power_fftscope(Gen1_Vab_5);
FFTDATA.cycles = 1;
FFTDATA.fundamental = 400;
FFTDATA.startTime = THD_TestPoints(2,11);
FFTDATA.maxFrequency = 12000;
power_fftscope(FFTDATA);

NewXLabels=num2str([0 2000 4000 6000 8000 10000 12000]'/400);

set(gca,'XTickLabel',NewXLabels);
xlabel('Harmonic Order','FontSize',12,'FontWeight','Bold');
ylabel('Magnitude','FontSize',12,'FontWeight','Bold');
title('FFT Analysis','FontSize',14,'FontWeight','Bold');