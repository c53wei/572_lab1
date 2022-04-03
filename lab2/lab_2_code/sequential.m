function [G,error] = sequential(X,Y, j_lim, aData, bData)
    a = aData;
    b = bData;
    naBCount = [];
    nbACount = [];
    goodAList = [];
    goodBList = [];
    j = 0;
    
    %1. Let a and b represent the data points in classes A and B. Let j = 1.
    while true
        badDiscriminant = true;
        abConfusion = [];
        while badDiscriminant
        %2. Randomly select one point from a and one point from b
            selectedA = aData(randi(size(aData,1)),:);
            selectedB = bData(randi(size(bData,1)),:);

            nA = 0;
            nB = 0;
            naB = 0;   
            nbA = 0;    

            correctA = [];
            correctB = [];
            
            for i=1:size(aData, 1)
                x = aData(i,:);
                % 3. Create a discriminant G using MED with the two points as prototypes
                %MED Calculations
                distanceToA = sqrt((selectedA(1)-x(1)).^2 + (selectedA(2)-x(2)).^2);
                distanceToB = sqrt((selectedB(1)-x(1)).^2 + (selectedB(2)-x(2)).^2);

                % compare the distanceToA to distanceToB
                if distanceToA < distanceToB %the point is correctly identified, add it to the list of correct A
                    nA = nA + 1;
                    correctA = cat(1,correctA, x);
                    
                else %the point is incorrectly identified, add a counter.
                    naB = naB + 1;
                end
            end
            
            % Same process with B
            for i=1:size(bData, 1)
                x = bData(i,:);
                distanceToA = sqrt((selectedA(1)-x(1)).^2 + (selectedA(2)-x(2)).^2);
                distanceToB = sqrt((selectedB(1)-x(1)).^2 + (selectedB(2)-x(2)).^2);
                if distanceToA > distanceToB
                    nB = nB + 1;
                    correctB = cat(1,correctB, x);            
                else
                    nbA = nbA + 1;            
                end
            end
            
            % 4. Using all of the data in a and b, work out the confusion matrix entries
            abConfusion = [
                nA    naB;
                nbA      nB;
                ];

           % 5. if naB, nbA =/= 0, go back to step 2 
            if naB == 0 || nbA == 0
                badDiscriminant = false;
            end
        end
        % 6. This discriminant is good; save it as Gj = G,
        
        % Let j = j + 1.
        j = j+1;
        goodAList = cat(1,goodAList, selectedA); %naB,j = naB
        goodBList = cat(1,goodBList, selectedB); %nbA,j = nbA

        naB = abConfusion(1,2); % #times G classifies a point from a as class B
        nbA = abConfusion(2,1); % #times G classifies a point from b as class A

        naBCount = cat(1, naBCount, naB);
        nbACount = cat(1, nbACount, nbA);

        % 7.
        if naB == 0 
            % then remove those points from b that G classifies as B
            bData = setxor(bData, correctB,'rows');
        end
        
        % 8.
        if nbA == 0 
            % then remove those points from a (A_data) that G
            % classifies as A (success_A) using 'set exclusive'
            aData = setxor(aData, correctA,'rows');
        end 
        
        if size(aData,1)== 0 || size(bData, 1) == 0 || (j_lim ~= 0 && j == j_lim)
            break
        end        
    end
    
    nA = 0;
    nB = 0;

    %At this point we have a sequence of discriminants, each of which classifies
    % some part of the problem perfectly. The overall classifier for some given point
    % x is sequential, passing through G1, G2, . . . until a classification is made:
 
    G = zeros(size(X));
    for k=1:numel(X)
        for i=1:j %let j = 1, or in this case i = 1
            selectedA = goodAList(i,:);
            selectedB = goodBList(i,:);
            x = [X(k) Y(k)];
            distanceToA = sqrt((selectedA(1)-x(1)).^2 + (selectedA(2)-x(2)).^2);
            distanceToB = sqrt((selectedB(1)-x(1)).^2 + (selectedB(2)-x(2)).^2);
            
            % 2. If Gj classifies x as class B and naB,j = 0 then "Say Class B”
            if distanceToA > distanceToB && naBCount(i)== 0 
                G(k) = 1;
                break            
            %3. If Gj classifies x as class A and nbA,j = 0 then “Say Class A”    
            elseif distanceToA < distanceToB && nbACount(i)== 0 
                G(k) = 10;
                break
            end
            %4. Otherwise j = j + 1 and go back to step 2.
        end
    end
    
    %calculate error rate by finding nA and nB, similar process;
    for k=1:size(a,1) 
        x = a(k,:);
        for i=1:j
            selectedA = goodAList(i,:);
            selectedB = goodBList(i,:);
            distanceToA = sqrt((selectedA(1)-x(1)).^2 + (selectedA(2)-x(2)).^2);
            distanceToB = sqrt((selectedB(1)-x(1)).^2 + (selectedB(2)-x(2)).^2);

            if distanceToA < distanceToB
                nA = nA + 1;
                break
            end
        end  
    end

    for k=1:size(b,1) 
        x = b(k,:);
        for i=1:j
            selectedA = goodAList(i,:);
            selectedB = goodBList(i,:);
            distanceToA = sqrt((selectedA(1)-x(1)).^2 + (selectedA(2)-x(2)).^2);
            distanceToB = sqrt((selectedB(1)-x(1)).^2 + (selectedB(2)-x(2)).^2);

            if distanceToA > distanceToB
                nB = nB + 1;
                break
            end
        end  
    end
    error = 1 - ((nA + nB)/ 400); %400 data points
end
