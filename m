Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1362A4078CA
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343904; cv=none; b=FW05Da/qEv0dkEx4vKuAWY3fiCsYJoRu9BS15fA8cUih8gRvix2NJe4Oxk1yCIoNmYE0lIQp9xBQ8RlXL98eMXGHfEphUT9eb6psC8e9cZ+o9mN5y7DJL/KGeWp4dQoTB+Df8OjwZZ5Iis+3uqfaL/ZCsYdLC3uP5pJ2k0x5/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343904; c=relaxed/simple;
	bh=4wanXhsB8fkoUpm6HY4eUUZelncd9RUT4L3/fOqFCSk=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Y04xEABYki/sjIJVRAS9ljkq7nZLNaCpMwta0e7lPzrAhA9MMIuAW3uRUAQBFGwWt1h9l8D/6XBsclwCg0TkDg04ro+KnAlDt6LLLUiHFytFg0XsikjaKCXhiHSOUQ2lzANdOTMmJ+VOUATo36qjXbyFtd6YhXquBZluxfIVCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvvwWWf3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvvwWWf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969E61F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792343901;
	bh=4wanXhsB8fkoUpm6HY4eUUZelncd9RUT4L3/fOqFCSk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VvvwWWf3jJYy/yQfKpeGzgPZAAD04eJdlGVhxmR7ArB5IzaksrJamN+HAivofkoMi
	 BDqG26asnm0Gxkx6DgwUFZKZGzwifJplh9hly6wy9mIPDseLrxlpmI0gPVVkIM7kdK
	 pzr1b2SK7RSPX/MDJFn33xGk/gKwGp3MtJsK+0qSwzY6ScQEhOjnQS08uMCzX2FnoM
	 vr1Zdw8Bn8UvcctXof0BVSEuwXXztusIiRkJu7yHTwxQf6djnO+9FOmrGyhaXalapV
	 gP0GTYURZcX++Y2z3CArRWt6s9tYkfe/3ImlhPxhba1V45yH8MhVSB5ahBkVkDhpwN
	 h3SgzmmR5Lzfw==
Message-ID: <sashiko-outbox-176313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] pseries/plpks: fix length types for wrapping
 operations
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018170844.491252-4-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
 <20261018170844.491252-4-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:18:21 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The object wrapping and unwrapping HCALLs use 64-bit length values, but
> plpks_wrap_object() and plpks_unwrap_object() currently use u32 for the
> input and output length parameters.
>=20
> Use u64 for the length parameters to match the underlying HCALL interface=
s,
> and update the PKWM consumer accordingly. Validate input lengths against
> the HCALL-defined limits before calculating output buffer sizes.
>=20
> Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping =
Module")
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018170844.4912=
52-1-ssrish@linux.ibm.com?part=3D3

