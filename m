Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF48F1DDC3F
	for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779584141; cv=pass; b=ZYMAHHEZ+6B2+Nva2M/Mt5ESm4Ia8i6f1wICNfAzKoGjiHOLqFZBLBWhfSQV7VL6B0wJSHJm+un25acI5p+UK3Bfo1qywvrfChVEu2NsPgSkZF/TK03drLwuH5ebdy3N/HuWvMa/YZwmNwf16m4PqepqgoYIciskMKnGYGmxunA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779584141; c=relaxed/simple;
	bh=p+AG/29QV/Gbca8cjEqgBqRmo3LE8JW0kDEKqQ6ndZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGBz2aokO9Q0AGiC1rFnHW8YCIxHWkwMMkVYNoxYbmJj2eE2X55ZAJ5tZRcDA0fP/HtvFS8RpPHlP/8HntJ3/s/dERlQNrZlhsVe0Fh8BgwLqL8LIPLnInS8W594ZGZFdr0dVzLeZVbnybuJr7wkR209psmNiOceIGI6xrb3MhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LPtbUXZW; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LPtbUXZW"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-366be8040a9so3644961a91.3
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 17:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779584139; cv=none;
        d=google.com; s=arc-20240605;
        b=f0setoPuxx2paL/kTJUgwjFrSM4tVvTA19R05hBdlf6Vg5ke/GYrcBa7f+5do0Vc23
         PoxtpVy9c/Z0ruWB6lW6NboAZpvZcboMPlYbEePyAs9tyx0tMKsY+LVamftPFL61begM
         ynNeBc0zjjEa/7JQ2EHelwHOD0frnKBsDRTnmMuyLOzcKGA+ETV79ZtlBitLJQ92CytG
         5JNGdzdyQDiJvQ/FLbNYcB7AmFn6okwrH3RaacA6IahvWriwSlHlqDEJMZ40KY42+yYV
         1eSXBRFjqXbNDxp3OXP8ZCx/QLnO4qs1P9SVptoLrX92rWJeUgi9iktO2+GfUSeUmGBg
         iQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V3/jkhW5dThfKx+ujob/mso+Xhv3Sib/nvQhI/3XA4Q=;
        fh=IgE3YnRBbak2+BG2eKFtNgFs+SY9Twkr2CCwpftW6ag=;
        b=GqC783o2F9L7ZY7LZQwj4sxhp9CnRfJm+fQKhZIK1xMPFEjJK51cFWYhbScpCjWvtg
         KCTl+bKJvOoTG81ZonVh6bTgCTzri0rOGRYYEOd1lZ+q9M8BFMl2dmG/wM4e2G5Szpf/
         5eDR4XWg7NHfGSxWyTeGJJofDuaoOvAK92Fv9G9+3pP7Qk6DY0fnws0Ht+bhnyELKhhc
         zFqsqwrLaNJ8fxVA/tXq7SqzdeHS/8u2tladtg41IVSwoCPKUiaFrAsq3eAei8SpLnYa
         0Uf7iBFiVPO7C9zfmFAT0GfAm/ZEZ0OcFT3d6p0EsnHHv6WbU0G7z6LCDkO+QJsvyZn9
         ABOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779584139; x=1780188939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3/jkhW5dThfKx+ujob/mso+Xhv3Sib/nvQhI/3XA4Q=;
        b=LPtbUXZWS4BJOdc25C09sjZm/+ww2gOhIOX9qf1Yi4Ec3nkTctGWtJhO+bprA0ixvY
         ps6dbEjJL2DZ3IFFRHWU2P+oUTCiBmdhbWYnXzJ2tMYCtnpAnBFcbDVLhvKpKiCwtJP8
         0gdJKfj4oBVbOox2+ueEJy1JfYNtovGPe5YtqaPz9Q35wv4i6HJsvwvbIaGR12OCZHaC
         zt47T6g6RePGHqPJgdIT1Nh6qHYqX2WNNesSwwJjbKTRIbZxDh080Pd45Paw5+kfN/8Y
         FxJYJHL2DKbnz3naaVTp2HrN3FqHEU4hi5R/7/j9bWTajSJjcfkJkpRqDhSAMlqT8gei
         6MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779584139; x=1780188939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V3/jkhW5dThfKx+ujob/mso+Xhv3Sib/nvQhI/3XA4Q=;
        b=IXbitO5iXnpkRgSE62pan+ktXQB4PMcL3mnz2iliBIMezZvhTXESt7YNOkB1Hb1YjG
         4Ilm5VilxqSx7vf9Or0S+UhGBtVPYPU3J6IPZtFMCKXxwgIJA/tsy9OLhleERj+DD3t4
         W16laTmBwx6JeB+XSPoR8qhKGdU+84jIa4oOK+xw0232ZJqUSaACBbVb0MjeNJf5dFi5
         lCjVOeXWDIorE0aj92djgA2dmRSNvNaQ+14O5nRIuMbIVyvalNodMkvMRCkfc9gtjFOA
         turthbepeMbdKuwJWAQ9h9YrOobGnS6gKFm8oKxky2LZPD1+CdD0aQrtisM6MBxTILUK
         RWqA==
