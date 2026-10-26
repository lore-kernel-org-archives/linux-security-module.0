Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030089;
	b=k0Jkdz3Xet+JoasRdLiRmnIkUzaV9/Bs++yBL7fPQ8YSC5Eb9eaxsMmIg7Jk+9vUu3Qv
	 4QNzUN1IVn4r5GgWk/0cDdVq7/TGmPRpV8Zcwv7WfDcRdblTM08X+m5q/Bd4m0bf6XQA0
	 7XeLPtOiSVEYcOJRLdwC+Jz//6Yim1l6gxZigRsEQdbds7yhF0ZP5pqV0nPL64WeH1itc
	 AzsiXydT3Ehtk87bzc6t6XYcPn+Rr/MuACrXvNLVapA99qy4+t2md3dED9wkTNMR1t1wR
	 h7xREZR6vap8kd+gedqvxQbrVY6d/BWIPw5/4f7eU0IDzUwidXKncW4hqnkZWfFrb+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=STx+F3cRju/HY62c7Qs9NULDgPN6UBgh3od2+4e7B+Y=;
	b=EK+276jVWV37d8KLlMm4NjG5coyDRQbvogBteSJ1AzVfrEqjazBgJWiSjtT4ggry4XC+
	 snfQsU44jNMKwnO5/Iwq3OyOMMShV3vBPF3ZaA5HFciC4RgHemQeGx+0w6kDQ0Q8qe1XE
	 YgFvgRQ/CjApmqNOf3wFIbEHL3xUMYIRQ+fjffV4BL64q3YVKl2PBJLvJuFEKbwfEmMNM
	 4TRHt2SXNfbKu9J5JOS40gzAhlX2UphIMpE2NfUnqbBElSXIQHgCu0tE7zClVaPV29wWL
	 jtFp2LBntDSh+7aM2cVRsJrKcP2QJuCdhjW0b1oXQnEK+2Us65O4K641GHfpd1iP6/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YGHbDf/x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83653606A31B
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGHbDf/x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0248E1F01825
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030089;
	bh=STx+F3cRju/HY62c7Qs9NULDgPN6UBgh3od2+4e7B+Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YGHbDf/x1JdA8PKZfEJr4JkT8vFQYuOGetirNFPFh937WGR5M9f07RTIfzy+hQA9J
	 g/ceXSbRWyudHdUVJbPm80LWbpu9Q7f6qNRG+l331RmUc0d/RkMLGyJcasNZwVZHnR
	 5RqaoPGmhK5H9ehcan3qs4U/yNxKzMvJiFKmUsfVEfGJco48wcZIPoW9MDAxP5hAcj
	 E8XyDJphQQvMMazDbr8s7K85OpVcAnRAeYJhuhIiri+qiLJ+vmeB52fplYf7uycEP3
	 sS0FfJ7SdYUQ0Cv64EtUFL4ieGV5fDwG4Cy9tNS6rd2qwpqNLhDzpF76tBbimFiAp7
	 DcEg6fmVtXBHg==
Message-ID: <sashiko-outbox-185467@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] userns: don't let setns() lend CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-b4-setfcap-userns-v6-2-25f10b7ca497@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
 <20261026-b4-setfcap-userns-v6-2-25f10b7ca497@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 15:54:48 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-setfcap=
-userns-v6-0-25f10b7ca497@toxicpanda.com?part=3D2

