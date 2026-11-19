Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057647;
	b=udbJ+LZKNQRIzyYqOuC46U5REnQR/6soBX/+25LvS6jnDV6TSuJvutsZsxTam0eijE5t
	 5D8L3VZz9f/aTvZEOmvMW+BTxJxlu+viv/5BunO7xCAoIDkmHcGHYPV76/YshegVnOGnm
	 +BZZ1KN6pvl22eYHqj36swVcQKWbN4Yfxpf68CyaU8AZiSAsqpBh3KnnOK/47zJo6VdWr
	 4Y2SAcL4Fy7LxReidMILBvnz8sZ8ltkT2OfxvdyoeLrcKum59mXIygoYJBtlGzhjJLfbF
	 Bt7kmohjBvGIIgwyx7LsVqaBLhJ3m495bX9ZcXcvhJ8HD6594gxzP/J5Js2tWI64dcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057647;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cf5qRo3XbqFtCm4rxF7a/TRAnn7j262qzXYKRvBiaY0=;
	b=SMt0zbsc3qoGE249QLrLiBlc0MfvSmZCXfxsX/Yf9BCVaHVsWmTWt2RV87fwilqTeTvG
	 qEGU6eqc1akGr2gv19z7bHbaq9CCV1n4rb1XSrnFKSD16nNEaDBtSx3ZOLC9/rh0LKPXQ
	 5pFY3zvgCweCt+3xyZur08YZqFruyBOwj0nl1S0pmQi1c0D2ogEnmRHPngjdqws3Vdgef
	 a8r+it1A4v93LruLzeDIjxpcATiu8fCuI15A4t0wfe4rinSsNtLpyoHv9NBmA4p9Ip02n
	 fx3of6HvfyS5J5sfE9MHJ4poWbfPwxzm8WLYPUWRy7+nYVLnt7AsRnyk1dVy2x8FkRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iaJQNQ33;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBA4606A33B
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iaJQNQ33
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830F91F000C4
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 03:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795057647;
	bh=Cf5qRo3XbqFtCm4rxF7a/TRAnn7j262qzXYKRvBiaY0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=iaJQNQ33UxRZ18/r9ShrXkzrjvPdvD+JqfH0j0u4UiydaxY4eTJrDIj+oO3QhQV4/
	 kGm8mmwm/kcgoeiQ3FcqvecwqpOOiCQn7njm5hQ3SRFJk6TaTnJ3m3AsdQsevUM2i4
	 o/QNFkebpLyYuuHjEAOFeBZjc+muD9Sddd8rT3k08y2ITvClh00GmpBQWUnaeGBycU
	 3sSrKNY1KQaZBxhAszKdfHJU5XHTJxf6ypeWciO5cmpVYsyQ9ijnTj0LGgkD7qEBec
	 o+oVlLJmfyihzUGaDaCjUUcUrodb5sx3dXK/vQXdJkBCUalrgagI9ejLe3l7iMXnLs
	 WdOgfYA5W43tQ==
Message-ID: <sashiko-outbox-222363@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] yama: hold the PR_SET_PTRACER tracer by its struct pid
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261119025918.86247-1-ljyoung04@gmail.com>
References: <20261119025918.86247-1-ljyoung04@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 03:07:27 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Hi Kees,
>=20
> An unprivileged user can make Yama read a freed task_struct with the
> default ptrace_scope=3D1. relation->tracer is stored without a reference,
> and yama_task_free() marks the relation invalid only just before the
> task is freed, so a concurrent ptracer_exception_found() can still
> dereference it in task_is_descendant(). The KASAN report, the details
> and the fix are in the patch below.
>=20
> This is the problem Oleg Nesterov described on LKML on 2018-10-29
> ("yama: unsafe usage of ptrace_relation->tracer"). It was never fixed.
>=20
> Affected (reproduced under KASAN as uid 65534):
> - mainline 4405c18c95d2 (v7.4-rc3-230)
> - stable 6.12.118
> [ ... ]
>=20
> Link: https://lore.kernel.org/all/0000000000004904df0578b7d3da@google.com=
/T/
> Fixes: 93b69d437eff ("Yama: add RCU to drop read locking")
> Cc: stable@vger.kernel.org
> Signed-off-by: JunYoung Lee <ljyoung04@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119025918.8624=
7-1-ljyoung04@gmail.com?part=3D1

