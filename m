Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802540;
	b=dKQVevtTRMJ5yNnbn8M9DfFQEP6ZMVfIZzxuzp6mMMcB5lvNVnhB4syGiXIMYN2KC5Gp
	 MGhoBmpXCSSDmsE8KQlMkUi/AEPlkty/mmvgjBBAbetOZFpcKsRfCuCsiggLTdZZf+1l+
	 0pImyP4KT54aU7XORT0iGTqNIARDv4DndVGO2EeemQFbo0F3uXg6PplbqxPSucZL6l5/j
	 6UbYxlqRRj9Z07anl+XKm/+FT6JDdTnQxrvcysuQ8w8jFFZtgX+questpi/Mf9S+O0i9k
	 hJTCklvdoXAD59ju6PWjDYIpa+WeW4UPrglvS6vqlrGpEcAmIul5/1cv/0CqMapOcag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802540;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ld9EyojUDsl8IU0E1bMtT0ZKbJF0aR5+NC5QDCmi9tA=;
	b=LEbqp5kP8Oih+ge1rI8QXFvfAyY1AZDELNiYJtVR7+tbRIFn1hNCpKHNKXkTsitjFe0f
	 Dqjr3PLpUcrOX0ruSZDFxdWtJmYAncZO2MyDOJsOZuSNd2VBEXbnqB0VvVieY/g5oFZRl
	 ybNKAUhMOn6XoEJJ64T7Cb9nifJrRyN0swQl5OyQC/rOq1MqO8n+5CmS4kQ0xW0OJxOdv
	 LukQVfIjEE734ce431gZfuBOOk3bQn4SkYtGGlA872+9SfzaArnQy/I1SbFQXH6rAyJiz
	 2sUipgS7qEliK0UQgBYi6VtkUK0+gj8HDS+3BMyfnScYcZ2l8XE62lEogdgd1/yinGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DsN+1h91;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C71606A326
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DsN+1h91
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CCF1F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802539;
	bh=Ld9EyojUDsl8IU0E1bMtT0ZKbJF0aR5+NC5QDCmi9tA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=DsN+1h91J5A9LpRMaqjueRLdah3pAHeyS7yfndlXD3XhO4NnKrKx2AE1JKKSbz9pr
	 M55iUy/Q0Doir5bKxooGu79xmg0qUC/GGV4LPB6tx+1VlZagDmjY2nJTiPfJT1eX8u
	 bM4Xhr84FdE6oFRIlMK1Izopf/Z6dy3b3I+TPTuzQpJVVjW6nuEeTcfRNRk9wamVwt
	 NX3DS6ty3JvaO3Fmj68k8XFTXitHe1P9F/XnM/1rEHtHXCnJm/bR+XiSp9l+jrvank
	 GGzRqt8yAkM7KYP5UycXIcm4aL5Zh5usjeBhDaNd+1DaMiE7HRRtLoTVox3ms2dHYX
	 pp7s+xE8wZKEA==
Message-ID: <sashiko-outbox-197438@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/13] fs/resctrl: use cred_ids_allow_move()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-b4-cred-ids-v2-11-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-11-956213608f16@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:28:59 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> rdtgroup_task_write_permission() makes the comparisons of the cgroup v1
> code, euid 0 included. Use the library.
>=20
> No functional change.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-cred-id=
s-v2-0-956213608f16@toxicpanda.com?part=3D11

