Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848F3F210B
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344844; cv=none; b=MA+Zv3CmA2GxELzR8JuIEgGAxb2wLthYubiGZFLwjX2C9qc/w2/WLZN1zXJOMnMvtlMfZrGYlnY/RBHo/ME6D3CulH+Cf2UB/SZEXAUqViybWIt7kvfAzNMWBUvo6bclda12C506V56KI7sL8rwPyt6lFxSOtdG8QsFDAwyAsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344844; c=relaxed/simple;
	bh=OKGrrJgpSRx/E0KM7Qm44ym12xHLP/CFMqsbwqVqq30=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KfxnGMxXENTi+bZXYwDxE/vETu47CtqfP3VFLQM8tQDIcmYsKOQeSPFYwdS1NudNdllCnCUUZFwcVpV5Z/F2+hyGbGSVgo7ZWsxSrQVdTD1a6GB9yoZPiRvnb1PLm8xX16O3QENNcBxmn5Sn690qhBQ51jHt14VEJg0obeZ9CeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6ufAr5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6ufAr5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3098E1F000C5
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344843;
	bh=OKGrrJgpSRx/E0KM7Qm44ym12xHLP/CFMqsbwqVqq30=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=k6ufAr5yLXbdNxgm9fQi++oV6TVhDwRsxUaHqwLdAX5nhLTayETqFTgt43KSsvZSL
	 l4wJnD9h04C5tRAJx775yr2LWToyWxzfeQs9o6z+tDbxdhFABtrVAK8UwmmQF0J9jL
	 49EIX1tgWE1qxVC8LfXcmVvcPOlwa/cS2Te48HTe09pcD9VVNJEwCncFEiQ3rENns9
	 A6VhpUPMnROYveuRmLd2L+RrSFyLmJyWrOoiLbZaD5+5x7G7gO5FmUKLBbgyRLD4Rq
	 NS5KTbCpDctPonzCQkkegbjUAttbk23suTqRObWLdUggFh6xxqqJ4eRJzi29D0v/IW
	 AOHHY3q9UOWmg==
Message-ID: <sashiko-outbox-176318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] signal: use cred_ids_allow_signal()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018-b4-cred-ids-v1-3-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-3-7bdf2db4ea9f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:34:02 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> kill_ok_by_cred() and kill_as_cred_perm() have the same four comparisons
> each. Use the library.
>=20
> No functional change.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-b4-cred-id=
s-v1-0-7bdf2db4ea9f@toxicpanda.com?part=3D3

