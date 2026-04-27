Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD535AC0E
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777260251; cv=pass; b=bwuyQrt9jpM90B/gxvinXFdEy6yohraar/cvBbm2yPp5Io5sLlos1Ie65DMVfUJieBKoFwNvMYR2wbcGY8bG8PbVy/3obKJKIxEEAFWox52Vx5zN/OrMIFUDV/NtjTqKnptOO04rR2YY73y06DotomuDW4SrJ+IxAzPISIkGu1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777260251; c=relaxed/simple;
	bh=5scMGizBEZQ+MRt1lEr1zuH+6NL7GMmtobGuYdV0JtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Clf3q03YlmcLTD7FYQdw8+/bkMGwV/+NtnUTiWQi5m4MaCieHc/H72TCO2EOOMWT2XsprapkqzYV15n4QLfuwijSzBSWVBw34miegpyBq7FbkvLW1V+olZThJ2n81xsICP3TGsMZentkGDk4ZrMTdMTRhTRlIy+ooNSuyLEXyro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNefJAuf; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNefJAuf"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e97863425so72845011cf.0
        for <linux-security-module@vger.kernel.org>; Sun, 26 Apr 2026 20:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777260249; cv=none;
        d=google.com; s=arc-20240605;
        b=IkJrKQZtDhxBahWoxH2Eh+fYNhjEkUsbNNX5XC5OrGWtPuTGegLvzAk9x0KNGLcmBq
         a/ng2MveMhs9o3cuJWH4JpednIE6mNkM5HiR38vNAaA+2Eo0F+obvvPTnvWGNEvIzB0w
         In/hal2C7Mu9mSN+RYc+dmCwTQDGr6LMw7+IsjpDsz+4FYfixFBGBV48KcARHVpkuLDH
         FJ5bZeaNOWBnwtIKTC7wGMGFm5Gs2r/jT2fyVF7DxGK2YnO6sT2Hx2cx66Fj0YNlsRAU
         g8v//55wXpzfrT8Yt1X9TTbTnQ6AG2KI+ZeIwr1lwBugTibKkFzJBHQuMDknzjCpE3iV
         fx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2zE68H0RpKyKb+UxxWIY0vid0AEaBVY0DBcP4n4sG7w=;
        fh=b7HsrhyaRozEUVFYBliajR+s5HKms3sQCLRgsDYujhM=;
        b=SekyHj4XrGGbcZogMJKPZV6QrRAs/cMwz3onaD8pxxVcpFsW+RybWzNgU/yucaIETi
         RLmFcdTH6NatLpDcqATkLeznm+GWfIyENu7D2DzWojFPTfctVfbdOGZxtPdkP+dJ2LBH
         aK/NVHsH348tMJ4OVX/Fjei2+t6JM3HKyg3pErTuS+n7nnTkDpy4wzqyChkmxpaJWqhO
         010zOwoY/cKfBarEETG1fw3OMbH/2b3pHeIF0jaZTRc/rYTa0XT/Nu4LmmnhG0FbTvJn
         hqkWHWCdakFsHcFYeJKu/3kOuio0LMoQh5D6baeA+R5x9GdoJXQlE+aHLZmSaH/59I7y
         s0eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777260249; x=1777865049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zE68H0RpKyKb+UxxWIY0vid0AEaBVY0DBcP4n4sG7w=;
        b=ZNefJAufyWGznw27IG/u0F3FYcP8TsMm3USawUoCjfR5T+l1F/1NEkjhSgvVKwyg2/
         VfHTz63Ur+sU67l870IFMK2bB+eqc6pVLKYKhfMWV77p0Ts7Qzpzz8Kvelf9hfETnR7l
         847n6nL3AuQzLErajeLlQh9jyLgBXDy63+97Z8m/ZqBrv2phit/G9Y0eQCzlulhQ5vja
         QcoH6gprOgVLQlma6Jyewdgs2SOR27H24qLLbe7WQ54rthMRDjgQ3o4rf9HCZSXZvNJb
         wsQPBrvg9Gk3sSKAWddauav3oTTSCPJtBHR8hxGrCnjgRXam9Pt+BRdQQIyFZPloxPKO
         nXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777260249; x=1777865049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2zE68H0RpKyKb+UxxWIY0vid0AEaBVY0DBcP4n4sG7w=;
        b=AfPVPS8f7RLz5cgfwYTosiihnAQuDbdK58NX+RZcDkuSUYDCTj0V2UHTtV1gvv02Ku
         sJS/u0C3Xr+9Fdf0xS2/FlJ1Am7ApUDgeKfNJjpX6/B9vHOiSJVpO4sKKQObHuZ30swT
         Rgln7Bvmaon/V4UwMBviIsJKTgQisrX5WAiLT7tMvPdTSTR9E+DDCY4BMyQ7dDVrkIyc
         1ZPM964Xd4D8u+QUVtUf9FS/OOV07+wTTEScTSdC7cPlK9xzh4KcxKwHvu1KXJqapXf5
         qr9htiPx6eB7NRc4b3w/KJoPyco5+VXVOEZSXIenuHP+VmdOFiYapP73UdTLSp2nnIqf
         0bUA==
