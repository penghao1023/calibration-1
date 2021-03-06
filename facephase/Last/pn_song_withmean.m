function image = pn_song_withmean(row, col, mean_lum)
    pn.a = row;
    pn.b = col;
    pn.beta = 1;
    pn.fha = pn.a/2+1;
    pn.fhb = pn.b/2+1;
    pn.fhimagea = (0:pn.a/2)'*ones(1, pn.fhb);
    pn.fhimageb = ones(pn.fha,1)*(0:pn.b/2);
    pn.fhimagef = ((pn.fhimagea.^2 + pn.fhimageb.^2).^(1/2));
    pn.fhimagefbeta = pn.fhimagef.^(-pn.beta);
    pn.fhimagefbeta(1,1) = 0;
    pn.fhimageagl1 = rand(pn.fha, pn.fhb)*2*pi;
    pn.fhimageagl2 = rand(pn.fha, pn.fhb)*2*pi;
    pn.fhimageagl1(end,1) = 0;
    pn.fhimageagl1(1, end) = 0;
    pn.fhimageagl1(end, end) = 0;
    pn.fhimagecomp1 = complex(pn.fhimagefbeta.*cos(pn.fhimageagl1), pn.fhimagefbeta.*sin(pn.fhimageagl1));
    pn.fhimagecomp2 = complex(pn.fhimagefbeta.*cos(pn.fhimageagl2), pn.fhimagefbeta.*sin(pn.fhimageagl2));
    pn.fimagecomp = [...
    pn.fhimagecomp1 fliplr([conj(pn.fhimagecomp1(1,2:end-1)); pn.fhimagecomp2(2:end-1,2:end-1); conj(pn.fhimagecomp1(end,2:end-1))])];
    pn.fimagecomp = [pn.fimagecomp;...
    conj(flipud([pn.fhimagecomp1(2:end-1,1), fliplr(pn.fimagecomp(2:end-1,2:end))]))];
    pn.image = ifft2(pn.fimagecomp);
    pn.imagemax = max(max(pn.image));
    pn.imagemin = min(min(pn.image));
    % image = uint8((pn.image-pn.imagemin)/(pn.imagemax-pn.imagemin)*255);
    pn.imagemaxn = abs(pn.imagemax/(255 - mean_lum));
    pn.imageminn = abs(pn.imagemin/(mean_lum - 0));
    pn.imageampn = max(pn.imagemaxn, pn.imageminn);
    image = uint8(pn.image / pn.imageampn + mean_lum);
end