
self = imread('self.jpg');
%imshow(self);
gray = rgb2gray(self);
gray_converted = im2uint8(gray);
imshow(gray_converted);
for bp = 0 : 7
	bitPlaneImage = bitget(gray_converted, bp+1);
    imshow(bitPlaneImage, []);
    caption =  sprintf('Bit %d.', bp);
    title(bp)
    if bp ~= 7
        message = sprintf('%s\nDo you want to continue', caption);
        button = questdlg(message, 'Continue?', 'Yes', 'No', 'Yes');
       
        drawnow;	
        if strcmpi(button, 'No')
           break;
        end
    end
end