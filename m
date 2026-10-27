Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112027;
	b=ZAUeMGtPpBCysNjQd8yD82ZUWbY34tWsR1J6qZUIZ437t6xiSwgx00CJVoa0uDbccy2P
	 MiwZ86wFcqcABjc5zlxXDobgWgp+Gnf3Cudgy2pXWX/uv83sivKno5nfYsZ20xbQKswT7
	 XLIjSxvQnq+6DfWCNAmYTk/lPqsGY3sGjFlh1ZMfJ6vFi+KjJGq21gvrKpWjSED53RGoh
	 p7TotCFNsHEuKceRhkkHnLktM0RuyB6xrWYovujNxEqtamXv52rF/mGMrfjOxsTVlbjLr
	 DQMBStmdcz0DHYc1v7/mkEh4M2zRXIYRfE8ZB1O6Ogho0kTLiB1DHoAcBXMzBorH/eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112027;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EEfgA4xmqJxZOHNwQqKIYvtxlhAz1q1Bunnzi9FZEc4=;
	b=4Q1XKI3V/VmzXJNG8nrq5ldByVUagJsHVZKmHzUdulM8/OW4DEi0rQ39XFBkVIgui+t+
	 0BajdUsEEZGeYf7R7FPdJh2bOqX3IvcNoRbyvEI1C2YXlh8iZ7y5GnypKs/ogfOikkQdL
	 TNrtKXtrhPv0yso4Qlq1+vRHwf3kWcasYf8jHSxYTD1dUKF7Xeee3x0011bHi5s8zhw4m
	 UdQvVRE/MbAVAdUJIOBa+43F/Amczkt2yvBwkZ2qseKKNiN/SpGdVh1/Wbtlujt9SY4N4
	 kFX6e9ohHPL5MsbqJ/+rU1EshwzPWlREmtaQiCKGkqT6mgo8Nz80y5jwFa4eE6zyxtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVYtEMW2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A9E606A31D
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVYtEMW2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F98C1F031E3
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793112026;
	bh=EEfgA4xmqJxZOHNwQqKIYvtxlhAz1q1Bunnzi9FZEc4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RVYtEMW2q/SOoh49G7fIwv2cbew/0eMIvjLrzX8XuFfCTKrfLBo+ZpyPCqBqMDlgI
	 bHb8beyRLdKZ01oorIJfVnuHhCNoqZoDcgigJc+eFq+aiM7cUPNql/3Cob/E1/VcBp
	 BB37KTq4afMaDb+bbhRJAUk/DN9WDWbg6pdOY5ztj53IXXdzPiH5Oy1sNq7Td8OMne
	 BrMxqYav8ObOrEOk4am7wGSZYzfuMmFN+1orvyClxz9OaO3zANG8Q9c+SUD7UO4wGQ
	 ADvLEgmaJoQMveZWYpdwFCKWtytGPTUodm4aWox+psc7IXrkKm/qQRubEUWnfz+kS5
	 hMel3sIi/EuaQ==
Message-ID: <sashiko-outbox-186744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/6] userns: check the opener and the writer before
 mapping uid 0
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261027-b4-setfcap-userns-v8-3-2674adc63f3c@toxicpanda.com>
References: <20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com>
 <20261027-b4-setfcap-userns-v8-3-2674adc63f3c@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:40:25 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> verify_root_map() looks at the cred that opened the map file: it asks
> whether it has CAP_SETFCAP over the parent, or, for an opener inside the
> namespace, whether the creator had.  Two things are missing.
>=20
> The writer isn't checked.  For every other privileged mapping
> new_idmap_permitted() wants the capability from the opener and from the
> task that calls write(), but a map that consists of the single line
> "0 0 1" takes the unprivileged branch, where only the opener's euid
> counts.  So an open uid_map file is a token for mapping uid 0:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   fd =3D open("/proc/<pid>/uid_map")
>   B gets fd by inheritance
>   or SCM_RIGHTS
>                                     write(fd, "0 0 1")
> [ ... ]
> of the root user it passes on, now fail with -EPERM.
>=20
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-b4-setfcap=
-userns-v8-0-2674adc63f3c@toxicpanda.com?part=3D3

