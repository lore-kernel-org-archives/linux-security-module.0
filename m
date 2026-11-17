Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945964;
	b=WNCdyw70CTu15P2AsJW3u/UQE4IDVrAuHp0S+PKn/lggq0GSF2IIEUdDS4+gKRG8o0Od
	 0aBQsbIwhuVueTDLAnRHO3oZNfiCqAggxXTAXKvjLIayl0soTW/eYsbZnWsVqIa4yyebR
	 Unqwr7Ia4GxWjC0q4YPjEy2kgkuyYtbusli9TkG2GEKEbl66lUJkfhCcUCOWStpDTuxIX
	 RkKcbQaqUC5WYCWOP7od82tcUp+VF5HFDK0uNdL6p30sAbEjlhZwyhNZPphsywl/v4RUe
	 8C+F7DBNtG2EMLxO0kuH+9EpqUO/SSM3UqyFXIQs3KgV00nRzXdHYkcCc7KaNdMoFUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945964;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j5GmHmdoSihEqhVppVfspertnRhstGlqNjvS7J83Byw=;
	b=Wxf561yk8gUJpO22pWDXCULYaE4IisjOfh+NsO28+SGWIAedpvqjiewfE4SIUZ5c71IV
	 2Fi98D3FFeoIhnKwNU8lCNmRW3N6G6HlDgdSdv4SlyWQ4N+TTpqzSzDWLeQn4ngn6fZPA
	 ZHwBjk++M6p2LQjVlyjkwEz9b+TwSTCMYMHi24pZj4Dqq+F7jpe+n4Y66w/y4wcjLqAOZ
	 /BC6UJZaHPn4s/C0ycqZRHpxPLxPBsjwPHJNDL/r/9MZ3e8vLXHyvJ6iPoXYkGh0g2KtW
	 iVu4dEzC622Z9QqSYaFKuXZQN4+Ht8fdC5gu+jaL3e1x0LAYxgrYuYb2Tj7MT2UWyJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPt+h3vO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C4606A331
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPt+h3vO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C6F1F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 20:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794945963;
	bh=j5GmHmdoSihEqhVppVfspertnRhstGlqNjvS7J83Byw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nPt+h3vOGg6MAVtIA2ihimawmOFvoZPqewTM7Uipk68Hda5Ovn+W2phK3RE198zTM
	 eQxJy/VB5UFSQGokV9WBM5voN6wQv9TQjG6bTTO8TLNATc1jZjOIxYkZm6fTv1DdGg
	 n0ePl6VVAGOIfq++Ui5h44wwYfefZMpsvmn+ChdWfZ5h6wzOmelgWQsbQoOT+0YmWk
	 is3DW7M44QVa59kM/pkUQX4kSMSDqE/cBwzYQ8tWnF7BqJIiBPJ3hLjJE7PTf0yiOh
	 jqGKpohuhFeS+7RWjp2I0mtg6rEnQpt5f0YFIvt/vcPLsJ1rDva+1Bak4XwCiCWSd2
	 m9rnDGhe9ge5g==
Message-ID: <sashiko-outbox-219557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/3] userns: don't let setns() lend CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117-b4-setfcap-userns-v11-1-2be11a2c32f4@toxicpanda.com>
References: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com>
 <20261117-b4-setfcap-userns-v11-1-2be11a2c32f4@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:06:03 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> A uid 0 task that gave up CAP_SETFCAP can get it back by joining a user
> namespace that another root task created.  Commit db2e718a4798
> ("capabilities: require CAP_SETFCAP to map uid 0") keeps such a task
> from mapping uid 0 into a namespace it creates itself, because tasks in
> that namespace could then write file capabilities for its root user.
> setns() gives a joiner a full capability set in the namespace too, so
> it can do the same there:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>                                     setns(A's user ns)
>                                       allowed, euid =3D=3D ns->owner
>                                     write "0 0 1" to /proc/self/uid_map
>                                       A had CAP_SETFCAP -> allowed
>=20
> [ ... ]
>=20
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@ha=
llyn.com/
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-b4-setfcap=
-userns-v11-0-2be11a2c32f4@toxicpanda.com?part=3D1

