Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A73BE642
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223033; cv=pass; b=ZSXO7cn5vpVK+glE77yL0KpJSMNr+sWa47siV9Q23+7xlWdhuWITNjCo6yjByaYHapzIb2JXqQP0X/teqwU3E9FPHShk/zb0ueKNXyOLq1RDjM5CE8YbSTIJUkZAHVNwmcYSFLCGetZgMFCO7wBWsxSuMf3eN5NucOPAxncTlr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223033; c=relaxed/simple;
	bh=htugnVr6bWMsd4UVaZ444F0i7bjcPWVsMZk2kiyMsEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGzfN5B3L96L2HMTGZ5ktHBD6EXX6O3PjGxkP5eVw1vr5e1Sgy7W1jp0k2ueZjvlZUGNgwpg0/esVZMpKcTjSiqgj0zF1z1fCvBSAUNEFnBcsLZ9fH3Qusi4ndOdqej3yV0VJPup71z5hgr3crIIkdXlahv+BkSC7cOuqV2kRng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCEqmXbx; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCEqmXbx"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dcd17e19b6so2254198a34.1
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 13:37:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779223030; cv=none;
        d=google.com; s=arc-20240605;
        b=NL2fRoVMPKP0jmCvuP4Gdn62LWzj1mgFGRq11LlWliRr0z86DOqHu4ipSos/MAaA4C
         7h6YQvqc65R/VXmE643t6T/KF7Lvm3m6+B/ueHOATZqbVE9aRCj3lN6jw5lwzVmOKVAT
         DBY7xoyW/+A9go1sF53xQdF4zt/j+A8Mz2AtKzJURDRKy8w9nJW37Ro0pAUoP46f4LvK
         7DOZpzPudA97hl2RrvPJzgcAH6m9jVrSD1DBS61tBOVPmP+uZXKsqCBKXBRg2OzI0GdZ
         HDXfSt3UrxFP5IdRJ6CWpc8zJ09DzIK6mN1v1+NQ5NLyyvh8li1EpuGPdnggn1uytNOC
         2S+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eXfLHzJ3Nl1qL/yosx+NOUbJbIUhHr1gcXJ5Ci4SfGU=;
        fh=91wnEoLpgxsA6tr5Ofm1PY+vOHWrSrQhafQvEt2d3Zs=;
        b=e67SzGwPfck1K06xDnYxvBpVJYEMQkdQ1KzA+ZGPVE9NwsClyrgN2cC1NFnctNBTh6
         ALA8XHpdoo0CNFsv1331AqnpTmxWlVsI1f2OGLo5LuUP/1msT7SrABj/C3AxFZWVOq9Q
         e5YcsZqpVHlfN8YFEHMvqolH9eJjoSoWuV6f/TR4LlEM2ATJ0YSA5QitszxoWdJ3QmWn
         9AWRN6v/nTPCC8VUJ3LxSCkEVxIkPnHld6nY1Bt2xnFViLniBpI98liH2FILvOeG13nv
         4M6xFQOeUMghcEArdGlbz7sVmAdmhNEesKC1NHizFlP8/ZFb6AklJezz42G4QEERFOiX
         1O7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779223030; x=1779827830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXfLHzJ3Nl1qL/yosx+NOUbJbIUhHr1gcXJ5Ci4SfGU=;
        b=GCEqmXbx+aCn8GRMU+SxvcBkApZ29Pb0B60U5okOrVXIQW7B87/sonm/QTXrypt9OI
         caJTLB2/eZWZCoGggRYQDloLPTwmkzRe55l1Uj18PWIOzOoRtudiA3av8z38I4hn8pCZ
         s8tYMTZX2f8K55614WwK86d46xAyw3vl1BNnx+JX1Mpf1c4ZNsO6kNQFzjaArQKi0A1E
         r7uT43wcUisc/PWA4/4CTeFrF4hu4AHCsNYD02KP5eIq1tzBFEZ4Lc573915rKM5us86
         yTLbvhsFK5qECID0jhbKH2EZxRMT5r88QgzY9psnuiZhdSeD1n2KG75O2NyWXOnE+2YI
         wBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223030; x=1779827830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eXfLHzJ3Nl1qL/yosx+NOUbJbIUhHr1gcXJ5Ci4SfGU=;
        b=SLk2WdxEqWyjFK0j/Oa2fots/+n3e9R9+lKvlUNlpuxxJjS73hrSbmboEdC9fzui/b
         KWRaZdM8SrJntqSufLVCGBuhVnZ5o3AcwNowZ2NNSc5qwdxhQOHQ7ac662TdaJUxxTUA
         QSvV3FoOniantxHaCMc/j5TvRlu0BcUSXN2s52Nh+vmxRDndKBolhWKm+pznSHTKdK5J
         4B6dEI3u4RVBPi0q9Rv8vgNquVT666VikKJUM8XeTt3AEf1SqC/sTkPwVHbwr3mX/SxY
         KR3ptnWtkWN7jhXDyDXROZ5xShOQFNNkXCao+u+PT5A2EQ5LBtfgNYP4e31VJrQ+Ty4W
         aR3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+d6N1VfaoMmZkw23U9jxeB/IsjEDbfW6jYe0IKs42RGdhzBC+XMK6Jy4yKBPtbh+rbNVDMb07+LCYTv6K6uvFvVzKxOXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bMDD5wCt86PEs3RrKnrSNywsxEWW7GdJGArlG/ARgry4rukd
	FcMeRKVwHkklvlqOo+/tsWbC+W4eOvrvG3E7FDjbwSjqfpR8Th+TeDTKGuM/SmqXG+hlrfqeMv8
	FGNGbm7zo0VOZVz4qQBI/9pzyt22AZ8w=
