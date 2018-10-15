function [out] = symbolModulate(in,order)
%symbolModulate - maps the bit values, in, to complex modulation symbols with
%the modulation scheme.
% 
% Syntax:  [out] = symbolModulate(in,order)
% 
% Input Arguments:
%    in -  Input bits 
%    order - modulate order 
% 
% Output Arguments:
%    out -  modulated output symbols 

%----------------------------- BEGIN CODE --------------------------------- 
m = order/2;
in = double(in);
len = length(in);
bit_i = reshape(in(1:2:len),m,len/m/2);
bit_q = reshape(in(2:2:len),m,len/m/2);
temp_i = zeros(1,len/m/2);
temp_q = zeros(1,len/m/2);
for k = 1:m
    temp_i = temp_i + bit_i(k,:)*2^(m-k);
    temp_q = temp_q + bit_q(k,:)*2^(m-k);
end
switch m
    case 1
        const1 = 1/sqrt(2);
        data_i = (1-2*temp_i)*const1;
        data_q = (1-2*temp_q)*const1;
    case 2
        const1 = 1/sqrt(10);
        const3 = 3*const1;
        book_code = [const1,const3,-const1,-const3];
        data_i = book_code(temp_i+1);
        data_q = book_code(temp_q+1);
    case 3
        const1 = 1/sqrt(42);
        const3 = 3*const1;
        const5 = 5*const1;
        const7 = 7*const1;
        book_code = [const3,const1,const5,const7,-const3,-const1,-const5,-const7];
        data_i = book_code(temp_i+1);
        data_q = book_code(temp_q+1);
    otherwise
        disp('wrong because of m');
end
out = data_i + 1i*data_q;
end
%----------------------------- END OF CODE --------------------------------