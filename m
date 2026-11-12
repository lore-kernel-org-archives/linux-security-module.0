Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521867;
	b=V4NQBnFr8AHd8TSG7bkVPcCGjG3My11nMo1OQ6vpO9RK/UvEaIb6/MS6YH1wYzoljKs8
	 j5x6p8kdbQAQezURRH2QCSVM+d5gAZpVuQLdsyNie9vZcmBnKrX3/IUC3SCflo+MOiRVJ
	 +rhPzWn85R8A0YpqYYZAN+VfRIRoF/7vLmRkRdGw0CD4SCB6XcG0z92QdqIp5AAgOPJ7O
	 KNAWrl4ndEvxx/t1Qb8moP77AKu65zek8aLfUK1OOWsWw3eFe6EsMfkHm4bG1BcgDpawh
	 G0FRBLxKF/3DfwYRcxjpMHp8IMtS1fzS2tWuecQdGaJP4MJirwd6VUK9KGkcQFkB1xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521867;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MON5mT4J3yXxiiVSCmWKlSStXsmz6yog5yyJ8Wxce8w=;
	b=FWvHGGd1OeYapK0d5zj8LwcrhSaA0NhT65X6AyP0XkFGg4HELqNbnjXjDvD3Lmg9/ZPi
	 xcNoFL60zgbJDpyhnB1/StevFwQvE2rTF90hv6nbzG2KN8uEXM154lKd/lq/D6AkvLjU1
	 iAlbrU5v3O7/sZjmxDWh3eFEtZimywzYqLdpjbl4lqI1lMWGWPfX1oMKJGxfEUov+jm3z
	 gYRgks9aIse5Rg6DRma/jsUPA4iUvjaoIssAkYvUj9E17gEhIuzCjBHUTtU8iFIKTSIHj
	 rFXgc9pI6X5xhHsjZeLWvac9621YnLzoqtn5UXbLw4EkjxWkStI3haF3diu+2gkitFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSuk5Xi8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB1606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSuk5Xi8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A281F000C4
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 22:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521866;
	bh=MON5mT4J3yXxiiVSCmWKlSStXsmz6yog5yyJ8Wxce8w=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VSuk5Xi8m91NincgWCHLCo9BeP2+dTetNr9Z9D8FYANsuGNuso5jfNTSxEXxtdsT+
	 AfAK3/tY2mVEl8ESJD9rwBk697+CvgnLNUELH5a8IqZugH61aqTAEAwLiCfXIMKcYN
	 RCLe2xW+/IP7PpZ5m+qctAiF/rtJ/7qk2QFaCRxU6ox2zyxG1AHvrQw8PuEsmeBoER
	 vhjCY4Zqcpz2Nj6i7cnV/4Jx26VWOlWU8YV5lsWu0pt72CUpIwBx9R6Jlmc9gcTxwT
	 1HYclOehf4HTh3/yKptpjSq+n7GLrDrForTk3f3Sik+wldnKxt5joSzj+qxNCPlfXC
	 Iqdm8PjD+pILA==
Message-ID: <sashiko-outbox-211900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/3] userns: don't let setns() lend CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261112-b4-setfcap-userns-v10-1-84f6f7faa903@toxicpanda.com>
References: <20261112-b4-setfcap-userns-v10-0-84f6f7faa903@toxicpanda.com>
 <20261112-b4-setfcap-userns-v10-1-84f6f7faa903@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 22:17:46 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-b4-setfcap=
-userns-v10-0-84f6f7faa903@toxicpanda.com?part=3D1

