Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911085;
	b=FB+WNS7rcTakZ3HbPUg56m6ieDIN4SqsEfoWXlHwNLY/K7GNlq+7Om9E7jCgpDe1aOxj
	 VYMTld4ZQizZNTsy17VOYnhT2k/XJdKYSJNJAtPOIPVUVjiEWHam2mtczHpCBRlRcZj5z
	 jziTtppq1flXCpcD5PPHkw1Ra0ONQ9wEU2QxcJeCyy76Q1kgRzjzozNrQZrGyjYwgyNwv
	 gec0f4lOv1O1zCViVBV8L6GSmSVavxBWWjuKIwj7zX3oNZw/QcLu7B7YSckoj7VdbEL49
	 WD9t6M1qdrzZVjq9Ei7Vh2JjOL/u/bk3IBF1hj6fQL3RfhuUrNBMSuKJG8MqfpGK6ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911085;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1aVgGu1enTneaPX/3Etu0AuGvQ0kcFrqTpQq/hj6hHU=;
	b=2qvDR5S1oij4Kcs2tiv6SAHNweCZTgCt+G4psfbZLA+if2C86CSfVggClZ5DQA6Sx9rA
	 ZhtxNBJHsHjATLlY9+PD9oFfhmIih77lsCezsUd5MCtFNbj52lUycmP/6YZ4lGZPLTXpz
	 tVBD7fKHyOtyDqEXYjQwhpVJlHbx/Tx8Qq+8fHl6ySZRFajulSxJDu6eJLo55rlmEvgFg
	 qO4Fah7XxEvS4yRmlClxJspkwEJSdQK+BJrco40zjIdWn1X7GUs1yi9Sdy6u/aZ8ClMcS
	 k14RINBQeHyMGimUKIFR84Ld1gIDf2tZQXN9VG6FPxzBX1i83qsd94ekQrlc936z3xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQvtAW6Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68926606A884;
	Tue, 17 Nov 2026 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQvtAW6Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40D91F000CC;
	Tue, 17 Nov 2026 10:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911085;
	bh=1aVgGu1enTneaPX/3Etu0AuGvQ0kcFrqTpQq/hj6hHU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=iQvtAW6Y6xm3jIDyfpbSs+SA6Oc/nR/a7UYMkVLSRC5FDqGKJfO0TkILLy3/mBsNd
	 JDBE305ENUsrUsLKcpQShXt7wbxziNZvuRQ694Z/+oxuCS8C6PyxL/o+oETomXMdmX
	 sQX46LPW9T0XvJ2HTaDySIJlOLem6HcCp1cVV2f6Kp0oVdAQmJVk1+IxENnHZikDzi
	 AZzidAb8vq3nYsbGDyaRxQCsuhSFHLjFdg0yDfKUZ0nw/JIZbQaNfRRTJJgTNyNZui
	 vN2ClaW4bnB8aVbtamKa/Wbyd+v9fTac1zbYicRW2naVEv6EeAAj8tVpmg6xNZ3pza
	 YjsnzuVUFN7+g==
Message-ID: <sashiko-outbox-218610@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] selftests/landlock: Test namespace denial
 operations
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261117102110.2524197-4-mic@digikod.net>
References: <20261117102110.2524197-1-mic@digikod.net>
 <20261117102110.2524197-4-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:24:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The namespace trace tests cover creation and entry denials, but only
> creation exercises the quiet path.  This leaves the new ENTER request
> tag untested through quiet selection and trace dispatch when audit
> logging is suppressed.
>=20
> Add the missing quiet setns(2) case.  Together with the existing cases,
> this exercises all four combinations of CREATE and ENTER with logged and
> quieted denials, including each exact namespace_op value.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117102110.2524=
197-1-mic@digikod.net?part=3D3

