Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615705;
	b=rojder8a16R4jxtu/yT7Ep3/WwHkBcAU8pZrwJrM43i+cBF4DoCjzHDbcu9fL/3PHLKp
	 v6P4coqkBFf9C8TMWnkOf/jBRIh+AqQleTgIMBqioofqfEABeT0wtxkR5ogWAxjd96hts
	 4arL3CicDU1W+Hpa71eSzzBivH90xaWUORrhWOgoBkmOtoVLRTHcAPy+0keFVZSAw/i3H
	 fUTIZqoUwB9iLpsAHOzYmqufrRJoGv8uHnuKIPETRfeKDIEraPhPF412cL36yqQDP9yWF
	 wm/G5jphyWZ1fsvuT7zl/LsFXDd0Wf3jE8bXVh2o15LNdTlBXvUQigMFH5JYH3LZqVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615705;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sjfXzbh9wtDphe8rA+Shh5Iq7IbByneQQJKYVGx6uuk=;
	b=a9li99KZUZ0veZZLwTaJ1ZF3AGwd/fd9txAlqvsjc4aIs3V+AH73z6ho+VgwV+UJ/d7I
	 BASFylJoaXst1HUuNRdvbANXp8J4UuRZ9zkyWWYcuNVcszmPZTCfanbn+zH4gQxIdWUZB
	 +kbDp9ltDydelo5s7sR8s7j3lEBL9Edkn/bjS/RkKaj0wTwSIl/BMOjsAH3mVdAxvO5qx
	 RvZp53oAfN1URjEmrkFpHJ1zkFiWFNg6E/R4UfcmvyUEEBsbVz5VcgyD4puVpx4LbItYI
	 1cU3BK5LVumUmNBa7r25MMWx3ftl5vygdPQ4tYMc78pLm1CEP52eaFc+ArRQuFQnNHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikvHQw57;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931FF606A319
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikvHQw57
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD3C1F000C1
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 20:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792615705;
	bh=sjfXzbh9wtDphe8rA+Shh5Iq7IbByneQQJKYVGx6uuk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ikvHQw57HgjDhY5BC8ZRoHF9mL/OXLdkSEAKSQbUPtqLp44Y8/jzMSwR6dm6RWVvn
	 Ilc4wQ0fyhnEo5QJmuikxwW6+cFYSasTRSqXustYFwRcw7c003a6aYeDlgrdOyJ3rA
	 p4mXo4LpWUG+Yvk2O43Sgh/ch3+Z+uSnZO1IXOV6Dv818KZlers54+ehZT1KvPMAhG
	 T2b6DR9I9Vrtf8UxYVPy64NWjp2mTwIqKJdP2ZVzjh2MNkzQTDA7xPuje98bVI80sq
	 wwD68YyD0DftkgbkZ3DmQ/whYti0w/AnkQRfjqbtRleIpndx71kPqZCk4Um8uHEZzt
	 H3y2APIAc06VA==
Message-ID: <sashiko-outbox-180650@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] userns: don't let setns() lend CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261021-b4-setfcap-userns-v3-2-97c7ed4e43e1@toxicpanda.com>
References: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
 <20261021-b4-setfcap-userns-v3-2-97c7ed4e43e1@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 20:48:23 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
> because a task in such a namespace can write file capabilities that are
> honoured in the parent.  A task that is already in the namespace has a
> full capability set there and can't be asked any more, so
> verify_root_map() goes by what the creator had, now ns->setfcap_level.
>=20
> But setns() lets other tasks in, and they get the full set as well:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>                                     setns(A's user ns)
>                                       allowed, euid =3D=3D ns->owner
>                                     write "0 0 1" to /proc/self/uid_map
>                                       ns->setfcap_level is A's -> allowed
>=20
> [ ... ]
>=20
> Link: https://lore.kernel.org/all/20261021-bioenergie-allheilmittel-undur=
chdringlichen-35666eb62cff@brauner/
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-b4-setfcap=
-userns-v3-0-97c7ed4e43e1@toxicpanda.com?part=3D2

