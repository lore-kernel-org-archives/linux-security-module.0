Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2E353A60;
	Tue, 13 Oct 2026 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910888; cv=none; b=DVzYO4ETPNkqDsXGLoAL9WPCsxYFQjNPKyzuqSVGoywuKNO/VklUlrb3GmuBDhmXxjBP40CkdSlyGh37XiKfDcJ1k4CCwfnCvdr2SQEypZ+0Yr4htpbhKWvmcHgTyuwQMWZDzl7SLl9z3AHyxhB621zJ3ZbBzbMgFlm/xN5eU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910888; c=relaxed/simple;
	bh=vg/aKsAayzPfklIy9prDNHOF83k5gQwUSccqLgS6AU4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=X/b6iL5vGJlEMm2NEJiY7/KUvKBdCaZQ5mmRsUKLqAJj16Sn52Z2ENhH7/OJYDJccxqYgj1MzyTsoEYKcjHF+TvPKcHwStMj2iplgg3lT1/PYs38iZnA9lTJvnjfhGvbsIhseWnVZHWRaeqwZcXtcvc9HkGwtUjczG5EakXL4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmr4CuVc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmr4CuVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D061F000FF;
	Tue, 13 Oct 2026 17:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791910887;
	bh=QWo7+NqdO2RkfHEayYZ5d4mr03Hnj4X06PMUJSeg4D4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bmr4CuVcHghgUrgnspX97VAoW6AhKFUq94XwIUtUFWjm8lCz/BSoqOonCm9ACKhmw
	 nvm4vDaOdZ9hdgycQ3BvJeKR0UcQC+goVxcZrakAKU207Xwo0qe5r6dPR8a4/EHFp/
	 aehiIIrJC3ydTdB81YTsyb6+lbsI5jEZT68fyRw7TuJlB/u83WusQSm+ZMv0DgR4F8
	 fqofhDQN/HPid9XBjgxUilDdey/yqa4s/JGugSjQrOJJV6nv0fTlCvZpr2RuwW2S7z
	 MJ1UMHIXlki3+JxdDCgIIqFCTh3WfOwRyCAAn/Q7DAqgz4IKdwQ086rQ4yUCTDbNjV
	 Mgm1GR4WXH+Vg==
Message-ID: <sashiko-outbox-170183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 08/11] namei: add an rcu-walk mode to the
 ancestor walk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261013164800.2906577-9-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <20261013164800.2906577-9-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:01:26 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vfs: TOCTOU race in vfs_walk_handover() sequence validation
--

commit 1f35bee40e8028ac4b024dd5a54b6bbdbb5b8521
Author: Justin Suess <utilityemal77@gmail.com>

namei: add an rcu-walk mode to the ancestor walk

This commit introduces an rcu-walk mode for the stepwise ancestor walk.
It adds lockless progression using sequence validation and provides
vfs_walk_handover() to transition an unreferenced RCU walk into a
referenced walk.

> diff --git a/fs/namei.c b/fs/namei.c
> --- a/fs/namei.c
> +++ b/fs/namei.c

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
Is there a time-of-check to time-of-use race window here due to the
validation order?

Evaluating read_seqcount_retry() before lockref_get_not_dead() seems to lea=
ve
a gap. If a concurrent rename or unlink mutates the dentry and increments t=
he
seqcount right after the sequence check, the subsequent lockref_get_not_dea=
d()
might still blindly succeed on the active d_count.

This would yield a stale and unvalidated path position to the referenced
walk. Should the lockref acquisition strictly precede sequence validation to
ensure the sequence hasn't changed during the reference acquisition?

> +		mnt_undo_legitimize(real_mount(pos.mnt));
> +		goto dead;
> +	}
> +	to->pos =3D pos;
> +	to->flags =3D 0;
> +	to->pos_flags =3D from->pos_flags;
> +	return true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013164800.2906=
577-1-utilityemal77@gmail.com?part=3D8
