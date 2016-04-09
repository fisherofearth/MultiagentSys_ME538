results= [];

A = GReward(1,:);


for i = 1: 600
    noisy =100 + ( (random('unid', 3)*random('unid', 4)) * (random('unid', 3) - 2));
    A(1, i) = A(1, i) *  (noisy / 100);
end
stem(A)


A = GReward(1,:);
size  = 600;
acc =  random('unid', size,1,100);
for i =  1 : 100
    noisy =(random('unid', 100) / 100 + 0.05) / 10;
    A(1, acc(i))  = A(1, acc(i)) *  ((100  -noisy ) / 100);
end
A = smooth(A,100, 'moving');
plot(A);

results = [];
results(1, :)  = A;
for i = 2 : 100
    
    reduce =((random('unid', 100 - i))^2 / 100 + 0.05) / 10000;
    
    results(i, :) =  results(i-1, :) *  ((100  -reduce ) / 100);
    
    acc =  random('unid', size,1,100);
    for j = 1 : 100
        results(i, acc(j))  = results(i, acc(j)) *  ((100  -noisy ) / 100);
    end
     results(i, : ) = smooth( results(i, : ),20, 'moving');
end

mesh(results);