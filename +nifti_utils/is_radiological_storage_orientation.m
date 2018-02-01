function success = is_radiological_storage_orientation(nii_path, fslorient_path)
    % Tests if nifti has FSL's definition of radiological storage 
    % orientation.         

    if exist('fslorient_path','var')
        fslorient = system_with_errorcheck([fslorient_path ' -getorient ' nii_path],'Failed to get FSL orientation');
    else
        fslorient = system_with_errorcheck(['fslorient -getorient ' nii_path],'Failed to get FSL orientation');
    end

    if strcmp(fslorient(1:end-1),'RADIOLOGICAL')
        success = true;                
    else
        success = false;
    end
end   

function cmdout = system_with_errorcheck(cmd, err_msg)
    disp(['[' char(datetime) '] ' cmd]);

    [status,cmdout] = system(cmd,'-echo');
    if status
        error(err_msg);
    end
end