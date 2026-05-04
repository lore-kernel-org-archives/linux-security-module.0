Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80533388377
	for <linux-security-module@vger.kernel.org>; Mon,  4 May 2026 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934562; cv=pass; b=VnMy5UWrOBxhvmQnTFXXGpNiXO1QCHR35t9NQGZQTizrZMHDRUK8F4XgU58SOvxM/4NhcXr1NrIdXoS/D0wJgvEE11v5gQTgIc3WeDYX++v9wOoGHfBkdELnnloG3iwshSRuNZSuQVLfNjx0F/XqlfrtoLipezUcpWXr93nLpj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934562; c=relaxed/simple;
	bh=jrK/HiPlfROzpLQwuaupLlvkZBTy1nkn4zGH4/MZ46M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyaKfvgvDFU39WStUWYrPh9y3kfkr44Bm8dzWYRkSOCuKlDxVNt9shG5I9wEl64/N3+we4HVq9FNOoBT1TK2OZ/GZZfTVmaS6eKsz0Y6+oSbsIKtYGVyMuN//Gm6QZBUA4d0xxfv+ox6VeKgdnHl9qAIjAyRbm1+DDu4HMiwnR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UGi3Z9fJ; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UGi3Z9fJ"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8173b2af32so1090068a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 04 May 2026 15:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777934560; cv=none;
        d=google.com; s=arc-20240605;
        b=f2BKAS1SQa+RldIHtYCkqn/HxL29J8MRwJVTha7vpyuo2ILvcqPcn+ZxiyxAaPt/p8
         BBa85sesGpfyayQvGqGkb1f51AA4EA7G4P5upb8MCdihIJoPCGJ4tVB6PSxS8v0Tw6H2
         FJOHiU2USOpHhy/dOvL+DXKrubIzSCoxtsV/OArvse0UEJ7wiDnXTXPMlyDygw7M5CZ+
         fmI6jB/JICpZddFyEarpQvQd9Hat5H1ZUboFuieWyxEO+IqlYqz19EroS9jN8FJIjRQ8
         e83/g4+ix/dpAA2EGRG7Vy29+0p1uzwA2R6ZiQAmIzWsl2ZhxWLD5og9jSYkem1BJYEE
         +G6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IXBRZAGpUpDHDZmPqiOWgzQrVjT26h5rDl2WnSWzU/8=;
        fh=uIlIQbu/FQ+HMfAlGUj2ZW1xTlc5g02owXZx8yhlJNg=;
        b=ENKskW/6QJoxNHC1xRsFjelqJleP7SR3mcLRrxvjSOzFQZEKCCXCBay2jBh7Yt9otE
         ZJzmYzvhQAav/n+fqgOgoYPXPHsx2/AfNwBLV+i09LZUXM30u2Az3Ohp3hAvnjE3PjeK
         +NiXGBy2JsIltPX6zNdxCyE6n2n/sXiTmmPCuYq7c/Ubi4ldUw/F4ewKq7AqoC1Bhfqw
         ic3IPgYAIWY0zBMTSmmyjJVUpJKNet66v+0OPGvasK7VNm6AYOVm/f5luUisPvGqymaT
         MPE2g2zUsbyRFlJlHoN3GMQ4ZE080IMZbdt/KG/QsOExG+7p4ZzjlgScm43pRB6mB3f0
         9dCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777934560; x=1778539360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXBRZAGpUpDHDZmPqiOWgzQrVjT26h5rDl2WnSWzU/8=;
        b=UGi3Z9fJLfezyp0OJDVLLNFuIoLRa1wo0OTjff6UNOlY3ZRdPTNMPdO5YcjAc9iyOl
         agb1F/QUPJpTdLppeZa1vhhJ9CJWO6vuQAz0W6fnIwxs5/92na+qXx0bY7Z5CTFYp03C
         R6WaF18KHUojniaVITwSsnJ5fWLuAfuz1zDC+ZAacmzaXr7bNbFx7ZunXCjlp4VWhZ1l
         EfeBeF12UbEmxFtdekM345BWt6iU0Hf51Fujf50LqcFVmZoiCpoNsAgG6AojobDbZAxh
         x8ZpGDJ5PU+eN39u6K/ADsd6KozqsTsvdp6jpJI3RZbXjlm3X+o0N1H1nwDGuQonit9Y
         0kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934560; x=1778539360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IXBRZAGpUpDHDZmPqiOWgzQrVjT26h5rDl2WnSWzU/8=;
        b=YhjCnkmECqS+1apD7OxLjetFmWKYHSjZ1DuxbZ4dmMkK7U6+zx17n1MBi+7TmhxUV2
         TCSN6g+Sepbsife0IkI/NxjvyB0M5rdvicpkJkiXTgkVQkf1xLydT3VxiHBIxPmUGOoi
         P2uFkmePlHycDYb55kAFtdtvP0fl3Ee0Gn8DZ1iofnFffQLgpOfcFBnHL8vBnXosVWWG
         YyRIyZukaHnoFjQaZgoAWWK1NSaEG/Hpq9YW0SMyxQ4Tghjehk+hD6morK8kQ1XQtlal
         ckF+naXkXuakbhpcsYJVGCIL+OPQn5bHmfhqJvBTPhwP/xukGWQrNtrwJICn+a467aVc
         53KQ==
