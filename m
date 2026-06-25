Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29863672AF
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420297; cv=pass; b=Bqbj+cMlRJ2LMAgOL4/5QcnDNd/TaZNUSfMAF4K1BTa6/QmJ3HiYwD9olbRTEHDA3Nv36a9n4qCts8Zthonzwr3UnjQAlpmp/QA6JCUgQZ3Dc0g5t2+1FBe+ubCcEfr/UCl4avILDupkg26T2TO5ApgOJ8mpJrI0RCn1Z0BjJuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420297; c=relaxed/simple;
	bh=N9Dq4DwFj346OsehhL6Mi2d0QMKVNJTttDz0kqTp1YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn/CFvdcl45raJRmD4D9a4VdGiX0kSCeLQGFc73CGP/5ojCvaS4V7Sl7P+3CBgSqJRGzWwcC0fCQUWGKVUDnaUlDKy8xvv7ocIkjuEIpGg/i9Z4qD8ThipdSJcCBhIRb/cxPsbgfWMznB4wBsHKRleI7GF65/lL31r6ke16Gy+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVt9QOH8; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVt9QOH8"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8ce8f2e235so193551a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 13:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782420295; cv=none;
        d=google.com; s=arc-20260327;
        b=pEzrQeBLPfy06U6UUh3SA5am3EtdR2HJIEHLYJl89ImStf/RZtXapznh7H5aIHSxPs
         +GN1Eo7UD3Wpm7c+qI1izyPu/FePwJSb82+z90K6FRbM++b7y/5AjjGPL8tVTlrg4mBa
         TLSBDN7mp0KKLq0PZgwVdqFz8ufmhyMMRUM+fhr0slLmqZlCWGVy1gZ4DToc+c3pQvmR
         +jXnSJL6yZ9SmaYhnJ+EWxVKdKWrV3iFdxIlh7pwVP//LHZqRCcS/YyloTjeSIEeBx0j
         Co8mifTll4Ru26PNEYVwCl0igo0X2cbgHzY58BqJv7oBf4YDIlLxkIlaccGhLwVOgbKi
         uDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p4nuJamRLnRW/kvnyuggLvvM8UuA505yMAZohH7ph0w=;
        fh=3HdQyPjp1YpPLLKYkLtAukEESKVnvccaiF2FK08ZOpc=;
        b=s0RO7zBDq7OYG+vREpepDmvyN02zS1xrMPJtEuFIaE6ScJM0TSN561AKN1Vm2JkrMh
         b1reQg/6cdbC4zzAF3juAxycnAn+NzxlLn6DcKautTHrqbo1y47sBhW1ldXkuc7fIPLW
         vUvXiVkuSh73FvUXiKvnpxL98DOeo/DHa1Z+JZEDPsH2r/I1CavRKkdWUV+UxHF7X+Ti
         MIVFWWcgf4u7U6Ve5BvwtsTZ91Ae5oz2OKQQnV9p/HSpy4jlmziSYW0kYcZnXWKtRfoX
         WuYww6Vkvp4p2t+6Qvnue9daTT1ThB9sGfRQsYdyiDcaoL0z6TjcNXaO5qWiDsuAtDqU
         w1kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782420295; x=1783025095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4nuJamRLnRW/kvnyuggLvvM8UuA505yMAZohH7ph0w=;
        b=cVt9QOH85TZczzIKAW32WQbCke6oi2BzExTRrguWXJ53mLBPCyqikD/7rXtPYAYUE4
         RY0xEqimDJNhH/F/QZxsbtL2c/8Zct/VDrSkf17c/4VgQ518x5S+ao6WHbl6O8raGuVc
         IvuFjmRU97QWlC4wwkKSWHn0qi2wzUNT8Oe0hRoz3jXa/PAVLo7mYg1WKMfa0FrjHSuZ
         NCuOFwoRtUN2p/TrQ+uIoNs3dx7lNlnfIihxVAujVQ3NavHtOhH1KnY14YIV0RPZP371
         bDc3BlbBqVKeTW4+R9tCFGpP5eEVSBDqSQlZ+3MD17Rk14y9t75m1fL393UV1vgHlc0g
         6lOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782420295; x=1783025095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4nuJamRLnRW/kvnyuggLvvM8UuA505yMAZohH7ph0w=;
        b=TCzQ9hRFMlzr+3SJVTXUHw8pW6ZLl2EbTLPXDWM226ImSjZ7n6pVaUfWbzVgGpNEJs
         vAZxzhOqvGIeuzUwmv9T2U2aMV6AHeks7aYoMvD8S+TIAxGnKaRFjXd1/N0rjWb5Sm8y
         RF1Z3gV7XVVpWoHZIA00gLPCcASkfTsyx4lMqemRdt6E/Q3y1gcpoKL5GLTrC55W6ARY
         ZfO4rZUwsG6orQI2Yf7HGRbLR5FogGSsTg+uo85zZPBFS2C7NS7mOdtZBpZVqT9v1H+j
         HAN7n9OejbV1n7PVOFSx8K70UYxdq67IBNgLtkxyiFlIJjxAD5Fbz+ARoQJlX+5+vAZN
         fh/A==
