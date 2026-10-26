Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792997931;
	b=LQ/lNUxf4b8zRMEJaAZQ1niOdrnFLwzenYskZ8Dl/nbqWJkC2rjbtMOhSrz+34TeCXjg
	 /7bLTWcL7hxqpgg6qow3NlEpfsIFKWsy6EzdXDN5tVIp+lrWyqyCDtpGSRu1/FWvoJGJv
	 DRg/EB2uO9Vp+XfiEFA+JHtC23zF04cca7pmcq1FoG+SLPjKhBwbE3Xr93b2g6Be75QIi
	 QJrZ5xYT3PSzgYPQQUu7BpbH3XwsRcuO43MLY17Kwj/+7CxDZYFUJbA5kDphD6ikDrm8T
	 LcT2e8qgqCHB44AGFQQiPLrUKtjD8wsUQn8xjSIQwqR2NVlOsmju80r9//J1Jj2sllg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792997931;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A9ScBV72TW7/CuZjJZ5GnVQQvndOxt3kGh8LlqX643Y=;
	b=KmwJ9KLSiKli4D2Zs74VFpOc8R/JvtzchaU/4mWVuCr1bjwHVVquEiy6J8VkJHqCJdo6
	 zEMIpd231T67f5r/2Ir+czxnnPULEZmuOMKfQ0kj67UoFY8pQTxQRDvwjROqaPJkyXZ9H
	 1UBL/IYEXxWU/kkP7rABeM/f3hx+sa5ws8n4ECyPhypGGWdEc6hMA0+5WUumOK9MLF/j3
	 rpgOPdxNByQLBZEica1DmeidyPVnpa2r6Ir74UgWK7ioy6I4X2gySXw+yenDKaqAYNv3Y
	 A3x8mGWh1VoYghM51m3NtrV8u15E/uy6fzWnJ+BM3lBxvxaPu0sXPmAOmzZtg9rcn7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htpCrMRf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A89606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htpCrMRf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A290A1F01825
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 06:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792997930;
	bh=A9ScBV72TW7/CuZjJZ5GnVQQvndOxt3kGh8LlqX643Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=htpCrMRfLotyJ8r31ezcqTcDW5I144KSu+9oEF6mGzpVbPvpwqufIKd6y/W2ijKxb
	 49FyGKBPSKlIVVkp9OGsMlelpL7waJ+PZlV93IIoDRob08LsKlfJ8s9xReT1CjaJdV
	 xcdTqeU1YcUIyaATGHdGQW5qXo8ZBFxcmsYCMPjIqBBTV3Ux+wEPvdKfDTs+cRapng
	 nbxY/aSG7/7eJse9mFP3hB2FEDxUcG8i7sfsz0cVTOFlZv0lbvAWaL+GH6j8ZcPRLK
	 Cd7xMgyfyZZ+VY3lGyvtZtjcUVsCvj5JwHCoADyg76npkstVXiRf/c3v/rsnPKVXBt
	 KGAutNZlf1oFQ==
Message-ID: <sashiko-outbox-184637@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: dispatch key_gc_work to system_wq.
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261026031219.2627968-1-jarkko@kernel.org>
References: <20261026031219.2627968-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 06:58:50 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> schedule_work() dispatches key_gc_work on the per-CPU system_wq, which can
> choke the queue:
>=20
> BUG: workqueue lockup - pool cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 stuck=
 for 30s!
>=20
> Queue the work on system_dfl_long_wq instead, which is an unbounded wq for
> long-running tasks i.e., it has the WQ_BOUND flag set and thus cannot hog
> the CPU core.
>=20
> Link: https://lore.kernel.org/keyrings/20261024042944.52493-1-hackerowski=
y@gmail.com/
> Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6ad35b60.7952420f.283480.0360.GAE@goo=
gle.com/T/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026031219.2627=
968-1-jarkko@kernel.org?part=3D1

