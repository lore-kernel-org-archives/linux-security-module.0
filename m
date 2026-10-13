Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D070B5013BE
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911030; cv=none; b=IYyskfioEHO1c2r0Rsjmx2ahXcY0S6RwLml4mS0flPfEaVBSJewrsyZqxTtTdwBddO7VAM+eReOVu5xVBlf6hTn3oXjO5ut7s+8FLp3b9Za4YGIbLsG0YuDfhnyqkYw67HAabML1h1Q6+zKJYBU1GAavroscJ7vBLhBHoDZj0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911030; c=relaxed/simple;
	bh=ZYXKGwlOsfElJu4OEAbFo9HGZndHleaEeWO+ZiUokyk=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=i6i7Y8DX/NaeicmHNRKeUlo8T0ImVbWXBzu8hFMInwCiGmeyLjwQg2uHFUGYdnTSF0Nm0XMk5zttjyfCgwmJlcRrJyUZVrfliLUfWXIbthg1S3VBiPZC+c/IkiAkY4GHL+kXU2G7T9YpmNm6RjjKiiOEZnn/1heQ438z8Z8fk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENRsypqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENRsypqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C6E1F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 17:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791911029;
	bh=y2e/XIT4LYoNmExRcDw8kwTJUs4mEAjtcah4EVsKIYk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ENRsypqni+PiKIauCTn2bc8U4rfULfY9MFLamikSw1e2s/K2XTdOKyahQipr17tGp
	 CCHeey+IURWsmxFtZpcYKdfBRFTfB1QwPPILsCJAGTGvnZA5ujEx8bLZDFdyGIbW7m
	 okW2lCiw4Y9g3iIndO6C/z5cb5lmtHyI9PBqcM84wd/myWN00igpJrEzozu/shYFjv
	 sJFtBgXFK+hJrYHSuGRnsjqlznA/lzGQ035MSUyD6tweC9pEM38ud0hFfls8wWz4+I
	 rByAgUmEUT3wYvl/uvCh14N+eDGOcz6CYJPWbdz2+Y91aHZ0rL6UtR52yK8HkdQTDd
	 ANSlqLVbeOKrA==
Message-ID: <sashiko-outbox-170184@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 10/11] bpf: add a lockless path ancestor
 iterator
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261013164800.2906577-11-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <20261013164800.2906577-11-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:03:48 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Add a second variant of the ancestor iterator that drives the walk's
> rcu mode: bpf_iter_path_ancestors_rcu is KF_RCU_PROTECTED, so the whole
> iteration sits in one RCU read-side critical section - implicit in
> non-sleepable programs, bpf_rcu_read_lock() in sleepable ones - within
> which the verifier already rejects everything sleepable.  This is what
> makes a path-based policy expressible from the non-sleepable LSM hooks,
> and it drops the per-position reference traffic for the sleepable ones.
>=20
> Positions come borrowed rather than acquired here: a lockless iteration
> holds no reference to pass on, so bpf_iter_path_ancestors_rcu_next()
> hands out the walk's own position, valid until the next step.  That is
> what RCU protection buys and all it buys: the dentry cannot be freed
> under the iteration, but nothing read out of the position may be passed
> to a kfunc demanding a trusted argument.
>=20
> [ ... ]
> else is needed: the source argument's ordinary "__iter" classification
> already rejects a handover from an iterator whose RCU read-side
> critical section has ended.
>=20
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013164800.2906=
577-1-utilityemal77@gmail.com?part=3D10

