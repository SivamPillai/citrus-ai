%Generate a
[fileName, filePath] = uigetfile('*.jpg','Select an Image');

if fileName == 0 
    disp('No file provided');
    return;
end
myFile = strcat(filePath, fileName);

[orig_img,cmap] = imread(myFile);
crop_img = imcrop(orig_img,[1 1 100 100]);
gray_img = rgb2gray(crop_img);
vec_img = gray_img(:);

mean_vec_img = mean(vec_img,1);
std_vec_img = std(double(vec_img),0,1);
vec_img = double(vec_img);
    
vec_img_norm = (vec_img - mean_vec_img)./std_vec_img;

vec_img_norm = [1; vec_img_norm];

img_gender = hardlim(w_gender(end,:)*vec_img_norm);
img_smile = hardlim(w_smile(end,:)*vec_img_norm);
img_glasses = hardlim(w_glasses(end,:)*vec_img_norm);


if img_gender == 1
    gender = 'Gender = Male';
else gender = 'Gender = Female';
end
if img_smile == 1
    smile = 'Expression = Smiling';
else smile = 'Expression = Not Smiling';
end
if img_glasses == 1
    glasses = 'Vision State = Wearing Glasses';
else glasses = 'Vision State = Not Wearing Glasses';
end

person = strcat('Image File Name: ',fileName);
message = msgbox({person, '', gender, smile, glasses},'AI Image Analysis','custom',orig_img,cmap);

