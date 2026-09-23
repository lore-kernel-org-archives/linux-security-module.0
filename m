Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74574369D75
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142995; cv=none; b=Gp50SFANcxtkXWHEc5mjtZ98+f6rI8hGj/xZ+orn2HOFztzw2wifW/LC16DcDqv+/aYs6LGJ5LIhtYEbb5sd9iHB/IfC+/fyZvT3CDOI/YMzXQnowXQwowPqyZEHEz1A9nzaWSUDK7PMi1P9bp6Fpy1PYMIz3d/lm8rAtS3VNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142995; c=relaxed/simple;
	bh=KcLGfhVwTE/W5vJ6RADMLmBy3pxIWe0RSUe5N67tbuk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SxF6fc2dgX+v76JHPWsDXg+oDqrxfH/KdjhB7Fp+Ti3GCYNfiPBOM0f18xhLmtyiF1YbSbIRFeFjdxO1405/lFD4gLn+OU78RXG9pk9XhvgYFGRkvrnP1l8cRbVm/Qy6XHGZrDhOCfKOIwgtMGlzc+YvLgKKAMxL56+QUWBpmNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orMqzp04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orMqzp04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8781F00893
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 05:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790142994;
	bh=fiSlmDcZ5y1KmyHhLQ7rlkb30XKcfEkVq47x9dy87vE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=orMqzp04iVYQIeOLqmXO81yCHlji9wXXx0dbeiSr0Wk/AYTyLuHYLYGEEv+TyX7O6
	 JbhypFV2wMPTu49AlmN/Mh1DnfLrpmET6XZNe3VAyyVAfME7JIW9t4WipBHsw+o3+f
	 2JTYOUO0ytorjDC9w8+o6XySTScJ36eYUd5G6b5lwDsz9WHCfCtDWm9+qcufg/Ccw9
	 tSLBH9Oh0Ul82Vnzf1YW6fTg5yGYTkwt5jOpUuWPzcT9u2K+0EqQJlTvV/fxIbjYMs
	 A7kD5wK3e6rbNwpeD3tgDeAiin75K8GdsvKmJpq6eBo12F3EhHIU2RVq0wWNbZaKLe
	 apwqVKZx6J9GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH security v1] apparmor: fix a use-after-free in
 aa_lookupn_ns()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260923054623.247634-1-18983559317@163.com>
References: <20260923054623.247634-1-18983559317@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 05:56:33 +0000
Message-Id: <20260923055634.1C8781F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> aa_lookupn_ns() takes a reference on the namespace it finds with
> aa_get_ns(),which is kref_get() on the reference count that the
> namespace is released through, without checking whether the namespace
> is still in use.  A concurrent removal of a ":"-prefixed namespace
> looks the same namespace up and only then takes the parent lock to
> remove it, so the last reference can be dropped between the lookup and
> the aa_get_ns() call: the reference count then reports the increment on
> a zero count and the kernel classifies the following use of the object
> as a use-after-free.  A user with CAP_MAC_ADMIN can trigger this by
> writing a ":<name>" removal and a ":<name>/<profile>" removal to
> /sys/kernel/security/apparmor/.remove concurrently.
>=20
> refcount_t: addition on 0; use-after-free.
> WARNING: lib/refcount.c:25 at refcount_warn_saturate+0xc0/0xe0, CPU#6
> Call Trace:
> [ ... ]
>=20
> Fix by rejecting a namespace whose reference count.
>=20
> Fixes: 3664268f19ea0 ("apparmor: add namespace lookup fns()")
> Signed-off-by: Binbin Deng <18983559317@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923054623.2476=
34-1-18983559317@163.com?part=3D1

