Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA54CF468
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343664; cv=none; b=EF+S2wXuMSkiMu/JIjX1c4gVBl4aHnCV4gnWZS4wiUoYIiOkVhNRcsAd/V3vvbcdKjICTnUiaKv1DaN7+TV4eiRH4KVPswB66fa9nwUjm3mno02zS1ahr2xlUEro+d87ZKxtjs7SQMjdYvLc/iZbuASy6PV9o51Gqqayf1YlXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343664; c=relaxed/simple;
	bh=X3gweK1DtT+G26pz3C2Zt+f9uI0HjqSGWBLsWQOwEVI=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OCOW/CEub8Gv4qKXxteQjOc3uz33MhVkn/jsouuTfJRa55liAhrYdt4HB/WBsRBX22iQmmDMTVdunrwU9jPJCGwP+quWRUmTe+aO6dEZNrmtyWX4qN4VfBiYxb4AGns2lX2kOBFiMCC/GUcDQ86qfqUKkhZZvIQpkSRq/g2XkuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8Gi7lLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8Gi7lLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24391F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792343663;
	bh=X3gweK1DtT+G26pz3C2Zt+f9uI0HjqSGWBLsWQOwEVI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=K8Gi7lLyi/4nZ8mx3xko+yTiiVuPJGtRLoCmgKvp6ICVc/P9va6L/Yu6jg2xRbG2m
	 C7p4Ml+ebHeZUZd75oSF3RFB0U5b7IGaiLhOvmoJjIzPloQartLQ6fDA/zHUQxmXEe
	 3aYNLcoDzfOInsFvgmQ1ysKlO/c7v4Ydg/hAcoF+s1GRNWYAi6l8WbQgXUdQ1YztVP
	 hdOTeSpOZdX6ckhvBhBfSVAESGi/CvtGJOfuIT3WHl74Wdm0j+a4ToDFmtEeqNfJe/
	 /B73BjSFwqV/j9J43WelxPdxlqIT/9rNe6wNBJ0323yn/bbHgGchH9oT8/+VFd672e
	 imkzo932wqloA==
Message-ID: <sashiko-outbox-176309@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] keys/trusted_keys: propagate wrapping key
 generation errors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018170844.491252-5-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
 <20261018170844.491252-5-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:14:23 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> plpks_gen_wrapping_key() returns a negative errno when default wrapping k=
ey
> generation fails. However, trusted_pkwm_init() returns -EINVAL for all su=
ch
> failures, discarding the original error.
>=20
> Propagate the error returned by plpks_gen_wrapping_key() unchanged.
>=20
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018170844.4912=
52-1-ssrish@linux.ibm.com?part=3D4

