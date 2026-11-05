Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916665;
	b=rgVDphArJTxj9F5g1zyCTpP6T9Xtl7b+IWqZ+7KkEvbfE4BQ8PYNDbHaZbGCpM+xOaY5
	 7Tzw4Aiz2vp38KrYWB/YCGLNGFBdMQjPZ3CbJwsi930FTmXHDM/M/KbyNXG/ioxs9a3j3
	 9od7Ncr+uDu+/MND7EhjUYYtVqCFqGTNqWilHE1F3ilAA/aLHORqfQRenIgsqQvD/VuHy
	 t3y4zypps/aEukY3i3qeO0Yx35JadCgBcHOQE2GAakGcE4FJhXa9GZQI2AGhFJZBaXh5p
	 hWlDDksOnZ5ch4gfm/NbnIjXnHqq9uBLnH3D0dYcfvHjUhBIBVn+hAh3JOZ/TyQezRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916665;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tXHGRdh+9NlNXLQE8Jco56rOjOK3nsqAJlAiVSLAoj4=;
	b=qUY1uiIEHLc1VgUH5SNXT1BPT4oDlPuQWLbKpXe6ITXpvnEkBBF8rIsn6pR7Y71SgeBH
	 ZeTtBPOuyMbllQPUkKVlWGNpWZavZlF7jDhkuNyAJnbX4UCvjpvU5Onka4+Au+bNooXVt
	 vvcRMxjLm6xs0foKYLW7+CvqJjTPxbBVvb6MuFuHw+PnXnmBjXIb25nqDERS4iazQMyp7
	 okm4p8yBhCvTnpFNBhyToh5QtoB5Y4N0OWKMdIRyArygOEBqCfbQf3am5N9ohbbmrzC0e
	 TBcOTJWjkwJjRU8AE+rF9OYnXB94oX9RlEONVYn7mYRIDXKwx6YtnPt+irC/eyazSuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hplZbvxK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0A606A326
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hplZbvxK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329A21F0089F
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 22:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793916665;
	bh=tXHGRdh+9NlNXLQE8Jco56rOjOK3nsqAJlAiVSLAoj4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hplZbvxK8PiAc1fPxfWgX5+a7pTSwGKtIoB3z/NRWRvPLTXoFvhK8XL1sy+dpc5nn
	 Q2wyqcc0l+kQqr3n5gtkRBBriJyEmzDD8hxumRrqUzQ0XBM7DfpjJTuQNSdiP3ASTw
	 CfnN+jvxnAcWhhnuF8SHZ8PygV48VlM25gblbA6H1/5MULaDrNLdfAXWugzncD5ETp
	 5jZ+yh5f4hoAsNKEjx2+jBxrMg3lgrSEL76oZPfKED/Oyl6FZFAy0euF1v5fxjvcNn
	 wfFSwUfvXqLuqvNMorH5/HPoFQAptpfjMmT9nmMKT+SqjK8Wb9+MvdLmMuULT/9KuT
	 7ero8nXpldyJA==
Message-ID: <sashiko-outbox-200295@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] KEYS: Reject keyring creation with overridden
 credentials
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261105220050.1421842-2-jarkko@kernel.org>
References: <20261105220050.1421842-1-jarkko@kernel.org>
 <20261105220050.1421842-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 22:11:04 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> If the current task is running with overridden credentials calling
> commit_creds() is forbidden and triggers a BUG_ON().
>=20
> Reject keyring creation with -EPERM when credentials are overridden.
>=20
> Cc: keyrings@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: stable@vger.kernel.org # v5.10+
> Cc: stable@vger.kernel.org # v5.10+
> Fixes: 3b11a1decef0 ("CRED: Differentiate objective and effective subject=
ive credentials on a task")
> Suggested-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/keyrings/CAG48ez0XjVSR=3DM--UBauTm8sJuc+Z=
bhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105220050.1421=
842-1-jarkko@kernel.org?part=3D2

