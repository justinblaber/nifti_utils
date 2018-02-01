function copyexceptimginfo_untouch_header_only(nii1_path,nii2_path)
    % Copies nii1's header to nii2's header and saves the file, except for
    % the img related info (dim, datatype, bitpix, glmax, glmin, scl_slope,
    % and scl_inter). This is used when an image is altered in FSL 
    % (bet, fslroi, etc...), but everything else (qform, sform, etc) should
    % be the same.
    nii1 = load_untouch_nii(nii1_path);
    nii2 = load_untouch_nii(nii2_path);
    nii2_hdr_buf = nii2.hdr;

    % Copy header
    nii2.hdr = nii1.hdr;

    % Restore img info to header
    nii2.hdr.dime.dim = nii2_hdr_buf.dime.dim;
    nii2.hdr.dime.datatype = nii2_hdr_buf.dime.datatype;
    nii2.hdr.dime.bitpix = nii2_hdr_buf.dime.bitpix;
    nii2.hdr.dime.glmax = nii2_hdr_buf.dime.glmax;
    nii2.hdr.dime.glmin = nii2_hdr_buf.dime.glmin;
    nii2.hdr.dime.scl_slope = nii2_hdr_buf.dime.scl_slope;
    nii2.hdr.dime.scl_inter = nii2_hdr_buf.dime.scl_inter;

    % Save
    save_untouch_nii(nii2,nii2_path);            
end