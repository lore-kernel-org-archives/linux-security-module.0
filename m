Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24C7081E
	for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789344650; cv=pass; b=RGMPfG504JRgJ5EdAzFMQ++5cXWRzrPZZlMRiyCNxwXjvOryGVLRVQnYdK9p2elWUzwADp3YBLrGzSdM+KQoKCv/qxUKVt11thhy9j5rrKOtQNAWZLR/yRsCFXh1b0NbL4cfZbVTWjX9tG7IKCLyyeFfQwZEGAxW6akNQRuV36s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789344650; c=relaxed/simple;
	bh=KA+rPTv5VVNalzwukEV1piJ+nvWJpoPLWw6I1lvrZWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdSpn6NW0pzRhkjvxH2XylJusiAIpb6GI5cJQ+uhVqMaKEZ6yox/GKIr925CbzFemu9w9NaG4AA+pRvZTHNcrXDXcI/niQDo9zdRf7LpMh/BOj9diyltZhjcUCndYk5zK3N8jJGf0BsUYMeAnm8uL4i2lfPt9n1tSooY7qIRBes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VFuMwuhK; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VFuMwuhK"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8692a856865so1828496b3a.2
        for <linux-security-module@vger.kernel.org>; Sun, 13 Sep 2026 17:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789344649; cv=none;
        d=google.com; s=arc-20260327;
        b=NG3amUtF7TNah012BDpP+HMP3BXeCwMqHcLevta01F37fockmoQ/OuF/3VZVwLHC75
         8egdLjmVfJQQr0P/J097EU+iDqImfQPjlBh8EKI1IfoXBuYkzRF76rF/0wTvQvPldqMU
         atoeC0U3hv6nvwvgEGsyzvyNJtbJZx79kXF0livV8lRgmF1FleczR89UmDUL95RSyubn
         Qhb6kD7x4AU4vNEjBv72mZuOIP8Vsu5p8X5dXDCO5cuB6iRIqxlx486z7BJOU9fQy3FT
         Hq7YcQRyIyWG5Z0fb9CQCsEELVptBdOFoBUN7tJvyTbkm+oR5XuD06XVGMteoC2yYHWh
         6uCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ceBFcNq/usYwqaerRcbMKaaFE+KCx/MdZ6c3TMQKCHU=;
        fh=yc5rQF+5wxSC6aP7zeMhRhvKpZs1jYJTQ4SzPusjLJw=;
        b=ax/K2h03Qga7C8JxSLMzR8IdtU90W47/TJt402cJLTI6YRLRBqj40wp2YawSePSFci
         0hMPtjtRMawXTtAud1CEBYmjYrrdB8fvsBEpcHGgwyjyPwBX7AYG+/OlPzB9og4mvhLp
         fj3RScGaHRdEJeVaf7yu/LQMrUwoIOlghzhE9fohcNSlwFufB6+3LrtfB1wNwk44IvIv
         WyJopS6HDk/kX1O2uHG6ebGrkcRju/dp95Glrdy2slVie+S36QSxMyh7solHaZTtzQ8N
         6ihHFyKbSYK1eLZG3wuuDrDiRH75QSbiVCIeA181qiYOZ3kMyNfXKOn8K6tAmxGC2yba
         LLHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789344649; x=1789949449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ceBFcNq/usYwqaerRcbMKaaFE+KCx/MdZ6c3TMQKCHU=;
        b=VFuMwuhKWpZLbLTVULdqImtYwv6yZUOTbedztWZERBz9+3FYrJgdedTbp/AxJ101rK
         Wg8msxRfxzCl7ldOI0iO9iPjBom60i2FqTXrp8ctV07irGWqu/2f5Geo8Nbh3zqbukws
         8G1rHOX6PtulrRi/u0leeQmdyjDP/yYU7PKKOQur7UVtYiRV04TylVoW37S64Oz99snr
         u3ERY33o+6Lz7V2T90AWV/WV3Z0jiukN2b0fUQpE/onyr1TzBP/VS1Vo9UXpSFjtz/aO
         pz3SBskJsizgHUdF7NvU6aYzUFQH6EGZeaeYN4pWZcrpAqIkb0zHQjKoqnNGjYivtTor
         YS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789344649; x=1789949449;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ceBFcNq/usYwqaerRcbMKaaFE+KCx/MdZ6c3TMQKCHU=;
        b=KPXhJ2J2A8eMzXeXWHHB2nCWKJxxwOiFn/00fSPMbDE7WEJ4l+RrgFAvuq7xbm2wGq
         x7QIi84MKNoGedembGNIGydjISmVKxvMrXK9u0toYOeaIBSWapM2ZNryjAOze/+dDKNE
         9tYpQIwf+vHAcOplVhUAsA1vmNErbWZYvQHlIpd6OJ5qQ/fwQEVKlKxoMd0rKtB7ECdG
         oxVnO6z0CzoQteIa4RzxieT9jmnGvLUiNV8/yK+9aEQGAHMlyKkBs7JPz12AorDbMY7o
         pZtdrUA88i4QxKiABdPm1IrkTcLKZwYgXzvG0djCTd3sTpuEwfOBB4cZNbj65YxUApxR
         7f+A==
