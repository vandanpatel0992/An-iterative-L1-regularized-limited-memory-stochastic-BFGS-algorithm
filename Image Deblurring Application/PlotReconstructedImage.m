h=waitbar(0,'you are awsome!');
 for i=1:12
for j=1:4
load(strcat('S',num2str(i),'_',num2str(j),'.mat'),'w')
W=reshape(w,[l l]); %B is sparse matrix
W=full(W); %B is double
W=uint8(W); % B is uint8 for imshow()
figure, imshow(W), title(strcat('ReconstructedImage: S',num2str(i),'_',num2str(j)));
saveas(gcf,strcat('S',num2str(i),'_',num2str(j),'.jpg'))

end
 waitbar(i/12);
 end