Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8250D485946
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989707; cv=pass; b=jcDZVaOTFyRbnPPd/5WgLZcJE0VsJDxCWFr871Gsg55iPCbCAFrz8GiEVpnqmVafAapskGEI1YkS3TeCtbYMvkHCUftdPI+1VM+T7wecoDNUhngFtursDBrtQ+cHdcVoyE85tAoR8SLrLvGtsZkygXURYCnLSH3FXo7qVUkH1E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989707; c=relaxed/simple;
	bh=3oNUmTrYWtNLjHBd0tZgzihnKQzz3N1wdYYyGkA2BrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRNwn+FMmWno5ZRVrhWsw1SMzAMvO9IDmBA32r42l99sHL0sSBhnVNMgPcI4v1lwpKlfLtsroY5hCyiiGSiDFqMDBrYl//Ctex3zt/p5HXkgU2qu7tSvfmW1OgRpiHzrMuiBhKSDzLJUqKW/HRtiFhteso2E8IZqvFHj/9ptZJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Mc+gUO7z; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mc+gUO7z"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2938116fefso194307566b.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 14:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788989694; cv=none;
        d=google.com; s=arc-20260327;
        b=Pby7esdGj49rsuzas5E61L7QVr0bQJF7XWyy2gP+/2xFfs9dYi0Svm0hSsW3cvLsxE
         MPbOu0BC5MA4yWyl5ambBupfI10A9Vm7CxKc8rdXNAx9kb2xoQHrnrEVwfwkcT9oBc+g
         wdABcx5iskm05IyyauokdMLXz+N/UwTknb7VmWLIwhPyq/o3AsV0eEyRd2XBSsY9ntCS
         5GvCqGUMHz8esCrjAfWpCCa5+hMX+959OXs3Cvl4EAZapW0VFy4i3eLL1JU5FIKosIMO
         8VCyiY5k3uoLyxFfoevevD27zmdq7YJyTXHr5Yp7+4kqKBRp3dySC2zJf7qbK9RsnBdQ
         YVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v/5kGipgpDimrS6n35sjSMetEnTNyDyUhJUmOMfkSZ0=;
        fh=h+kzEsXjOvFPW9nFO4i6s+n9TawM1ZPkf6jtBFV0EMM=;
        b=D0CWCVT1W9uaHOyKUd1oQfa+26a/WDlmi5SJAw4bPltNVbSFFcLvVc/run2DbT901g
         j1t72+9mM+ofv4tZfqhBASHpCJirlZVDi6la6lQk85INbR6/nYXluwhbQze0ZDE3CipD
         md7ipI3tiXlMsK/JF6Al2i2yLu7OdQ0yNa7wOhMG8uy/K3410me0r6Xr9ApTRZ9a27+o
         EKkDNtUYCjwN8Kw4FJF2xvEWT3/CGJtsucBRu0JZaR46+XeXiTpkw+IGk+NtPlui98me
         jUmDBKRamZ7rfxsGmr2GKp4SGCVQ6EzaDdzPEYdMjd5x1BE7355TPMzYpmZFKSliMeY0
         SlDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788989693; x=1789594493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v/5kGipgpDimrS6n35sjSMetEnTNyDyUhJUmOMfkSZ0=;
        b=Mc+gUO7zP+pXp3uky25sn5Om5bhl8wTMVZ1/4cUssJCpSA3Dq5jS+VDyAaF3qW8SUJ
         Tcjf9J+AvvvdIWkOwoQ+8ouKh/Z5/1pQRCOhwnHIf8SMDXpIkyon2HMYPOijZDd3rcEK
         b+fo1WdFLSPIwFdeKbpt20URkGrlgSSvdvG9TnAcNE3EZAzBBOLl7HOvYZmDZTwkZd/W
         x2iftQmf2zhQsfPxxj29X3iysFuiVQcJ/7djFJ3Is6iYLD8O5dFp8bsL6lxaTQBr6L7L
         1WTl7jHWXDmoy38ti28/UR1mD/xZXi4xTcccVHW2DWWutNMRQPz5flILSqGk7SMhM2wc
         /PcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788989694; x=1789594494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v/5kGipgpDimrS6n35sjSMetEnTNyDyUhJUmOMfkSZ0=;
        b=erWAH0SUc9/SJenqvj9AqiCNcBG17KOLNZ/jyMJ5iV4IVP66zfqZ4Mv7LEqUDQhmHU
         QSrxb1PonXImVy2Dp9KrpMj7GtbtwI4Sn4ctlPAbCOdlE/PzzTFhJD8tqTBghjCxi3c5
         Gb+YK0q75ojVtQrL/6sceZr9Ye+IbV84Kkh9ibXwCiem/kFFe/2YQ3VHAUb+8PkI5UZ7
         exMsDhqtHbqYiTmzkY4BRT77Zl1YZrfCaLz+XEX70dWu1v8BwV5qlVGMiAAgNe77Je+t
         yymNsuz92hQRjXkp0fufWCc9F298rDgHhzvc6wxsxZc/XrIHx9EycbDg2+6Cpi7Kx0Bm
         xfAg==
