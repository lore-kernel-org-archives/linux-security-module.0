Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906B2F12AC
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300438; cv=pass; b=Ud3yeqdS3x7tQR4KrVBWSITAQVtqq7Z8CliWyavmXbWH9sPJz42xW071JkL6HcQUk8s4GwpdePUah9qJ5Ulg2XWWebndlbDweZAbd7iGhL4jyRSyEW9TL90GHhceAVF9D9ONi98+dUEPslw57gQNLv0xofhHQW+04B0trYxcIq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300438; c=relaxed/simple;
	bh=BxBDIJpOCEN9cmK7Xc3qnTtKGs1GTwEe6Gc287iXtLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csoFlkDul4lKgcddILt6ASQzeZiy0aECGUrhEYMEu/7EcI13eu2JaKh5skrMxlzRLdt3aMEK3AaiPFAlErvGZLDVugFDNu5J51VWjRWsY4aGkyjfEjGoUzg+dJ2Q2UU9aELLkmV7OBRmBlrkk8OQSL0lqEi5MztKVuRMafIrp2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg7lEW6B; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg7lEW6B"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so10488258f8f.3
        for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 07:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777300435; cv=none;
        d=google.com; s=arc-20240605;
        b=Ob2wWbDlxP9QeK4O8GilJwEQtkD95zW/BLplzNn9dpxL6aGH/MKvODPMZyKF1G7i5y
         2OfVNMikCwrD+nTnEhuEgiLAwjKMXAMFbvQY504m752uxeBEbVk/hk1CJy03vzjqtZFs
         RgmePZuhpIGfzmHk/VcfKkMjfCOb2BsC0YNggEHVWoCqBnIifpbZLE67htad+covZyw2
         IIOQDNqNrI7B0MEt68LCCirjazXvwdAnuCMxT1+5OCbhkjog7Ac7zbPxrh95ZSGAyii/
         Q1yHRF1OHyfheokbmtw9MOFCgFTH4axqAFPYdjpLwQgAWZc94wySfFt0G8fxKwDimQ5w
         Fx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pFu1HBFOkQUkkUSIPtiTt9PSDYzJQuwVt6q+ET8HXT8=;
        fh=YOh/jHzBgnUur1kC/8tV7NpTo8JGpLp5a2Uo9nUSBGs=;
        b=Gk0EbkpAegvGh2G3lB/WjctFPoIphJYAFE3Q3UQIGMVw+3WH6QSU1k7r4Om+BqCp+E
         YBY42X4faReq+kyJWdclJ4g0NWMRjZ9KMEAGhb/Cp3FwSoXj19lpA6T62PaETPw0Igno
         CXlZGmhOYOYpV74mn1mYOkLIjNcNm+Lg1Ru7KN7W+HBPUlUl9qXZ0Y0D8Sp1ZoVC5Vye
         qXjgfMR3teUWMGths2o9x84L08Ti5bM0XSvHtm3TFF3oioqr0w5rYkxDR3STqb6DKDiZ
         vmRGH0C2CAkr6ax5bHE0ASWWZWrcxG6pmpRHd3InFETm2y5o58/JVQ08px/lZvUmkbiI
         0U3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777300435; x=1777905235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFu1HBFOkQUkkUSIPtiTt9PSDYzJQuwVt6q+ET8HXT8=;
        b=fg7lEW6Btht96XYQoo3Bu45XSjelEwr/rNUaNMxN5Q9HHjCmzkizrvkLQ/sgQEA/Hg
         Z6nNTGaZgv7qJYWlkU09sbvus0KzCLnHr5wGA+axsn7gcESH3xEKyw2W4jPKQXPLmmiE
         nG/KPsfwL96b7NYjTFsnu86cIJtn3oJoDQD1klXl157DrMX3Dvv+iqQJvEJ4NuJDQYak
         ngAI5xVEa7A4pdoOqpdL8FfbscBryWB8UhtZDc8BhCf4pYLNr1QJd4Vd3XupgU4hwKLZ
         EoSMcApEG2MhxIWKHWVHVBepuycD5K+u43Wsw2fyvYuvobBW1+gl8Q3OCpDyBjJU5+s6
         wYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777300435; x=1777905235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFu1HBFOkQUkkUSIPtiTt9PSDYzJQuwVt6q+ET8HXT8=;
        b=XpEK7igqP+HT0nHd+dUw5ol2A97T1ndNX3Ohzd4y4YnxOjw5IHXJPsZ6jfB3mKLfoP
         oKKMCoPSI+qnWQYPnFQHLY4A7mhf/0LUqlgKbuUHtcLipoPFRImZyrEhFE8kj7zFZ4Ac
         KWeRSdVVDJaZhw0s9ZTNUpySOo92/UEZWISgGnoLoW7LW2v6RUXZ7g9+turJ4Dl0bf05
         gwM5lsYaBNuM0Lpp+/PkxlYIRzABkb0hsPUJk2zDnAJ/67Rs/i70zzxmUlNv5hDOopdL
         AKaWnfiHXiP7gMb7MvTxypA10JeVqDm6Tc7+MtGK9LKOGucOLxnb9OO621/0zW1o7xAR
         6ZEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/stwhMCtqBSjzG1iY+dDEIUGdt33G6MPtqQUkNfYapNfNE/jqOLqKmuXBk7gOV45rjQfeD0u6AonDmiG5J95KlLcz1iGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7L3Nt8vHV5ymL73bNuyueJXzeJPYwsKW/ZNapkXu79lyvgziJ
	f/vmgYlNJ5U8AoAMQX4Zrq7WUPEmxtMSg4ySdKi4wnDfHwrntHoeo/qfVosiZRBGM/Jt9vtxJLe
	YjPL7RR9sLSlUuA+krLYGk9tfePKjmwM=
