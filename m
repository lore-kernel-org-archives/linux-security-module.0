Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794077187;
	b=N2j4eZs+HroUTUg7FnMfjjr+87wQOa8mZPJjD1uj0rP1Vdz5kxg1vNjvfzIe0WqKyEfM
	 JaPKkQMIHSG3HKQPZ24+vcCFE1zqbY8szu645WVfRsnDMI2EGNLP85ZxWB3fZOP53P4YN
	 ZGdH1qpQ/SIA+bPm1A5GhBMMOM3rKurIyT66mmjDTjN9pKleKUdIoTAw/owfXMnerXHJp
	 WEthVXncjA2CcnTq/t5l6itNd+yB/ohUtX/LY1tOrq1/0o3ZDTjC4w6pn8WO9qPoiVmTj
	 ftv+nyWl8GUsHnI/DD+A8JI35nZKjFvMrjueDDLgyE8pHeISN/7oKKCn9tG42lWXsjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794077187;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HFM8F8WrEhcmaCEDyo35/uCDLsRPjFmLssYorAqYyeI=;
	b=AAPXJ7raUxG/NkuBK0R6yPoKZGYWiEwNNmhgy7eOZXT4bMIw5LrWSw7bcNrqJ7yVm2FE
	 e+jhjzHwgepTfMAoSIQKsCyMY9OdM+Ga1bXA3P6bnPHgJgOWYpEogH1uPvtLBrCJuh16S
	 b788SB5U1Ef94vMcixuExppAFq8GTncXF+wXVTR2mrVUuuXyC7rKSgKHCPgk6H5CWu5Xd
	 rc9/F6+kdNrIkOuwIedOzfOqf+8SOig1a8abVzPsK3yv/tmJq1L+f4/C41N/6LdIk4xfV
	 XltdytVXKl9k5PwUflKCzAEHoeShuO7BKVy/fWXLKMLMQOZ7IZAB3ZvhJt2LqH1eNXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S92Ve4W4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751C606A326
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S92Ve4W4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869481F0089F
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 18:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794077186;
	bh=HFM8F8WrEhcmaCEDyo35/uCDLsRPjFmLssYorAqYyeI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=S92Ve4W46ILvsFy2H3bDG0MtAAW0F72Kl5WXwX/dWKbWb2qycUVg2m6Oq65rJDVaW
	 07yOdciFSaVjP/ViVqOQrZRsHg/UytUs64jpJaISZw6q85E1qbi6hjXw84l6Lu1R0u
	 PASpHhuQgrkQNoxSWmgX8FbimC2dUYvQ+uDRF58JFef/j45UufM0HRoKb6FtrRhii4
	 fKljrsawCJU1e0W+9ntr3DHjxSRT34vyeFbQlxaxrqH/jckdesS0cxADJvik52He4r
	 eX9F6ok7bn1soOQtWuUcA1hZWeJPgL/EAcW1kOeHrt4FpB2KBpPJawpJJFaW0RL2r0
	 6n6dWyfLIki3Q==
Message-ID: <sashiko-outbox-203185@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: hold candidate profile reference during
 attachment lookup
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261107183514.1575928-2-bestswngs@gmail.com>
References: <20261107183514.1575928-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 18:46:26 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> find_attach() retains the best matching profile in candidate while walking
> the profile list under RCU.  When matching xattrs, it pins only the curre=
nt
> profile and drops the RCU read lock around aa_xattrs_match().  A concurre=
nt
> policy removal can therefore free an earlier candidate during this window.
> If the policy revision changes, the retry also preserves candidate and its
> ranking state because they are initialized above the restart label.  The
> final aa_get_newest_profile() then dereferences the freed profile.
>=20
> The reproducer triggers:
>=20
>   BUG: KASAN: slab-use-after-free in aa_get_newest_label
>   Read of size 8 by task poc
>   Call Trace:
>    aa_get_newest_label security/apparmor/include/label.h:413
>    find_attach security/apparmor/domain.c:505
> [ ... ]
> Fixes: 8c62ed27a12c ("apparmor: fix aa_xattrs_match() may sleep while hol=
ding a RCU lock")
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> Closes: https://lore.kernel.org/linux-security-module/20261105164839.6676=
0-1-shuangpeng.kernel@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107183514.1575=
928-2-bestswngs@gmail.com?part=3D1

