A = linspace(0,1,100);
B = linspace(1,0,100);
A2 = linspace(0,0.5,50);

alpha = 0;
beta = 0;

for i = 1:100
    r(i) = A(i)*0.05+B(i)*0.08;
    SD(i) = (A(i)^2*0.09+B(i)^2*0.15).^0.5;
end

tangent_SD = (0.4^2*0.09 + 0.6^2*0.15)^0.5;
tangent_r = 0.4*0.05+0.6*0.08;

xSD1 = 10000/8000;tangent_SD;
xSD2 = 6250/7250;

SD_1 = xSD1*tangent_SD;
SD_2 = xSD2*tangent_SD;

intercept = 0.03;
slope = (tangent_r-intercept)/tangent_SD;
CML = intercept+A2.*slope;

Port1 = [intercept+slope*SD_1,SD_1];
Port2 = [intercept+slope*SD_2,SD_2];


figure(1)
curve = plot(SD,r)
hold 'on'
line = plot(A2,CML)
scatter(Port1(2),Port1(1),'.','k');
scatter(Port2(2),Port2(1),'.','k');
scatter(tangent_SD,tangent_r,'.','k');
text(Port1(2),Port1(1),'Portfolio Manager 1 \rightarrow ','HorizontalAlignment','right')
text(Port2(2),Port2(1),'Portfolio Manager 2 \rightarrow ','HorizontalAlignment','right')
text(tangent_SD,tangent_r,'Tangency Portfolio \rightarrow ','HorizontalAlignment','right')
xlabel('volatility')
ylabel('expected return')
legend([curve,line],'Efficient frontier','CML')
title('Before the new regulation')


figure(2)
curve = plot(SD,r)
hold 'on'
line = plot(A2,CML)
%scatter(Port1(2),Port1(1),'.','k');
scatter(Port2(2),Port2(1),'.','k');
scatter(tangent_SD,tangent_r,'.','k');
text(Port2(2),Port2(1),'Portfolio Manager 2 \rightarrow ','HorizontalAlignment','right')
text(tangent_SD,tangent_r,'Portfolio Manager 1 = Tangency Portfolio \rightarrow ','HorizontalAlignment','right')
xlabel('volatility')
ylabel('expected return')
legend([curve,line],'Efficient frontier','CML')
title('After the new regulation')

