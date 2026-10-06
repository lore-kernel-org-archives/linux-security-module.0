Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E946AA64
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297863; cv=none; b=f8zAqTvAnOY3v5RGg8NYGRvnO6+3F/jtkPEOO4clzisL5bNn5p+UjSyJuvFrgBzU9+t9xVmc6WQPxOhVSinth7/3BhyxUoDPjJlfQAvr4nmBiuk+Rm9tncszFsV87CqFHUrbcK3NkF4WY5Gw82zHtOs9mQcSES1We+VSVnt4PkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297863; c=relaxed/simple;
	bh=xg4nVjZgK3omQ3IqcCOJ6LqQ7bDNIMVw34gz+6JR8ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5eSVrSTsh9bdrOr2hrvJM9WwFU+E6r757Ro68EPRU8563Cu60LjsSUCEjgwS5eScg1gXWY/GqsBf20aFot9k2gbWGyl33aOQNAW3c9p1aaRQi6cjZH4eNKPjaeVb16Xv6++7rQLDrCr0X/X9nDXysUM8xXDRvfxJqk+MYvVf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik9V3upG; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik9V3upG"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-677d35fd1d2so2278950d50.1
        for <linux-security-module@vger.kernel.org>; Tue, 06 Oct 2026 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791297860; x=1791902660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z16WMQi6X5ulLLprpNpp5KM6uOsUPopslq1m3ekUifc=;
        b=ik9V3upGVtCUpR3/aqNSQoWBARrPlUwfBLwu7x9KrE+mVYYLpj3Ken17EWeqx60NaR
         +iMWl6b77TTj7G0ski4SJd9YphF139UwmUOg4RDR+H9b4lD7h3VHi6LDwRYFbFY7ZSxg
         fDjo2LixnKPlr6/BI03F0dIzO+XSdG8B5GiRIM2KYIWPw+9vSUTPyiktFHEq0VGBoF7p
         846TNxDBByd08hSOj971BuKfkxmHC0W83gGQYyEDLZ3dbnSWHrM6UwrTjQzI9Ko4uiZw
         SnK809V5siho6qbdricxw+82VnQlVUT07oJDRaFIR0qx/Inuf1uQMAKmybpOBqvd9tLc
         jkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791297860; x=1791902660;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z16WMQi6X5ulLLprpNpp5KM6uOsUPopslq1m3ekUifc=;
        b=MjlIuDD6VTsPOYhfjY/3ZM03e9yIZ7+IRoPNeaL7sY/1/VGk+VR9GssbyGhsWbb8wz
         H2dTsyUCNo7LZGsAy0J7ndO+ZvyDdY0RL/CtU7vug3RovjbTWhaw2nN5V4is+S+pfSG3
         ZWkYo3EUNH+2p5iiyKm/KnD/hRP3v4wyoe0rAvde6NIasiHDtPg+Bk6R26TR45bNsoN6
         OYBY6A57fW8MgIfwtvsFrmpbUiHFGtpcFMemxni94nzBO/7gi+0sXU5tMohS8BXhAkWH
         PGr60T0d1BWJBDm1tozaTsjITAUj5JQX+jPXzEL+Q8q8Ua4y5aApBtCnh8V4uyWU7F0d
         ehPg==
X-Forwarded-Encrypted: i=1; AKwUvBzfmF8ET0kF5QSMUowdGyWfTXhLSRIfoM8A8Q45DGSZagP8RvNwyw06RNadbPUeIDBTAgrVzC+PIb0+p7BCqW8ZY++8kf4=@vger.kernel.org
X-Gm-Message-State: AFuF++le2BSxDw6OL0g8GBqdVFfwoWdksM7AQGqmdTP6myY49oKDwcYJ
	U+80oZeBDUGLsz0r5oL87o7nFxgl6N8wvCPQn420M1eLjYCsISqN6m6K
