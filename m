Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26C835C1B6
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777260807; cv=pass; b=kAX5WITsaDWkr4ssMeYxT1WZk+9rW25W4Rn8lakXybu/8nbWE+zWan7RTzTFcYxchb8DyzmvPKCc4JilDg5KtLb0ITwHTwWZkyp8gwrU2GYz+j5GlJnEuI5tUR6Yp73tQ7Qg8riN31+iQfM9+leq8arTshp1Wm5GPE2tAnYi2Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777260807; c=relaxed/simple;
	bh=FlRySTzL7yR9u6SjPj5k70NdbvHE2bc1gU3Eq2AkLA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZEPUwxX6MCeSlkNG4rz63wQ0nnO5W9xe+x0FJLgj7xj6cci3NreHxiRSqqrrCoP86Nn8oFI3KzzFGOaMRkZ5j1DtMBT5BAZh/mlzx43KNXvp5GpqDl7UHK8+UeyEqCWwasvAkL4M/0Rr7Sc8RTiCkGv9uOpxQ6cFaKCloG1kJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLEOZyKX; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLEOZyKX"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43fe608cb92so6562467f8f.2
        for <linux-security-module@vger.kernel.org>; Sun, 26 Apr 2026 20:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777260804; cv=none;
        d=google.com; s=arc-20240605;
        b=C/613q0GxyPFPPRuRtEZ77lk4gvRm3Et2U2mFD86P/Awey8H0PuiyziLfsj06F/UQw
         pa5Klk0fgMr8opMnqw/vZbx69R1vFFFOTCRzu0xlnnGQKBfmGUQ7UD/ygH0ZEP6THYeg
         P8QDyRqQpht+KCT43vr1JMWKI5Mgf99ACgWF7caPf4VoZ+ZJoFWhUSSFPQcbFAAtQ/07
         DIjxCto1gLNfwMUsVWM4n/XkMFtgd1TKtSpdYHPER4Wvab2NXXMpk1cpxGoOC1R2lzlP
         qT4IWIlnjCGvV65h79A9jLVzyPhMZEyoBC1EWYFpGEyw3Bbn9AhcOBYLjlAtLaYj1tmP
         JUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FMeRQIgABI0rxTD3+7gFqkezgpUe1NFoTAQ8q5oe/AQ=;
        fh=0SF1YM/vvLiCI/bLHPFMf0ivxmSaB9niEY6+ZKrCBQI=;
        b=Ph8EKp93zYnIQakA9GIW1wCVtviy4zvjtyd/NsCvln9bi2iD08fwXqigY4QBNat71S
         RZKYaMaZO2/lekaIekuFD/NbrpWmb8iZmJj6SN/dYRSvxBce4rwI8ADekpxmNdKXgAQI
         ZHe/Qm9QFUmV+Rj6lLWJVVadaf/u4pF+WPZ1XgHt8ABmTsKnN/e5NqiVBfrQTkZkOJWp
         CRX3+g2Ak7U9R60cFClE41Vry8oGW/Jl40+fg7zYVKJDReHnn77XywUUNtK+dDNzxjz5
         2Ku1y3bD+jPsMruP0Zfxdf/c/rdpR03YbyFFv5fgofR8rlzayUbinFIYJwJoWv8I0JcM
         mqpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777260804; x=1777865604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMeRQIgABI0rxTD3+7gFqkezgpUe1NFoTAQ8q5oe/AQ=;
        b=mLEOZyKXnYS+/AXRTj6N1BZ0VGl4Ed/G7TH285S63iUPgPatg3vhCvbz0aN7hxLud0
         Ma7q4vzRFUKNk6su9OsN/BPXTaFyyYUL4Gy5KTgHSS5efyg10XtBkgh6nlbjyuwm2M6r
         Dv0boad/PpGbwRO+nqBaYXv+JxiMdWuGgGh2/TFP4lgkS+yz0zEzM2MAHRs1dito9ilE
         8LPgcOpGWijtUyQJM1XCdZVMc+g3+Spv0jMaYBJyYduMrIsFCNnmaet9QGX3tntsK+Bq
         xJ7qUX/WaYAKexaR92dbqjoMwr99FHKuzsL2dPyhzAw19gB+gUOWnbEIRRniA53D3U4K
         qFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777260804; x=1777865604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FMeRQIgABI0rxTD3+7gFqkezgpUe1NFoTAQ8q5oe/AQ=;
        b=jrjkSfJQLtl3AKWkixYw2gyDCH2EGGM8BMZiPiDShsxXRcmscn2VzIQHkBDMSj1uVm
         YDgDfJqoiaUPQJR0Zbt9N03Gylj1/CHfFizU+qKamPHGb1i4M7bHFlukSBKoLwG5AemW
         4WaJCCJ5vUdzYSVBBb6rVT22/ZaUhLxXKWy1Y7zd7Mkd7hBAINYf0B7giZs5lTbIS0Tb
         Zp6NYRzdffrIQMmfOG5QbDKevHBCe2bAh9E/bSQMF1NV3E9N2Gd/V/cwoq0GW0rQeeNE
         ydgCtYXCpaSPPzvcKH2zJY1tvXQgicwYN38GTspNJCr1jtXlPXO4GuXuRpWAR0fQPf4p
         BLIg==
