Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAF324A067;
	Fri, 18 Sep 2026 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757704; cv=none; b=OE22h9ZcnIeO5KX3ZLepWcOZpULrzFfk1kdz6GxvvTb1Pg5o07REfXJM8QDzKSqU0nneM7kxd5IAmlxqcnwySclN1ND7wMwIEkjPc+Z4Mv8CFqYOdH0DOR2r8VH4dfozHG9yj7DU7PH+zMU7wHzy2TBXsKVjlb6pAlQz1YgqOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757704; c=relaxed/simple;
	bh=1ho7vryfn+7mUfOn+cEHuxsk5vR84fsR/ZIVxu1Ld3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i7ZeyZnUECRXft7cqUk9u5XsK4FxuLf1EZKA/Q7qW7vatskvrpSUURktZ1kvEhz4IX7c59UhGZMe1/jkGYKP6ltu2WbDvI3QcF5dn6W4XwJSj9pCnjfos1tFgtP3Fw3vydAluEDca/cTIsp3oMpSz1IGGXsI7Noc1uP6JwHtrx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLrP9ns4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLrP9ns4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2401F000FF;
	Fri, 18 Sep 2026 18:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789757682;
	bh=1ho7vryfn+7mUfOn+cEHuxsk5vR84fsR/ZIVxu1Ld3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SLrP9ns4Xy31BS0OKvau56QtM90N4/3yUqduW7vRuiXFw+zJMpFEBuXl1pYuDCjKe
	 bFNT8GZIzeZVUzj0iKycGFam1WKLzJd0k+spYHF2hw0gzR2RZQgnKyXD7i0LhchZg9
	 dAFmvbkBmxKqkPQr/ffrEgj7HpyeeuC9aGsP87uL+Xm+Wuna/7RRaHpToFAjQp3NhW
	 GCUnqfR8hMtNH/VO4n8kPtHjp0rrTTzgi/4rfj2Co93Drsy2jbzdCE2G1XiKLDC5VI
	 VE9yD7gzVdEwgezgbiHNQZTJDxMiAYcedwvhvyGJ96epJO/kBwa9zKHkC1cMjbwr2p
	 jH+Qc2uFAhnbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/9] landlock: Fix tracepoint fixed-width type names
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-trace-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260918185036.608651-2-mic@digikod.net>
References: <20260918185036.608651-1-mic@digikod.net>
 <20260918185036.608651-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 18:54:41 +0000
Message-Id: <20260918185442.4B2401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The new Landlock tracepoints use UAPI-prefixed __u32 and __u64 names for
> callback arguments and record fields, including internal IDs that are
> not Landlock UAPI values. Typed BPF consumers see callback typedef names
> through BTF.
>=20
> Use the kernel u32 and u64 aliases before release so the tracepoint
> contract does not present internal values as Landlock UAPI types. This
> changes BTF-visible typedef spelling but not integer widths, calling
> conventions, tracefs formats, or record layouts.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918185036.6086=
51-1-mic@digikod.net?part=3D1