X-Gm-Gg: AYBFou3GtAo21Ve2Fuy+4JWh9QIT+rM9MkgsZQrwmObU2Gy4OJx1aXifng8nSMJB2kC
	waXmg+cwt5RkpNGmWTZ6ZMY5uxlS+HCvqPCWQT3thgeatI42wSrmzy5RmMYJC0rFpE+1AV9Q9kG
	Q6ZXzS7w7brwTL1RsuRT6LMekO31DgF/kWnFjC3cQs8+Gz7Furilbnf/OcxuANcszlkELSXPtcC
	2SPuFbTThLkVZYeEURqHMAEkAtYhiuuBp3yt/i+O9NkkX6IMnceQqEpF8vQBtnSYW5YUkRt9yTg
	hjQpzjn/nbR/J2hh5g6O39DlKer0G0Th1VvnTQpJymPx5khjEObA7zJZ7XjbO13Y20l4h+zJQbB
	PkV8Gbe8D05NQrY/lZICtjnnCyj7k0TI87AGCZBrtgI6VBOM5q8hR109IA68wrYPF4Ju10byr8v
	NCjB48bgCrTsLdgDl/SRxnI/r4kGGRAvlh+zQ/Wh20FuQsp5FY2ZqjIQN/gVBbrgbNhCrP8hrgM
	g==
X-Received: by 2002:a53:ac85:0:b0:674:11fe:cb0d with SMTP id 956f58d0204a3-678fcf01225mr679592d50.57.1791297860190;
        Tue, 06 Oct 2026 07:44:20 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c19b196esm4642908d50.1.2026.10.06.07.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:44:19 -0700 (PDT)
Date: Tue, 6 Oct 2026 10:44:18 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	neil@brown.name, mic@digikod.net, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, song@kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, memxor@gmail.com, jolsa@kernel.org, jlayton@kernel.org, 
	amir73il@gmail.com, mjguzik@gmail.com, shuah@kernel.org, m@maowtm.org, 
	martin.lau@kernel.org, mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [RFC PATCH bpf-next 11/12] bpf: add a lockless path ancestor
 iterator
Message-ID: <asUBWNVtSzLXkXsF@zenbox>
References: <20261006002020.2890858-12-utilityemal77@gmail.com>
 <ea38d86f4c0b9e3a152efb949421d2af3bcc50c03c620780eddc90ef28a9ad51@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea38d86f4c0b9e3a152efb949421d2af3bcc50c03c620780eddc90ef28a9ad51@mail.kernel.org>

