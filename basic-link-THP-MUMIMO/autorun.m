clear all;
for i = 1:100
    step = 100;
    TTI_START = 1+step*(i-1);
    TTI_NUM = 99;
    TTI_END = TTI_START+TTI_NUM;
    save('TTI.mat');
    basic_link_THP;
end