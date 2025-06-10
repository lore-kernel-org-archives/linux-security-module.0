Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99202367CC
	for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749577046; cv=none; b=UIqr2TtwHaR5VaudOFWLnE9FtWXvLvpqeiXBUk8MEvcjmIF6PL+URY4wBkxJynevmQ5yXPE8AyAVzbhTiwz9Lnw9YAAQi1414Sv43aI6Az9dkHxDwM4dYWdkdVxe7rd5X+RoBWeaC2DyDzT9TNzHCW2PxvX3hcYlXjxOW6l2i7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749577046; c=relaxed/simple;
	bh=Ur5dV8QKH80XZZ3n1/Lz8iLMGTqBPVVJWTX10PB5Ssc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5b3v8ykxKJfTzMwLC88rLgDKSF3AJqRUTaDZCUG4uZaU2lzvA3J+98hQKs5JNxuFc9K/zBV/QjDf0Y5shY9ayfZ9aYtoAZHNWs8WJstJK9DNVjP7opJ6+beQfO+/GN2BjQ3hhBKOupScUVoE1R4VmOcG+LxsBhn+PHauk/T8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1E636ncN; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1E636ncN"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bGwW71MT6zltw;
	Tue, 10 Jun 2025 19:18:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1749575939;
	bh=N4poSoqHkFTaRXhQjec38Gy8OXs4VTV9129KaB1cSFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1E636ncNZwlaEm4q4CVWcB5uhlKB/7nQVHrRoGQsZxN+rX35ZlNeak99oLezrDhs3
	 Au6GVp08oBSerwGGOvFuUtVKYrOZ9EEkhnxPlI0WN3Isik1Gr9mUva/Ewlq1zvonAi
	 kcoekPkFHgQosvOHcRfjlA2Y7Yb4lsshBfuJs/oA=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bGwW60ZtKzNsQ;
	Tue, 10 Jun 2025 19:18:58 +0200 (CEST)
Date: Tue, 10 Jun 2025 19:18:57 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com, m@maowtm.org
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
Message-ID: <20250610.rox7aeGhi7zi@digikod.net>
References: <20250606213015.255134-1-song@kernel.org>
 <20250606213015.255134-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250606213015.255134-2-song@kernel.org>
X-Infomaniak-Routing: alpha

On Fri, Jun 06, 2025 at 02:30:11PM -0700, Song Liu wrote:
> This helper walks an input path to its parent. Logic are added to handle
> walking across mount tree.
> 
> This will be used by landlock, and BPF LSM.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/namei.c            | 51 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/namei.h |  2 ++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 4bb889fc980b..f02183e9c073 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1424,6 +1424,57 @@ static bool choose_mountpoint(struct mount *m, const struct path *root,
>  	return found;
>  }
>  
> +/**
> + * path_walk_parent - Walk to the parent of path
> + * @path: input and output path.
> + * @root: root of the path walk, do not go beyond this root. If @root is
> + *        zero'ed, walk all the way to real root.
> + *
> + * Given a path, find the parent path. Replace @path with the parent path.
> + * If we were already at the real root or a disconnected root, @path is
> + * not changed.
> + *
> + * The logic of path_walk_parent() is similar to follow_dotdot(), except
> + * that path_walk_parent() will continue walking for !path_connected case.
> + * This effectively means we are walking from disconnected bind mount to
> + * the original mount. If this behavior is not desired, the caller can add
> + * a check like:
> + *
> + *   if (path_walk_parent(&path) && !path_connected(path.mnt, path.dentry)
> + *           // continue walking
> + *   else
> + *           // stop walking
> + *
> + * Returns:
> + *  true  - if @path is updated to its parent.
> + *  false - if @path is already the root (real root or @root).
> + */
> +bool path_walk_parent(struct path *path, const struct path *root)
> +{
> +	struct dentry *parent;
> +
> +	if (path_equal(path, root))
> +		return false;
> +
> +	if (unlikely(path->dentry == path->mnt->mnt_root)) {
> +		struct path p;
> +
> +		if (!choose_mountpoint(real_mount(path->mnt), root, &p))
> +			return false;
> +		path_put(path);
> +		*path = p;
> +	}
> +
> +	if (unlikely(IS_ROOT(path->dentry)))

path would be updated while false is returned, which is not correct.

> +		return false;
> +
> +	parent = dget_parent(path->dentry);
> +	dput(path->dentry);
> +	path->dentry = parent;
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(path_walk_parent);
> +
>  /*
>   * Perform an automount
>   * - return -EISDIR to tell follow_managed() to stop and return the path we
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 5d085428e471..cba5373ecf86 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -85,6 +85,8 @@ extern int follow_down_one(struct path *);
>  extern int follow_down(struct path *path, unsigned int flags);
>  extern int follow_up(struct path *);
>  
> +bool path_walk_parent(struct path *path, const struct path *root);
> +
>  extern struct dentry *lock_rename(struct dentry *, struct dentry *);
>  extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
>  extern void unlock_rename(struct dentry *, struct dentry *);
> -- 
> 2.47.1
> 
> 
