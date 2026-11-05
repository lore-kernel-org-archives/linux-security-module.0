Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890498;
	b=lUIMqFESLKpU5C78WDjCzAdwzhzOLxV8Y7Pauf0uOok1ikY7MddCCjgg4z/xYnYQJIds
	 3hSzUdMKGDHZIvrKwy5aMDPhs2U2duPOfKVy0W9sctTiiKjYVq4I48Z8MiojXQfFPl+Ap
	 GO6UihSkbKzgD/KaoSQOMf3wZTKdCID69wk0EVyXj1Unr4tuSEWcF2aAvSfuSbic9aiTA
	 03fyA7wL/xM1WHAcG/igjg1VGYB0u0EJhgjU8BeTllx8mtMlMwXYhm7L2aj4FsJR5VNPk
	 ehkoaMHO2adZUVKFBhvHmaiUA81gMk9K16xqgarqnck75zcugmr4w5fyZZByOtb7CZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890498;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cy8bK5niBluspavHCXFiVpHqCWW/yI6KPgwUyq1qrss=;
	b=CEXhPIvLHqoXicDBeokTIWtjMQO61M4ZYbutL315dt7EHhLY+2DwX021CmvxbQ2wfiz6
	 a3+OaCGGg8k8ywEbdHU4Ky7pjQn3UwXpLUtj3EmdX2NJG0Wbw10sO1CM0+ny4Qi1ESPDH
	 OjnQPlcnq7XQ4Y4WguehkT05c3rulaabVcZAKixB+Xe3GjfL3BORo14oFZHmmj8M5lROQ
	 MbCbJRWdSY+UhboaJ0XLRz6o0u9RvF+votTIGbxDjvt8yqdjtI8PPaImq8BsURrDh7Vtq
	 96xjWwbZIB5FdFwcRywS2xCWh/ZthuTCTxxK0jPsaN7U2JupwpGVd1hxkjA1YCe4OWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IonJaSA5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8A606A31B
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IonJaSA5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110CB1F000C1
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890498;
	bh=cy8bK5niBluspavHCXFiVpHqCWW/yI6KPgwUyq1qrss=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IonJaSA5dxKmMq8MFArRZQKlQkTIYV+fvgtpTfj7haMu8Hera4g9N/BvUIC8y+sOB
	 rnUfQdswShNmW7xm6SL8G4srQDMeorOKs5Rv+/mFieqNreHIp6FEnDR1HF1OolcgMK
	 bnhih/OCjrgptD8EribPmgyTC5rdN29FBHxAv5iobedEPpTivH+QgYKjoy+Sh95tpX
	 336kuFF3P0cGY+MsLdvcgmdu9OY+/9nmozMLswbEo5rm0YoXkNfGwM35hQjkOQsIGf
	 LO+VKUOMpqNxuMBPVfqR9OKxGhskXRHGzC6FbXuQ4RcHQFl77z3JWyt3h5O5O3MgtB
	 OWnfq3oVeeGqQ==
Message-ID: <sashiko-outbox-199274@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/9] keys/trusted_keys: fix PKWM output buffer
 cleanup
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261105144320.357260-3-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-3-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:54:57 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The PKWM seal and unseal paths unconditionally free their output buffers,
> but the PLPKS helpers can return without initializing those pointers.
>=20
> Initialize the output buffer pointers to NULL to make cleanup safe on ear=
ly
> failure paths.
>=20
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105144320.3572=
60-1-ssrish@linux.ibm.com?part=3D2

