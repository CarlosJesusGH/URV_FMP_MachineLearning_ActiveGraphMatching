function varargout = DetectClickCoorOverImage(varargin)
I1 = imread('img_01.png');
figure
imageHandle = imshow(I1); 
set(imageHandle,'ButtonDownFcn',@ImageClickDown);
end

function ImageClickDown ( objectHandle , eventData )
axesHandles  = get(objectHandle,'Parent');
coordinate = get(axesHandles,'CurrentPoint'); 
curX = coordinate(1,1);
curY = coordinate(1,2);
curX , curY
end
