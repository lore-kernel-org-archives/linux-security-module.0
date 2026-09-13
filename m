Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB46437F8DC
	for <linux-security-module@vger.kernel.org>; Sun, 13 Sep 2026 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341910; cv=pass; b=CixrH/ANTVr5iHCIHIfRvlstoip0+86VWzd5jlKg4OW3koXZ86cVqbSF531H7g7Z4c/i+KfV7uywdEsv6XObkd/p6Y40RULns5r7gx4VvuKR9s2932un+uFCUzivHAgcscRan50axtWdDqPW7Iemko9ffNtA4YAiniyAx5NAVOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341910; c=relaxed/simple;
	bh=MKz9YMkBGISCMtma3zl4V6/L6vHskNHtuEKv8FNHu8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzzOVXUZnwwDB+gezC33+/hb37EMdskvyAJuifSqL1mJjQCOGWNmRNI7viiUnN9sY0o34fnqIHyXVs2kHnwJv5DI6wnlXbYnzpIcWVxIVTExVwXQ9MzyhPx8kg+HdJ7X3n0pG6QmUD7TKSl176KXLq/kyWSc5gZWujF9sy8xQ9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdcNQvqv; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdcNQvqv"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8623e5d435cso471356b3a.1
        for <linux-security-module@vger.kernel.org>; Sun, 13 Sep 2026 16:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789341908; cv=none;
        d=google.com; s=arc-20260327;
        b=X2Oo8sHCSkk9XaBiJufvQrJkLp7JqAhixyyvvtvtUIC3FXo34vo6SGjP+cuSAmqNqT
         j5hmY6EgX/7rQ5ycpsbwBPeINF/j17nxnIgdE4lZXt3rLk1VeRk0kmzTdV2Hb347zeq5
         x4ICL7qZOgJ+zJfEOscZgyZgnAXPamiMfeLJISQg114Fyc9GlU5cQDYMXILUZCgpo1LZ
         XXWcniRmakIqjuazMxORqrfulsCCinRNR7yrvI3CY7qoWgY4t9zsDGKq67y1DJyxLWpF
         8Ej1SvcKFfkE5OMOlFvL+3qs9p0213ZADxz1xO3Agu8F0hZhaz1FD2/amFiZ+Jy9gTFU
         dEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pbPc/varaxQSoxoCvlzbtZpSK7urW4ExB0j1Yox4pVo=;
        fh=aYoiVrWZV6W5Q15VLdNIi/tB9H3S3/EOZk0xVXQrr+4=;
        b=aHMQVE2e6wQAsXzWX2bT031cJBmyAIxj4J2yyWwjJIGX7sr+B6/J4bxlunFOegKuhQ
         NuM/+5GhSIluIY5/nJ5lWJEfZJdGYHDjS3cdtoxw15dpF5p7vkiceZKTvJBADWnnTSyA
         vU0B3SyRJXa1/8P4T/xd0WtIK8Bu+r0Jw7EFjN94JB4DbEZ1lpMzXkVyQH8/iKD5IKL4
         CaAmOY0U7FVW2Cqpt4egMniI+z0qiPl/hBsq5O3DghO5zyLVAUFwmjEzyXqgYJ3LHVl2
         D+CWF7qKFPXqexJu42ps+W9jFLjeTHHoIijZZhEjnTpyPverDlb6d/3BuTj9NdhkERfP
         qT9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789341908; x=1789946708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pbPc/varaxQSoxoCvlzbtZpSK7urW4ExB0j1Yox4pVo=;
        b=GdcNQvqvWwzquJgXATB7kfNOSBVXqpwZjNMNOmOLbnz0ldHeslnRK4hic72ZE6oMun
         j0UC1uJAtCxu/RtUqx3a48H9RqiknvMPC/qnc892eLGXJPITtSWmP8PVhhJlVbU6P7Tf
         Y1QZOZc6g4xrYqKwTDuq3vreKroCNZenh6wbkDL4djFzwJYR7t/9F+yQ3GMPHAKFAheX
         5+hKGTS6VtDjMns8RAs/X54vgQJ4yDJ98hocOuPqa13IM7OebUb3n11GwWaAHF6eld2R
         eclqt386plu4Uw3CVp64recHkjCK/Ez8iNbo6OakvplDIX+YKRJgZfNDf22UfYb5sOLG
         ZKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789341908; x=1789946708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pbPc/varaxQSoxoCvlzbtZpSK7urW4ExB0j1Yox4pVo=;
        b=mHIFNT5XFNT18QgKJHaYnQ5Rxm1RguYeTbQ8mkQMrpOGm8OOru/0qUZ6TvM9rntCfP
         T5g4GX9p05HGqai+Tdqx7g6W+pHIliNJTNTgdRH/6yAzAb6DdTTxmsnWymez3oQg4lYM
         dB5CqV12XXavc0dbAZkanI6YfzrKy8JYOvgXqf4TtBvecHTTtCvFT+ljDqdrAdJ0H/iv
         r35RpaCqJC6hrc9XlQuvEgNd3PHE4B3XB0DzRoCl8ApS5c8eJd4sszybuL3iitaSY2SL
         psGlKoboWmzRO8X7hX9DSoifClyToaESA0eFz/vy/91thl0iLjSwuzh/66NrYTqzdUFy
         itBA==
