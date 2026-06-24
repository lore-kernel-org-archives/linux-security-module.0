Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A83E5EE4
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jun 2026 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336190; cv=pass; b=onrp9XZMUky13hePUTYjTSRNM7rYQY8E5Hn/hkIsTq+GhhlwrRNhBqRN/ALDvDHvxzjhwEIH/OzYyH+qBOKcrFZYIEXVYKZ+PvNxjpgFhj2z+5chjr3P7XuITUH3Vh4svlSDM/vfbv5rmoK4B5GiaAr7/o/aJMvu5/lr/DxWJzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336190; c=relaxed/simple;
	bh=e8FKnMxnQE6EcbhtFXm3u/ZDFx7rumJIKaX/xozB5Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNdZKSmw/HtG6CrbKvtWONI6JZpj+O9xcrgdAQkapNN0O5ymIKx9LpUtg4kLlbxJvYpydh7dSObf/KJXiFbJoQL/jsSSbyN6umjoClsJveWeQaLfDb3bUk3XpCklYyiYLkzivyl+50ibs+Vlbx0sJ9Sx9I+r3wZTh4AVZJdsclo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=raltZR9i; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raltZR9i"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8e066990fb4so16313116d6.0
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jun 2026 14:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782336187; cv=none;
        d=google.com; s=arc-20240605;
        b=OIBE5vEX9ZnpxbFpkeOa9i1e3c5uksWL9T8MEPzkcR9vtiQge4Hx47NYbAiQEbSJ7G
         C8ec9XjbSh/WnOVIStuNxXMvP+wS31kqm3IcFsan36yknqWF7e/PAUaZY6inRPMzJXtF
         sLL7TtXl1wVtMiQ9IbLmFeGvenTEtB6De44oZuSJEghUgmzG62UJi/Bh7vseGF66pVIa
         ycOTULxFb7zsZNps+XT3POwXii3ATCm9pHAmMpGUbO9NL4eDCDg/t/lWZH9dyDzAfhmZ
         oPKqSogMRVvZS4E9iPDs2aeBDD1FIWGmgYn50HtzxW3C1eRIVbbeQSR9HcMtpAJtbz46
         ac1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qSoqZHCVaW6be7/8vwIAP/8yZ9kR/NSjkqmErBuSEOM=;
        fh=ksjUB03MYY2bzuh8J7hi7J66TGsMbyxW1CbP96Ts/x4=;
        b=SXH6cBHNCrvTjJHn2IycR98PjtQIU/XquiSUvQ39AUc2q8EOdyfzJMG0o/45zdXvQK
         miU/sEHsP0YaM93BFXtyQbth/8urvWubhPBanRzvgdQ/pfD88fyFuDURx/5v1wna6oxd
         kvtBSbk62wclThWTGTIGrSPNAXYIx9R7pGtiwljHfXWtC8ZCZvLCJdjXeCNexCXgUNKY
         J9KB0ethmzQk6X93azCnckjQreSyX2JuliYrUL4OQMJjEWWl58lkR4smBxHdokAplwZ2
         AlrH3giXJE51e1XCKKdczV3TVqsVZequL89zNeT0w1Wmwts5YHnkDhQp4EjkLEB55PTJ
         fznA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782336187; x=1782940987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSoqZHCVaW6be7/8vwIAP/8yZ9kR/NSjkqmErBuSEOM=;
        b=raltZR9ix+5bTVcUNHjV/cKP9ZaG1gEmiC+WOxk/Bti6+RV+yArkBmKtnOStqlTsK/
         ae0P9i68bhil7Gs4F75D7Ra/1LP5Go/rBmccFGT1/FGT3CL9Sf28c0p0p23wUlHO4TRt
         8bT8mMwUWidmP36ArLQDRrfkHJwY6KobR9od+7qm+0rMKRJMpZl1+0ZNwZaTG2+F906I
         faqY01BZpg+808056MwqrwGc+i3OLXcjjfzyCxwtH2i9+NtMhOXCQQh4i1Kx019DCs+u
         LrpW93yC6yNCe7eBQ9XrMxHxEChoF7qARpla1T2YvZlr35n1Yuk3SpCk2niUFbYZcner
         +WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336187; x=1782940987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSoqZHCVaW6be7/8vwIAP/8yZ9kR/NSjkqmErBuSEOM=;
        b=D0Ca3tYC3f4AoNhxcP86SDY/baXUDcOBsILzA9G2+fbwfDi6roElZJ04L+i+la+9Au
         TPCsT+JO4skFcjXXZzXjRUjoeIn5KbpbMZwhrpeprjZdWfdny+qByLKwyUp+avGxyYw0
         BJe/yQoZ0I1jpZFXLtJrKfNxZGeNLLy9UQ+6r4yXQk5qm8GQP/q4hHqncoBL2jhwiN5b
         cEPdcdtg1e96RGK6t8oWBmMfT8J8hZy35XAmHB2QtnmFkH8seasR3jFPwgJo5XJvQ92x
         SqCt1vTQfaitvfTqzibNqPbI/DBAdvJiNmXieGw+lAW/teHLludqsrX3n9zrdk1WJt9p
         j5/A==