X-Forwarded-Encrypted: i=1; AFNElJ8oiqc3cz+lUXVH8hN1u3/rMOx4+LA23JhFy99IVx9EowLL1bWUjb+qChzmnILeMDqDiTnKSOE39jxPtUEBzT89W9E2ioE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOBsRmmoV2ew7MgA8jFE8jOfoO80zqffntUc4rAsYGBvdzLxV
	0Kjyo7fQj68mM99BlK98EJPe3Q3cP4/Wel9Y3tRcT1ZboKn7eV4G83+Rj7RA/JThI+MHgwR1pAH
	6DOJlyHP8FMsCwjZ3nIFrrX3/7vseeCA=
X-Gm-Gg: AeBDievtQPiJvasvzmpQ2EjdiWalUnS+tz1sYdyG3k/NwGs4iQ5H4Q0F94gHTPKAbbh
	WoVBo0KbKf+ls/ezBvqAgtRHq4fAod1yg4DritCoDdrzqoR+YyeL8w52acbT+JYfNAzRNJn0LU4
	lTb3e+sW88uy0bvWFXIUDS10MMv55nCNH5KVrqJXOyw3Pu+tTJKY/fM0regUw8Na6amavZ2ddyo
	Rnlwmb3ekdNqDrqNJSCTMfqlY8VJ0pCs6D6tR7/5qPPIyfWMY9rwok6cg6ShmPWYYTsHU7AS7hx
	oQ/FjwiajtEvFEYy/LywWS7l3qFPRGJoFcA7rORd1D3suC2XO/9K2d+t/zi5dM8h+sDgLlUBv7p
	q2aiTB1JPOCYhvkzU8uj9d3lcchCEwuZ3TWGvlQECRvHkDSVTMs/nxUopXsT7fCrF3G/E
X-Received: by 2002:a05:6000:40ca:b0:43d:70de:1c62 with SMTP id
 ffacd0b85a97d-43fe3e120c6mr64592007f8f.45.1777260803470; Sun, 26 Apr 2026
 20:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com> <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
In-Reply-To: <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 27 Apr 2026 05:32:47 +0200
X-Gm-Features: AVHnY4IWx2cxeZrRnlqhjZ1wcwst3yduTrI_1755npZU2JYycYn4il-T3V10fRY
Message-ID: <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 at 05:24, David Windsor <dwindsor@gmail.com> wrote:
>
> On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrote:
> > >
> > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically s=
et
> > > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> > >
> > > lsm_get_xattr_slot() claims a slot by writing to xattr_count, which B=
PF
> > > programs cannot do: hook arguments are not directly writable from BPF=
.
> > > To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> > > value), and the verifier transparently rewrites each call into
> > > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs a=
nd
> > > xattr_count are extracted from the hook context, which the verifier
> > > spills to the stack at program entry since R1 is clobbered during nor=
mal
> > > execution.
> > >
> > > A previous attempt [1] required a kmalloc string output protocol for
> > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs =
to
> > > provide xattrs for inode_init_security hook") [2], the xattr name is =
no
> > > longer allocated; it is a static constant. We take advantage of this =
by
> > > passing the name directly. Because we rely on the hook-specific ctx
> > > layout, the kfunc is restricted to lsm/inode_init_security.
> > >
> > > Link: https://kernsec.org/pipermail/linux-security-module-archive/202=
2-October/034878.html [1]
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D6bcdfd2cac55 [2]
> > > Suggested-by: Song Liu <song@kernel.org>
> > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > ---
> >
> > The explanation and code make no sense to me. Why not pass xattrs and
> > xattr_count directly as arguments, even if you choose to restrict the
> > kfunc to a specific hook? Why does the verifier core need the hack to
> > spill the context and extract the two arguments?
> >
>
> xattr_count is an output parameter; we cannot currently write to it in
> bpf as there is no verifier support for writing to int *.  xattrs and
> xattr_count can be fixed up by the verifier, so we only require the
> user to pass the name and value.

Sure, but the kfunc can. Did you try passing them in directly?
If that doesn't work for some reason, we should fix it instead.

>
> > pw-bot: cr
> >
> > >  [...]
