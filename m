Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0277B2FE042
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792225114; cv=none; b=lU33mJt/WDJy3zKd1YV8vhlbb5pNqaNyV/yb2szdFPsBPDnZJMtXdE1y7Fdi6QYGt/HjHe9CQYvuK1ub0ofjmjPEVt7Z81czaLa30waOVkoXuSxLF00NPz+GtgKBYTyGC/IBFz/9bkvBcXnqjh/vlDu1VACVr0vkmuanBiXq+lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792225114; c=relaxed/simple;
	bh=a/A2/XUV9E3vEuqZl4fICoWDd9U/1hcp+drFZYGELhs=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=A9qP6psRNll3ZQddExQwirn/OTllPIgPyJQyKkNA0xODBsO8a9gwEsk7uf+gnVsxGlDDlxh2mjM72CCoPle7al95x6CMK4UWHqWFNU9AuSbeOwnI9q77XEgZDev0G/Cm1lNBH5wtKd73Ex8BM7yNvNdzuNiPTzFqUknN/dUelq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9oMToOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9oMToOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED1B1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 08:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792225113;
	bh=RdcdkWNnt4PS2pW/BI0KriPhFBYYQRE5UqThaFp7ZpM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=k9oMToOskBGkIeGjrDfwBI+Ava7XPK1b8OXEl9BPWiaC/LZDI7j2fzext3xNY0BzC
	 QbmKmt5dByC/pozBZl8SgFmY444YsCOfYrR9biDIdur2nUKJX4sVmr8pSIC3wY/Yt/
	 TGcDsZOM9ytP54HdinMvYJnZhi0MfLgZ1qZf4Kqj/PB3d2Nz+jgkB5dLHtJ6ZJcA8q
	 xlqBIwkMmjz/MEVs4gRxXmMswci3z/NLuDolrsi19HccCPyqJtPcsBHYFMe5NkgVyt
	 9fw1SBfNyJHYx+bXDlpdyCiYodxFaNIV+2nfooBsHfAEcpk+rd1mwTrip41baghiAd
	 XnAzCp4Ti+Fzg==
Message-ID: <sashiko-outbox-175389@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] keys: Avoid owner account dereferences in /proc/keys
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <pm-keys-proc-owner-uid-followup-20261017-v2-8f8f34a41eb1bbb94ef0@gmail.com>
References: <pm-keys-proc-owner-uid-followup-20261017-v2-8f8f34a41eb1bbb94ef0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 08:18:33 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The namespace filters in find_ge_key() and key_serial_next() read
> key->user->uid while traversing the serial tree under key_serial_lock.
> That lock keeps the key allocated, but it does not protect the separate
> key_user from ownership changes.
>=20
> A /proc/keys read reaches find_ge_key() through proc_keys_start(), and
> key_serial_next() through proc_keys_next(). The lock stays held until
> proc_keys_stop().
>=20
> A successful privileged KEYCTL_CHOWN on the same key replaces key->user
> under key->sem and drops the old owner's reference after releasing the
> semaphore. If that was the old dynamic key_user's last reference, a
> /proc/keys reader can access freed memory:
>=20
>     /proc/keys reader                   KEYCTL_CHOWN
> [ ... ]
>=20
> Fixes: 454804ab0302 ("keys: make procfiles per-user-namespace")
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/pm-keys-proc-owner-=
uid-followup-20261017-v2-8f8f34a41eb1bbb94ef0@gmail.com?part=3D1