X-Forwarded-Encrypted: i=1; AHgh+RpnIssx3FE//h9XGzCmrBOOPuLvOvvThBkt0sSlb3wqCvFcc+Vhff8TKq2Lq9y++xak8gT7zx56nsUKEd6MPTdxhwrt7nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEobSjrygFBShsmU64gQtXcQS08yo+o9rzElTXTFWWqA8uhOR5
	KU7euTIqw0ZWFViDq/ZZlWrAW6BnFL4ci8iaVesiX3/N2FUNSQrj9K5/fsxUQA4ymObDk7YHdG3
	Csg3g3J0+xXwAdaWApauDqnbNZfhScwU=
X-Gm-Gg: AfdE7ckOLxSfJkk5sA1EDPJC+yWT749ew69Mu27YeLnVGXEL3lCqW3R6NhvN4SUCTWP
	88twvBXO8NeyK+rdlAJK4spbImSqK2TkkdOdGD2lRhz6NNyTjm++bSMTd3JLBvPQw3vqQ/4enRw
	2s74N421MIb6w7Ybln4BYPHxBU8isi8hJHquoeTp4RhKW1Ropyze4NkQpluKZi8K50o/M/DiLMa
	ERVvt+Rhow+8mGDmyFdAQlSK3LLY2wEAv/vwREEaiyV2uJOD0qtgu1qtSE1PqbDsIHfd4VyCSkg
	EykglH/vVpE5VxiysMTkv9rYi6Q=
X-Received: by 2002:a05:6214:cc7:b0:8db:736b:b2fd with SMTP id
 6a1803df08f44-8e402a51b48mr148834946d6.26.1782336186403; Wed, 24 Jun 2026
 14:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
In-Reply-To: <75d39fd9847cca915d704235264ab474@paul-moore.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 24 Jun 2026 17:22:54 -0400
X-Gm-Features: AVVi8CdrIOcn7xbcClmMBTsg427tmja6_i0WQl1k6YwRkJtqaPChbJXPc9S5D7w
Message-ID: <CAEXv5_gSOoHnVn9bKsCdHB5aR_tNHRZ+m2trVcYNmbtS-K=4fQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, jmorris@namei.org, 
	serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 8:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> I have a few specific comments below, inline with the patch, but I wanted
> to make some general comments too.
>
> The kfunc additions really don't belong in the VFS kfunc file, please
> create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add the
> kfunc code to this new file.
>

Makes sense. I will also do similarly for the selftests.

> While moving the kfunc additions to a LSM kfunc file does sort of convert
> the VFS changes into LSM changes, Christian's comment about splitting
> this patch two patches, one with the LSM hook changes and one with the
> BPF additions, is still reasonable and a good suggestion.  I would still
> CC the VFS folks on these patches and I would encourage reviews from the
> VFS folks as there is a VFS component here, albeit a somewhat small one.
>

