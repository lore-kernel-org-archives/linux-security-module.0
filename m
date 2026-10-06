Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291952E719B;
	Tue,  6 Oct 2026 01:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791249062; cv=none; b=FeN3RoVBYyAvSUeodEf1c8I3rVhFew+14xTF5ADSj1lXn4KbCsqS6oFwZ9uOM6Poo/zANMX1sN+OXGGC7Nf9EJjrNrb04Z9ucex4ldlgVDA+muRm0PlP/srDb4BQ1ko6Bod+00fk45yGTdZCf6PngyPyqSvaVl3WnXUHW45h2Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791249062; c=relaxed/simple;
	bh=iX04aU+xQhY5RCAKM4KVd4yNpnkEtAErGswsSvO2zqI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gmca2oMwaV7Mmw6YBCfQi3aUNh1vPc6eDvhppxkPnCftCjeDNa7aP3tOMp6T1FtQWaFFQP9yq4Is4KATDqUD3r7twvsSXiHPm3TPlDMa016tgHo8c1E8ciz+6g7tWT8elgf/C2ozHdKYH72jtJe3FwM8O2qHRU2J+7ROOKC+RUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUHCJj5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUHCJj5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953A01F000FF;
	Tue,  6 Oct 2026 01:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791249060;
	bh=NExDvIWjReMaQN3K/XzZFIf8ilfRYWTz2gjMno+hkCA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nUHCJj5bvAFYIda40r71i3W1i3vBNMhJS37PpgWxXyx7WVMkQG5bUhzzKBvxlEiL7
	 XSaGJeiR/xoLfm9mcX9OsZ3bPvuB8ZXgn+0k7gK0XB8ZjWGzPErZd6kTsrQmglHZnR
	 mb71MtGjzUpj5y6jXhUOR2D+L/NtJIShI7jlRtVbv2igHT/F8YLf2WPz9a/m4a8llq
	 lTimSZh7zIDo4bayZI6jLPtMZ4JUrMvMM/iwKnOkTIWzZiI+egd8myTnAUO7uynA+j
	 jrbv0LeSq3yZkCBPSAoPTkUf3hYHcQDSSLySoY2/113JLAu1QgHD8KGTFplV1pXtdH
	 QdIOCtEzvBnVA==
Content-Type: multipart/mixed; boundary="===============2398697027849271308=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <21df10775af8f6f82725c366e78ab93c9fefb75ba436144030165b05c7a3b845@mail.kernel.org>
In-Reply-To: <20261006002020.2890858-10-utilityemal77@gmail.com>
References: <20261006002020.2890858-10-utilityemal77@gmail.com>
Subject: Re: [RFC PATCH bpf-next 09/12] namei: add an rcu-walk mode to the ancestor walk
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,brauner@kernel.org,viro@zeniv.linux.org.uk,jack@suse.cz,neil@brown.name,mic@digikod.net,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,gnoack@google.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,memxor@gmail.com,jolsa@kernel.org,jlayton@kernel.org,amir73il@gmail.com,mjguzik@gmail.com,shuah@kernel.org,m@maowtm.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  6 Oct 2026 01:10:57 +0000 (UTC)

--===============2398697027849271308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> namei: add an rcu-walk mode to the ancestor walk

TL;DR: vfs_walk_handover() may drop the MOUNTPOINT flag on a disconnected
root, so an escalated walk could report different position flags and give
Landlock a different verdict than the lockless walk.

> diff --git a/fs/namei.c b/fs/namei.c
> index 73f25152d917..31f96602d4e9 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c

[ ... ]

> @@ -2286,6 +2330,35 @@ static int vfs_walk_step_ref(struct vfs_ancestor_walk *aw)

[ ... ]

