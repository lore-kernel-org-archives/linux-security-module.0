Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8833D3D08
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299661; cv=none; b=NPcVRC/BQDn5UcPBfD981Qrqb/ufpVAURo171SGflJaVh8O2LNJGYq3UHNYjMsnzl10Y+dPlhqRyLsQIhfdtGvGvh8vfgZ7j8i1VVs1RFUvu6AEN89KWOppFk97vNkzye6IeNsjUrwTVejuLXUP5ohlr1B7f4RE5Q3gh57M3Oc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299661; c=relaxed/simple;
	bh=iYeaM1jIWkQgRPkEZHNaD/j88IYl3E3ZeJw9cZlyYl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXAb7Uu0SNVyTFxsPwW4w+CPYIULxdpbU0fcWwtPNPeXPGYksobp4m1l/J1SfdNnYdwWewWM25nkLmXChSosgNStzQTIHSIKvL6AvObCEZyBsOtGwD189HFzbjxPhvSxiVmvj/rne8uLlHoqLOnYSbTSsASQBYvPKzKaP97zB3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD+VTiTp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD+VTiTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E78C2BCB9
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777299661;
	bh=iYeaM1jIWkQgRPkEZHNaD/j88IYl3E3ZeJw9cZlyYl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bD+VTiTpIJAQcPm4X7aatvaCwq8cFO3iNoQc+YM/5JtACWc/iHiAr+NYGWnNnGggN
	 MKnkVL2kS8ZKBXN3QXUG0JeA0ZrPmb2oNLCc4siQCXbSAu/iG4wiWIIKC0daLu6Gll
	 EEHkgHIQkUOKbDKplFjAkaPl9R9EImDXIcRgkq1POg2FIlwe/AsnoPJC9pQxVIyaEm
	 OaWyzV19evFKRYRbLDL7CwZDk2F4e9xXwGm20HlyJjnHIpnnCeWTNWx4HMy1CoyV8L
	 y8mdqxrajutBhr2yB5hUj6RPjX1lZrVZzSZC0EGSHeWvBEpiarE1XxRMzopCJ7K2la
	 Ok9eTDzPZD2yQ==
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-60fa13bde2dso6529329137.3
        for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 07:21:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9PfHhEo6FqTTctfMJGQkqj+KTYQ6lzWgtimy2buwN/YLJVQbN3vBy4c8YS5P3QeR+MUqHhPQ78cEISGLieTnmVnsesIuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0lQoZmkmrQTcUwmYfeBdIMtV7DLGotWGm2SjK8xh951s5tKxi
	F683yI4+XfbQuiRVN64e1/6fTQgASIRZXT/+5B6uF7XmLAVOHCwe3HykeKW8cubgGhFApLYQKe7
	T+NbPftt50wZ21z9iRNrMm9IkX3Kb+aI=
X-Received: by 2002:a05:6102:162a:b0:605:5d09:8631 with SMTP id
 ada2fe7eead31-616f807265emr21177893137.29.1777299660351; Mon, 27 Apr 2026
 07:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
 <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
 <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com> <ae82Vv0RWzcXqSaz@google.com>
In-Reply-To: <ae82Vv0RWzcXqSaz@google.com>
From: Song Liu <song@kernel.org>
Date: Mon, 27 Apr 2026 07:20:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW60SRXZbFYRDm-QaTiB8tTtJD_N4jk1=680x5UsZmpj9w@mail.gmail.com>
X-Gm-Features: AVHnY4IpuvPbEgxDVLoVsaHhXP3B7YAYoqdEKM5mE-x3NufiAn57piXniLfGauE
Message-ID: <CAPhsuW60SRXZbFYRDm-QaTiB8tTtJD_N4jk1=680x5UsZmpj9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, David Windsor <dwindsor@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 11:11=E2=80=AFAM Matt Bobrowski
<mattbobrowski@google.com> wrote:
>
> On Mon, Apr 27, 2026 at 05:32:47AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 27 Apr 2026 at 05:24, David Windsor <dwindsor@gmail.com> wrote:
> > >
> > > On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wr=
ote:
> > > > >
> > > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomical=
ly set
> > > > > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> > > > >
> > > > > lsm_get_xattr_slot() claims a slot by writing to xattr_count, whi=
ch BPF
> > > > > programs cannot do: hook arguments are not directly writable from=
 BPF.
> > > > > To hide this, the BPF-facing API is just bpf_init_inode_xattr(nam=
e,
> > > > > value), and the verifier transparently rewrites each call into
> > > > > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xatt=
rs and
> > > > > xattr_count are extracted from the hook context, which the verifi=
er
> > > > > spills to the stack at program entry since R1 is clobbered during=
 normal
> > > > > execution.
> > > > >
> > > > > A previous attempt [1] required a kmalloc string output protocol =
for
> > > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all L=
SMs to
> > > > > provide xattrs for inode_init_security hook") [2], the xattr name=
 is no
> > > > > longer allocated; it is a static constant. We take advantage of t=
his by
> > > > > passing the name directly. Because we rely on the hook-specific c=
tx
> > > > > layout, the kfunc is restricted to lsm/inode_init_security.
> > > > >
> > > > > Link: https://kernsec.org/pipermail/linux-security-module-archive=
/2022-October/034878.html [1]
> > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > > Suggested-by: Song Liu <song@kernel.org>
> > > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > > ---
> > > >
> > > > The explanation and code make no sense to me. Why not pass xattrs a=
nd
> > > > xattr_count directly as arguments, even if you choose to restrict t=
he
> > > > kfunc to a specific hook? Why does the verifier core need the hack =
to
> > > > spill the context and extract the two arguments?
> > > >
> > >
> > > xattr_count is an output parameter; we cannot currently write to it i=
n
> > > bpf as there is no verifier support for writing to int *.  xattrs and
> > > xattr_count can be fixed up by the verifier, so we only require the
> > > user to pass the name and value.
> >
> > Sure, but the kfunc can. Did you try passing them in directly?
> > If that doesn't work for some reason, we should fix it instead.
>
> Hm, perhaps this fixup approach might be the simplest in order to
> assure the needed safety?

+1. I think this is the best approach I can think of.

Thanks,
Song

[...]
