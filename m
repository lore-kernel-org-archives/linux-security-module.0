Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694850;
	b=ptxfou7DbIxqPcs7aJNM1hu/iQAHOe0gJuMpAffSr3Wy6yXWiq2+wtXeol8orWaLaK1q
	 IFkjpCVx9rXz6cC9bDch2K8K3b/n1A55mMc9SRIQWqF4xc0LrjzL+0wVWFTBR/2JzAa2C
	 J4dSl+3t1ec6E79g49kvdrlTKS1T1/u6mIUmo3Dqb5sL6b6q12D5fFIV2noXplrlCkw4f
	 MPkhDEX+17S0gjITF/oEi4t7PPmANsMrkn5cjpYnkP7B2dU++RemvDRZ2aPhULVpvoShk
	 JRYD1KywwDTp+ex0jmgak968GgynHW6bENMCu5c6k6Mc7PL7ahw9tbHYkSQeGnAJMIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694850;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=38v2WGdWaNOmPEUTJKRr68QDEp1kBpoWwKVplmkiE2o=;
	b=JpaHkbzzp9mtUGYjzwbujNMC0QHBiGPiX+Se4Tk7lEKehxsDhdDni+8l8fPEcYE7YtOy
	 fj7+agA/vYaJSsD7dizUH+lyH5N1l4AyiwLeXoWU89EoLhkWiK+M4Ir7ErTvIoszTb2vZ
	 wM35pPbcoMWazSEmfN41LHYsdhpvEwbkb8pYLqAtxBXLS0Jbglfxl15zwqvwngxpZQokg
	 vKrz2yQE2tJxWsyyedFx+LPfUeE/rm7ee+QBjaWkux4/DSt5L2kEvgdHxNTr5ajNB4KUT
	 +sqLnP+kzcSiZqIhQa5kHjtrmH5lBqqXbCwO5ahvxHmvDpxD6t4PGneVPZxY/spYHjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uf1g0dG+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87167606A319
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uf1g0dG+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5C71F01825
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792694850;
	bh=38v2WGdWaNOmPEUTJKRr68QDEp1kBpoWwKVplmkiE2o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Uf1g0dG+sQweDEHXJqDBvU4PkLINCwuVW21mCZmTP6y/v7jnq+B7T5mqvi/Shpy9O
	 RA++iFEPaYiby+Dd7084DWS/sA0snwixmSktcmZUgBwz5kst6fuzycU/iyW3f/0ZPX
	 QW+RwO9HJYZwpjyARrMPH8to56Hc/jOsBOrrbgc7sOXggZYW8wTlXRMerACLCIELEo
	 APTcSs9u+lymnJ4ODb8OLT4MTOwGZeorRMjV4/I1ak01PQZbZkvJoe3rxbRnriAIQj
	 SN++xyT5JcXgcDCkH29UP0rWSxjIwNKGe/arJkcN7gpDqDT+ubji3YIi77zRGah7iv
	 TljycK6FLktaQ==
Message-ID: <sashiko-outbox-181935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] userns: don't let setns() lend CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261022-b4-setfcap-userns-v4-2-88aa0ffaa08f@toxicpanda.com>
References: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
 <20261022-b4-setfcap-userns-v4-2-88aa0ffaa08f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:47:29 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-b4-setfcap=
-userns-v4-0-88aa0ffaa08f@toxicpanda.com?part=3D2

