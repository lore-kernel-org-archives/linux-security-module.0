Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91234A794
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 02:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777258658; cv=pass; b=AGZac6oLYfWcWX8KxcMPO6vs1G94FLzbsn3urLGq8FNo+92wyURbOQ09A+YxGy2YRdiC2qqaDmpuU7c6QC1H7mcUHz4p18GNuqh9Fz3plcXAGIUClkkz08q/aR8os5WbqUgnQv1ioCUS9jc0ccFXpktSRpEoWNGGLkNzNavA6eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777258658; c=relaxed/simple;
	bh=8dMygFUytJEMs1YRWIK3+Tn4nrEm8XrSROj0X+itmw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE56I6NmNaiwtq7agIwO0ORfip3/I57HS5Q/B0hhSuRuSSr/lYmuyLopIeOjwjcPxjx/q/ocfiTAhgbtuDQRKYPwhGJEKKZueC99EyNVNZL0tVYs6xgpp0TihxqB5Idz77WMhIM023U4ui6xFKS0qBXzc8Icu+8b9vuR9moY9pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL4uGMKP; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL4uGMKP"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4891b0786beso68508755e9.1
        for <linux-security-module@vger.kernel.org>; Sun, 26 Apr 2026 19:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777258655; cv=none;
        d=google.com; s=arc-20240605;
        b=XwFCHtFp74ejdUQJQsjuY/WgEqd1Y+Uq6vjEMYIyacFbXeUP5tXL6jymW/c9ydMnXF
         HBieWfWxrlGUmDNuIzzR1XG22Yjcl/DQ+un4tpQy+WMlXqlJeSwJYl+zM7oOtw1jYU6m
         KFtrmjIyBrtooPhn8PvzmIuSKJt7uvOBB4/WdK4+wA7Due0E2dipCPhPHK5Ac/992rwd
         v5udzWNugV6ggqIIYG23raaJeeuvh2XjJ/yHp8QvzXCXYHDqZM6Dm5DrUH1bFayDg7vw
         P0HG9I4vpblz897DuojheQQxD7VcxkBAexMCvaoGfBsVizTvECL+o6+GLU7fssaz8a/I
         rg+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZmRJmusgqsQpznZKGOW2aBXk2DJZZmsblMgmOD3i09c=;
        fh=fHoUzQ1cThHZCMyyF+mp85HHyhCvkEuIl+WedEvGnV0=;
        b=LhMxpChhdxAim6Djot0KYtEbbMhFm1p18ESi/FdZLbvng6yJFP6H82TaYeye6P4LZG
         rccPG+QGNe5AIyV8y8heK8NeokNI9cb0K00ngrQ72v5WjC6xi5VK1lAgjZmRN9mURNj0
         L+DVsiOOP+grui72UvSoCDguFkfVO+jA0NpTq/SJJWn81CVthC62D3fG6821j8TFRGnq
         4lPSGGag7v1bMsXZbeghSyX3tS143cXCNO0cMWfLQFj3yrdcVyTsyNrX6ckdH4hPmvw0
         vC+F16y0RIVWgulEMU7P/gm13QPz8VUOdAf3sctwq52uo70s4wa6Ls9R+dD+xcf34K+U
         R5qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777258655; x=1777863455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmRJmusgqsQpznZKGOW2aBXk2DJZZmsblMgmOD3i09c=;
        b=RL4uGMKPedmGYKsYoiSlXHqEWi6hPR3deTBR+SosuKfBtDMTJ/IYnchiCj4u/8BEgJ
         Zct5GCQ8qup3tnlrekMr60VHRYULH8XE2rU0ctIVw+zBKyCpmP5s5ztlvAOPKYUVzGgn
         qY22EsTPtzOs2ggoQ/130ggmmgFDeAjxy21TNrX+GZrLsUw61sPohNeEeRyv2Pz3UUQa
         ysbyCw+Adi53AhSgyO33KOS3D13XQYfzJjoH79vBLOLYVpKuAv+s/NtsQ1XhOcGGyCLd
         MeBVKmqUX2agfAvkF9D6tAZFNsOcFaCWF24nIBSaCs6y8iw6WIRt+ZioMHVcbRA+XqA7
         69HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777258655; x=1777863455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmRJmusgqsQpznZKGOW2aBXk2DJZZmsblMgmOD3i09c=;
        b=QMmc1xqa42q3nMTap4UDixKMaKTDhiMqKtaAvcp237c7yFUxfq0ig70J7KMn42cwC+
         QRbVVBncya68g8Tq3YvN057Qm8FyOhoqygtaVm5vD54qns+mEL4pywDcpizdTfAc6rEx
         DZNsLA4T/27Mnmur6ff6W7OX/fhWMsG8F5RjU0zKRfUzKKlSk9S8FOT8h+WeppGFOfhV
         BCfrtYPP6/eCIjDvcYEKH2dDK4a6Ufg4qTPprLI6bLm4ybizYfXl/WE55ecLhoiB6pjd
         9bwnmM2HdZofIuT4U0lMKIE/PjdbGeSgpWBi/US5bjGBhtroSffI/MkpqyNrdWI4GRXf
         hTsA==