X-Gm-Gg: Acq92OGNRiSSK/mHwQz/rjuTOOyVuojPea6UE85TzaE9Df4k7uq4Dy7AAgAFjDZbCCu
	lUOFYnzkV60D2L6aNGhqWDnXLXpNWTRa9MuYjp8gGp+tFS/I9yxZuJFARfmJMnp+AcTdydvU9JS
	HAEb4sUQar/FCi/Wu/2/fKbA93v3+SR/wNJiiHW+4+ZWPCPXTFWwPb7W7AApASwlgLAMi6EVH3g
	ImxE2RXb5DqxUHmvWZaCAhkjvfLT9/kWFNmzDLufEIfnnL0ESOwQBhVTzOehB1UR21OB+AJuiuq
	bHAVgBvIjtFmo+nDTe2w
X-Received: by 2002:a05:6830:6183:b0:7dc:d99c:c441 with SMTP id
 46e09a7af769-7e4f2a35e29mr14629843a34.8.1779223030488; Tue, 19 May 2026
 13:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519200933.30752-1-kpsingh@kernel.org>
In-Reply-To: <20260519200933.30752-1-kpsingh@kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 19 May 2026 13:36:57 -0700
X-Gm-Features: AVHnY4LPN8VfF45a-heGGbUIRiWnCUIj4kQ8mbzBKF0UnixzMc1_AlqaWC5qx0w
Message-ID: <CAMB2axN86YUT66kxyrdW=OeznFZ=YApKVLUBWaZ_Q0r29YsV0w@mail.gmail.com>
Subject: Re: [PATCH] bpf: reject NULL data/sig in bpf_verify_pkcs7_signature
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, Xianrui Dong <dongxianrui1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 1:09=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> __bpf_dynptr_data() can return NULL (FILE dynptrs, any non-contiguous
> backing). bpf_verify_pkcs7_signature() forwards the pointer to
> verify_pkcs7_signature() unchecked, causing a NULL deref in
> asn1_ber_decoder() reachable from a sleepable BPF LSM at lsm.s/bpf.
>
> NULL-check both pointers and reject with -EINVAL. Mirrors the guards
> already in kernel/bpf/crypto.c.
>
> Fixes: 865b0566d8f1 ("bpf: Add bpf_verify_pkcs7_signature() kfunc")
> Reported-by: Xianrui Dong <dongxianrui1@gmail.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  kernel/bpf/helpers.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2bb60200c266..b5314c9fed3c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4241,8 +4241,13 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct =
bpf_dynptr *data_p,
>
>         data_len =3D __bpf_dynptr_size(data_ptr);
>         data =3D __bpf_dynptr_data(data_ptr, data_len);
> +       if (!data)
> +               return -EINVAL;
> +
>         sig_len =3D __bpf_dynptr_size(sig_ptr);
>         sig =3D __bpf_dynptr_data(sig_ptr, sig_len);
> +       if (!sig)
> +               return -EINVAL;
>
>         return verify_pkcs7_signature(data, data_len, sig, sig_len,
>                                       trusted_keyring->key,
> --
> 2.53.0
>
>