X-Forwarded-Encrypted: i=1; AKwUvBzvCnli13SeOO/cH9skDBrck4gVSzHzsJPXMMIwim10+GioRe975vnJHjINFoyGlHVDc8Iti1yrBvtFtHAgeBlVAQmAoMc=@vger.kernel.org
X-Gm-Message-State: AFuF++nZ0a5GM0yhsPetWVX3D/Y1PgOnazX7FKpSbL6J9XzSdOYtGa8x
	aSSMNQ4hO4qHzuV69yMhikxQfnu2eO1AAtxdsFxSUaWcg0zjwcjmcx0YP1X+sznkh1feedKEHTf
	pOtoUqaIbxQDOzX6N9stYe04PDmWE6gXKcH8V1ajW
X-Gm-Gg: AYBFou2xlLxpUQ3S2z/FBACxvylYy0PqTELR7cH+V4S8/FGwlD2q6D6RAUU+sZK31Wz
	1ylgvE1eByqzRwxyDKwZDAVZl7jgCTJx1Rs7P9nFn1cHA7+C+7zpbGUxlZeqSr2pTZPPi9UDsdO
	FKCFvPoZvRSbRhiOshYBGtSiNd8bCSEZ/jyh+gVOYEyjzcGXSZZrI2MzouzCDirlzA0NyS61maO
	rn80NF9nfzO3HLY0VQztDxewen51yjVOoS5rH95NL7lb5rB6ijS+WiSvaJZq/jtGOJsvUTFHJAt
	epHkktMagCLmrr/tmMfPnOifYWgjAV9ZQw6EPlzQiCw2KenK0Gj1+jxpqAEN7dAPCc2Blx6O4wb
	9zIZ4HWYJM3A=
X-Received: by 2002:a05:6402:42c6:b0:6a7:fb24:264e with SMTP id
 4fb4d7f45d1cf-6a7fb2427d6mr11476660a12.34.1788989693583; Wed, 09 Sep 2026
 14:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909193719.518517-1-utilityemal77@gmail.com> <20260909193719.518517-5-utilityemal77@gmail.com>
In-Reply-To: <20260909193719.518517-5-utilityemal77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Sep 2026 17:34:31 -0400
X-Gm-Features: AcwNN1VsK6p9PaFEMp2PujAdfTIJTXAYr2yXrUJqn7w6sJuHfrRDFgEKLUlYFeg
Message-ID: <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, matt@bobrowski.net, mic@digikod.net, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	casey@schaufler-ca.com, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, eddyz87@gmail.com, 
	memxor@gmail.com, jolsa@kernel.org, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:37=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
>
> Add security/bpf_lsm_kfuncs.c, the home of the kfuncs exposing LSM
> policy objects to BPF programs, with the first of them:
>
>   bpf_lsm_policy_release(object)                KF_RELEASE
>
> The kfuncs are the LSM framework's own BPF interface: there is no
> per-LSM kfunc and no intermediate security_*() layer.  Each kfunc
> walks the matching hook's implementation list and calls the one
> registered by the LSM whose lsmid the policy object carries.  Calling
> a kfunc for an LSM that is not active or has no policy object support
> fails at runtime rather than hiding the kfunc at verification time,
> so BPF program loading is independent of the boot-time LSM
> configuration.
>
> A policy object reference is meant to be handed over through a map
> kptr field, so also register a destructor for struct
> lsm_policy_object: map-held references are dropped on map teardown,
> possibly from a context that cannot sleep, which the
> policy_object_put() hook contract accounts for.  For the same reason
> the kfunc is not KF_SLEEPABLE, and the filter adds no per-kfunc rule:
> releasing a reference must be allowed wherever one can be held.  The
> filter itself is needed because BPF_PROG_TYPE_LSM and
> BPF_PROG_TYPE_SYSCALL, the two registered program types, share their
> kfunc lookup buckets with other program types.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>
> Notes:
>     v2->v3:
>         - No change.
>
>  MAINTAINERS               |  1 +
>  security/Makefile         |  2 +-
>  security/bpf_lsm_kfuncs.c | 98 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 security/bpf_lsm_kfuncs.c

While not a new concern, it has been a few months so I want to mention
it again to see where things stand with the BPF crowd: are the BPF
folks still opposed to BPF kfuncs in security/bpf_lsm_kfuncs.c,
similar to fs/bpf_fs_kfuncs.c?

If the answer remains yes, the BPF devs are not able to tolerate
kfuncs under security/, then I'm afraid this patchset is stuck.
However, if the BPF devs are willing to ACK kfuncs in
security/bpf_lsm_kfuncs.c, I'll add this patchset to the review queue
for the LSM tree.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6215fcb07770..ba816d7ee127 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5081,6 +5081,7 @@ F:        kernel/bpf/bpf_lsm.c
>  F:     kernel/bpf/bpf_lsm_proto.c
>  F:     kernel/trace/bpf_trace.c
>  F:     security/bpf/
> +F:     security/bpf_lsm_kfuncs.c

We would need the maintenence of security/bpf_lsm_kfuncs.c to fall to
the LSM framework, just as the maintenence of bpf_fs_funcs.c falls to
the VFS.

  % ./scripts/get_maintainer.pl -f fs/bpf_fs_kfuncs.c
  Alexander Viro
  Christian Brauner
  Jan Kara
  linux-fsdevel@vger
  linux-kernel@vger

--=20
paul-moore.com