X-Forwarded-Encrypted: i=1; AKwUvByitEv+phQJYJIpc1JuKwD/tJv6ybPHdqQNvt+NSBzAKwN5vBPKLYy+qYzgihmSr+Mvm0cvbiewOFHTU71u62KQ6sWHbHk=@vger.kernel.org
X-Gm-Message-State: AFuF++mD7vn8BvR+dOtcg47sWh75dMb46SQ8RKi0BhAEId1oXpvn4U0x
	+48BqrQFHf8AOHRxttd4LZEYxCQ+3U0Vli5GzPYa5KznF9xdQaV3zr+anM9EHRkh0+faD5O3jqF
	yZeS4VEALT5YoZ/AOpWK4vJKhGysd4F4=
X-Gm-Gg: AYBFou1j4XoyqhuvuOWZdjpu2ybCmERg46cjiMUbKg9l9IUh3zY3JxPqHwDvEcTWPjH
	ebZG1drlBcVab80UN/iAgLK8NS51dCxCWWZajOc/ckCHEsWGg23rUVfqc2youhAF6lWeGhKHgFz
	3jEB1XZVKgwz8t/0wRgkrypOYVG4q2RQWFcg8jIv9xRSCeM5iJ2ZEkqOWw02fp1ANnyTDkh0cp9
	mSqaMEh++es+vS5q9QIXangXSuxzwAc5IPI8tkMYgeTrFHVwUmJuzcxlmEr7F2peDRJivahAEbr
	ApeLp1/p+mKY00cA2zW4nYaack184gUhmtg79XOYXY4sEbHQGuzTM2zERD/hroC7FhlTGnp5MHo
	kqbnnN61XR5rha74L/MFJmJodfIYlgSMiiaBZYr8=
X-Received: by 2002:a05:6a21:4c0f:b0:3d8:effe:34f2 with SMTP id
 adf61e73a8af0-3db3f1e2442mr103161637.12.1789341908038; Sun, 13 Sep 2026
 16:25:08 -0700 (PDT)
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
In-Reply-To: <CAHC9VhS0JckwfomqLTUJkZZkDSgeRXYOjMmPQYErgYynQYqMKQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 13 Sep 2026 16:24:56 -0700
X-Gm-Features: AcwNN1U6X57XXPgvs7wBUo1AVpm-fnxQGl3Bt0cNbgPT5Dz1tG3b1h2XibzcFQ8
Message-ID: <CAADnVQJCJjy9Eiwn6-88c0iOk4LfgPU6KBv+w0JZdBzmXBMUCw@mail.gmail.com>
Subject: LSM boundaries. Was: [PATCH bpf-next v3 04/15] lsm: Add the
 bpf_lsm_policy_release kfunc and policy object destructor
To: Paul Moore <paul@paul-moore.com>
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

On Sun, Sep 13, 2026 at 12:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Sat, Sep 12, 2026 at 3:33=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> > >
> > > If fs/, mm/, drivers/, net/, are permitted to have kfuncs, then why n=
ot
> > > security/? kfuncs.rst doesn't seem to forbid this.
> >
> > because fs, mm, net see the value in bpf. bpf helps these subsytems
> > to focus on their core technologies and moves policy decisions out of
> > kernel and into bpf.
> > while lsm people treat bpf as arch-enemy.
>
> It's amusing to read this when just this week we merged a patchset
> into the LSM tree for the benefit of those writing BPF LSMs.  If you
> look at the discussion around patch 2/2 you will even see a reasonable
> exchange between Matt Bobrowski, a BPF LSM maintainer, and me about
> the patch.  Alexei is obviously welcome to his own opinion, but I
> would encourage those reading this thread to look beyond his comments.
>
> https://lore.kernel.org/linux-security-module/20260904-lsm-mount-idmaps-v=
3-0-920a1963675d@amutable.com/

And that's an example of unacceptable land grab by LSM folks
that I'm concerned about.
security*() calls sprinkled around the kernel are not LSM territory.
It's a decision of subsystem maintainers to pass more or less
objects into lsm hooks.
VFS folks could have decided to pass a subset of the object to
avoid exposing internal details to abusive LSMs or, as in this case,
they decided to pass struct mnt_idmap as well to increase
visibility into vfs operations.

Paul,
it's not your call to ack or nack their decisions.
Your job is to review security/*.c side of changes
and give feedback.

The needs of the kernel subsystem are far greater
than all LSM concerns combined.

Daan's patch:
-int security_inode_create(struct inode *dir, struct dentry *dentry,
umode_t mode);
+int security_inode_create(struct mnt_idmap *idmap, struct inode *dir,
+  struct dentry *dentry, umode_t mode);
 void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
  struct inode *inode);
-int security_inode_link(struct dentry *old_dentry, struct inode *dir,
- struct dentry *new_dentry);
+int security_inode_link(struct mnt_idmap *idmap, struct dentry *old_dentry=
,
+ struct inode *dir, struct dentry *new_dentry);

broke a bunch of production bpf-lsm programs for many companies.
It's annoying, but I cannot complain, since it was VFS
folks' decision to change their hooks.
Pls at least cc bpf@vger next time.
If you didn't mention it we would have found out about
the breakage only during the next merge window.

Anyway, back to LSM's land grab...
Because of LSM people's behavior, networking folks dont
want to add new LSM hooks.
It's really starting to feel that LSM hooks are like
tracepoints of the past.
They could be in the way of subsystem development.
Hence it's important to stress that it's a subsystem
maintainers' decision to shape LSM hooks in their subsystem.
Neither LSM people nor BPF cannot nack VFS's LSM hook changes.
