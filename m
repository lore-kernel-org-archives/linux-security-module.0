Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A338A72F
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 03:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184281; cv=pass; b=anGNpMspLkxXV/0wykf3tjEb09j19SBn4+fOSzzgASE6noLN1avgmrWCrkX/V1H4R5gu9EvaRelJzqSUE/6aJoSEG8gV59QEfbTKc2+pIy0toUPVVoPXMJc0lBjW1qmUnFynKZTMnm4sEbWvNVBAAY/gINybYa0wHwQdD166Bco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184281; c=relaxed/simple;
	bh=5tsJG8K11FH33t75X0aMZwkwKArLiDR3LlMxbCGTaK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=af36s5iCBEweLo6J5Jb4tBAKXTI0zIIQOcJ00PmwTzE/Viainrb6ynSkfT4cYiq/VuPMuAxG6x1nbuRR5eyFshKt9A+3z+8tD+ukvnMLjRtWlg8N1HjbFB8h+kO61YmCieCsIpKIRRwZW3NDRl3RYNHcE0qZu7tHFworAVJzCIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rIvU5v10; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIvU5v10"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c86307c4e6bso1918292a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jun 2026 20:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782184277; cv=none;
        d=google.com; s=arc-20240605;
        b=CJWn9ZLzpfE6WXOCuJp2o8ApG3ls7JeWByMwPKgLUq3RtEK7uAzdLN8nXcnwj3J0Yi
         0oTbJTNkgAxBp/oa2St/QtgAY0qmgF/OkEHKnJQRlpueddUcw0FdAS53/wH1RMA9CFTy
         hFOFxW7BtljXD4tWx6zKzC+j4SpLKv1sCdneByyQEtwjZiSLNbdofOby9+1sekcMAaQm
         Q4CrfyTqQ5hGDeRqvBbNvvhq9dvNXd3MMdZrc18sEInfXV2Xd3xfIQnAplszVOgHl/rK
         Q/KMsE0nt7QxpFV/HDxFnBaHknow2S6fm+ik8SV6x5m5E6W+LLY5Ux8DWdnYa65AY5OM
         4H8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BjtwR7xlZwTKzwmfKPGdqr9b1raakaR85K+/MxsMuxQ=;
        fh=jHL/altdLNFtO2VzTakUgf6YxmLvLDKAFEi4SB5gHV4=;
        b=KwMLAPoRQkwdpWXX2oyW950G2lnHiWGbXYsXE81gWezHAfKK6azeDuMJoZLDRLTB3w
         UmIijh2VAJCgRTKlcam+DeBV0ggeILD8uOv03624yMGuRSNVAGmMVrkUZX2PKx3XL0h9
         Do/VxfrW9ANtSZsIEr7aF5j0pFBPCoWKEuHrd1L04HOmNIH2n5BQMsh/BWO2xTuGcSmj
         d/ljbVDM2n8YWg07GSYzeK/Ff2bE7YurNF9uRw/3KutXtI0inll/7R5gVQsaC/ndG7Dm
         C0VHgRGYr6xxUKITR8RIZPksNDpTywLqhinSgUyNT1xjO8Kf2j3EmQQPykM34h4Gj5Y6
         cXEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782184277; x=1782789077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjtwR7xlZwTKzwmfKPGdqr9b1raakaR85K+/MxsMuxQ=;
        b=rIvU5v10tYjFohKj2Ab21hSM3Rt0+B/gvpNfbrNGzoFmcE23woP0/R7tRHgqvq0pbu
         fWsy2FYn2yCdppbXd2PHnmvuSfNnszKQ+EY3RvnrPLWXPYNSy9HkHmeGnLYYu8+aofor
         zp8jXP2KEs7UlXnORd5Z2drcxT6t1tGkVsMyaeL50dAQav5rMZSfi+7RIqIibh4CEyek
         dlYHRm+sv86RcPbLWgkEwqcmvd/j89h+IWW7gjI9rF25y/Xsr/wyk61DRf1KtbUofBpT
         h4UcHQceGY+w2tKlRM4K8Ek/BM39XdoG3GAjDTaTZ7r36IdnjgofTTxXpFfI/rBBpxRd
         dxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782184277; x=1782789077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BjtwR7xlZwTKzwmfKPGdqr9b1raakaR85K+/MxsMuxQ=;
        b=KEpfIsQ0W4IdiJc/QjYMGb/P/5YmKlWxsrNXgSld2USx0p4pEWRgCGpBAuB58IqKSI
         aydNad/FsBsbS7s2H+F11eKD+NKTt2hpAxS4mRcPU+lRBEGjXyvSGWzyCGpeizPTkSwD
         sxgNAIwxa74+4CmDqEB3MhzFJY7ztJFCdF8LTIPUbIIef6B+fKToD8i/OJYLbeKH++Pu
         ZpdsnbObuho+SOQ4aNmkPSo9N+fqX5NOoufVrbJwwGsceHvSNlci5/8Rs6YKmIO5iIb9
         otCfQXZDoPQTDJH3U6fihp4zB91OliRrTUobSNLKBt4d1f320fq2+ss+HZpx8EGV0cdt
         Qd4Q==
