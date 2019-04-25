function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************
seq = nchoosek([1,2,3],2);
flag1 = zeros(1,3);
flag2 = zeros(1,3);

for i = 1:length(seq)
    k = setdiff([1 2 3],seq(i,:));
    if P1(seq(i,1),1) - P1(seq(i,2),1) == 0
        val_j = [P1(seq(i,1),1)-P1(k,1) P2(1,1)-P1(seq(i,1),1) P2(2,1)-P1(seq(i,1),1) P2(3,1)-P1(seq(i,1),1)];
        flag1(i) = all(val_j>0) || all(val_j<0);
    else
        Coeff = [(P1(seq(i,1),2)-P1(seq(i,2),2))/(P1(seq(i,1),1)-P1(seq(i,2),1)) -1 (P1(seq(i,1),1)*P1(seq(i,2),2)-P1(seq(i,2),1)*P1(seq(i,1),2))/(P1(seq(i,1),1)-P1(seq(i,2),1))];
        val_j = Coeff*[P1(k,:)' P2';1 1 1 1];
        val_j(1) = -val_j(1);
        flag1(i) = all(val_j>0) || all(val_j<0);
    end
end

for i = 1:length(seq)
    k = setdiff([1 2 3],seq(i,:));
    if P2(seq(i,1),1) - P2(seq(i,2),1) == 0
        val_j = [P2(seq(i,1),1)-P2(k,1) P1(1,1)-P2(seq(i,1),1) P1(2,1)-P2(seq(i,1),1) P1(3,1)-P2(seq(i,1),1)];
        flag2(i) = all(val_j>0) || all(val_j<0);
    else
        Coeff = [(P2(seq(i,1),2)-P2(seq(i,2),2))/(P2(seq(i,1),1)-P2(seq(i,2),1)) -1 (P2(seq(i,1),1)*P2(seq(i,2),2)-P2(seq(i,2),1)*P2(seq(i,1),2))/(P2(seq(i,1),1)-P2(seq(i,2),1))];
        val_j = Coeff*[P2(k,:)' P1';1 1 1 1];
        val_j(1) = -val_j(1);
        flag2(i) = all(val_j>0) || all(val_j<0);
    end
end

flag = sum([flag1 flag2])==0;
% *******************************************************************
end