Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4982D5C7A;
	Fri, 31 Jul 2026 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505607; cv=none; b=h/miQ8Rt25xJijYdThTlRwWpErYbpRJXV3TNVg2B63iqqvPB55JYcligYDJ7h/rOidRyvnky608cAFLtNneQeernrA7YDyARW9LreIWLWrrQhuW40ybpLBCIqBX4ytngiZSmlFE7vODQ1JlHkbaq+xQXNluFdUI3N2VAHyaOGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505607; c=relaxed/simple;
	bh=WkaqHGXeX4loIQnZSphth1Sb6QpFHTAc3988PzoliuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sE3WmXqFs2T6Wyg8CHIQnDR398UP3a4lbYSri8uZP8YwzqSoGdcrkbKSuQ13pOqgaSNxyduuHYDaQv+602G0hWwj/fvnkzrf1WUjKT9wefzSWt5H/MbU3CnQsEJbOKzY9eOpF8Xdz4Bs+ota9F4oW+x6kAb5VIMU/7c7bx3gMts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccBQw5+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccBQw5+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7DF1F000E9;
	Fri, 31 Jul 2026 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505606;
	bh=D7v8nZmyEVNqHAC2bW2DU74KMUcaCj/i+y3Rs2vbNQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ccBQw5+WVuynCMG5SGRwvIlbotSpmDchtKbCNFjmiG2sFcZDXMpFo0IxRMzjWRn2f
	 3L9hRiDFKaTLoZfXwaXIa9tfiytIrMR2APARUek9CXGXx8divEdgNLDg/YeGTcaWhi
	 GberLml2lXVZQNGp4mmRWyiqlosh0+jflbOCEIQwWiPxhmCF2m9umwJvQIR03rpXkb
	 s8kUtcsOohqkOIfu9imzfnwWYftPp4t06qFP8XTzdjG2YmMYomqWV+h4KEXj4jscY1
	 +VXxnofXtunvh4TYm9pSa1yFXAEMVmaBO89ZiDz+4fdDRuaS6kZrlvsP30dkX5DT3V
	 l6dvbZ5G5puiA==
Date: Fri, 31 Jul 2026 15:46:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vivek Parikh <viv0411.parikh@gmail.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: Landlock: mount_setattr(2) is unmediated by LSMs (ro-mount
 confinement bypass)
Message-ID: <20260731-ausrechnen-plaudern-zynisch-159895b78684@brauner>
References: <20260718101540.309387-1-viv0411.parikh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260718101540.309387-1-viv0411.parikh@gmail.com>

On Sat, Jul 18, 2026 at 03:44:50PM +0530, Vivek Parikh wrote:
> Hi Mickaël, Christian,
> 
> Note: this was found with AI assistance, so I am treating it as public per
> Documentation/process/security-bugs.
> 
> While auditing Landlock's filesystem-topology restrictions I found that
> mount_setattr(2) is not mediated by any LSM. It only matters for a
> sandboxed task that holds CAP_SYS_ADMIN in its own user namespace -- the
> rootful-container / userns-root profile that landlock_restrict_self()
> explicitly supports (security/landlock/syscalls.c). Fully unprivileged
> callers are not affected.
> 
> do_mount_setattr() (fs/namespace.c:4928) -> mount_setattr_prepare() has no
> security_* hook anywhere on its path, whereas mount(2), move_mount(2),
> umount(2), remount and pivot_root(2) all do (security_sb_mount,
> security_move_mount, security_sb_umount, security_sb_remount,
> security_sb_pivotroot). Landlock hooks exactly those five in
> security/landlock/fs.c (hook_sb_mount, hook_move_mount, hook_sb_umount,
> hook_sb_remount, hook_sb_pivotroot) but cannot see mount_setattr(2).
> 
> Documentation/userspace-api/landlock.rst ("Filesystem topology
> modification") states that sandboxed threads cannot modify filesystem
> topology, but such a task can still, via mount_setattr(2):
> 
>   1. Clear MOUNT_ATTR_RDONLY on a read-only (bind) mount and write through
>      it -- subverting the common ro-bind-mount confinement pattern.
>   2. Change mount propagation (shared/private/slave/unbindable).
>   3. Request MOUNT_ATTR_IDMAP changes (narrower in practice: gated by
>      can_idmap_mount()).
> 
> This is a mediation/coverage gap, not a rule-evaluation bug: Landlock's
> filesystem access-rights checks still apply on top. The issue is that the
> ro-mount / propagation / idmap layer of a confinement -- which sandbox
> setups rely on -- is changeable despite the documented topology
> restriction. It affects every LSM, not just Landlock (SELinux, AppArmor
> and Smack cannot mediate mount_setattr(2) either).
> 
> A self-contained unprivileged reproducer (userns+mountns, no external
> privilege) is available on request; I am not inlining it here. Its output,
> on 7.0.0-27-generic (host) and reproduced on 7.2.0-rc3 (QEMU guest,
> CONFIG_SECURITY_LANDLOCK=y):
> 
>   [1] write via ro mount before Landlock: Read-only file system (expected)
>   [2] Landlock enforced (all fs accesses allowed via rule on /)
>   [3] mount(2) under Landlock: Operation not permitted (expected EPERM)
>   [4] mount_setattr(rw-flip) under Landlock: SUCCESS  <-- gap
>   [5] write via formerly-ro mount: SUCCEEDED  <-- confinement subverted
> 
> mount(2) is correctly denied (step 3) while the equivalent attribute
> change via mount_setattr(2) succeeds (step 4) and makes the previously
> read-only tree writable (step 5).
> 
> I could not find an existing LSM hook for this in v7.2-rc3. If this is a
> known and accepted limitation (the v30 Landlock series was synchronized
> with mount_setattr(2)), then documenting it in landlock.rst -- the
> "Filesystem topology modification" section currently names only mount(2)
> and pivot_root(2) -- would already help. Otherwise, the consistent fix
> would be to add a security_sb_mount_setattr() LSM hook in
> do_mount_setattr() and wire Landlock's topology denial to it, mirroring
> hook_sb_remount(). I am happy to prepare that patch (plus a
> tools/testing/selftests/landlock/ test) if you agree with the direction.

Song is working on this.
