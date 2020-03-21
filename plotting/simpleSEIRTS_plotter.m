function simpleSEIRTS_plotter(feat_emp,feat_sim,feat_xscale,R,a1,a2)
titname = {'Infected','Recovered','Dead'};
for i = 1:3
    subplot(1,3,i)
    plot(feat_xscale,feat_emp{1}{1}(i,:));
    hold on
    plot(feat_xscale,feat_sim{1}{1}(i,:));
    set(gca,'YScale','log');
    title(titname{i})
    xlabel('Time')
    ylabel('Number of People')
    
end

legend(strcat(R.data.srcCountry,'Simulated'))

