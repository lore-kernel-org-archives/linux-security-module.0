Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645528;
	b=ySXsPnAkh7dKozsmRwPXQQZBW9BcZaRogMnjJUcKKLjxkTYN66tsq8wDz8EugeL+zqhP
	 b0F7dEbp2Oer2oTdObd43AHCDIpO5B/b/42Um2+k2MaRMAkFL9Ar/mXEEn7/CjSveQY1L
	 /VOnVEMXWaprjDqq6dA5Fi2ui94ERivv2ngAeJjhRpA0P3RmFsKuEP0IZ8LldiIYCYOnA
	 ML92hKy2p1ajlNs0RTjPltKxloRxOg7CW1BwG/mugnDng8792dOAhPmnCHVPnu9VwkO4V
	 4ZFgR/lC9NZgRAY393kYBfRnp8HE836UsNzFUT9t1KeyDkFrC/ircdJj4k+nYSDLA5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645528;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type;
	bh=DAnq9jZ8WL+2JNYO3yb7/WAILtpdjC/5phjzX2RHlt4=;
	b=GGVf4FxshdOb1FqHEJpzVdVqF5XGiG6fs6huXXlCxdiVLARAd68vWBOajv5cJ6F1yakz
	 IuJIwviw3du17Cnhy+j9oAzLX3bRBUb/4AHHY4S5mmvjlcg1tCNd64MSdQehWQJMZE67U
	 ODIB7eJxp3k/BAqylM6FwWWRjmKc+gONyEcpqLfilt4eHxkTZ/EmrT/Zm4qF4+hW33UUA
	 37nYc0LDudLsLFNJdRe1MFkndWWW3XcfI95bkdJQgMrQiDEGtlS+u+2MUqi+bXvqG2IMg
	 NaMPJvjHgKua5MrVRmH9scvSjc8e4HW+cMF3fxuoDewgKxvDvASQp76h3DjwlyWPH4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QufVbt1p;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AFD60A3829
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 22:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25AFD60A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QufVbt1p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795645527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAnq9jZ8WL+2JNYO3yb7/WAILtpdjC/5phjzX2RHlt4=;
	b=QufVbt1ps/1EQRI6HiuOGcA1US2UeZ7+zzu1CqZdTrnp9mP2ypgIFrs7yvhyUVW7z3ZPsW
	Disj0H8JZEYDsMVdFrzoax57RjIL8hI99R6LCNGABsMg2pGnefzmv3tnEs+4MD3X0aO2xl
	FQC9XJxgFSloWvoWR+erYTQG4Wr7uTY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-K3rNsI39O52GgV2or_-Uhg-1; Wed, 25 Nov 2026 22:25:24 +0000
X-MC-Unique: K3rNsI39O52GgV2or_-Uhg-1
X-Mimecast-MFC-AGG-ID: K3rNsI39O52GgV2or_-Uhg_1795645524
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b4d09fefd7so58108527b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 14:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645524; x=1796250324;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DAnq9jZ8WL+2JNYO3yb7/WAILtpdjC/5phjzX2RHlt4=;
        b=sw9IL9pMti1lAQ2nxWzH75Cw+Rx93hsrdx7Zamw62q4H0Zfoz0hscry8mSVnkOW+lM
         HHfBzWCZyQM8id1Yg8p7PLU8Ez1Y0SQsG/gtr2PsJ+rl41nOpOGQq1DLRZfEPj2dUlkN
         w+DY6jBv20DCQhorG2l8FpHIcZdf8CFFAoNlOEQ0GZJHx6SOAKuPQ1UlrWipsL0S/lFV
         FOQPs9t/UOLUjgXv71mAfG9cn7Pu6NmdOs4T/RM6JGCOWyy8Zveijs2H+gIW5g49mSmY
         wqC7ZVnEoGY+kURVCtEnMpvMjsfOcUL989d/2LT8bSeC6I1tmsIZ8fvh07X/3rexX4B8
         No0w==
X-Forwarded-Encrypted: i=1; AL+hErEIvcwyvSpb+d/b85dC8Z8SwUzEumXtZZEqvMv3Fo1fatNTrmgA//smJBTFNGcfE2xeXsWpq0iEnf9PP/HOl9wH+6KoV3c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8z0CvlZNo7yb69L9RGKnYafTbGOAULoT8oTnfCAZrW3HVLDmrG
	mWPWLGqWiM0q6M976rGgdYlVEUqI8jm3wb2KUSy8TlGPhQgImFUDSDBwd7JVIYTyZq2I5GtVMZq
	akp/KcEK+YIAeCPS/ZTeY2tpI94jsGTIfwp2Qf9Kzsq369tuA61eFlt2OwDwshAt5G6kiLio5aS
	tSe1oE8U8xENUgeZZVoTlgUlJjzT2tHqzsUYdR9x3IGS5WuNIuSVWlhcCdIYHobv0=
