function hl = simpleSEIRTS_plotter_CI(R,A,empflag,cmap)

% Compute stats
for i = 1:numel(A.feat_rep)
    X(:,:,i) = A.feat_rep{i}{1};
end

XE = mean(X,3);
XS = std(X,[],3);%./sqrt(numel(A.feat_rep));


titname = {'Infected','Recovered','Dead'};
for i = 1:3
    subplot(1,3,i)
    if empflag
        plot(1:numel(R.data.feat_xscale),R.data.feat_emp{1}(i,:),'r','LineWidth',2);
    end
    hold on
    [hl, hp] = boundedline(1:numel(R.data.feat_xscale),XE(i,:)',XS(i,:)');
    hp.FaceColor = cmap;
    hp.FaceAlpha = 0.7;
    hl.Color = cmap;
    
    %     set(gca,'YScale','log');
    title(titname{i})
    xlabel('Time')
    ylabel('Number of People')
    a = gca;
    xlim([1 numel(R.data.feat_xscale)])
    a.XTick = fix(linspace(1,numel(R.data.feat_xscale),4));
    a.XTick(1) = 1;
    a.XAxis.TickLabels = datestr(R.data.feat_xscale( a.XTick),19);
    
end

legend({R.data.srcCountry,'Simulated'})

