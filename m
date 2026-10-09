Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25903A1A29
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791523588; cv=none; b=ryyQqELFhUiqHwRPcJ1yMb3f1KsXTMO2/2U9yYG6dH+F+qLLEgXzz6CsxchqiD2quBIaF69KnXuZo3q2fFYZkpSsFA9RpCwAuTDVKlF+HfO6ev046/aDQMbqcRIvXRofw0DPpMCOXZlojJjP4Cngt410tKEO02q08K+XKFLftsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791523588; c=relaxed/simple;
	bh=1N4xrA+/b8xkSzsUhQQf/hG5DFUQxTs5MnWiVm5KCMw=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=P88MvGQqYf15hOlmSW9oBH4y1DL53xc5GUZyBfs5BfXPDxlWYHSB7ewgvaqSIhj1YgdO4Sv5YKXc7Wq3JgfkHeCqLxUmSYcSs8LGVKpnkt4QHAzmmpTaQ9BVD4KLWSpMWYCuairC52gyXBL6CkuMg7CJV41JlNBocdlrTTmzewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWKZTI93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWKZTI93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409A01F000FF
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 05:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791523587;
	bh=/paQOHSabtZ1fNZ5u8yyA4cTGL0Z1o+VzecBlD2UU+A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZWKZTI93RGVGAHmeWVe+pvl5y8lxWF7bXnlA56e5OidRpgO3Oh14F2XCvjL2HK3ZB
	 HvknfgWXkAJWulRX6xEMni1MeDLo//YVoA5QKf8/4AYlKph38siDfor6hmbXuK6AdR
	 kNR2O1LAPcjP+71GeJvlIaHrn4+ekJnTSTQlO4POLz8NaMbGmYaxk8nzVGmB5DmQO9
	 Q/QwhmmUYRF8AG6DcIXRLM89eVM01VOZgLFtTxKNwnVx/0s+BhFWK3VKVNpw2Vgrlo
	 KLRJ65WPIfdF8YCb2ucgtBZ1ov6HBikRgw92s8jOhCEWss2tuKyg927AC611mJ+7vf
	 EBKrp2CD9kOLg==
Message-ID: <sashiko-outbox-164891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] keys: Protect the type name while describing a key
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <pm-key-management-objects-candidate-0009-v4-6b537c5732fd957c33fa@gmail.com>
References: <pm-key-management-objects-candidate-0009-v4-6b537c5732fd957c33fa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 05:26:26 +0000
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
>      vsnprintf+0x330/0x1110
>=20
> Fixes: aa9d4437893f ("KEYS: Fix the size of the key description passed to=
/from userspace")
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/pm-key-management-o=
bjects-candidate-0009-v4-6b537c5732fd957c33fa@gmail.com?part=3D1

