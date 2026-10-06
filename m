Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E53E40EB
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284912; cv=none; b=oupKB0syq/doRxWA5RzOCjF4vpG0zZDkb0mO+xmKbqkCg2jSr/op3K8St0kSbQCFwzPmxwlH2mbQ47LH7dHYbl6lqmSTr+nc2bh+g8M56hOR5C3LR08jnV2NL55DhTFffMfQj/gIaldTJFLhdMyz6L5NbLouDjk6efmF3F6SeOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284912; c=relaxed/simple;
	bh=v31MGgBidoi/yXZNt4BWw0iqdu2b6B0oZ/qLQicDV34=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r66LsziaMYdIjrlPqxodMbfowGI0+ZJ/TTvsAl9y/CWxrRPzPbDTv8WwmsFyKxKIYeDgFpknoCh46/hXO+UZjACq1UaoimuDBzLYtFLxKVZ2i4QIKMy2SEsF7JAY5mwXenu3FrWgJW+UUkSKkwPuZpRaeF4S+egOXYIvbP1tmDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcOSyB2I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcOSyB2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9D61F000FF
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791284911;
	bh=duoreqd0sRRrKUlrTukaog9j/6iGN93aIzEj3QAPBP8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TcOSyB2Iy+z6glkcfxPCzGFBpDkjSoUmzl4uTE7XEpFVBwJM0JbaD+T/7u5i1vz+i
	 dwybKDBMJroKZ5iBtrNFwLogFkPeOgBFK85G7G/RltOY+mlDA+Yk35OzeFusam+nZ8
	 ODMaLJg6s1xO2ujKMlKfubQ3QLg7ZBAVLRn6UTXyOyj/hmKFE3HMTUJdYvkrLI1VkI
	 JMiL0+STqFQJ4WCwXQIcr7+C78aV04xkxP6ycVMM793Ka2VQoWQz8EPlqH22xP4hON
	 KnST+HUDKsfSIyCYZifX5Is70G6djyyrH5Qh9oWfyEhelwW4EWyVfZ7cIQr8quPaGc
	 45+QuToGNFoNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] landlock: Fix superblock use-after-free in
 release_inode()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261006105847.2541190-1-gnoack@google.com>
References: <20261006105847.2541190-1-gnoack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 11:08:30 +0000
Message-Id: <20261006110830.DF9D61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Without this fix, release_inode() (task 1) can race with a umount operati=
on in
> hook_sb_delete() (task 2).  The order of operations in which the race occ=
urs is:
>=20
> * task 2: hook_sb_delete() arrives at the end of the function, waiting for
>   landlock_superblock(sb)->inode_refs to become zero.
> * task 1: release_inode(): does atomic_long_dec_and_test(), decrementing
>   inode_refs to zero.
> * task 2: gets woken up through some other means, sees that inode_refs is
>   zero and returns.  The caller is the unmount operation and proceeds to
>   release the superblock.
> * task 1: Runs wake_up_var(&landlock_superblock(sb)->inode_refs),
>   *dereferencing the sb_security on the freed-up superblock*.
>=20
> Notably, wake_up_var() does not dereference the pointer passed to it, and
> only uses it to determine an overapproximated set of tasks to wake up. So
> [ ... ]
>=20
> Cc: stable@vger.kernel.org
> Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006105847.2541=
190-1-gnoack@google.com?part=3D1

