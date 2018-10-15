function [w1,w2,w3,w4] = zeroForcingBeamforming(h1,h2,h3,h4)
%zeroForcingBeamforming - zero Forcing Beamforming
% 
% Syntax:  [w1,w2,w3,w4] = zeroForcingBeamforming(h1,h2,h3,h4)
% 
% Input Arguments:
%    h1,h2,h3,h4 - Channel
% 
% Output Arguments:
%    w1,w2,w3,w4 - Precoding

%----------------------------- BEGIN CODE --------------------------------- 
w1 = zeros(size(h1));
w2 = zeros(size(h2));
w3 = zeros(size(h3));
w4 = zeros(size(h4));
for i = 1:size(h1,2)
    H = [h1(:,i) h2(:,i) h3(:,i) h4(:,i)];
    W = H*inv(H'*H);
    ww1 = W(:,1);
    w1(:,i) = ww1/norm(ww1);
    ww2 = W(:,2);
    w2(:,i) = ww2/norm(ww2);
    ww3 = W(:,3);
    w3(:,i) = ww3/norm(ww3);
    ww4 = W(:,4);
    w4(:,i) = ww4/norm(ww4);
end
end
%----------------------------- END OF CODE --------------------------------