X-Gm-Gg: AeBDiet0y6AGa0GNCqFwa9LEfyYyXnV9dD9B6zd1jL4tt/UOAtuirFl2ObycZ2K6VLQ
	kHAMD+wDWvO40Kj73KVPhAnYAtescQsCVltbbg6kaLIzNM6DDwnhYou8/ryuKNhLSRItmesyWWm
	6Gzh/Xvll2TWJ6lWBNC7NjWnDbfL1+zOUtG1roXGooZc6+lMDhpL9M6C5ajpS416eoByz+A7i6G
	cuR1cI1aErfYPYFmERL3ImmpQNgbGQU03gilhMmqJtoIIhD4yJUHadgzadh3IcUVoe0l0qYxpIt
	KY7h+XoIlCDxGMsfQAOwuordz4sbTM01A2GfYsz3xkYXZwSDHbSRdknOr2D5aa92X+/OwqIE1U3
	o5l2tql7SoW2tP0RxN4zjl9Bgoo9ViJVdfJ+bXv+M8PMxgGhpioWZEChb7G38vaBkbsU=
X-Received: by 2002:a05:6000:2503:b0:43c:fde7:f1 with SMTP id
 ffacd0b85a97d-43fe3dd3a84mr67619523f8f.18.1777300435210; Mon, 27 Apr 2026
 07:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
 <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
 <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
 <ae82Vv0RWzcXqSaz@google.com> <CAPhsuW60SRXZbFYRDm-QaTiB8tTtJD_N4jk1=680x5UsZmpj9w@mail.gmail.com>
In-Reply-To: <CAPhsuW60SRXZbFYRDm-QaTiB8tTtJD_N4jk1=680x5UsZmpj9w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 27 Apr 2026 16:33:18 +0200
X-Gm-Features: AVHnY4LqkIDPfVb8uImPBj27UWWOVcz7SAlBpnueXBL0kV-JzzdvYtW43eOfPb0
Message-ID: <CAP01T75SBw6NNvBKyPW11JSYY2oh449yoBsWi_GOBR5Kq1ykmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Song Liu <song@kernel.org>
Cc: Matt Bobrowski <mattbobrowski@google.com>, David Windsor <dwindsor@gmail.com>, 
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

On Mon, 27 Apr 2026 at 16:21, Song Liu <song@kernel.org> wrote:
>
> On Mon, Apr 27, 2026 at 11:11=E2=80=AFAM Matt Bobrowski
> <mattbobrowski@google.com> wrote:
> >
> > On Mon, Apr 27, 2026 at 05:32:47AM +0200, Kumar Kartikeya Dwivedi wrote=
:
> > > On Mon, 27 Apr 2026 at 05:24, David Windsor <dwindsor@gmail.com> wrot=
e:
> > > >
> > > > On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > > On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> =
wrote:
> > > > > >
> > > > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomic=
ally set
> > > > > > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> > > > > >
> > > > > > lsm_get_xattr_slot() claims a slot by writing to xattr_count, w=
hich BPF
> > > > > > programs cannot do: hook arguments are not directly writable fr=
om BPF.
> > > > > > To hide this, the BPF-facing API is just bpf_init_inode_xattr(n=
ame,
> > > > > > value), and the verifier transparently rewrites each call into
> > > > > > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xa=
ttrs and
> > > > > > xattr_count are extracted from the hook context, which the veri=
fier
> > > > > > spills to the stack at program entry since R1 is clobbered duri=
ng normal
> > > > > > execution.
> > > > > >
> > > > > > A previous attempt [1] required a kmalloc string output protoco=
l for
> > > > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all=
 LSMs to
> > > > > > provide xattrs for inode_init_security hook") [2], the xattr na=
me is no
> > > > > > longer allocated; it is a static constant. We take advantage of=
 this by
> > > > > > passing the name directly. Because we rely on the hook-specific=
 ctx
> > > > > > layout, the kfunc is restricted to lsm/inode_init_security.
> > > > > >
> > > > > > Link: https://kernsec.org/pipermail/linux-security-module-archi=
ve/2022-October/034878.html [1]
> > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > > > Suggested-by: Song Liu <song@kernel.org>
> > > > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > > > ---
> > > > >
> > > > > The explanation and code make no sense to me. Why not pass xattrs=
 and
> > > > > xattr_count directly as arguments, even if you choose to restrict=
 the
> > > > > kfunc to a specific hook? Why does the verifier core need the hac=
k to
> > > > > spill the context and extract the two arguments?
> > > > >
> > > >
> > > > xattr_count is an output parameter; we cannot currently write to it=
 in
> > > > bpf as there is no verifier support for writing to int *.  xattrs a=
nd
> > > > xattr_count can be fixed up by the verifier, so we only require the
> > > > user to pass the name and value.
> > >
> > > Sure, but the kfunc can. Did you try passing them in directly?
> > > If that doesn't work for some reason, we should fix it instead.
> >
> > Hm, perhaps this fixup approach might be the simplest in order to
> > assure the needed safety?
>
> +1. I think this is the best approach I can think of.

We're not going to add more and more special cases to the verifier.
The whole approach is unscalable.

If the concern is that int xattr_count passed for xattrs can be
unrelated int pointer obtained from elsewhere, can we pack the xattrs
and xattr_count into a struct and pass it as an argument to the LSM?
Then the pair struct can be passed in directly, ensuring both
originate from the arguments passed to the LSM. That should eliminate
concerns about either being out of sync if obtained from different
sources.

Even if we wanted to ensure argument provenance was stuff loaded from
context, the right solution would be some kfunc flag that constraints
the argument to be derived by following the ctx pointer, not whatever
is done in this patch.

>
> Thanks,
> Song
>
> [...]
