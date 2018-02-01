function xform_RAS = get_RAS_xform(nii_path)
    % Returns 3x4 transformation from pixels to continuous RAS coordinates.
    % Attempts to use qform; if that is not available, it will use the 
    % sform. If neither are available an error is raised. Units are in mm.           
    nii_hdr = load_untouch_header_only(nii_path);       

    if nii_hdr.hist.qform_code > 0
        % https://brainder.org/2012/09/23/the-nifti-file-format/
        b = nii_hdr.hist.quatern_b;
        c = nii_hdr.hist.quatern_c;
        d = nii_hdr.hist.quatern_d;
        a = sqrt(1-b^2-c^2-d^2);

        % Initialize
        xform_RAS = [a^2+b^2-c^2-d^2    2*(b*c-a*d)         2*(b*d+a*c)
                     2*(b*c+a*d)        a^2+c^2-b^2-d^2     2*(c*d-a*b)
                     2*(b*d-a*c)        2*(c*d+a*b)         a^2+d^2-b^2-c^2];

        % Scale by pixdim and q paramter
        q = nii_hdr.dime.pixdim(1); 
        xform_RAS = xform_RAS * diag([nii_hdr.dime.pixdim(2) nii_hdr.dime.pixdim(3) q * nii_hdr.dime.pixdim(4)]);            

        % Append translation to finish
        xform_RAS = [xform_RAS [nii_hdr.hist.qoffset_x; nii_hdr.hist.qoffset_y; nii_hdr.hist.qoffset_z]];
    elseif nii_hdr.hist.sform_code > 0
        % https://brainder.org/2012/09/23/the-nifti-file-format/
        xform_RAS = [nii_hdr.hist.srow_x;
                     nii_hdr.hist.srow_y;
                     nii_hdr.hist.srow_z];
    else
        % TODO: maybe support Analyze format?
        error('Analyze format not supported');
    end
end