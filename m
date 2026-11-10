Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343001;
	b=ml1syppw8ve0cbhFvGsOWh+HpPtxpcfvo/ers1lX4nN72jf4lZWzRLmjFhn5b4IwmbAk
	 VCPoQFS0ynr9EuIvVAEubYw9mCFOoSmCa7l1PuarEuR2ASgxlPrmzqi0uqXPGftYWbARv
	 0soNYXOHSyKCKKdFgE0NKTaqHct6HFG3FZTG+YBVrsZpzCP9tx21Db/vN0RbBg6oubKjv
	 RUjGXLChRHWkw3iWNTGAxfbxKJWBZXU9cPAWppkKifSXC9JWJnC03eflNZBPbZTsJE0gV
	 uSSdQkrgCtfgvZJrS0lUtk/UMiLpQs9XQytGVoCsbhW4d5w/6bMMUM/EfotIFkxURGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343001;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FPZWjrVDVziSV/dvRw04WM81Xfctg2HUXyFP/hKuhtI=;
	b=wSO06jVPrLVdnB/0X7LmcOOCvq83RWgK7Da1Bvs1BiDQILHepKPLdCKroND1MWwZMyh2
	 jrFpm1k2/dMr944RRwaLRKLettyUqA8m7TI82kPuvLQYBwwKGvuedyCdvCP03Nd4b1Mg1
	 KjO9k5Sx2GkjylHPm4r6AAGIBqTQSvf/C7BWSlFnq7GpibQBzw6omj1NXTSpM4nlZpf+J
	 W8mYywO5K18D3d9oVdjfPLIyXweFMNkwF8OXYtKTojs2LWmv3GiSXZK3OKmsjsu1EMBUM
	 AKYSzka35Crogc4pVwDVoz/zScdQ9TovKnDGkMlb0MBbyHax9NYNYHdXlL7mTDEV3Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEABNeWS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276E606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEABNeWS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05471F008A1
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343001;
	bh=FPZWjrVDVziSV/dvRw04WM81Xfctg2HUXyFP/hKuhtI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=iEABNeWSBLBu3Li4ysLh63gY54e8xFKG8MpXrMFaEVC6fydDbVDfnpEgTNDURUw8J
	 HMbCXYNc8qvOkl1dSoGRV9oy0wM+9N5YDP28x+8iNUw3/qr6Z2HsAiROGo2Fcf8XH1
	 RcREh0nTS1BmCZKBS6FBbdBY7x/8qrvMbGAX8JMxkTafmR0Qs4dAr/fEjSiKzssnOw
	 uRhOQzYdqcDuvGOpWXViyzgE4dkEUUVnCkdADpUvW/CxHdH8N9lHsuKCUIcq7M4028
	 I3lybTV+BIIpmGTmDc4mQQ4qCVY5Ip0OekBr5rfGx8c4u5NA1GsDey0Whpk95O3psw
	 XEOJHStrU3piA==
Message-ID: <sashiko-outbox-207717@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] landlock: Mediate CAP_SETPCAP for inheritable
 capabilities
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110202436.2408244-4-mic@digikod.net>
References: <20261110202436.2408244-1-mic@digikod.net>
 <20261110202436.2408244-4-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:36:40 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> A process in a domain that denies CAP_SETPCAP could still add
> capabilities outside of its permitted set to its inheritable set with
> capset(2), if it held CAP_SETPCAP.  cap_capset() checks CAP_SETPCAP with
> cap_capable() in cap_inh_is_capped(), so the check never reaches
> hook_capable().  Through file inheritable capabilities, such a set can
> grant new permitted capabilities on execve() when no_new_privs is not
> set, which is possible for a domain enforced by a task holding
> CAP_SYS_ADMIN.
>=20
> Add a Landlock capset hook that checks CAP_SETPCAP against the domain
> under the same condition as cap_capset().  As with the mmap_addr hook,
> LSMs implement their own policy in this hook: SELinux checks capset with
> its own permission.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Reported-by: Ada Smith <adasmithgt@gmail.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110202436.2408=
244-1-mic@digikod.net?part=3D3

