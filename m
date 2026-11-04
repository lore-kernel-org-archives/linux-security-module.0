Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802472;
	b=VH+w1WXJunJTDr//FGcaGfQ7+5wA7uuAf+Lq6Aqzr1pvDlWTCOC4T2B/wATDp57piul/
	 +AfOzomXxsaFFzUlCPonoetPfMyIB91EXGIDFvuu/NQmLVxjP+9eaAUkUkIb1AYH2oGJf
	 gml1eEK8/Zo5SRItQHXZ26D/FvALxpHvIM69eHJMP2VPYmQwA6K3Jucfbc2aAzv92a0JJ
	 mqXyT+aclFFxeCcT1lsx9OQtPy482EK/kEfDtqnKd/V+v+bDSgSyg9zj6d6k4XbKwBk0x
	 h5xSnVMBn2X6YihB2n8HB5UNwpQmAauwdzqnUi5sZcF5k+IpC4fAqFpuJXfmtqHG9Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802472;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2ya5QXEnct6OK69AZUCaGKRRaskyS6Q2HCu3XOg2ZII=;
	b=uGWIdYlhwJkoDt/4K2bc4VfoxKbHRtHk2MwEOLnerz7dapGvuRxavVHEFll3n7k3hMUd
	 bNJ7XFo1RO4woUwj/9SfCjPu2YiwApibz9NevckFmjhu51EAHRF47i0Yy/uJoC+I6lsg0
	 CZHB26bOphxfoGb6pnsPg6CKLGlD8r5gl1oIdkvPjMHVGjnPEmpSICU2dxm6WtbiKX3CT
	 2a8VnpEddTwUmXxeVTwmfQATuAa/EFmGyHlral7jSPjV1149nNPVZ38wKrug2SoEXYlkr
	 kTCQK8qzT0zWZwP+yW6rmbcSAs+Yu3F6tIyGZoxD/oPvoePSL8BC30GMaasuFgY+qbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGNtN92R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C400B606A326
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGNtN92R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833BF1F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802471;
	bh=2ya5QXEnct6OK69AZUCaGKRRaskyS6Q2HCu3XOg2ZII=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FGNtN92R8A+S83W1MpfyyFmWgxVkhgz60SdD+2JXJOjQAIbcdLsokR+bYDBvxcb4z
	 r1ilBKygGV34ytZCI0q/s9zCKBg+JGwxI26w6nZn3RRnERlNCCOTdaOjHHGKgB/0eP
	 eLdUW/QRd2vCo06M9Qnq7wtzAfcEMEa+ZmlZPN1OC64J7rt6bOmXsf+jchK9s4WjW3
	 v+evw58pvcHfUcjjcUnjT0hz/S/X3+8v+Tl9jUCqP3SceUUw7jwS5iF11oRQyUT/a1
	 eK9hEFPv01pAnbtN0k8GtvmmjnZnczaHY1+Uy/Q+6bNLtLGOXZ4+7H32tH6Fc5uN7N
	 EKTxo0fwA/aPg==
Message-ID: <sashiko-outbox-197431@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/13] MIPS: use cred_ids_allow_sched()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-b4-cred-ids-v2-6-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-6-956213608f16@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:27:51 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The FPU affinity code has a copy of check_same_owner() from the scheduler.
> Use the library there as well.
>=20
> No functional change. Compile tested only.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-cred-id=
s-v2-0-956213608f16@toxicpanda.com?part=3D6

