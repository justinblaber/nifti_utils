function vol = vol_apply_xform(vol,xform)
    % Applies xform to volume

    % Flip dims first
    for i = 1:3
        if any(xform(:,i) < 0)
            % Must flip
            vol = flip(vol,i);
        end
    end

    % Permute            
    idx_permute = 1:length(size(vol));
    for i = 1:3
        idx_permute(i) = find(xform(i,:));
    end

    vol = permute(vol,idx_permute);
end