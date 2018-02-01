function merge_untouch_nii4D(nii_in_paths,nii_out_path)
    % Loads niftis, concatenates them, then saves to nii_out_path. Input 
    % niftis should all be same except for scl_slope, scl_inter, datatype, 
    % and bitpix. Slope and scale are applied, and then datatype/bitpix are
    % set to double.

    % See if niftis are compatible first
    for i = 2:length(nii_in_paths)
        % Issue a warning instead of an error since some niftis have 
        % slightly different qform/sforms
        if ~nifti_utils.are_compatible(nii_in_paths{1},nii_in_paths{i})
            warning(['Warning: niftis : ' nii_in_paths{1} ' and ' ...
                     nii_in_paths{i} ' were found to be "incompatible". ' ...
                     'Please check to make sure sform/qform are very ' ...
                     'similar. Output nifti will have header ' ...
                     'information matching first input nifti: ' ...
                     nii_in_paths{1}]);
        end
    end

    % Load first nifti
    nii = load_untouch_nii(nii_in_paths{1});
    nii.img = nifti_utils.load_untouch_nii4D_vol_scaled(nii_in_paths{1},'double'); % Must be scaled with scl_slope and scl_inter
    for i = 2:length(nii_in_paths)
        % Load nifti
        nii_tmp = load_untouch_nii(nii_in_paths{i});         
        nii_tmp.img = nifti_utils.load_untouch_nii4D_vol_scaled(nii_in_paths{i},'double'); % Must be scaled with scl_slope and scl_inter

        % Concatenate
        nii.img = cat(4,nii.img,nii_tmp.img);
    end   
    nii.hdr.dime.datatype = 64;            % Double precision
    nii.hdr.dime.bitpix = 64;              % Double precision
    nii.hdr.dime.scl_slope = 1;
    nii.hdr.dime.scl_inter = 0;         
    if size(nii.img,4) == 1
        nii.hdr.dime.dim(1) = 3;
    else
        nii.hdr.dime.dim(1) = 4;           % fsl convention
    end
    nii.hdr.dime.dim(5) = size(nii.img,4); % fsl convention
    nii.hdr.dime.dim(6) = 1;               % fsl convention
    nii.hdr.dime.glmax = max(nii.img(:));
    nii.hdr.dime.glmin = min(nii.img(:));
    save_untouch_nii(nii,nii_out_path);
end