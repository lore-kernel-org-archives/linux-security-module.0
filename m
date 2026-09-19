Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480D2D322E;
	Sat, 19 Sep 2026 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778068; cv=none; b=B+LGb3JyN7ey3GO7F0ZmisdhkkMbAEt0N8URTZV7lkLz+KzyhBByGPNyMQoMrBnymdLa0ZteCYCzLpCpcVTWjADoNZqwA+bI3I2BuL9Wx+xdtMjFtL+rdRH0NlJT7q6CeUFY8oIZL5pcj8JzplCskroAdsrDhPL/zftX9t1XpcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778068; c=relaxed/simple;
	bh=G6v2ZDa/2+F7fA6TsGjMl1PFCCEfccpmbRB5TtXZ4sY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TxG8hArel44b0o0dECY2WWZVe6V89PxUfXLaOPOQY56kzxSIWlqsWyw4A2lb/lmMK09EiVlDMixKmwBNt3O0eBkHtEy8jdAuRCpqXElau9H+6H2bwBhtDsMcs9fS01Ms30zLuH6N3dgggRDMdZMvknfs3U3SIc0DgmrPGg30GNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHzT7Sqy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHzT7Sqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE55E1F000FF;
	Sat, 19 Sep 2026 00:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778067;
	bh=G6v2ZDa/2+F7fA6TsGjMl1PFCCEfccpmbRB5TtXZ4sY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eHzT7SqyZXkagMWICSAgWB1CaI9P2qM43Kf6IthvshAZY93xas/4ozLDwgaAEcjrz
	 ripmQdMAehqmLjZSJLa+VrZcNF2pZN3tGy/sF9FY0SaU9nOuxL47J/jNDyzn23hQ4h
	 s48/i5DDv5LZyp8+aKNoMHQ0zxN9/dO1E1gNs8XXdtjQnOiP5nKc+VrlqHP3piVXyc
	 O5u/U8t+dderkTOYGxKXievEFE2S9ppvvwfOQDKD8/Bd2I0n7MP0yILGnB6SJPKjYd
	 cK8/jkr5mj+ydQgKgy7jpRx0d1yLeko+VYVlxir79/bO74MOZw+SdwlslWvn0qzeLn
	 wnX/yET+aYr9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/9] seq_buf: Do not pop from an overflowed seq_buf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kees Cook" <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260919002714.4060307-2-kees@kernel.org>
References: <20260919002658.stay.929-kees@kernel.org>
 <20260919002714.4060307-2-kees@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 00:34:26 +0000
Message-Id: <20260919003426.BE55E1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919002658.stay=
.929-kees@kernel.org?part=3D2

