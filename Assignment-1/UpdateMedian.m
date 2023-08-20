function newMedian = UpdateMedian (oldMedian, NewDataValue, A, n)
   if(mod(n,2) == 0)
        if(NewDataValue >= A(n/2 + 1))
            newMedian = A(n/2 + 1);
         
        elseif(NewDataValue >= A(n/2))
                newMedian = NewDataValue;
        
        else
            newMedian = A(n/2);

        end
   else
       if(NewDataValue >= A((n+3)/2))
           newMedian = (oldMedian + A((n+3)/2))/2;
       elseif(NewDataValue >= A((n-1)/2))
           newMedian = (oldMedian + NewDataValue)/2;
       else
           newMedian = (oldMedian + A((n-1)/2));
    end
end