X-Forwarded-Encrypted: i=1; AKwUvBy80GK4Uu6TZ5rylvcarKhdxkNAmkTpVXsDLBA8z9Zk0B8byKDSt0id2Mw2qaFNAIjT5r0DNI7FpbgPFMtJoSms8ANcdMo=@vger.kernel.org
X-Gm-Message-State: AFuF++lTXGcoACfPCYvvJadXugH+ZrcLX7F5e9B4D5AWDHUOEGAgnIGk
	zVFSNVjUtP2E8Nh8MEjH0v7ccFlE5MimDw428F21KkGSZVvFT9wkZASgDFetV4CXI5II5LRS/Ft
	Nzv1xJuthC4qcjekSG4fjezkigusgbxMEe/P8r0sl
X-Gm-Gg: AYBFou0zrEkR8WIYrXCSD7S9Qy+fSfSWH5nti9E2Nruw37REKVePDC4BRd/z+1HQOIJ
	MSLqTmZupG8dy2ii3JBpY4ZPKFyZDsKfu+LG7NukTm8ULcGd43k8/LtwXSokDffCgxCNPajPz1u
	LO4Qih8kY9LLycUpkPGDTQqQVWmZQmi/ucVdxnw/AOz9aBXQYfoc4gTynxhFLu4KYFMSUjoC38K
	tV1F+2F0tiTg4pUU46+LfzbMQPfzwKbmuQ983AmpAHJ2UG7hEpBCA4/iRTPRQcCJhFSIpiTkznR
	tGX4l9kQ8yWsXpHiLQbiLD7BN2cVPL6p6svPY24vDiqPuCuidyIw9lG3iMcnr6GI5mf3TP5tIin
	DmU1XXnKdMXmAr2ni+0/JuQ==
X-Received: by 2002:aa7:88c8:0:b0:868:4538:c44f with SMTP id
 d2e1a72fcca58-86f852000c9mr556726b3a.12.1789344648633; Sun, 13 Sep 2026
 17:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com> <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox> <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com> <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com> <CAHC9VhS0JckwfomqLTUJkZZkDSgeRXYOjMmPQYErgYynQYqMKQ@mail.gmail.com>
 <CAADnVQJCJjy9Eiwn6-88c0iOk4LfgPU6KBv+w0JZdBzmXBMUCw@mail.gmail.com>
In-Reply-To: <CAADnVQJCJjy9Eiwn6-88c0iOk4LfgPU6KBv+w0JZdBzmXBMUCw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 13 Sep 2026 20:10:37 -0400
X-Gm-Features: AcwNN1XOcc2wDiZEgdl-zuy4X7NFEMcBCsCAlJzRSr-oGZZVEvXYbjHajbfewBc
Message-ID: <CAHC9VhTh446SkpPF-hUiLYOHipuurzkgju_nH9LsRGdERSAL1w@mail.gmail.com>
Subject: Re: LSM boundaries. Was: [PATCH bpf-next v3 04/15] lsm: Add the
 bpf_lsm_policy_release kfunc and policy object destructor
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Justin Suess <utilityemal77@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <kees@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Jan Kara <jack@suse.cz>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Tingmao Wang <m@maowtm.org>, 
	bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 7:25=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Sun, Sep 13, 2026 at 12:41=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Sat, Sep 12, 2026 at 3:33=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> > > >
> > > > If fs/, mm/, drivers/, net/, are permitted to have kfuncs, then why=
 not
> > > > security/? kfuncs.rst doesn't seem to forbid this.
> > >
> > > because fs, mm, net see the value in bpf. bpf helps these subsytems
> > > to focus on their core technologies and moves policy decisions out of
> > > kernel and into bpf.
> > > while lsm people treat bpf as arch-enemy.
> >
> > It's amusing to read this when just this week we merged a patchset
> > into the LSM tree for the benefit of those writing BPF LSMs.  If you
> > look at the discussion around patch 2/2 you will even see a reasonable
> > exchange between Matt Bobrowski, a BPF LSM maintainer, and me about
> > the patch.  Alexei is obviously welcome to his own opinion, but I
> > would encourage those reading this thread to look beyond his comments.
> >
> > https://lore.kernel.org/linux-security-module/20260904-lsm-mount-idmaps=
-v3-0-920a1963675d@amutable.com/
>
> And that's an example of unacceptable land grab by LSM folks
> that I'm concerned about.

I made sure that patchset was ACK'd or Reviewed-by'd a VFS maintainer,
a BPF LSM maintainer, and the Smack maintainer before merging (I
covered the LSM and SELinux parts).  You might want to double check
your definition of "land grab".

--=20
paul-moore.com
