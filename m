Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7224651C331;
	Tue, 13 Oct 2026 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911516; cv=none; b=iQgaGh8A+AlOzIKp9KFQBqzkWdoZxxKQeRv810oGKf2n/rxZAYWnlWo33BRd2lS3Pt0c46fi/kcmNnk2nM9tEDQylUbzAjJzU18X+nevss0+M6P2tnhR2WRfwx6CB2yIX3tI02R1IjbuaxngNkrYm0o64XyMs6LPA3iX+LeWaKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911516; c=relaxed/simple;
	bh=9IVX/gVzPWd3R0eCjz6okHHSwSPWgk89UApMD/LmM54=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Na0nCQMGuXTud1GNHnzkejQ24MLIgfy4plXQ2mu+zA+WOuuzs0LxiHrjeI2ZLcEaZ5UGoJ4Gp2rGD4GLBvtIPXdodga7ar1XVFQvWKlYXfdfVrsqLkPQsrFKsBHkqbkYO9KzqtpoFSaC/RePFoz3EEl89KdKWQnFe8uwvgVdiwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpWhxmZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpWhxmZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87761F000FF;
	Tue, 13 Oct 2026 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791911515;
	bh=dlv1hcUCjzpyvH6DiiTJT1dIlaKJ9QFe/RVLYxLUeqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BpWhxmZvrmA0rVs34avGsnuWH8WadyWXCqqND6AzDCF2MnltTF4S8xD/PrJoaMGJd
	 6nSwrPIlMBACaLNQpcrFK0uLHJYiCXCEdhJ7mqYKPP3wb09RmfOPeSD6TCH7lAFNGI
	 8fPS4+azavf2aXX1JzQJuvFKxptRs6FbYfWlWWOLzjUaPJhbxoumk7S+Jh5iadOT55
	 vhBfj8u7v4YpypcyH4QzgqgYb8poTwDC+Lnp4vn9riUp7LTo9HB/3t/lbkcBrQCL/+
	 iH2hpK5AYUnKdUEdTjmojV0+5BpyKUXAr9Fn3p8GLXF+uxwcokBd8MzrSMVNbL+FHP
	 jMuA5fT03F92A==
Message-ID: <sashiko-outbox-170194@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 05/11] bpf: add a path ancestor iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261013164800.2906577-6-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <20261013164800.2906577-6-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:11:54 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: deadlock in bpf_iter_path_ancestors_next due to GFP_KERNEL un=
der VFS locks
--

commit 0d24b2f0561971ff2a9d89456692d9ec1ea13279
Author: Justin Suess <utilityemal77@gmail.com>

bpf: add a path ancestor iterator

This commit introduces a sleepable BPF iterator for evaluating a path's
ancestry using the stepwise vfs_walk_ancestors() engine. It adds kfuncs
to manage the iterator and hands each position to the program as an
acquired reference by allocating a copy of the path structure.

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 08f0847c49708..02398f5a46d5a 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
[ ... ]
> +__bpf_kfunc struct path *
> +bpf_iter_path_ancestors_next(struct bpf_iter_path_ancestors *it)
> +{
> +	struct bpf_path_ancestors_kern *kit =3D (void *)it;
> +	struct path *pos =3D bpf_path_ancestors_step(kit);
> +	struct path *held;
> +
> +	if (!pos)
> +		return NULL;
> +	/*
> +	 * The position must outlive the walk's own view of it, so it gets a
> +	 * reference and a struct path of its own to live in: struct path is
> +	 * a value type, with nothing a BPF reference could be taken on
> +	 * otherwise.  Sleepable, so no atomic allocation.
> +	 */
> +	held =3D kmalloc_obj(*held);

[Severity: High]
Can this allocation cause a deadlock if the iterator is used from a sleepab=
le
LSM hook?

If a sleepable BPF LSM program is attached to a hook like
security_inode_setattr or security_inode_unlink, it is called by the VFS
with the inode's i_rwsem held.=20

The kmalloc_obj() macro appears to default to GFP_KERNEL allocations, which
includes the __GFP_FS flag. Under memory pressure, this could trigger direct
memory reclaim.

If reclaim attempts to write back dirty pages or shrink the dcache/icache,
it might try to acquire the same i_rwsem, resulting in a deadlock.

> +	if (!held) {
> +		kit->step =3D -ENOMEM;
> +		return NULL;
> +	}
> +	*held =3D *pos;
> +	path_get(held);
> +	return held;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013164800.2906=
577-1-utilityemal77@gmail.com?part=3D5
