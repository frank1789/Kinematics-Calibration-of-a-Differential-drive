function graphOptimization( parameters )

% Instanziate vecotrs of radii
Left  = [parameters{1}(1); parameters{2}(1); parameters{3}(1); parameters{4}(1)];
Right = [parameters{1}(2); parameters{2}(2); parameters{3}(2); parameters{4}(2)];

% Collect 
collectRadidus = [Left, Right];

% Name for boxplot
NameRadii = ['Left ';'Right'];

figure();
subplot(3,1,1)
boxplot(collectRadidus, NameRadii,'orientation','horizontal')
xlabel('[cm]')

subplot(3,1,3)
boxplot([parameters{1}(3); parameters{2}(3); parameters{3}(3); parameters{4}(3)],'orientation','horizontal')
set(gca,'YTickLabel',{'Track'})
xlabel('[cm]')

subplot(3,3,4)
boxplot([parameters{1}(4); parameters{2}(4); parameters{3}(3); parameters{4}(4)]);
set(gca,'XTickLabel',{'orientation camera in RFr'})
ylabel('[rad]')

subplot(3,3,5)
boxplot([parameters{1}(5); parameters{2}(5); parameters{3}(5); parameters{4}(5)]);
set(gca,'XTickLabel',{'offset'})
ylabel('[cm]')

subplot(3,3,6)
boxplot([parameters{1}(6); parameters{2}(6); parameters{3}(6); parameters{4}(6)]);
set(gca,'XTickLabel',{'angle'})
ylabel('[rad]')
pause(0.5)

%export graph
print('boxplot','-depsc','-tiff','-r0');

end