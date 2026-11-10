Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316547;
	b=M0hwFos6QWELaRnFI3f4R0qYTZF7bg/xbpqvn4SqCEB07GMS+AgoGtc5BduI7nB1ZyxR
	 8YlK/C65GATYIRPS+a2i0rFD+JEYZgFuxHqjf+KyJuTKyBk5o3n+c8Ml1Fv4uGQwGU9yf
	 Sh60A1wS0kscimCKKE30EuMYgJXKqV/9mSnYp6H4cHMIOJD7RpFujjaz/JL33JWWfwjpw
	 l98fvyHJXYo9UWf+tqPIQVl3R8MPBe7hPLHIiUgb/DYZTmPQF5g2gfSYohmKNLKRqBo0Q
	 ARFqaT5NUBUjyj2G0ybU7iEXftHoeQuPojnK06S+Br1O62sTbVEuNcCws9mTjMKCobg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316547;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yIQAMOsH31ed6r5be69pN6yLtji8R7xQeu4+orzyXdY=;
	b=biU8xs+W5ThURpthuX6uyj+Gn+aJZCwTfm+jiOwmt+pI6lTxGt8X62aELo0PPadHKQg0
	 ksJO16UwrjbROjWR8lKYMVzKyK86/XBOUCZ2HnY5+ajgH67gJLHYyApSVal7EOln6FgsM
	 lQSIdvuo+0GsPB4VuHQLgX/X/gucs0fACT6n0H5OFxjEAwW4DWPpTDXLRQ3iAZ+N5UgcN
	 Rwm4cdKoKiz2Em67E5LSHzj81+7hZNp4e+0Mhza9VOAix+KwmZGGcK5B0a8jqmAg6m5wk
	 gqPgdb4vfY5JxRAp6aWBDbQ2YdEK1+y0Lo6gAizyQS66Ghdx4TNOpD2TD3KNbiBhFXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g8LoZTq/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB352606E465
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8LoZTq/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A3B1F008A6
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316546;
	bh=yIQAMOsH31ed6r5be69pN6yLtji8R7xQeu4+orzyXdY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=g8LoZTq/1sjWJgFJEzk+SID9AbDr1G0IDtj9KBkzJjsmo9HBMRCS6BUdGpA5AH9AI
	 xDKodaFo58/yJHWOteG/K/5M1twXgAewHvrM/dapdLIl40GZ6bMMngQ/EEaO1BI4yZ
	 +EjY9xbR20xnPdQb2IHvrPChCeONjryMSjdg6neK8k3rH9qscGTX/fRLDEYV4TREpi
	 O+VrjCJehKvPsN3S2diK9h310CAamSe+8p8pyuiuk+H6v+cLKQtZV+KE40tMBSLarg
	 gQSyUGcJ1X4eeSJKbA2wv2+jIF3qCezGDc0WCOPYbWUrV3hN01W4zhQEUjzsrWbSXG
	 vbWXs2fuW9w3Q==
Message-ID: <sashiko-outbox-207106@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v2 7/8] Documentation/ABI: document the lockdown
 securityfs file
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110132818.2231593-8-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-8-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:15:45 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Describe the /sys/kernel/security/lockdown interface: the levels it
> reports, how the active level is marked, when the file is present, and
> the write semantics (escalation only, EPERM for the current or a lower
> level, EINVAL for an unknown level).
>=20
> Also add the new ABI file to the LOCKDOWN SECURITY MODULE entry in
> MAINTAINERS.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132818.2231=
593-1-caixinchen1@huawei.com?part=3D7