X-Gm-Message-State: AOJu0YxBFmXYRqzm2TzONqSn3b3WR6pNDQ0Gc+OKudxGeegSQqXDPIaL
	8LMUJwI9pzy7rVJNmQZM2CUZZsLtY6k1uxOqvnnIKBXHMapLuEdMvMIQQz/tszgedRRFbwaIMHI
	DngjrNctfP5Jv0eYpEHWFqV+JoVgmTOw=
X-Gm-Gg: AfdE7clOeJC1noay9FkJTYO5DBZTUXkqNNMyO4LPzq5c3OQ+T9CbKSB4ga+9mG4IyUd
	634CZamiuKjalnzHMRUHzInmucYPJM1tXsM3dwjYYl/aAYS7py5bCu0i4wZPupJBU6O1az6D5mo
	ySfnMa3hrb9R+s65HE1RJYMQmfXLGeQKf3B8GSriWaKcOpkEWKP3GtXwolTDai7c/Rg8NAyKnZC
	FAAeMQcwHlHOI52Oh/GjqbdqBRxWt+SVPhuV8h2Js2SqkzQCAynZkmUQyi4ZbRHrndgerEhk9kS
	yaN27iinEnHs6bLepSbGjPTtWPWQ2jVd9/wTiQp3cW7i4o2YaAbrxLJbVPq0289+dLApqCpPz55
	Su3vi2xHIisreKw==
X-Received: by 2002:a05:6a21:6915:b0:3b4:5c70:ca3e with SMTP id
 adf61e73a8af0-3bc531af581mr15488925637.25.1782184276701; Mon, 22 Jun 2026
 20:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619130305.27779-1-include@grrlz.net>
In-Reply-To: <20260619130305.27779-1-include@grrlz.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jun 2026 20:11:04 -0700
X-Gm-Features: AVVi8Cf1oIzvdtEGICckV061Q81IswIClpWIZQWhYHurLRYhBKU5VvvDzlC6Veg
Message-ID: <CAADnVQJ4rpEMdj3jq9d0AFNcZterObQpJQiQ8VLwcYUph_M+sg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: lsm: disable xfrm_decode_session hook attachment
To: include@grrlz.net
Cc: LSM List <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Florent Revest <revest@google.com>, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 6:03=E2=80=AFAM Bradley Morgan <include@grrlz.net> =
wrote:
>
> BPF LSM programs can currently attach to xfrm_decode_session(). That
> hook may return an error, but security_skb_classify_flow() calls it
> from a void path and triggers BUG_ON() if an error is returned.
>
> Disable BPF attachment to the hook to prevent a BPF LSM program from
> turning packet classification into a full panic.
>
> Fixes: 9e4e01dfd325 ("bpf: lsm: Implement attach, detach and execution")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  kernel/bpf/bpf_lsm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 564071a92d7d..1433809bb166 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -51,6 +51,9 @@ BTF_ID(func, bpf_lsm_key_getsecurity)
>  #ifdef CONFIG_AUDIT
>  BTF_ID(func, bpf_lsm_audit_rule_match)
>  #endif
> +#ifdef CONFIG_SECURITY_NETWORK_XFRM
> +BTF_ID(func, bpf_lsm_xfrm_decode_session)
> +#endif

Applied this fix to bpf tree.
