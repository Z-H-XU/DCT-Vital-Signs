function [breathe,heartbeat]=plot_emd(x,imf_emd,Ts)
N = length(x);
t = linspace(0,(N-1)*Ts,N);
[M,n] = size(imf_emd);
for k1 = 0:4:M-1
    figure
    for k2 = 1:min(4,M-k1)
        subplot(4,2,2*k2-1)
        plot(t,imf_emd(k1+k2,:));
        set(gca,'FontSize',8,'XLim',[0 t(end)]);
        title(sprintf('The %d -th IMF component', k1+k2));
        xlabel('Time/s');
        ylabel(sprintf('IMF%d', k1+k2));
        
        subplot(4,2,2*k2)
        [yf, f] = FFTAnalysis(imf_emd(k1+k2,:), Ts);
        plot(f,yf);
        ind = find(yf==max(yf));        
        x0 = f(ind);                     
        y0 = yf(ind);                     
        
        id(k1+k2) = find(yf == max(yf));  
        m(k1+k2) = f(id(k1+k2));         
        a = find((0.1<m) & (m<0.5));    
        b = find((0.8<m) & (m<2));     
        aa = length(a);
        bb = length(b);
               
        x_reconstruct = 0; 

        if (0.1<x0) && (x0<0.5)
            title(sprintf('The %d-th IMF, breathing component', k1+k2));  
            if aa>2
                for j = 1:aa
                    s1 = corrcoef([x,imf_emd(a(j),:)']);
                    b1(j) = s1(1,2); 
                end
                [p1,q1] = sort(b1,'descend');
                h1 = q1(1,[1 2]);
                breathe = x_reconstruct + imf_emd(a(h1(1)),:) + imf_emd(a(h1(2)),:);  
            elseif aa == 1
                breathe = x_reconstruct + imf_emd(a(1),:);
            elseif aa == 2
                breathe = x_reconstruct + imf_emd(a(1),:) + imf_emd(a(2),:);
            else
                breathe = x_reconstruct;
            end

        elseif (0.8<x0) && (x0<2)
            title(sprintf(' The %d-th IMF, heart beat component', k1+k2));  
            if bb>2
                for j = 1:bb
                    s2 = corrcoef([x,imf_emd(b(j),:)']);
                    b2(j) = s2(1,2); 
                end
                [p2,q2] = sort(b2,'descend');
                h2 = q2(1,[1 2]);
                heartbeat = x_reconstruct + imf_emd(b(h2(1)),:) + imf_emd(b(h2(2)),:);  
            elseif bb == 1
                heartbeat = x_reconstruct + imf_emd(b(1),:);
            elseif bb == 2
                heartbeat = x_reconstruct + imf_emd(b(1),:) + imf_emd(b(2),:);
            else
                heartbeat = x_reconstruct;
            end
        else
            title(sprintf('The %d-th IMF, noise component',k1+k2));
        end  
        
        hold on
        plot(x0,y0,'ro');
        text(x0,y0,['(',num2str(x0,3),',',num2str(y0,3),')'],'color','b');  
        xlabel('f/Hz')
        ylabel('|IMF(f)|');
    end
end
end