X-Forwarded-Encrypted: i=1; AFNElJ9jpTACAcmc48CxP1VvDvdpwMuy+olMYYskzgNw+sKkJ8P6YESzMpQHUETTy98nhm/u6f3Rgcirz1ivTpoX12LRgOlY7ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEvq6UYL1IJVJ04QJjw2r4DSApyVV6G/yEcQtPv2ahbGCbF0S+
	w3KHDz83ikougqlkmkJJtNOEMv4bQ79dGjghxNF3HrAzlSmW7WKb9ah/pRXFselQXLRDWjxXB4m
	pw34WQwlNWNWEUMXo4S4MJ6/k1XByuUAqiDVl
X-Gm-Gg: AeBDievBXg3bKaN81Kas+l0ghmW+y9d6eGmNvpjJQ6SEk61+v/ZlYmna7cXxX7Gz/j/
	FkwMMOvnNHqD6xPPVXfWUTHTnuvMEkKHlSQrnIeALnM4+UW+TmhXTeP4DomyQM7BhftJ6xZwO2u
	eyg+ypaM1s8N9x8HeLARtqgG66dg/4X/oEY3EroGX8GCKvlXkAg6MrhzANU4aqs2HTJnflVGXAB
	47dpeOopk7BXk2Qq2x2/dslRpbEvAjgWUbfKHmaTzy/c0fPN6+91MNaGSVw24XkCgy1CcDqSgO0
	UK22xiNQky+l++VGfcoyo1DTBdCQSv/D1ECh/oIlUT9g7qd5mQ+KmE6kiQqaDw==
X-Received: by 2002:ac8:7e82:0:b0:50f:c15d:3f65 with SMTP id
 d75a77b69052e-50fc15d4453mr321942841cf.1.1777260248936; Sun, 26 Apr 2026
 20:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
In-Reply-To: <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Sun, 26 Apr 2026 23:23:56 -0400
X-Gm-Features: AVHnY4LNYufhxdoAmceUuZwiccpvrcrEMwYgU2MUvTWN4N_kz_NZl2ifuCum7P8
Message-ID: <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrote:
> >
> > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> >
> > lsm_get_xattr_slot() claims a slot by writing to xattr_count, which BPF
> > programs cannot do: hook arguments are not directly writable from BPF.
> > To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> > value), and the verifier transparently rewrites each call into
> > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs and
> > xattr_count are extracted from the hook context, which the verifier
> > spills to the stack at program entry since R1 is clobbered during norma=
l
> > execution.
> >
> > A previous attempt [1] required a kmalloc string output protocol for
> > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> > provide xattrs for inode_init_security hook") [2], the xattr name is no
> > longer allocated; it is a static constant. We take advantage of this by
> > passing the name directly. Because we rely on the hook-specific ctx
> > layout, the kfunc is restricted to lsm/inode_init_security.
> >
> > Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-=
October/034878.html [1]
> > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D6bcdfd2cac55 [2]
> > Suggested-by: Song Liu <song@kernel.org>
> > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > ---
>
> The explanation and code make no sense to me. Why not pass xattrs and
> xattr_count directly as arguments, even if you choose to restrict the
> kfunc to a specific hook? Why does the verifier core need the hack to
> spill the context and extract the two arguments?
>

xattr_count is an output parameter; we cannot currently write to it in
bpf as there is no verifier support for writing to int *.  xattrs and
xattr_count can be fixed up by the verifier, so we only require the
user to pass the name and value.

> pw-bot: cr
>
> >  [...]
