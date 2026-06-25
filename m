Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF40B316192
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420038; cv=pass; b=PCWQtDYiOISNsQkVK2vDe1ZPekxrKaU1Y1TQl/x/QduYO1eMHz9q2WTk51rlcZD7k+/cJuCur8FMl9/UZGMtPqC5PnRVvRq5mauRmOByeOAgNvtv/zu4zW3f1t5uhtKjnrNfzsdMRyOU+ol8bBrJ286DtKZkutikYlfjSlo/hPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420038; c=relaxed/simple;
	bh=RyZsVwgwp6SsDCHuEWnfop0rVpAHFJuENw+MxHAhUEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/6lIaoi1y3M3FQXrjpiXG4uuMTYdzk2XvuWO71zgmDh0cZGZ+MyNtfbvIbrD9OJHdXz5QpI1BdNR85VsKIB05RbjsY1MmH/EWE4N26vGiALzxwBZdkaKXXmrJfYfxw7E00AeYcc9FOywACShEShIyT1jNPisEWLumB1ncz6IHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MFsW9Q5c; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MFsW9Q5c"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37d4ab2e7c5so185534a91.2
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 13:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782420035; cv=none;
        d=google.com; s=arc-20260327;
        b=DmwIBFHyS+yvMcDLaYLe9tra3mJ/9th8/AyIxvA9KhjJO88ZgUXjqtEEuBgigOYzKe
         hrVtX89eUWiZJMi+nNIhzb+iJytr2xBbHJ3GJXwL02L5SA+vBQ9yrcsv7x0fyZMgU+tL
         wiydrbiMoxaRUvPHCW/8AYW0coTwGW0njRIBk/STXxK6WelnFWmjDyc+cUNDgC3Rv58J
         w+G1i4Rs0s/27k81MnmjG4N2Z+GOqzC3ZWa20hPf4pNXtyWQm4mfUcwQ3n5ocV4tcLXH
         p8NvRV8Yo8dFc+vHvrtfwclTZFY2UD5Z/b4YJQ7/IUL/E+GIhMX82Cj1TH18YTPLn0xk
         tovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+yx21f/fYo8TQI0aGf8AWSMgWBwIVqC4ciRZnA/Tpso=;
        fh=I3AwVGtdQ47fPs9bFfChS1hZ9TysqU6p9EvlzXhjyIE=;
        b=guaf3F65xFLLul4dRZvZHPlN7aDWyy2SJ6uJIoKXKoH8SSXXTaTpJkntH5txF0DKRO
         TegCqFhDgGQMKy3arrKrOAqH/pc8+vEx6ZXufWxyKZQS0iqDy+aXTkMN9k81Xh1D3VZ2
         mBKzH3qNd2flFVhiG5Dv7F4vRNNoV74Ba98CqgNwxXstuGMoavbTH2g0zDyPsXbigrDK
         A5eX2VVtyen6SZRwIPAB3gpDrWW6l9cy8bia+Nemhn1z8+oxsPFLbXWLXcd4dRMr8fUn
         O8OzkvbI3A8/U49qVE3j9c7WQndf5zYfM3hovbgxpK1iDUEe76yxOtQ/d+sRYEn8B+0i
         Gdfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782420035; x=1783024835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yx21f/fYo8TQI0aGf8AWSMgWBwIVqC4ciRZnA/Tpso=;
        b=MFsW9Q5cwGycDxFIv1uTpQRDOXbfcxY/EiDTQvSiLgo4ZYkMuB9Pmrc1+YsaqzfH1D
         9DCVPc+P0+adZtcH0x5OgqmsneY6rOu7C2xAeoz/m5QpVGfAmlgr5Iee/asJtZJjXFAP
         r2GIk8tOPNWGes2h8n+EIxfyWX9EI6UVGbOzfyCdzq4CverDDtos7ZVd/N+qmyeNUhB6
         nicRrE0+AYncynkQN7d8+DJlEjFaSRja+6yT8gnVcgP1ncGULueRNJ0sWt3PhrYfNkkv
         pJZZwkZCknfioGQTu+A6NaXExUgbBzpoRp7vSMmkhMueQW1rgIM/ept+nhUYO7dUyuhF
         1HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782420035; x=1783024835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+yx21f/fYo8TQI0aGf8AWSMgWBwIVqC4ciRZnA/Tpso=;
        b=WFFTdW3MS3hY3gkVkFt6tvsJUzpUEDqcoDA6EoMei9EqAW/BWvSGebdvc/Gh7sfl9g
         Ff9pCg5e0PgskRHkQOVQIMr7XHaYFzKMSyftQky2yOY6mOR36SvySUfEt2EEwhV/I7rK
         tv+XCaJKmk7/cOTKNQ8JA1x4eH4SlpgBnG6RJPSoiVdOALgguN6jhP73hTKSdlcVrBVs
         WA66YWKZ/y1ECUu1FoVg4bA4sU4PHmby2KQOJ+sOsX5MeWnUwRm2t/KRRAziCl8NzKrY
         1zE35LzyPijs85R8VhSWAgxDkLvBXLoXtf1fxk8A1vNYwi992H0Ub3IAZIgY1im1DD1g
         NzOw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7RFCyDz5snaVimY8bow9+p5DoT4RXVEG2ePXYmvYQ3TCMSH5tITjMwXjkyTwslnEqXf3lPEWR8JeytbvLJq+rIx8z8qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWiAZzuYkAz79K5iQ5iN7y1DEdQU2GQH+wJxjTIp9e5ag02CBM
	ezfle2MaTYDJ1MXRsMKEFXBkgljMmkWm2qYDBGnrBAeaYVXDGdhRG2ZXPCIAfsA1j+MX6F29BY9
	fioQxrXidBnQfgi2eyWoyZYHg2Vr6kWZopKmXTHf0
