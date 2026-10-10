Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B583451D6
	for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791628036; cv=none; b=tJawgUj8ZRT1Km/u2HTC7mH81fI8N44gv87kOpuqj1NV2hvVHdDv8cNDpUd0AX81UgF7fdmrfBxBv4STcHJZTvb3h/G9ln8eKJ1bze5wrj5IbwTGWDRYeMbJd6VGRkWr7OF1dZtxoXNGsSH8a6nJHTLLLgxaJeNjIy3xIG8ZJb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791628036; c=relaxed/simple;
	bh=uPP26/0Uhe8vRtYpei67bicSUsZNvXtNQbzePp/Lrpc=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NNejfEgBYkt17recQEwXpKa2MHIBXPwsGh8Ke1tF5QSY4Y/zbCgkSdZZFu3aEP0RxdC001/AUB7XSQRBtcqHvdGkXHQP2EsxMITc5MSKEH3cCZi9vkOx0qqtCKGHvrPFBWcK6n48tw616x35HU5vLPzTHgwkCWtUY/bp6twaBTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDlvDAXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDlvDAXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A871F000FF
	for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 10:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791628034;
	bh=uPP26/0Uhe8vRtYpei67bicSUsZNvXtNQbzePp/Lrpc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XDlvDAXCX6gcwEW4gkc+sVRzbz+KqmEL0NE6KtGmqgRoHWb97PF25sDXIZy9KC0bD
	 Gsy2QsnvFEvDHoJtuDXiNcSMLFirCcjPRTa8oT7htsX0WC0rMj5iVvZdhoVs8j3Qo4
	 xfrEbBOhhPoX1hZOYOQ3mXhzbshBoLQJnUnzHQrslduhCFvc58oLEO0gHzEV8pdv5B
	 HF1W+pS+5oN+sRxORNX9VZlLExcjuTsoPy7rWQR9kH/AucXT9fzKU1QPbE41XcdMQ4
	 L+TDN0fXIOwRFcx7oBNBhadrVOYWArq1As6RTbHrqIiXry/89A1S0DGrgJmcOEVJSA
	 SxB2AWBSkimQQ==
Message-ID: <sashiko-outbox-166430@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] pidfd: restrict task access ioctls to the
 caller's pid namespace
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261010-pidfd-get-paths-v3-1-f245440b2b30@black-desk.cn>
References: <20261010-pidfd-get-paths-v3-0-f245440b2b30@black-desk.cn>
 <20261010-pidfd-get-paths-v3-1-f245440b2b30@black-desk.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 10:27:14 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Chen Linxuan <me@black-desk.cn>
>=20
> pidfds can cross pid namespace boundaries: a task may obtain one for a
> process outside of its own pid namespace hierarchy through SO_PASSPIDFD
> or SO_PEERPIDFD, via SCM_RIGHTS, or through file descriptor inheritance.
>=20
> The namespace ioctls gate access with a ptrace check against the
> target's credentials only. That check does not account for the pid
> namespace relationship between the caller and the target, so a task
> inside a pid namespace can use a pidfd obtained across that boundary to
> acquire namespace file descriptors of a task outside of its hierarchy.
>=20
> procfs exposes the equivalent information only for tasks visible in the
> reader's pid namespace, and PIDFD_GET_INFO already answers with -EREMOTE
> for targets outside the caller's hierarchy. Extend that policy to the
> namespace ioctls: fail with -EREMOTE unless the target is visible in the
> caller's active pid namespace. Callers in ancestor pid namespaces are
> unaffected.
>=20
> Unlike PIDFD_GET_INFO, the visibility check is performed after the task
> lookup here, so reaped targets outside of the caller's pid namespace
> hierarchy answer -ESRCH instead of -EREMOTE.
>=20
> Link: https://lore.kernel.org/all/CAG48ez1T5-tUHVK_iHsgUtWa-inVdrZxA3E-ZC=
W0iENJvasKfg@mail.gmail.com
> Link: https://lore.kernel.org/all/20260925-gewischt-auftrag-tierzucht-c15=
3cb3f9f74@brauner
> Suggested-by: Jann Horn <jannh@google.com>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Chen Linxuan <me@black-desk.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010-pidfd-get-=
paths-v3-0-f245440b2b30@black-desk.cn?part=3D1