On Tue, Oct 06, 2026 at 01:10:47AM +0000, bot+bpf-ci@kernel.org wrote:
> > bpf: add a lockless path ancestor iterator
> 
> TL;DR:
> - Verifier may give a plain trusted dentry from the lockless path iterator,
>   risking use-after-free in sleepable kfuncs after RCU exit
> - A failed legitimize may look like a finished walk, hiding a lost race
> 
> > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > index 265cb414a08a..9dad65df4267 100644
> > --- a/fs/bpf_fs_kfuncs.c
> > +++ b/fs/bpf_fs_kfuncs.c
> 
> [ ... ]
> 
> > @@ -633,6 +656,79 @@ bpf_path_ancestors_pos_flags(struct bpf_iter_path_ancestors *it__iter)
> 
> [ ... ]
> 
> > +/*
> > + * Unlike the referenced variant, this hands out the walk's own position:
> > + * a lockless iteration holds no references to pass on, and the verifier
> > + * keeps the whole of it inside one RCU read-side critical section.
> > + */
> > +__bpf_kfunc struct path *
> > +bpf_iter_path_ancestors_rcu_next(struct bpf_iter_path_ancestors_rcu *it)
> > +{
> > +	return bpf_path_ancestors_step((void *)it);
> > +}
> 
> The commit message says that "nothing read out of the position may be passed
> to a kfunc demanding a trusted argument", and the comment above struct
> bpf_iter_path_ancestors says the same.  Does the verifier actually enforce
> this?
> 
> The position returned by bpf_iter_path_ancestors_rcu_next() is typed
> PTR_TO_BTF_ID | MEM_RCU, because check_kfunc_call() adds MEM_RCU to the
> iter_next result of a KF_RCU_PROTECTED iterator.  Commit 7ed5aa71ad77 ("bpf:
> mark struct path trusted") added:
> 
>     BTF_TYPE_SAFE_TRUSTED(struct path) {
>             struct dentry *dentry;
>     };
> 
> In check_ptr_to_btf_access(), the branch taken for
> is_trusted_reg(env, reg) || is_rcu_reg(reg) applies type_is_trusted() and
> sets PTR_TRUSTED on a safe-trusted field even when the base pointer is only
> MEM_RCU.
> 
> So loading the dentry field of a lockless position yields a plain
> PTR_TRUSTED dentry.  It does not keep MEM_RCU, so
> invalidate_rcu_protected_refs() leaves it alone at bpf_rcu_read_unlock().
> 
> The safe-trusted rule for struct path assumes the path pins its dentry.  That
> holds for the referenced variant, but the lockless walk takes no reference on
> the dentry, and an ancestor's lifetime is not tied to the original path once
> a concurrent rename moves the descendant.
> 
> After the program leaves the RCU read-side section, could a sleepable kfunc
> that takes a trusted dentry (the xattr kfuncs in this set, for example) be
> handed a dentry that has neither a reference nor RCU protection?
> 
> Would it work to keep MEM_RCU on fields loaded from a MEM_RCU struct path
> (for example by applying the struct path safe-trusted rule only to trusted
> bases), or to avoid exposing struct path as the return type of the lockless
> iterator?  A negative selftest showing that such a load is rejected would
> also help.
This feedback was repeated several times, and it's real (missed this).
I assumed that the RCU characteristic would propagate, but it does not.

Basically the issue is that the dentry is trusted even if the path is
under rcu, so it can be stored and becomes a UAF outside the rcu
critical section for RCU walks.

Two ways this can be handled:

1. Don't mark the dentry as trusted. (patch 4) 
This is the simplest fix, but limits the utility of this patchset
as you couldn't use the dentry for kfuncs expecting trusted dentry args,
including the xattr kfuncs.

2. Propagate MEM_RCU for a __safe_trusted field reached from a MEM_RCU
base. (as stated in the above suggestion)

More invasive and affects existing BTF definitions. I'd have to dig
more into this to see what this would affect.

...

Leaning towards 1. 2 can be a follow up series without breaking
compatibility (path* equivalents of the dentry* kfuncs would work too).
But if it's desired I can try 2.

> 
> [ ... ]
> 
> > + * Return: 0, -%ENOENT if the lockless iteration was not on a position, or
> > + * -%ECHILD if it lost the race to acquire one; %BPF_PATH_ANCESTORS_RETRY is
> > + * then also flagged, and the program has reached no conclusion about the
> > + * ancestry.  @it__uninit is initialized whatever this returns, so a program
> > + * need not branch on the result: a walk that could not be escalated simply
> > + * yields no position.
> > + */
> > +__bpf_kfunc int
> > +bpf_path_ancestors_legitimize(struct bpf_iter_path_ancestors *it__uninit,
> > +			      struct bpf_iter_path_ancestors_rcu *rcu_it__iter)
> > +{
> > +	struct bpf_path_ancestors_kern *rcu_kit = (void *)rcu_it__iter;
> > +	struct bpf_path_ancestors_kern *kit = (void *)it__uninit;
> > +
> > +	/* A zeroed walk makes destroying the iterator a no-op. */
> > +	memset(kit, 0, sizeof(*kit));
> > +	kit->step = 1;
> > +
> > +	/* Drained, or already failed: nothing to hand over. */
> > +	if (rcu_kit->step)
> > +		return -ENOENT;
> > +	if (!vfs_walk_handover(&kit->aw, &rcu_kit->aw)) {
> > +		rcu_kit->step = -ECHILD;
> > +		return -ECHILD;
> > +	}
> > +	kit->step = 0;
> > +	return 0;
> > +}
> 
> When the lockless iteration had already failed with -ECHILD, or when
> vfs_walk_handover() fails, @it__uninit is left with step == 1.  That is the
> same state as a referenced walk that has passed the real root, so
> bpf_iter_path_ancestors_next() returns NULL and bpf_path_ancestors_pos_flags()
> on that iterator returns 0.
> 
> The documented contract of bpf_iter_path_ancestors_next() says NULL comes
> "once the walk has passed the real root - or on an allocation failure ...
> reported as NOMEM", so a lost race reads as a completed walk.  The kernel-doc
> above also tells programs they "need not branch on the result".
> 
> Can a policy program that follows that advice and only inspects the resumed
> iterator treat a lost race as a finished ancestry walk with no match?
> BPF_PATH_ANCESTORS_RETRY is flagged only on the lockless iterator, which has
> to be destroyed before the resumed iteration can run.
> 
> Would setting kit->step = -ECHILD on the destination in both failure paths
> work?  Stepping would still stop (step != 0), the zeroed walk would keep
> destroy a no-op, and bpf_path_ancestors_pos_flags() on the resumed iterator
> would report BPF_PATH_ANCESTORS_RETRY.
> 
> Separately, when the source had already lost a race, the first check returns
> -ENOENT rather than -ECHILD, which conflicts with the kernel-doc describing
> -ENOENT as "not on a position".
>
This is also real, just forgot to add kit->step = -ECHILD on the failure
paths. ~2 lines.

Justin
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37395354107