v4 will contain 3 patches: one to introduce struct lsm_xattrs, next to
introduce the kfunc, and finally the selftests.

> > +
> > +static int __bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> > +                               const char *name__str,
> > +                               const struct bpf_dynptr *value_p)
> > +{
> > +     struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)v=
alue_p;
> > +     size_t name_len;
> > +     void *xattr_value;
> > +     struct xattr *xattr;
> > +     struct xattr *xattrs;
> > +     int *xattr_count;
> > +     const void *value;
> > +     u32 value_len;
> > +
> > +     if (!xattr_ctx || !name__str)
> > +             return -EINVAL;
> > +
> > +     xattrs =3D xattr_ctx->xattrs;
> > +     xattr_count =3D xattr_ctx->xattr_count;
>
> I'm not sure why the "xattrs" and "xattrs_count" local variables are
> necessary, especially since they only appear to be used in the sanity
> check below.  I would suggest just using the values in the struct
> directly.
>

Leftover from the previous implementation, will fix.

> > +/**
> > + * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_=
security
> > + * @xattr_ctx: inode_init_security xattr state from the hook context
> > + * @name__str: xattr name (e.g., "bpf.file_label")
> > + * @value_p: dynptr containing the xattr value
> > + *
> > + * Only callable from lsm/inode_init_security programs.
> > + *
> > + * Return: 0 on success, negative error on failure.
> > + */
> > +__bpf_kfunc int bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> > +                                  const char *name__str,
> > +                                  const struct bpf_dynptr *value_p)
> > +{
> > +     return __bpf_init_inode_xattr(xattr_ctx, name__str, value_p);
> > +}
>
> I'm sure there is a reason why you split the code out into
> __bpf_init_inode_xattr() as opposed to just putting it directly in this
> kfunc, can you help me understand?

Not sure, perhaps prior convention, or something with the verifier
perhaps. I've removed it in -v4 and everything works.

> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 153e9043058f..1f8e84e7dd7e 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -68,6 +68,11 @@ struct watch;
> >  struct watch_notification;
> >  struct lsm_ctx;
> >
> > +struct xattr_ctx {
> > +     struct xattr *xattrs;
> > +     int *xattr_count;
> > +};
>
> I see the bots already pointed this out, and you acknowledged it, but
> since I'm looking at this I felt obliged to remind you once again about
> the rename to "struct lsm_xattrs" :)
>

Yeah, sorry about that. =3D)

> Also, looking at this closer, is there a reason why the "xattr_count"
> field is an integer pointer and not just an integer?  We're passing
> the entire struct by reference to the individual LSMs so we shouldn't
> need this to get an updated count in the caller and having it as a
> regular integer should simplify things slightly (you could also
> make it an unsigned int while you are it).
>

Copy/paste from v2. Will change xattr_count's type to unsigned int.

> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_tramp=
oline *tr,
> >       }
> >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> >               return -E2BIG;
> > +     if (node->link->prog->aux->attach_limit &&
> > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_limit)
> > +             return -E2BIG;
>
> Re: Alexei's comments about this - if you look back at my previous
> comments, my concern was around BPF LSMs using too many slots in the
> xattr array and causing issues.  If the BPF folks want to do that check
> in the kfunc located in the LSM framework I'm okay with that; the
> important part is that the BPF LSMs don't use more space than they
> previously requested.
>

Ack, will remove this attach-time check.

> > diff --git a/security/security.c b/security/security.c
> > index 71aea8fdf014..8f82a1352356 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1334,6 +1334,7 @@ int security_inode_init_security(struct inode *in=
ode, struct inode *dir,
> >  {
> >       struct lsm_static_call *scall;
> >       struct xattr *new_xattrs =3D NULL;
> > +     struct xattr_ctx xattr_ctx;
> >       int ret =3D -EOPNOTSUPP, xattr_count =3D 0;
>
> Since we have the xattr array/pointer and count in the new "lsm_xattrs"
> struct, I think we can remove the "new_xattrs" and "xattr_count" local
> variables in favor of the fields in the new struct.
>

Thanks! These will be eliminated in v4.

Best,
David
