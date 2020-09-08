
self = imread('self.jpg');
gray = rgb2gray(self);
gray_converted = im2uint8(gray);
imwrite(gray_converted, 'gray.jpg');
%imshow(gray_converted);
increased_brightness = gray_converted+40 ;  %increased brightness 
imwrite(increased_brightness , 'increased_brightness.jpg') ;
decreased_brightness = gray_converted -40 ; 
imwrite(decreased_brightness, 'decreased_brightness.jpg');
%transform mapping 
increase_contrast = (gray_converted-40)*1.4;     %increasing slope and decreasing c 
imwrite(increase_contrast, 'increase_contrast.jpg');
decrease_contrast = (gray_converted +40)*.75;    %decreasing slope and increasing c
imwrite(decrease_contrast, 'decrease_contrast.jpg');
%%%%%%%
img{1}=imread('increased_brightness.jpg');
img{2}=imread('decreased_brightness.jpg');
img{3}=imread('increase_contrast.jpg');
img{4}=imread('decrease_contrast.jpg');
for i=1:4
    figure
    imhist(img{i});
    figure
    imhist(customhisteq(img{i}));
    figure 
    imshow(customhisteq(img{i}));
end


% implementing a histogram equalisation function
function out = customhisteq(img)
orginal = img;
[rows,columns,~] = size(orginal);
finalResult = uint8(zeros(rows,columns));
pixelNumber = rows*columns;
frequncy = zeros(256,1);
pdf = zeros(256,1);
cdf = zeros(256,1);
cummlative = zeros(256,1);
outpic = zeros(256,1);
for i = 1:1:rows
    for j = 1:1:columns
        val = orginal(i,j);
        frequncy(val+1) = frequncy(val+1)+1;
        pdf(val+1) = frequncy(val+1)/pixelNumber;
    end
end
sum =0 ;
%we want the 256 - 1 that's why we initailzed the intensityLevel with 255
%instead of 256
intensityLevel = 255;

for i = 1:1:size(pdf)
    sum =sum +frequncy(i);
    cummlative(i) = sum;
    cdf(i) = cummlative(i)/ pixelNumber;
    outpic(i) = round(cdf(i) * intensityLevel);
end


for i = 1:1:rows
    for j = 1:1:columns
        finalResult(i,j) = outpic(orginal(i,j) + 1);
    end
end
out = finalResult
end


