Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342498;
	b=zpJ/DkZul8pjGJFSpKAGMfrzKhWtEC6CRzuEPNWLbjMkWpCv03R9wYtdpJXOFUVYePBB
	 41gnkNAQ6KtJP3QFMnRwt7TeVCKvR2TbqmEyIOSWo1S7XJ65wOa6pX7QCVnbXdL/9eorJ
	 Fayh12FwQy+OXFY6+qp3BqRhvd0hjGAaH4dIAQYFoJ9xVfV9O+HfR2oUQBhc/2Fahm7Xj
	 Lswjl/LlrMioNyDM0/VXNiYgtKEtNYmMkmwfGNBANuX5RgJZl81tcv6Nh/alFsABjHMfC
	 hDPyTzzftsoA+7ATyIPbmu7lSNJmiN/dNF/j7TDITVOWP5ROKSFgCn4yRsED94PLJ5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342498;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C/Y5J7CbIZgM0RpIfcsxrRlhpiYdwGypY7RusdLwRvg=;
	b=n9kXFDNbP6o9DgAxAKv9+LL+a44RRlc1NUOi/qgybR5z9fag45+QSCs+/q5k01piDacN
	 aUqL3WTmnyWql/qvVvuFKzdQbV3JEQD02hv+PjQdkz3ffHHWwMrQxv0q1DkryDXHRtt/6
	 JGRtwXh32XD0HEBdRa1W/y961uRhbr9F6I9Kv3IrIUIVzW0tUFkt4DkQ9zOrYGHoED4cF
	 fpeith3LwzJrZiH3yx9YHQE4jjnZFwU9JpRRTj4xhOozersJGTqmzqHaP8bFc+sCxRtiZ
	 THhIKG7p6saJKl6HPn3JGRiPGho+BlgPbPPjJFkMUW4b2dw+aj0kl6FAZlpUGSj808w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dK9owr0n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D753606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dK9owr0n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29FA1F008A1
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342497;
	bh=C/Y5J7CbIZgM0RpIfcsxrRlhpiYdwGypY7RusdLwRvg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dK9owr0nNv0sT2RMTjMMkFWklRD0xOSMvFETLWuCcyWovMdyM+mW/0Grws4hSpK2p
	 GRXXpIrAgGay99R5VgzkOqq86zDb0B8k9jXpgU6AnV1T8RmHeuR78+xXvLcviBTX4o
	 3FpsJ0Ndef/NLfmVt2th3GeX+lcHthKop/kYv5igUMiiKz3nNG8owDWU73jns/mub3
	 +mCMVtTgXQFcQDu3Mpph4WwrRr6RvQbubpmSQY2IG3N77m3L+lKp0D9rG4MFIdO2RN
	 3xrCmJsusRrrrrKHG/jdK+n5mneT7d5LuvQPHzMzAuI9j9WvNo2z1fO4GLYbIHPHWv
	 h7lJq35quFZhw==
Message-ID: <sashiko-outbox-207709@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] landlock: Factor out capability denial checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110202436.2408244-2-mic@digikod.net>
References: <20261110202436.2408244-1-mic@digikod.net>
 <20261110202436.2408244-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:28:17 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> hook_capable() is the only place that checks a capability against a
> Landlock domain.  commoncap also makes capability decisions from other
> LSM hooks, and the following commits add Landlock counterparts for them.
> Move the check and its denial logging into check_cap() so that these
> hooks share it.
>=20
> No functional change.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110202436.2408=
244-1-mic@digikod.net?part=3D1

