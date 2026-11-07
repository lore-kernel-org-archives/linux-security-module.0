Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067219;
	b=Ep+YSNNt99VrEpnBACgLoCgeol8nDJzPfgtJ56hyaGaJ2GEXTtJC3QjKEAHNmYciTJtq
	 E9wUgebhbG+xkbpWmZdTGTDF4xN8EKuOAsKM3iSaZPKaXJdCO3DVPP0P2ih2mDEOyCfZ0
	 +7xBa7oW81lRdMbYTcfS5NULyXN610DgqUVObdbi9/YnS/V8al94LuIqiUcPHw62Q9ibW
	 OaAQr9MZisaMN3MQK4dKUcaqDZGGrOCnHlAJ9+9/GiNb5Z5euENBwfG22RG6WA5i0xP/s
	 GfPLQ+mgHAQDABy00DRsH/UPQNT//IqQZjZUIrjqUuB0/1nVQtmA8TBYeHp49UG74kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067219;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tJK+b5w1keH5nLvVJXT5cNh8msflrgdpLJSWrIMH3OM=;
	b=tFgIXzq8u9FA5KLyhf7Cfi4eF5JnDL3DVy3OAF7KQQTxhlGtQF1YRQ6VN0Dxq+RXZW7g
	 rfy4N0h/nlZfe3mCIe/ZmYGrMEj89BKW51G9bwE/xFkHMkW7+zOnXdn2riR9Zmudx+/1j
	 sdNUvNbVRdj23QBuTsoyqjCg3pYcYSkIIcp1p0IaFLvMDZxpbJRMlFm78hJ7qPvAW2ZJX
	 gICTkeFsNIkAt6yEF3zA37lSFHurS7NoKwl3iWWpEX5HY80nD30ujseNbnkt3QrAGeyFC
	 H4hx2BOwO2Yuz1MhFqRYmGNuE8BSdXzbRyVhh3uLZ6wthJRImPfNJwTnFmhmx4SABWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfKknoQk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E2606A326
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfKknoQk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5981F0089F
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794067218;
	bh=tJK+b5w1keH5nLvVJXT5cNh8msflrgdpLJSWrIMH3OM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KfKknoQkGjymq1PlZBnLBPBHh5SxUZfJin1KLg1BVty2Uf3AMwhDq+LDUt2U3xgfO
	 8IkwcWjeRFK7Xw1l7AnDgPCSTviaR2JrfAK3j/CJMsVQydiBMl1G9eFdn+3httNGe3
	 HdTdcrRP3E1JNRhpLqEfqE0tdMghsjQiOOG5aehKHqU2OsJEpNREqWdZpa8G8cnByW
	 XUrhYeWPt8bDWvUuu2Uoy5WZmzztxDmtXDu9uk2SVEBvCPRBW4RYdwHyefnQ1bOTgY
	 3EiVs+WqdXX1Mn7V+h0ZPaBRhUKunhmaDQI8pH5dtXCm78volHA/NaD+309dNcvFd1
	 BnrQQ3c/uDfAg==
Message-ID: <sashiko-outbox-203004@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] apparmor: mediate file-generated signals
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <B01DC8398B429509+20261107154928.3519030-2-shilc2025@mail.sustech.edu.cn>
References: <20261107154928.3519030-1-shilc2025@mail.sustech.edu.cn>
 <B01DC8398B429509+20261107154928.3519030-2-shilc2025@mail.sustech.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 16:00:17 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> File-generated SIGIO and SIGURG notifications use file_send_sigiotask
> rather than task_kill. AppArmor does not implement that hook, so its
> signal send and receive rules are not enforced on this path. A profile
> that denies SIGIO reception can therefore still receive an asynchronous
> pipe notification even though a direct kill() is denied.
>=20
> Save the credentials of the task that sets the file owner and use them
> as the sender identity at delivery. Resolve the newest sender and
> recipient labels, and use aa_may_signal() to enforce both send and
> receive rules. Treat a zero signal argument as SIGIO.
>=20
> Use the existing fown lock to protect the saved credentials. Replace
> the reference when ownership is set again and drop it when the file is
> destroyed. The task triggering I/O need not be the owner setter, and
> delivery can run in interrupt context, so current cannot identify the
> sender.
>=20
> QEMU/KVM tests on v7.4-rc1 cover send/receive denials, allowed signals,
> F_SETSIG, process-group and TID owners, profile transitions, ownership
> replacement, unconfined senders and TCP urgent notifications. A separate
> fcntl fix handles the case where queuing a configured signal fails and
> delivery falls back to an unchecked SIGIO.
>=20
> Fixes: cd1dbf76b23d ("apparmor: add the ability to mediate signals")
> Signed-off-by: Shi Lecun <shilc2025@mail.sustech.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/B01DC8398B429509+20=
261107154928.3519030-2-shilc2025@mail.sustech.edu.cn?part=3D1

