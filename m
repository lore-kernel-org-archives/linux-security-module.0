Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE91B4F0A
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791441686; cv=none; b=rIWh5n9igSW4BKSsWyQr8RfCm+RcPJlfnpV+qB3rGxFtYQhigT5KkqJ13wswGIVUWt5MJL2l+tE7x64n23KfDeh5dbX9GAJ7ZWYzEJfbfc/E5IFuPa4Q+wo6LBeQM2o1H20Ao67BAQ8RHyilWy+2n7IO6hT+RtIvKC3hWjGTv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791441686; c=relaxed/simple;
	bh=NbU1v8Cq2q0zfqB0Q4bcd3dcpnZ8FJM1kCcbTCcjHtg=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FRt4q+sJq89hhssgZpzu2/2WBmly81fLQ82aYRHb8CDKKKYNkgd5wfcEoSMxoXeyFd0rDw9Zn4v84iFYlnznRaqphcW1HnMGCwI7Aeb9hEEf2FIK5nqkYJiDCbV+LpiiYSKnkGUn3mt1wmLO2AfN+yKVzqx5hQKsGU8VKNI1e9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCPx6i00; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCPx6i00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187901F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 06:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791441685;
	bh=FtLafvXK/u1LC5N4ZagEiSU7PAq5Am4xa+ZetuX1ByU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SCPx6i00AVf6dHjrNsWFe1e4ulpQIoU+7gXIeOtKMbkrxHsUCRTa2YWanSx6cW2Mp
	 gqsFnTc05TRyJYjRJ4vxZ7JJmynnRGCi1VwkqFN63jGZLseEAfDaE9GMNRmgiStDvK
	 RYpTmABxbRA+9B2reFFXZtUssM8Q0q9cftKibEuxpLcAULhKZYUxSb0AegY5XgEskH
	 ULzbdMQ/KAwAVAbeQ/jk+2ATYIV505e7gSwFAjVPZM9pcLArIQiItpu+Blf9BDLwox
	 1Fa1sP4tcXqaJcVlC0cpCn9RQLLGFya9mv7mSkES8KeY+mNA0rZMK4MloboOEbVJCM
	 PtTwtNT0Svr7Q==
Message-ID: <sashiko-outbox-163707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] keys: Protect the type name while describing a key
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <pm-key-management-objects-candidate-0009-v3-43bbf21d1c452f23d829@gmail.com>
References: <pm-key-management-objects-candidate-0009-v3-43bbf21d1c452f23d829@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:41:24 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> keyctl_describe_key() must keep the key type's name alive until
> kasprintf() has consumed it. The retained key reference keeps the key
> and its description alive, but does not pin the module providing its
> type. The name is passed to kasprintf() without holding key->sem.
>=20
> kvasprintf() uses the saved name pointer in two formatting passes, with
> a GFP_KERNEL allocation between them. With AF_RXRPC=3Dm, a task that
> passes View permission before type retirement can overlap a privileged
> module unload in this order:
>=20
> 1. KEYCTL_DESCRIBE looks up the key, saves key->type->name in the
>    kasprintf() arguments and completes the first formatting pass.
> 2. While the formatter is delayed before its second pass,
>    af_rxrpc_exit() calls unregister_key_type(), which removes the type
>    from the registry and waits for key_gc_keytype().
> [ ... ]
>     ---[ end trace 0000000000000000 ]---
>=20
> Fixes: aa9d4437893f ("KEYS: Fix the size of the key description passed to=
/from userspace")
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/pm-key-management-o=
bjects-candidate-0009-v3-43bbf21d1c452f23d829@gmail.com?part=3D1