X-Gm-Gg: AZFdTZeUg0Z17mnuPKDTm2HlrdPj/vAGBSpe+oMb5TROny253TWz8jlFITUjGi9a0eN
	kogq7Y8UiBedp9VpZsjN1BdXdK38dnjDmyO5A/F791zXQyLwcWcqRVrfvXwZNH9342yAsy6x5tx
	S4oLBCka0X2HVQaJNveJk65lm+YsqmW8W9NYdYyb2dN+5o1IJxc0VoPDvz6058J1zdm/FTTrmk9
	tQWVQjUahdChDH0eRXvPQTWp4pk6Gas4iXGvFWfwS5Gdg==
X-Received: by 2002:a05:690c:3610:b0:8b3:2250:aed1 with SMTP id 00721157ae682-8b52045fff4mr82109127b3.26.1795645524046;
        Wed, 25 Nov 2026 14:25:24 -0800 (PST)
X-Received: by 2002:a05:690c:3610:b0:8b3:2250:aed1 with SMTP id
 00721157ae682-8b52045fff4mr82108897b3.26.1795645523329; Wed, 25 Nov 2026
 14:25:23 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125091157.1822521-1-huangsj@hygon.cn>
In-Reply-To: <20261125091157.1822521-1-huangsj@hygon.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 25 Nov 2026 23:25:12 +0100
X-Gm-Features: Aa3M54qaE8GdHE2I6BQLUshqnPgXMm7o_gQT8cXZLdWKqWmzLqc31bUGv5jcvAY
Message-ID: <CAHc6FU4h-FRvLkO_0ouTey9MbX=n61t3abt4hPNFOthsRGG9mQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] vfs: add inode iteration methods
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DlSIp9ZEqb7kbyeQK8oOXzxHkROdIwt66FrWN568SVs_1795645524
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Huang,

I have some thoughts ...

On Wed, 25 Nov 2026 at 10:18, Huang Shijie <huangsj@hygon.cn> wrote:
> This series adds a superblock inode iterator and converts the open-coded
> sb->s_inodes walks in the VFS to it.  The design follows the cursor-based
> construct proposed by Christian Brauner:
>
>   https://lore.kernel.org/all/20261120-mitverantwortlich-drehbaren-kantholz-241300d20168@brauner/
>
> and is the same direction as Dave Chinner's patch set:
>
>   "vfs: improving inode cache iteration scalability"
>   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.com/
>
> The caller owns the iterator state and drives the walk itself:
>
>   CLASS(sb_inode_iter, iter)(sb, eligible, priv, flags);
>   while ((inode = sb_inode_iter_next(&iter)))
>           /* do stuff */;

The pattern should be:

  for (CLASS(...); ...; ...) {
      /* ... */
      if (/* end iteration early */)
          break;
      /* ... */
  }

so that the iterator goes out of scope immediately when the loop ends.
Hide the details of the loop header in a macro and that this becomes:

  for_each_inode(inode, sb) {
      /* inode is referenced and unlocked here */
  }

Use that to convert the simple cases.

And then we've got preconditions that are checked while the inode is
locked. Those can probably go in an expression:

  for_each_inode(inode, sb, expression) {
      /* expression was true */
      /* inode is referenced and unlocked here */
  }

This unfortunately cannot be implemented on top of the
sb_inode_iter_next() pattern, at least not in a reasonable way, so we
actually shouldn't use that pattern.

The locked iterator would look like this:

  for_each_inode_locked(inode, sb) {
      /* inode is locked here */
  }

This doesn't cover all existing cases, but that's okay. Don't force
things into this pattern that are not a match.

We can always extend things further if it makes sense.

> The lock does not span iterations.  sb_inode_iter_next() takes
> sb->s_inode_list_lock, takes a reference on the next inode, drops the lock
> again and hands the inode out; the reference is what keeps the cursor on
> sb->s_inodes so that the next call can resume from it.  As the iterator
> is a cleanup class, a caller that breaks out early does not have to call
> sb_inode_iter_end() explicitly.
>
> Two optional channels let a caller keep its own state instead of filling in
> a shared context:
>
>   - iter->eligible is called with inode->i_lock held, so that a caller can
>     reject an inode before a reference is paid for.
>
>   - iter->status carries an error out of the walk.  Setting it to a
>     negative value makes sb_inode_iter_next() return NULL.

Nobody needs that. Just break out of the loop.

> Most callers just want a referenced inode and use no flags at all.  Three
> flags cover the walks that need something else:
>
>   - %INO_ITER_F_REFERENCED restricts the walk to inodes that still have a
>     reference, preserving the "only handle referenced inodes" rule of
>     landlock's sb-delete walk.
>
>   - %INO_ITER_F_NOREF hands out only inodes whose reference count has
>     already reached zero, and %INO_ITER_F_NOIGET suppresses the reference.
>     Neither keeps the inode alive, so the caller has to make the inode
>     unclaimable itself.

No flags.