X-Forwarded-Encrypted: i=1; AFNElJ/W1TqvxiABp2FKGKmYiGIKrzv4gW0qZWfBQmBxyzbkk22PeRq/GTctH87fu0DnwomjbnyXDC+wOXi9dFTni1lnBKEg8gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiRB1Pz2R/e+bmHskALADOIjgDFLiFnUS/SbPZ9ENpDftDDPxb
	+azifj97ONlQNO3B+bFx8+tIzqfBgbFxY/Wg5rFLNcipJLwcj99JpO9qO85WzRnDRKDQNg42RwH
	moESMx3Ik6R300oPNBXfhHOFWI2Cpfmz9mGWUHy8f
X-Gm-Gg: AeBDietCMToswCWCHCDt1MXDxeJ6w/0ZNd2lHzdq5OcJFefDOOYbf8qLjG+KEdnFLTk
	a3cBH8QEncLc2IhgDxJiTdSum/Mc8zPX9pB37SE7q3iZXKFOXbXsZwO0F0O2wtjEk5FE0Qm0lAC
	2GIMATk3wjLb4vq2g3+DCMIgvDZaTt5cMx1LCRNAV6NbfyLzo2iVaGmCmuHt5zg38h3W3+IUTCN
	maoa9P5a++z5OdAzzr1/DMucksh63mNNoDYwqeqEBtvnEnScRlPqQeBfwKI/cQCCF9qI91iBaAj
	vWnPplJ3956xzOl9og==
X-Received: by 2002:a05:6a20:7350:b0:398:7792:3882 with SMTP id
 adf61e73a8af0-3a7f1ad975cmr12466464637.16.1777934559848; Mon, 04 May 2026
 15:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com> <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
In-Reply-To: <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 18:42:27 -0400
X-Gm-Features: AVHnY4JwC15TGqrqFYxmzxatkMEXynJIr-3OCdScUP6s2DMx5Fh0pwblgffVK-0
Message-ID: <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 5:40=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Mon, May 4, 2026 at 10:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> [...]
> > > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > > index 9d27be058494..193accc00796 100644
> > > --- a/fs/bpf_fs_kfuncs.c
> > > +++ b/fs/bpf_fs_kfuncs.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/fsnotify.h>
> > >  #include <linux/file.h>
> > >  #include <linux/kernfs.h>
> > > +#include <linux/lsm_hooks.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/xattr.h>
> > >
> > > @@ -353,6 +354,97 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgr=
oup *cgroup, const char *name__s
> > >  }
> > >  #endif /* CONFIG_CGROUPS */
> > >
> > > +static int bpf_xattrs_used(const struct lsm_xattr_ctx *ctx)
> > > +{
> > > +       const size_t prefix_len =3D sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
> > > +       int i, n =3D 0;
> > > +
> > > +       for (i =3D 0; i < *ctx->xattr_count; i++) {
> > > +               const char *name =3D ctx->xattrs[i].name;
> > > +
> > > +               if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, pref=
ix_len))
> > > +                       n++;
> > > +       }
> > > +       return n;
> > > +}
> [...]
> > > +
> > >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfu=
nc_id)
> > >  {
> > >         if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > > -           prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > > +           prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > > +               /* bpf_init_inode_xattr only attaches to inode_init_s=
ecurity. */
> > > +               if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &=
&
> > > +                   prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_=
security_btf_ids[0])
> > > +                       return -EACCES;
>
> We need to mark bpf_init_inode_xattr with KF_RCU (requires a trusted
> pointer), then we can remove this check above.
>
> > >                 return 0;
> > > +       }
> > >         return -EACCES;
> > >  }
> >
> > Perhaps I'm simply not seeing it, but is there a check to ensure that
> > there is only one BPF LSM calling into security_inode_init_security()
> > at any given time?  With the BPF LSM only reserving a single xattr
> > slot, multiple loaded BPF LSM programs providing
> > security_inode_init_security() callbacks will be a problem.
>
> I don't think there is such a check. Also, a single BPF LSM function
> may call the kfunc multiple times, which is also problematic.
>
> I think we will need to make the default bigger, and also introduce
> some realloc mechanism for the worst case scenario. This should
> work, but the code might be a bit messy.

Thanks for the clarification, that is what I was afraid of when
looking at the code, but I was hoping I was just missing it.

Increasing the default is an option, but I don't think we want to
support a dynamic reallocation scheme for the xattr slots, that will
likely get extremely messy with synchronization between the LSM
framework and BPF LSM hook registrations as well as special code to
handle inodes with lifetimes that are disjoint from the BPF LSM
programs ... I suppose there may be a way to do it, but it will surely
be ugly and come at a cost.

--=20
paul-moore.com
