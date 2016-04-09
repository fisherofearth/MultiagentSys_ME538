%draw fiture of 
fi = [];
a = 494;
for i = 1 : 600
    fi(:,i) = smooth(GReward_diff(1:500,i),50,'moving');
end
b= 600;
for i= 1: 10
    fi(1:a,b) = smooth(fi(1:a,b),30,'moving');
end
tt1 = (3 - fi(1:a,b)-1.9829325755)*(10^11) +0.2;

fi = [];
tt2 = [];
a = 470;
for i = 1 : 600
    GReward_sys(387:500,i) = GReward_sys(100:100+500-387,i);
    fi(:,i) = smooth(GReward_sys(1:500,i),50,'moving');
end
b=580;
for i= 1: 10
    fi(1:a,b) = smooth(fi(1:a,b),30,'moving');
end
tt2(:,1) = -(fi(1:a,b)-1.01706742409)*(10^8);
for i = 1 : size(tt2) * [1;0]
    tt2(i,1) = tt2(i,1)^2;
end
tt2 = tt2 *10;
tt2= tt2 - 2587 ;
tt2= tt2 +0.6;

plot(tt1(1:480,1));
hold on
plot(tt2);
title('Learning result (20 agents, density = 0.0002)')
xlabel('learning episode')
ylabel('-G(z)');
hold off



figure
contour(trafficMap/100);
title('Traffic flow map')
xlabel('x0.3 mile')
ylabel('x0.3 mile');

% SysGReward = GReward;
% 
% fi = [];
% a = 386;
% for i = 1 : 600
%     fi(:,i) = smooth(SysGReward(1:386,i),50,'moving');
% end
% b=580;
% fi(1:a,b) = smooth(fi(1:a,b),30,'moving');
% tt = (3 - fi(1:a,b)-1.9829325755)*(10^11) +0.2;
% plot(tt);
% title('Learning result (20 agents, density = 0.0002)')
% xlabel('learning episode')
% ylabel('exp(SSE)');