> A second, internal iterator covers the walks that must not take a
> reference at all:
>
>   static inline int sb_inode_iter_locked(struct super_block *sb,
>                                          int (*iter_fn)(struct inode *,
>                                                         void *),
>                                          void *priv);
>
>   - It keeps sb->s_inode_list_lock held for the whole walk and takes no
>     inode reference, so @iter_fn only has an existence guarantee: it must
>     not block, and it must do its own inode state checks and its own
>     reference handling.  A callback returns a negative value to stop the
>     walk with that error, and 0 to continue.
>
>   - It lives in fs/internal.h as a static inline rather than being
>     exported: it is a VFS internal facility, and the small callbacks
>     inline into their callers.
>
>   It serves the three walks that cannot use sb_inode_iter_next():
>
>   - nr_blockdev_pages() is reached from si_meminfo(), which kdb calls, and
>     the iput() that the referenced iterator would do can sleep.
>
>   - remove_dquot_ref() has to scan I_NEW inodes as well, which the
>     referenced iterator filters out; it only touches the quota pointers,
>     and those have their own locking in dq_data_lock.
>
>   - the generic_shutdown_super() poisoning loop has to touch every inode
>     still on the list, including the I_NEW, I_FREEING and I_WILL_FREE
>     ones that sb_inode_iter_next() filters out, and it must not bounce
>     them through __iget()/iput(): the loop overwrites i_sb with
>     VFS_PTR_POISON, and evict() dereferences i_sb->s_op on the way out.
>
>   Patch 1 adds sb_inode_iter_next().
>   Patch 2 adds sb_inode_iter_locked().
>   Patch 3-5 convert the callers which cannot use referenced inodes
>           (nr_blockdev_pages(), dquot removal and the
>           generic_shutdown_super() poisoning loop).
>   Patch 6-11 convert the remaining callers (inode eviction, sync_bdevs,
>           drop_pagecache_sb, add_dquot_ref, landlock's hook_sb_delete
>           and gfs2_evict_inodes()).
>
>
> BTW:
>   This series is based on v7.4-rc2, and applies on top of the last commit
>   of that base, which is the small patch this series depends on:
>
>       v7.4-rc2-22-ga02161f70fcf
>       commit a02161f70fcf ("fs/drop_caches: skip filesystems without page cache writeback")
>
>   That patch was posted as:
>       https://lore.kernel.org/all/20260923070116.3226846-1-huangsj@hygon.cn/
>
> v3-->v4:
>    -the interface is redone as a caller-owned cursor, following Christian's
>     sb_inode_iter construct: sb_inode_iter_next() returns a referenced
>     inode with sb->s_inode_list_lock dropped, and the reference keeps the
>     cursor on sb->s_inodes.  The callback-based interface of v3, with its
>     ino_iter_fn and INO_ITER_RET_* return values, is gone.
>
>    -the iterator is wrapped in a cleanup class, so a caller that breaks out
>     of the walk does not have to call sb_inode_iter_end().
>
>    -an inode can be rejected before a reference is paid for: @eligible is
>     called with inode->i_lock held.
>
>    -the error channel is now iter->status rather than a three-valued
>     callback return.
>
>    -super_iter_inodes() and super_iter_inodes_locked() are renamed to
>     sb_inode_iter_next() and sb_inode_iter_locked(), and the latter stays
>     in fs/internal.h for the three walks that must not take a reference.
>
>    -evict_inodes() uses INO_ITER_F_NOREF | INO_ITER_F_NOIGET: it only
>     takes inodes whose reference count has reached zero, pins each one by
>     setting I_FREEING and dropping it from the LRU, and runs dispose_list()
>     with the list lock dropped.
>
>    v3: https://lore.kernel.org/all/20261120031305.3561045-1-huangsj@hygon.cn/
>    v2: https://lore.kernel.org/all/20261113115702.586594-1-huangsj@hygon.cn/
>    v1: https://lore.kernel.org/all/20261015093854.2082600-1-huangsj@hygon.cn/
>
> Huang Shijie (11):
>   vfs: add sb_inode_iter_next()
>   vfs: add sb_inode_iter_locked()
>   block: convert nr_blockdev_pages() to sb_inode_iter_locked()
>   fs/quota: convert remove_dquot_ref() to sb_inode_iter_locked()
>   fs: convert generic_shutdown_super() poison loop
>   fs/inode: convert evict_inodes() to sb_inode_iter
>   block: convert sync_bdevs() to sb_inode_iter
>   fs/drop_caches: convert drop_pagecache_sb() to sb_inode_iter
>   fs/quota: convert add_dquot_ref() to sb_inode_iter
>   landlock: convert hook_sb_delete() to sb_inode_iter
>   gfs2: convert gfs2_evict_inodes() to sb_inode_iter
>
>  block/bdev.c                   |  58 ++++++----------
>  fs/drop_caches.c               |  36 ++++------
>  fs/gfs2/ops_fstype.c           |  26 ++-----
>  fs/inode.c                     |  33 +++------
>  fs/internal.h                  |  25 +++++++
>  fs/quota/dquot.c               | 120 +++++++++++++++-----------------
>  fs/super.c                     | 121 ++++++++++++++++++++++++++++++---
>  include/linux/fs/super_types.h |  40 +++++++++++
>  security/landlock/fs.c         |  67 +++++-------------
>  9 files changed, 297 insertions(+), 229 deletions(-)
>
> --
> 2.53.0
>
>
>
>

