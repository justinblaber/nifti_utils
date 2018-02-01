function vol = load_untouch_nii_vol(nii_path,type)
    % Returns .img from load_untouch_nii. "type" is optional, and if 
    % provided, .img will get converted to this type. type is typically
    % 'logical', 'double', etc... 

    nii = load_untouch_nii(nii_path);         
    vol = nii.img;

    if exist('type','var')
        type_fun = str2func(type);            
        vol = type_fun(vol);
    end
end