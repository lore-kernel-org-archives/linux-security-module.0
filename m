Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D83EEAE9
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011401; cv=none; b=PZr3CdJjZyC9ha71bIvDOjzo+aumcpAkULBuGzuAjrBUIMGbtLMlZFJQngLwenGR+dv62WMDSjHQnigPSWFauOQmGa/1d22dAMvu+lBiBOsFqNQ0haPEd9QgmOcFGhh0AaHenfhSxoGb3yIMZAW0o65E83HivAHZL+L2tnmgxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011401; c=relaxed/simple;
	bh=d1mYDlQCiHaL+Tybjk1tWrewmc4l5GkBvp6siH6j0xo=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ov3jRdHAv55QDKgeky/YetvEagmz1h1LPW5XwzwHRe7p91fe9Jn/lXIi/ltNImnV5svrctMPs7qf2XSJLG8iCWobkdfaLXcXZURRYUbUzAH31wAf8UY5WgJR3fzFqvyUrcwkK1G8HmEpdlZi03pXpsooAF/GV2KJivyUS6CejBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpYfGGiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpYfGGiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479BF1F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 20:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792011400;
	bh=LGbZi4cXU+kfaLfjIm5hXxliMcqAqCFWopha0tNJt9Q=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YpYfGGiSVRUrE3R5oNUrDIZrR3H0sgRzU1utAtesNduqd4baUbIK2xdXK7cngpgeJ
	 ACy2tLWtXkwsqNVx8+IDTc/Sb/n/hVDxqx2XWnHEWNgxz3wneomXXHui/wrCgScMXb
	 V9Ed3VpkXvK6VVBOo4luxhnPjk5CsyJK8ZOF9TWcRZQQw9rj0B5BsknrFJz2vpG9EK
	 QYhmjMx3UaslpbkIFYA2pLyY/rRERWFis2WT8/k4WSdHyXQqumRaQL6hXNdhATV4dd
	 qDG85JxNvnGKCXVFld7kVa+tkuAWRauVP8+oRlRwwDelaU+cOKn3mj5//1kOV/QwkK
	 Is60Bwqg/NaRg==
Message-ID: <sashiko-outbox-171917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014-b4-setfcap-userns-v2-4-fac4d19281d7@toxicpanda.com>
References: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
 <20261014-b4-setfcap-userns-v2-4-fac4d19281d7@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 20:56:39 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> keeps a root process without CAP_SETFCAP from creating a user namespace
> that maps uid 0, in which it could attach capabilities to a file that
> are then honoured outside.  But the map doesn't have to be written by
> that process.  A privileged task can write it from the parent, and the
> file capabilities are not checked against the outside at all:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>                                     unshare(CLONE_NEWUSER)
>                                       ns->setfcap_level =3D 1
>   write "0 0 1" to B's uid_map, gid_map
>     A has CAP_SETFCAP -> allowed
>                                     setxattr(file, "security.capability")
>                                       rootid =3D kuid 0
>   uid 1000 in the initial namespace:
> [ ... ]
> an unprivileged user does in its own namespaces.  The rest gets -EPERM.
>=20
> Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-b4-setfcap=
-userns-v2-0-fac4d19281d7@toxicpanda.com?part=3D4

