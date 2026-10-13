Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632B351EE1A
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911094; cv=none; b=qFVod4Al2pJ6cNUSWWTJSuzy1nvtPPnqGDRV7P10JaZ5Ev6mI4ecPNYFVXy79w99RzEJaIZEJurADstNm5bgQYedhrYmEBwPqMR7/ba2jMd0k0fL0SNufxmyNSdVU6dyjuKSKgFJtWzbg6YzzdPdeJZRSRN8EBARKjZYnJh2g8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911094; c=relaxed/simple;
	bh=SVpD+2iYwF6ym3xDmtlrw5ntP+eMtl4u7bvWZtnMG2k=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UkvlpnxZrLjAVa+Z08H0taJ9X8bGzHdA8C8NY4hZaYVQkSEI717LN4stja59EexRwnmtx13PEs5W2FVZCan1ey+6yi/2VaCyfYCpEUUFx+ofeYKotsAH9jbl28B7EX8aFXLz2A2bR9U4/UA51jUc9FcTdjBpANsVVK7Nha7diqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYsMyyTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYsMyyTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D670D1F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 17:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791911093;
	bh=wXcBEd72QFCvDJJ+LgU7LSGQopBys6igIt4oIXPAJjw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=oYsMyyTWEuHdzIZD1wW2Mk7m83BTpVlyLI3pWauE7k5r3rJeMuFD3km2lp3BOOZwC
	 Y/rsxUe94E1/XCoSmNGGntGDS2mjAlPpffmU5PJ3Cx4RmeeBPWWXUz9nfm2sYqXl7M
	 3hARzd+cXifhLp5hpbQIL6OvrGWfyoB7tlx7Boj+cjoKVQEfc2rgAiPb+qDZfQWZ78
	 sGRcy0Ola3XeaRgtQaMc5acpgor8zBXJhN6KUHpZkXZnY0yXLOma2tMT9EwWr1r5c+
	 ktXgBa8LG3Ctn7+eZtjN/v1VzM25LHuYsheHR+VZkBSzpHk6qkNTVzH/hCsyY1+oUn
	 mBuEdktVgUQhQ==
Message-ID: <sashiko-outbox-170188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 09/11] bpf: support "__uninit" iterator
 arguments in generic kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261013164800.2906577-10-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <20261013164800.2906577-10-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:04:52 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Iterator constructors are recognised by their KF_ITER_NEW flag, which
> binds them to the bpf_iter_<type>_new() name and so to a single
> constructor per type.  A kfunc that initializes an iterator from inputs
> that naming convention cannot express - e.g. another, already
> initialized iterator - therefore cannot be a constructor.
>=20
> Let such a kfunc mark its destination argument with the "__uninit"
> suffix already used for dynptr out-arguments: process_iter_arg() now
> decides per argument, rather than per kfunc, whether it initializes the
> iterator or operates on an initialized one.  Only iterator-typed
> arguments are reclassified, so dynptr "__uninit" out-arguments are
> unaffected.
>=20
> The first user is the path ancestor iterator handover added by the next
> patch.
>=20
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013164800.2906=
577-1-utilityemal77@gmail.com?part=3D9