X-Forwarded-Encrypted: i=1; AFNElJ85FUollcB37If4HlalO9N50mPxve3jg3DecZz91E8sBmxzAepSrCiQXEdufR3unNzC3pI1jg9DMPRjZfZaO17OomfedyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwabG9+bSyx0XyaPwpXQBVhDyLeWrQPTsYzHRf88KZjl7VYY6Jb
	JODJFX46SzUU547xwZhmoamWINAbciujY/4RbGGJKU7Nud1w+PVJU6XxwLaFOoyM+AesZ4JmCzz
	igUOS+dtGq/tw8wdFSDC3/zhlgRBeYso=
X-Gm-Gg: AfdE7cnMHZfsRIjBv0GtAhEnlFXExmlkViQ7aXd/PSTwb7UWW0ZGezhY916RNCc9VwQ
	p/zPH6ilhYvGgr7WiSgYWTaBzV3wMQAOuoQ4/Iem5MRIlYr8a8LQpDrQ7vCc0QZ+DRsuxzPGBYV
	+qXFCq/R/8ybemION73vdO4OLfcpOxsvYTcWCM5wLph3tAa2etQeUaQc+bNDhuH1XjYVncWcH3F
	wriJUEU4WrL4KS5krL1LztcsoDaa7xL5OwmIkjYzeT3bsyHjENikaohAqkLFtVymMpi4hyP3b41
	ZNp3zr3VQjFvA0fls2zsZJ64cwA53krMoZ5RTgj6JrTK1xtlRInVM9hH+4EIzePJ2Cjo3+teWWM
	EwDuwRKy/D26R
X-Received: by 2002:a05:6a20:144f:b0:3b4:84de:aa79 with SMTP id
 adf61e73a8af0-3bd4b064fcdmr5342275637.44.1782420294988; Thu, 25 Jun 2026
 13:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
 <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
 <CAADnVQKKr5cCYTj8qS7tU-Aeda1iexYUp5aquTjYXMEL656cJQ@mail.gmail.com> <CAHC9VhSXXHGRUmJ4YjQ6uEh6dbq7+h_0TwWiV+W5dUWXCTFcfg@mail.gmail.com>
In-Reply-To: <CAHC9VhSXXHGRUmJ4YjQ6uEh6dbq7+h_0TwWiV+W5dUWXCTFcfg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Jun 2026 13:44:42 -0700
X-Gm-Features: AVVi8Cd1aiwx-Wi0FGOZBeYqi53u50Be8i1kd9zEsWrT9afz6qquacMnoCzNbM8
Message-ID: <CAADnVQJM15E0PwomdTiz8zvVMGkqs9mTSjYRdPBF6fgE=tsPCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: David Windsor <dwindsor@gmail.com>, Christian Brauner <brauner@kernel.org>, 
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

