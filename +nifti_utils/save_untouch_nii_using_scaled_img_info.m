function save_untouch_nii_using_scaled_img_info(nii_path,nii,type)
    % Saves input nii using its img info and type. Always sets scl_slope to
    % 1 and scl_inter to 0.

    % First set dims
    nii.hdr.dime.dim(:) = 1;
    nii.hdr.dime.dim(1) = length(size(nii.img));
    nii.hdr.dime.dim(2:1+length(size(nii.img))) = size(nii.img);

    % Set datatype
    switch type
        case 'double'
            nii.hdr.dime.datatype = 64;             % Double precision
            nii.hdr.dime.bitpix = 64;               % Double precision
        case 'logical'
            nii.hdr.dime.datatype = 2;              % uint8 - apparently there is a ubit1, but I doubt this works properly
            nii.hdr.dime.bitpix = 8;               
        otherwise
            error(['Input type of: ' type ' is currently unsupported.']);
    end

    % Set rest of relevant parameters.
    nii.hdr.dime.scl_slope = 1;
    nii.hdr.dime.scl_inter = 0;
    nii.hdr.dime.glmax = max(nii.img(:));
    nii.hdr.dime.glmin = min(nii.img(:));
    save_untouch_nii(nii,nii_path);            
end