X-Gm-Gg: AfdE7cl6VgjUAJENnuQZ45zOq18ZNLVZ6MdhQTDjPY3yxUYiXxl+13TF17dUjs2EVno
	RBSljtGMTHYc9YmEAbm9d89tuv7SSqB7tCUlA3F0d9AtrPwUcQuwfq+OlNihgAsl8q3mEERDVaG
	TrEoHGFls5Y1Ig6WK4m8n+R2hXTdG7pz75ZRQ5iyHVi9BKreD6nIn0hvziQc5AFMNW5OhPJUAYt
	Qd9UpHKty0SuVX3AZqlpI7yNAsB5nyKfRCKPQN1scbxYy4KDYwH96lgbuKKfENlenPHNGm2
X-Received: by 2002:a17:90b:5288:b0:35b:8d89:719b with SMTP id
 98e67ed59e1d1-37dfa1739fdmr3601231a91.1.1782420034987; Thu, 25 Jun 2026
 13:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
 <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner> <CAADnVQKKr5cCYTj8qS7tU-Aeda1iexYUp5aquTjYXMEL656cJQ@mail.gmail.com>
In-Reply-To: <CAADnVQKKr5cCYTj8qS7tU-Aeda1iexYUp5aquTjYXMEL656cJQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jun 2026 16:40:21 -0400
X-Gm-Features: AVVi8CcDIUi3TCDxMODHgBDj-5EqkoBML23qr5aVxuP34LM8Xdw4wwqiCZTY1ss
Message-ID: <CAHC9VhSXXHGRUmJ4YjQ6uEh6dbq7+h_0TwWiV+W5dUWXCTFcfg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	linux-integrity <linux-integrity@vger.kernel.org>, selinux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 3:58=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> > On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> > > On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> > >
> > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically=
 set
> > > > xattrs via the inode_init_security hook using lsm_get_xattr_slot().
> > > >
> > > > The inode_init_security hook previously took the xattr array and co=
unt
> > > > as two separate output parameters (struct xattr *xattrs, int
> > > > *xattr_count), which BPF programs cannot write to. Pass the xattr s=
tate
> > > > as a single context object (struct xattr_ctx) instead, and have
> > > > bpf_init_inode_xattr() take that context directly. Update the exist=
ing
> > > > in-tree callers of inode_init_security to take and forward the new
> > > > xattr_ctx.
> > > >
> > > > A previous attempt [1] required a kmalloc string output protocol fo=
r
> > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSM=
s to
> > > > provide xattrs for inode_init_security hook") [2], the xattr name i=
s no
> > > > longer allocated; it is a static constant.
> > > >
> > > > Because we rely on the hook-specific ctx layout, the kfunc is
> > > > restricted to lsm/inode_init_security. Restrict the xattr names tha=
t
> > > > may be set via this kfunc to the bpf.* namespace.
> > > >
> > > > Link: https://kernsec.org/pipermail/linux-security-module-archive/2=
022-October/034878.html [1]
> > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > Suggested-by: Song Liu <song@kernel.org>
> > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > ---
> > > >  fs/bpf_fs_kfuncs.c                | 106 ++++++++++++++++++++++++++=
+++-
> > > >  include/linux/bpf.h               |   1 +
> > > >  include/linux/bpf_lsm.h           |   3 +
> > > >  include/linux/evm.h               |   9 +--
> > > >  include/linux/lsm_hook_defs.h     |   4 +-
> > > >  include/linux/lsm_hooks.h         |  16 ++---
> > > >  include/linux/security.h          |   5 ++
> > > >  kernel/bpf/bpf_lsm.c              |  10 +++
> > > >  kernel/bpf/trampoline.c           |   3 +
> > > >  security/bpf/hooks.c              |   1 +
> > > >  security/integrity/evm/evm_main.c |   8 ++-
> > > >  security/security.c               |   7 +-
> > > >  security/selinux/hooks.c          |   4 +-
> > > >  security/smack/smack_lsm.c        |  27 ++++----
> > > >  14 files changed, 166 insertions(+), 38 deletions(-)
> > >
> > > I have a few specific comments below, inline with the patch, but I wa=
nted
> > > to make some general comments too.
> > >
> > > The kfunc additions really don't belong in the VFS kfunc file, please
> > > create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add t=
he
> > > kfunc code to this new file.
> >
> > We expose a bunch of VFS heavy operations for various security modules
> > and this is really not different. For xattrs we have it all centralized
> > in the VFS and in general all VFS related bpf kfuncs should continue
> > living there and be registered there. Anything that's just bpf infra
> > specific can go to security/bpf/kfuncs.c instead. But anyway, it's a bp=
f
> > specific helper so it's the bpf maintainer's call.
>
> Completely agree. This is vfs related kfunc and has to be
> in fs/bpf_fs_kfuncs.c to make sure vfs maintainers review it now
> and all future changes to it.

*laughs*

Okay, then split out the LSM specific stuff into
security/bpf_lsm_kfuncs.c; all the LSM macros/defines/calls should be
in the LSM kfuncs file.

--=20
paul-moore.com