> +	/* A crossing onto a disconnected root, as in vfs_walk_step_ref(). */
> +	aw->pos_flags = parent == aw->pos.dentry ?
> +		VFS_WALK_POS_DISCONNECTED | VFS_WALK_POS_MOUNTPOINT :
> +		vfs_walk_pos_flags(aw->pos.mnt, parent);
> +	aw->pos.dentry = parent;
> +	aw->seq = next_seq;
> +	return 0;
> +}
> +
>  /**

[ ... ]

> @@ -2308,6 +2383,10 @@ int vfs_walk_next(struct vfs_ancestor_walk *aw)
>  		aw->flags |= VFS_WALK_STARTED;
>  		aw->pos_flags = vfs_walk_pos_flags(aw->pos.mnt, aw->pos.dentry);
>  	}

[ ... ]

> @@ -2317,7 +2396,59 @@ int vfs_walk_next(struct vfs_ancestor_walk *aw)

[ ... ]

> +bool vfs_walk_handover(struct vfs_ancestor_walk *to,
> +		       struct vfs_ancestor_walk *from)
> +{
> +	struct path pos = from->pos;
> +	int err;
> +
> +	err = __legitimize_mnt(pos.mnt, from->m_seq);
> +	if (unlikely(err)) {
> +		if (err < 0)
> +			mnt_undo_legitimize(real_mount(pos.mnt));
> +		goto dead;
> +	}
> +	if (unlikely(read_seqcount_retry(&pos.dentry->d_seq, from->seq) ||
> +		     !lockref_get_not_dead(&pos.dentry->d_lockref))) {
> +		mnt_undo_legitimize(real_mount(pos.mnt));
> +		goto dead;
> +	}
> +	to->pos = pos;
> +	to->flags = 0;
> +	to->pos_flags = 0;
> +	return true;

Can the first vfs_walk_next() on @to yield the same VFS_WALK_POS_* flags
that @from reported for this position?

vfs_walk_step_rcu() can leave @from on a disconnected root with
two flags set:

    aw->pos_flags = parent == aw->pos.dentry ?
            VFS_WALK_POS_DISCONNECTED | VFS_WALK_POS_MOUNTPOINT :
            vfs_walk_pos_flags(aw->pos.mnt, parent);

vfs_walk_handover() then sets @to up as a walk that has not started
(to->flags = 0, to->pos_flags = 0).  The first vfs_walk_next() on @to takes
the not-started branch and recomputes the flags from the position alone:

    aw->flags |= VFS_WALK_STARTED;
    aw->pos_flags = vfs_walk_pos_flags(aw->pos.mnt, aw->pos.dentry);

vfs_walk_pos_flags() can only return VFS_WALK_POS_DISCONNECTED or 0.  So if
the handover happens while @from sits on such a position, @from reports
DISCONNECTED | MOUNTPOINT, but @to yields the same dentry as DISCONNECTED
only.  The kernel-doc of vfs_walk_handover() says this position is what "the
first vfs_walk_next() on it yields".

Whether a disconnected root is a mountpoint a crossing landed on is walk
state, not something that can be recomputed from the position.  The
bpf_path_ancestors_pos_flags() changelog (8dd2a68fe0e7, "bpf: add a path
ancestor iterator") says a program needs it "to reproduce Landlock's
evaluation of disconnected positions", and check_access_path_walk() in
security/landlock/fs.c skips rule matching on MOUNTPOINT positions but
matches rules on positions flagged only DISCONNECTED.

A program that escalates with bpf_path_ancestors_legitimize() (47d25368b3cc,
later in this series) at such a position would see a plain disconnected
root through bpf_path_ancestors_pos_flags().  It could then match rules
against the mountpoint dentry, so the same path can get a different verdict
depending on whether the walk escalated.

The position is reachable, since d_set_mounted() accepts an IS_ROOT
disconnected dentry as a mountpoint, for example one obtained through
open_by_handle_at().

Should the flags be carried over (to->pos_flags = from->pos_flags), with the
not-started branch of vfs_walk_next() ORing in vfs_walk_pos_flags() instead
of overwriting the flags?  vfs_walk_start() already zeroes pos_flags, so
ordinary walks would be unaffected.

No later commit in 3cc40137a219..70352ce0817c touches fs/namei.c.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37395354107
--===============2398697027849271308==--
