Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838F4CC622;
	Mon,  5 Oct 2026 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791216176; cv=none; b=m+prUH5jMUYxhSe/BGFlxsykZvP0cb9/DOK23enWvtrhH25BZuD8QyK3Td42D+1cmvyztY8wyHUSUOntkJwFessVmjhIcm1uMV4MDK/DWJbnBNIN9k/1dBPv+GCoMvQwH/nvBQSMuBK8nfqmaas57ilrrsHUQafb1ZHQYVJPMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791216176; c=relaxed/simple;
	bh=k3UdqU5Wa/fatxseqbsHav5Jbqwk984lao9TOqvG26o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r8F6IU56GQz0sPyoN4QUaolopXDvbXGAe0wlZfSDuNeD0NVCCDG9d+K87ORGvNFnnnyeaHodmGZIkKfxRL8G0c6tQxEKaTGE2V0pRW+i+S0WrN8BHm0OqniNajwg5Tu0ps1ZK51WlKSfi2X9uUnnGcKYq2lX+iIpoQTzKqcReOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZWesnvW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZWesnvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE1E1F000FF;
	Mon,  5 Oct 2026 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791216175;
	bh=k3UdqU5Wa/fatxseqbsHav5Jbqwk984lao9TOqvG26o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PZWesnvWkQVfMSCd55k9hk3NcYZRa1dHRGa9D7ZgaooSfSPmrmJVfMAFN9RSoxXML
	 bhvzrG/XGGeudaZbHFNMiZFsro+aOrtWxOtsAnG25RsjU1Q8hH7LD7MFa1Z4wClj+s
	 FUA3OxBSBBdYWVlPScYIcYtO+PePAABRmMGVJ11PWBPFNpOfs9ZuzpHutEloMr+z+v
	 B9RI7cAUko+Lco/xu/DZfzx+Wg9bfti8GLhCx5gve7W2wHe6P8qCXL52oiRDYBxtg9
	 KY3foAnItbMWWg5n33JrONbWMc/rOq/ffB1wV7upA6jXmtEzObNvL+Y9Eb2XycFCC7
	 vHKMdW07a2atw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/12] seq_buf: Do not pop from an overflowed seq_buf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kees Cook" <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261005155708.1471260-2-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-2-kees@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 16:02:54 +0000
Message-Id: <20261005160255.3AE1E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> When a seq_buf has overflowed, its len is size + 1, so seq_buf_pop()
> decrements len to size and reads buffer[size], one byte past the end of
> the buffer. It also leaves len equal to size, which no longer counts as
> overflowed, so a truncated seq_buf then looks like a complete, full one.
>=20
> An overflowed seq_buf logically has no last character to pop: the
> length of what was written has been lost, and the last byte of the
> buffer may be the NUL written by vsnprintf() or bytes that were never
> committed. Return -1 for an overflowed seq_buf, as for an empty one,
> and leave it overflowed, as the rest of the seq_buf API does until
> seq_buf_clear() or seq_buf_init().
>=20
> The current callers do not reach this, e.g. trace_syscalls only calls
> trace_seq_pop() when the trace_seq it pops from has not overflowed, and
> kernel/bpf/diagnostics.c sets the length from strnlen() before popping.
>=20
> Add tests for the pop corner cases.
>=20
> Tests passed under qemu on ARCH=3Dx86_64 with GCC 16.2.0 and CONFIG_KASAN=
=3Dy,
> and on big-endian ARCH=3Ds390 with GCC s390x-linux-gnu 16.1.0.
>=20
> Fixes: 32e0f607ac6a2 ("tracing: Add trace_seq_pop() and seq_buf_pop()")
> Assisted-by: LLM
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Kees Cook <kees@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005155653.late=
.426-kees@kernel.org?part=3D2