X-Forwarded-Encrypted: i=1; AFNElJ8vrB0UOR/r4vfqW00qvWBWBWpOFEvXJjUJ9UqtoKM+PU8PBcCnvflFCtTA0qTT4jhLCMk16Uidrb4xp4BAmXTRnTmqFwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZKaghTO22yIRtIhxsOj1ih+bHT5Y1dcPAbm1kFVcGuhSY0QT
	S6XYMd2XcxMSTWNLMF6nFW/gor2XqsKmvJq1QxYNnOdBeT11OSWVKxYF0wdQMZX5OkLr0rknUkD
	z6Nr0zS+4ttCCFUlONfT0TjOw7Ps5SDg=
X-Gm-Gg: AeBDiesGPntMnFVOfFagonYlVZck+P9v7f0IxGtftlFAHEE/fL7hc+WN+wgHArfKGcA
	sGE+fe6QdfHmuAgTiC0fbvwdkqyF5WkC4wBuZ5HTasENQF3eNneaT5ly43GimNIwYX1bSz7sx30
	KTBo0dT6Ea+koYmu8jeRyrPVPhy2QeIojVv6dbC37DkVR2vS4qTSVffStmGoG+kpxXj/KhDcVem
	r4NgHBvCwr7275ao6EHhujGqSyIQ9MAM3VAW/+CM8+bwIZ9Ay/sTIJnzwgJnliFVAyhnKEIxnFZ
	seGhWZXJPkFlt6ijpd6jS++yaS7Ha8sS8hmDGpYoHuF5Cio9ewqj+1OvbPqWPbDjtHnYttI71Y/
	9V9V6LchVTnwRF0SCairmgqjW0d866aCnvh5zpZvoW8w3O/65/Z2zyCBtQUu6xzIdu3YQ
X-Received: by 2002:a05:600c:530e:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-488fb768db3mr597309375e9.19.1777258655215; Sun, 26 Apr 2026
 19:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
In-Reply-To: <20260427001602.38353-2-dwindsor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 27 Apr 2026 04:56:59 +0200
X-Gm-Features: AVHnY4IcRwbwGGwdvR03dSV3hJJNxJUEaPLWc8-Ba8wrzAXUvhv-i_8JYRb3CeY
Message-ID: <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Song Liu <song@kernel.org>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrote:
>
> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via inode_init_security hook using lsm_get_xattr_slot().
>
> lsm_get_xattr_slot() claims a slot by writing to xattr_count, which BPF
> programs cannot do: hook arguments are not directly writable from BPF.
> To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> value), and the verifier transparently rewrites each call into
> bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs and
> xattr_count are extracted from the hook context, which the verifier
> spills to the stack at program entry since R1 is clobbered during normal
> execution.
>
> A previous attempt [1] required a kmalloc string output protocol for
> the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> provide xattrs for inode_init_security hook") [2], the xattr name is no
> longer allocated; it is a static constant. We take advantage of this by
> passing the name directly. Because we rely on the hook-specific ctx
> layout, the kfunc is restricted to lsm/inode_init_security.
>
> Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---

The explanation and code make no sense to me. Why not pass xattrs and
xattr_count directly as arguments, even if you choose to restrict the
kfunc to a specific hook? Why does the verifier core need the hack to
spill the context and extract the two arguments?

pw-bot: cr

>  [...]
