function graphOptimization( parameters, index )

% Instanziate vecotrs of radii
Left  = [parameters(index{1},1); parameters(index{2},1); parameters(index{3},1); parameters(index{4},1)];
Right = [parameters(index{1},2); parameters(index{2},2); parameters(index{3},2); parameters(index{4},2)];
% Collect 
collectRadidus = [Left, Right];
% Name for boxplot
NameRadii = ['Left ';'Right'];
% Generate boxplot

       
% Generate boxplot for track       
track = [parameters(index{1},3); parameters(index{2},3); parameters(index{3},3); parameters(index{4},3)];


% other parameters
beta = [parameters(index{1},4); parameters(index{2},4); parameters(index{3},3); parameters(index{4},4)];
d    = [parameters(index{1},5); parameters(index{2},5); parameters(index{3},5); parameters(index{4},5)];
alpha= [parameters(index{1},6); parameters(index{2},6); parameters(index{3},6); parameters(index{4},6)];
figure();

subplot(3,1,1)
boxplot(collectRadidus, NameRadii,'orientation','horizontal')

subplot(3,1,3)
boxplot(track,'orientation','horizontal')
set(gca,'YTickLabel',{'Track'})

subplot(3,3,4)
boxplot(beta);
set(gca,'XTickLabel',{'beta'})

subplot(3,3,5)
boxplot(d);
set(gca,'XTickLabel',{'d'})

subplot(3,3,6)
boxplot(alpha);
set(gca,'XTickLabel',{'alpha'})
pause(0.5)
%export graph
print('boxplot','-depsc','-tiff','-r0');

end