On Thu, Jun 25, 2026 at 1:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jun 25, 2026 at 3:58=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> > > > On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> > > >
> > > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomical=
ly set
> > > > > xattrs via the inode_init_security hook using lsm_get_xattr_slot(=
).
> > > > >
> > > > > The inode_init_security hook previously took the xattr array and =
count
> > > > > as two separate output parameters (struct xattr *xattrs, int
> > > > > *xattr_count), which BPF programs cannot write to. Pass the xattr=
 state
> > > > > as a single context object (struct xattr_ctx) instead, and have
> > > > > bpf_init_inode_xattr() take that context directly. Update the exi=
sting
> > > > > in-tree callers of inode_init_security to take and forward the ne=
w
> > > > > xattr_ctx.
> > > > >
> > > > > A previous attempt [1] required a kmalloc string output protocol =
for
> > > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all L=
SMs to
> > > > > provide xattrs for inode_init_security hook") [2], the xattr name=
 is no
> > > > > longer allocated; it is a static constant.
> > > > >
> > > > > Because we rely on the hook-specific ctx layout, the kfunc is
> > > > > restricted to lsm/inode_init_security. Restrict the xattr names t=
hat
> > > > > may be set via this kfunc to the bpf.* namespace.
> > > > >
> > > > > Link: https://kernsec.org/pipermail/linux-security-module-archive=
/2022-October/034878.html [1]
> > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > > Suggested-by: Song Liu <song@kernel.org>
> > > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > > ---
> > > > >  fs/bpf_fs_kfuncs.c                | 106 ++++++++++++++++++++++++=
+++++-
> > > > >  include/linux/bpf.h               |   1 +
> > > > >  include/linux/bpf_lsm.h           |   3 +
> > > > >  include/linux/evm.h               |   9 +--
> > > > >  include/linux/lsm_hook_defs.h     |   4 +-
> > > > >  include/linux/lsm_hooks.h         |  16 ++---
> > > > >  include/linux/security.h          |   5 ++
> > > > >  kernel/bpf/bpf_lsm.c              |  10 +++
> > > > >  kernel/bpf/trampoline.c           |   3 +
> > > > >  security/bpf/hooks.c              |   1 +
> > > > >  security/integrity/evm/evm_main.c |   8 ++-
> > > > >  security/security.c               |   7 +-
> > > > >  security/selinux/hooks.c          |   4 +-
> > > > >  security/smack/smack_lsm.c        |  27 ++++----
> > > > >  14 files changed, 166 insertions(+), 38 deletions(-)
> > > >
> > > > I have a few specific comments below, inline with the patch, but I =
wanted
> > > > to make some general comments too.
> > > >
> > > > The kfunc additions really don't belong in the VFS kfunc file, plea=
se
> > > > create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add=
 the
> > > > kfunc code to this new file.
> > >
> > > We expose a bunch of VFS heavy operations for various security module=
s
> > > and this is really not different. For xattrs we have it all centraliz=
ed
> > > in the VFS and in general all VFS related bpf kfuncs should continue
> > > living there and be registered there. Anything that's just bpf infra
> > > specific can go to security/bpf/kfuncs.c instead. But anyway, it's a =
bpf
> > > specific helper so it's the bpf maintainer's call.
> >
> > Completely agree. This is vfs related kfunc and has to be
> > in fs/bpf_fs_kfuncs.c to make sure vfs maintainers review it now
> > and all future changes to it.
>
> *laughs*
>
> Okay, then split out the LSM specific stuff into
> security/bpf_lsm_kfuncs.c; all the LSM macros/defines/calls should be
> in the LSM kfuncs file.

Paul,

I'm sorry, but you didn't demonstrate the level of understanding
of bpf to be trusted to maintain any piece of it.
