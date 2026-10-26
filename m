Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048851;
	b=At+WSs2WpWzGwoVyGoY+nVJ+u7t59sWaZnjbwNXkFzhaNDLaWFCXdmZ0JTfs28Ht3Sy4
	 N2OSeZR0FjwCuHWBDlU7KTSfhwqtC3edNOUl+vHlj0vqSBgGqt3t76onnhIs8yUCQzHMe
	 dIi7bmgHDnZoz3Ua6zcMLejDfYKCVMDZwZDddiyZ1iz2nXdiMGNbIK771uJ3wBpIHmUyn
	 0iRblwae1pZHnThGu47oNmqlnWR1pHFuleXg5Y8s6YwEUZ8sscbzarc5QZnsC9UA4XF6N
	 iSYvGE31QnWdaWmeotPMCUcbsGRl57cGmQXco9NYylY3aTV8mMhFwfNnEgyFm2kZ01g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048851;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mSFWDBmVCOgPeEtf6IZFW9wRql1SBwm66+3KK3uy82A=;
	b=XafKoIjbRoF2bepGLxoG4+Clks2fJ0kOKGo3lGbvTnV8sdtVfKS0YB1GgseZQY/hV+go
	 77yWevPiNEpnuxhgHBEgSQ8Bq1MS5pXR10jwwMhMorytq8KNbbWUMTriFvkKmOGDwiYGk
	 JW+JhniqsMdfhM915G7Mje0PkkMCv/MpHXu0ln/IIsFVWGS/Ou/X99v5YNAoXEO9C/rXX
	 HLWM9NnDuTGCFdnLZfxjd6eqp2GwwulYYpeL+igzStAiV94eps0XR6xXqjObp4VyVt3CB
	 /Lz2q45tQziv/1fhwdcYhEB2kz8yufGSK9oHIKFQk96hA+4JWisQEqBlEY49a9+fzXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZ+2klp9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59F606A31E
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZ+2klp9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3580A1F01825
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 21:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793048850;
	bh=mSFWDBmVCOgPeEtf6IZFW9wRql1SBwm66+3KK3uy82A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nZ+2klp9N7y//DLejWn4TGhP4vH938bkznlkN+x7i4eZFNBR4QMWoCUMpOZLJmymn
	 y6UaQ5YtJB4cbzR/FW/i+I6DMPh0A0WLXcW+Fx5ub1Fn9pI84l9KRCE4SKkpzA+oGF
	 XdnJ0sGEOZrOit9yW43MPpx0QYpd80AFHmm/uybDGL+6xzpoRsucM91risB6wJKO0v
	 WhDgk7BPWdhWvZ/w7ujWREFVmcvmpDE5+b9f+UTn+WrgGYQ61GJ29uplwS3sAB53G/
	 rLgjQIba91TmJmBIjQXKMYrpuyorexH34Pz1G1JtKAn/FQx/egpDGkuYj/CsLD19RX
	 nizwZm6jU6v4w==
Message-ID: <sashiko-outbox-185742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/6] userns: record how far up CAP_SETFCAP reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-b4-setfcap-userns-v7-1-bf8a576f7259@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
 <20261026-b4-setfcap-userns-v7-1-bf8a576f7259@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:07:29 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> create_user_ns() records in ns->parent_could_setfcap whether the creator
> had CAP_SETFCAP in its effective set, and verify_root_map() trusts that
> when a task in the new namespace maps the parent's uid 0.  A bool only
> describes the parent, though.  File capabilities belong to the kuid of a
> root user, and a namespace that maps the parent's uid 0 shares that kuid
> with the parent and possibly with ancestors further up, so what matters
> is how far up the creator's CAP_SETFCAP counted.
>=20
> Replace the bool with ns->setfcap_level: CAP_SETFCAP held in the
> namespace counts there and in its ancestors up to the one at that
> ->level.  cap_setfcap_level() computes it from the creator's cred.  A
> creator that holds CAP_SETFCAP passes on the setfcap_level of its own
> namespace, one that doesn't gets the new namespace's own level, and the
> initial namespace has 0.
>=20
> verify_root_map() keeps checking the same condition: the bool was false
> exactly when the level is the namespace's own.
>=20
> No functional change.
>=20
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-setfcap=
-userns-v7-0-bf8a576f7259@toxicpanda.com?part=3D1

