function w = task2_calcGrads(x)
[N,~] = size(x); %matrix input, each row repr. coords for a given vertex

m = zeros(N,1); %gradients

for i = 1:N
    if i ~= N
        vi = x(i,:);
        vi2 = x(i+1,:);
        
        m(i) = (vi(2)-vi2(2))/(vi(1)-vi2(1));
    else
        vN = x(i,:);
        v1 = x(1,:);
        
        m(i) = (vN(2)-v1(2))/(vN(1)-v1(1));
    end
end

c = zeros(N,1); %y-intercepts

for k = 1:N
    v = x(k,:);
    c(k) = -1*(m(k)*v(1) - v(2));
end
w = cat(2,c,m);
end