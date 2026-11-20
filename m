Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190684;
	b=Ot7nv7fZdw++j/v5pDYc7pUCa8siOEnSqE4cZFn2EoN8t2C/SibmLLdmg1klyl+rVYRf
	 fYjHcR/JMSOVpI/3t06+1zpRF3YyjCCPFnf7fNk1Z4Yur5mzcQ9bxQaG7T6QBnaJOsrKW
	 nGuFdyk1h3BoQCKZfaXbpHhLgGUzIVhoNPIRvqoAP9nX5E76iPmTEKaRgrFFN1A513N54
	 5qz1T1jIsAw0eorx1nl1ZB3GN0elxhnUGbGi4qxaddWkhZD/tR8ciJFvttDZCgwV5M9aG
	 XlLo+Oc5JZFtEh7yE0FZKNlLhNR4PZudTTAcA7gUDIZLCkzFgUR6Wm8/TPKmu3RF7FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190684;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=q9YON1OyDdbhVmSZ3qNdPEZ9E1LMVZlQqEKChXlKUBA=;
	b=RY+X1KUjtT3Qk4lEEFQ7Y4wOvOPTBVKxGzNac5hZU9CfFKkcAx+sipSBKyAMlC6s61WL
	 snjUVC4nJue4AsDJIsEHgtBVB0k6D5B4/ok8bCUT/pZZOE5tLRKJdjesGffbJQ9venui7
	 M1PUkdrX/eJxBq+KvGEBix/KyL8RRzHeYz97p2L4p+yz25XpPMT9C71m45r+373oKnpLX
	 ED7dfZOmt1uqHhsAlstWxhOnjbnhIHlH9dZwuh2NInS3ypIZgCCaND51x5XiamDXC1kag
	 LZ/pPrtnrbyAAw4TTqTc6cSJE2XASowcensW0RVg7rMp3Xt3CgFpZz1gPmiauQ7Irbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=M9qBDG2c;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B222C606A325;
	Fri, 20 Nov 2026 16:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B222C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=M9qBDG2c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1795190675; bh=JO6QMaohqpOpnglO+nbRvEH2R5s3p7FIcS9bHnt3aqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9qBDG2cZM7LjFCfgpszJGBKKgicC0/vAIeHCbRTCISq50F4PiFn5sf6TBxNXtW+Y
	 REgUYE3FsvLHP3fPuimDvBL6iD0fUqR9mJ+QAoXeNmFaV44OO7jsAHVQAdJrTl4KVG
	 n/TEBCpTQpM6vi8XIZuzy0CRIkYsmktCtJSKW3+tGLDRWQ0gHr+C7viSVpoWGajpkP
	 Eb9kgR6J/Md0jjzPLS2YA18PUp+6HDzOSgZ4sN8aMH824Ye51d/IBcPCImDsxNmOZd
	 kUNxSPtlEm55pJGrXGRbmuOotLkN0toTYn2o1dgrloEzd6g7TVVwiYRPOxICb0i8mk
	 ljWWZTYtcKo7g==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 941D71C4E; Fri, 20 Nov 2026 10:04:35 -0600 (CST)
Date: Fri, 20 Nov 2026 10:04:35 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	bpf@vger.kernel.org, Zhiqi Zhang <zhiqizhangg@gmail.com>
Subject: Re: [PATCH 0/2] ns: don't call the namespace LSM hooks for
 kernel-internal namespaces
Message-ID: <awBvk4BlFqT4jukk@hallyn.com>
References: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org>

On Fri, Nov 20, 2026 at 01:29:57PM +0100, Christian Brauner wrote:
> mount_subtree() allocates a private anonymous mount namespace so that
> automounts during the path lookup have somewhere to go. btrfs goes
> through it on every mount and NFS on every NFSv4 mount and whenever it
> follows a referral.
> 
> Since the namespace LSM hooks went in that namespace goes through
> security_namespace_init() like any other. Landlock enforces
> LANDLOCK_PERMISSION_NAMESPACE_USE in its namespace_init hook. So a
> sandbox that handles that permission without allowing CLONE_NEWNS can't
> mount btrfs or NFSv4 anymore. mount(2) fails with EPERM even though
> nobody asked for a mount namespace. Zhiqi reported that and sent a fix
> that skips namespace_init for this namespace (cf. [1]).
> 
> But namespace_free needs to be skipped as well. Otherwise a bpf program
> attached to namespace_free would see these namespaces go away without
> ever having seen them being created. Right now that can't happen but
> only because security_namespace_free() skips the hook if no LSM
> requested a namespace blob. So mark such namespaces as kernel-internal
> and keep them away from both hooks. The first patch turns the anon
> argument of alloc_mnt_ns() into flags so we don't end up with two
> booleans.
> 
> The anonymous mount namespaces created by open_tree(OPEN_TREE_CLONE)
> and fsmount() are handed to userspace and keep going through the hooks.
> Landlock covers them on purpose.
> 
> I tested this on v7.4-rc3 with a btrfs loop mount and an NFSv4 mount
> in a Landlock domain that handles LANDLOCK_PERMISSION_NAMESPACE_USE but
> doesn't allow CLONE_NEWNS. Both fail with EPERM without this series and
> work with it. unshare(CLONE_NEWNS), clone(CLONE_NEWNS),
> open_tree(OPEN_TREE_CLONE), fsmount() and setns() are still denied and
> the Landlock namespace selftests pass.
> 
> [1]: https://lore.kernel.org/20261114141323.19029-1-zhiqizhangg@gmail.com

Thanks, both look good to me.

Acked-by: Serge Hallyn <serge@hallyn.com>

> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Christian Brauner (2):
>       mount: pass flags to alloc_mnt_ns()
>       ns: don't call the namespace LSM hooks for kernel-internal namespaces
> 
>  fs/namespace.c                     | 31 +++++++++++++++++++++----------
>  include/linux/ns/ns_common_types.h |  2 ++
>  include/linux/ns_common.h          | 20 +++++++++++++-------
>  kernel/nscommon.c                  |  9 ++++++---
>  4 files changed, 42 insertions(+), 20 deletions(-)
> ---
> base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
> change-id: 20261120-work-ns-mount_subtree-d429ad72f8ac
> 
