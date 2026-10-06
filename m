Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A1254707C;
	Tue,  6 Oct 2026 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246787; cv=none; b=th+wzHWDy4jopaBxDC4nw4clISBtX5X+iYAQ0WXxMHaV35IIhESSTqTtmCD/G2kpeoYLK9By6/bdEBNT12xyq1cwPt7Yu8+t4UAg5ZXrT7ovP1tWW8MRIGomGErYtv6rFWo/7lk2wfTDKHTk+6exlxlgFZzQvBkFxNYWTOb9XWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246787; c=relaxed/simple;
	bh=67kYz8uoPSIj0/0CEeFFiSkQFLHWvjl94rTwLuF4vRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bwVXur3u+D5YPCIn3QYX7ddWadJax4FiNV2WBdff1SNcKW1Ne1rk1y1qMdLOS+mVdU4bRIYvJq8a0vlEVfLw4O8t96iU6vikdCy4hqfXU8bD9y6WxGr5iB2WL/4mgayWovZqTys1BJqwmwqTqNHbiu8Yf4gpMX6ZpLKoc/fWduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEeQUxGa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEeQUxGa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F761F000FF;
	Tue,  6 Oct 2026 00:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246785;
	bh=05o0o1I68/Ng1uA2x47FBftvbdwiR/rYNGaraQSf0bE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dEeQUxGa2kU1BxiHkQEQw9JHFBqNxpMVetSk2en4agQNdBL0imQH+hDXd+QlZaI3R
	 TzlSqPZovkhhCs6HJMgUHIZ3eRv85IWkaPrXd7iPV0oa0UXC5RJNl7zmx78yBm5n0G
	 FLhMT4yPzPsr00QzLUMP8JgNeu8Raqzr3ZnQrNiqKJNGHhTNcJ467tcHKJCI+EaUEU
	 snb5TcEJpASuWznT4+7XCoEMfKUuFgYYZdMoPT62kHCDf0S2HV/rVFkK7LsY1mFMwZ
	 yR3QdRcwqcMcuP2HtenQjseZjYFvH55nzyLznn8sfJpuf1n6QXSVNpDanlFHT3p6bC
	 6dpYIr1toA36g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 09/12] namei: add an rcu-walk mode to the
 ancestor walk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261006002020.2890858-10-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
 <20261006002020.2890858-10-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:33:04 +0000
Message-Id: <20261006003305.44F761F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] vfs: TOCTOU race in vfs_walk_handover() via inverted seqcount check
- [High] vfs: vfs_walk_ancestors() skips seqlock validation on early exit
--

commit aae071e59d5189d756d48145018ec259d19ab6d4
Author: Justin Suess <utilityemal77@gmail.com>
Subject: namei: add an rcu-walk mode to the ancestor walk

This commit introduces an RCU-walk mode for vfs_walk_ancestors(), allowing
lockless path traversal. It adds vfs_walk_handover() to transition a lockle=
ss
walk into a referenced walk. The changes provide a lockless stepwise path
iteration mechanism intended to be driven by consumers like BPF.

> diff --git a/fs/namei.c b/fs/namei.c
> index 73f25152d9173..31f96602d4e94 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
[ ... ]
> @@ -2317,7 +2396,59 @@ int vfs_walk_next(struct vfs_ancestor_walk *aw)
[ ... ]
> +bool vfs_walk_handover(struct vfs_ancestor_walk *to,
> +		       struct vfs_ancestor_walk *from)
> +{
> +	struct path pos =3D from->pos;
> +	int err;
> +
> +	err =3D __legitimize_mnt(pos.mnt, from->m_seq);
> +	if (unlikely(err)) {
> +		if (err < 0)
> +			mnt_undo_legitimize(real_mount(pos.mnt));
> +		goto dead;
> +	}
> +	if (unlikely(read_seqcount_retry(&pos.dentry->d_seq, from->seq) ||
> +		     !lockref_get_not_dead(&pos.dentry->d_lockref))) {

[Severity: High]
Is there a race condition here due to the order of operations?

Because of the short-circuiting logical OR, read_seqcount_retry() executes
before lockref_get_not_dead(). This creates a window where a concurrent
rename or unlink could modify the dentry and increment its sequence counter
immediately after the sequence check passes but before the reference is
acquired.

Could this allow the handover to return a stale or concurrently modified
dentry to the caller? Acquiring the reference first and then validating the
sequence counter would prevent this TOCTOU race.

> +		mnt_undo_legitimize(real_mount(pos.mnt));
> +		goto dead;
> +	}
> +	to->pos =3D pos;
> +	to->flags =3D 0;
> +	to->pos_flags =3D 0;
> +	return true;
> +
> +dead:
> +	memset(to, 0, sizeof(*to));
> +	return false;
>  }
[ ... ]
> @@ -2347,6 +2485,8 @@ int vfs_walk_ancestors(const struct path *path,
>  	struct vfs_ancestor_walk aw;
>  	int ret;
> =20
> +	if (flags & VFS_WALK_RCU)
> +		rcu_read_lock();
>  	vfs_walk_start(&aw, path, flags);
>  	for (;;) {
>  		ret =3D vfs_walk_next(&aw);
[ ... ]
> @@ -2365,6 +2505,8 @@ int vfs_walk_ancestors(const struct path *path,
>  		}
>  	}
>  	vfs_walk_end(&aw);
> +	if (flags & VFS_WALK_RCU)
> +		rcu_read_unlock();

[Severity: High]
Does this early exit path need sequence validation when running in RCU mode?

When the callback cb() inside this loop returns VFS_WALK_STOP or a negative
error, the loop breaks early and returns the result without validating the
seqlock.

Since VFS_WALK_RCU makes the walk lockless, the callback might operate on
torn or corrupted data during a concurrent modification. If the callback
incorrectly aborts the walk based on that corrupted state, the function
will return success or an error rather than returning -ECHILD to trigger
a retry.

Should there be a final sequence check on the current dentry before
returning the callback's result?

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006002020.2890=
858-1-utilityemal77@gmail.com?part=3D9