X-Gm-Message-State: AOJu0YzZXZFDae82o4pw4X0TdQTr6Ffma5uPWsQv+J0nEk6exHqerCGB
	BVX8W2ArpZyfytm5SCaano5TDxpdeapHdLRKYfRtfCRVLatzyOvU/0lGpOCNFrL3D01IVXqI1FH
	klYuFaesnI8xaJrN4xtIJ4hhHCAoANcHOineosk2/
X-Gm-Gg: Acq92OGxXfIaO5Pl1G5Z5sqTF+eNTzBGwszUH8hkQbKoubjcPhnGOP02m4nyxfffSUn
	yLRuo0Pxf7dioKYlnKpsJN6Ys2zQwCCjL95et9pyFGArr3Zh63d6VkRHVOAWq3iKb0rREszoL5j
	2le2sVumeyS13L4lGt7hth7XrLcF7STa8+qONpUnzqDeLXkkfjXRZYXYMYWOb4+H+39Cqhl+553
	Ftj0hfRuNysxWHAIUe9cNhxFnvU2zYuSSQwDBo/3qkK60HRUQpR2+eiGsULJcTXII4V56IPbmdr
	4FD5UeDY86Ri5LM6Fw==
X-Received: by 2002:a17:90b:2f88:b0:368:ac5f:d313 with SMTP id
 98e67ed59e1d1-36a6787677cmr9184632a91.20.1779584139064; Sat, 23 May 2026
 17:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <20260522023234.3778588-10-kpsingh@kernel.org>
In-Reply-To: <20260522023234.3778588-10-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 23 May 2026 20:55:26 -0400
X-Gm-Features: AVHnY4KsVTOCEpGxW1kxnwclUZDtnApGycQwDbSYR2fjGdWcQiPp454xoqaYUNA
Message-ID: <CAHC9VhQ-cq-nD7uq3kv=SFSJyzO_CEgwzFeMcdbznTmPWJoy6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/13] lsm: add bpf_prog_load_post_integrity hook
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, Fan Wu <wufan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:32=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> Add a companion to security_bpf_prog_load. The existing hook fires
> at PROG_LOAD entry where the verdict is at most BPF_SIG_OK; the new
> hook fires from bpf_loader_verify_metadata after the in-kernel
> metadata check, just before sig.verdict is promoted to
> BPF_SIG_METADATA_VERIFIED. Policy LSMs that want to gate on
> metadata verification (not just signature presence) register here.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 17 +++++++++++++++++
>  3 files changed, 24 insertions(+)

...

> +/**
> + * security_bpf_prog_load_post_integrity() - Notify LSMs that a signed l=
oader
> + * has just verified its metadata map.
> + * @prog: the loader BPF program whose metadata check passed.
> + *
> + * Invoked by bpf_loader_verify_metadata() after the kernel-side hash ch=
eck
> + * succeeds, before prog->aux->sig_verdict is promoted to
> + * BPF_SIG_METADATA_VERIFIED. A non-zero return aborts the kfunc and lea=
ves
> + * the verdict at BPF_SIG_OK.
> + *
> + * Return: 0 on success, negative errno to deny.
> + */
> +int security_bpf_prog_load_post_integrity(struct bpf_prog *prog)
> +{
> +       return call_int_hook(bpf_prog_load_post_integrity, prog);
> +}

Since you're using essentially the same LSM infrastructure and IPE
work that Blaise, Fan, and I developed for policy-based enforcement of
BPF signature verification, perhaps this is where we can find some
common ground to start working together once again.

I would be happy to support and maintain a
security_bpf_prog_load_post_integrity() kfunc wrapper as part of the
LSM framework, similar to what the VFS folks do with
fs/bpf_fs_kfuncs.c, so that either a lskel loader, or a BPF LSM
program if you like, could register a BPF integrity verification
verdict with the LSM.  This would provide a single unified approach
for LSMs, including BPF LSMs, to build their BPF program integrity
controls regardless of what the system builder, or admin, chooses for
a BPF signature verification scheme: the loader based scheme you
developed, or Hornet.

There is no technical reason we can't support these things, e.g.
multiple coexisting verification schemes supported by a single LSM
enforcement interface, we just need to be willing to accept that we
have different needs and show a willingness to accept different
solutions as a result.

--=20
paul-moore.com
