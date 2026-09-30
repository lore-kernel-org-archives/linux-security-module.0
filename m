Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4E1FDE31;
	Wed, 30 Sep 2026 23:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812745; cv=none; b=H+g/lCfCUKKJDhcM6nFRMaZMjrCa5rcPECiXLgy7F7uePlJbiyH0jJt+E/ENfzveJMYjYL0V77roqIT5lY9nDBt5uJQ/c9KVoF/DAwXzoaXZFgL+Pkp6s9791rhkZ5f/fIeFyB0P11lOOK2WriuVpBV0aw46Pj472ta5cqKeQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812745; c=relaxed/simple;
	bh=12lwzPvL6uoetQNPg+9cZo+UwkXiPfSN3X/sWI1P+2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WW+yUnQD2OAwVQlRefLYsfDyU5DDNatbphabWR9p2zj6tAc9bIsp12/zqCV78VZFjB0DZJwev5fEo5hOR7wK3CmmT4a7+M9qkMLBMz3qUkMx2IdqH8FOn+2TpVNqxEUVViXqYe3DgUC4YlGTUpr7XjHLJlsmhl/BdkUc8bIU9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSq45VIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSq45VIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A481F000FF;
	Wed, 30 Sep 2026 23:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812743;
	bh=12lwzPvL6uoetQNPg+9cZo+UwkXiPfSN3X/sWI1P+2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kSq45VILvh9u+LBKYCnf+UaHCaIovsfxBopxfI58/0MhNsgKUh7cQjZI+E7b1H6+P
	 sKTUzt6E/aXJ/Ku/P+8uR2pHAsfdR5V7FKnOdmAQ5Yzn10FLbMt6/+D7tVnGDg0cvL
	 yDc+ovynbeItyobKgpIrrElU8muNRsZBroucy5o3/S1gT6KxgU6vAoiMQezFRZGRAn
	 e6o37i24uuQxZ291u6E1uOVMnygn1BWwyv1CxU4/RokDKTxYHH0zxVzMppIxVZUl+b
	 hEuo6/SZtesJ7Y5PYBo2Xj9aHeIn3tZLIeqr4BcTEcprAyiShWAqLgwjnrsB5LP7q2
	 l4xtOyk3u9UJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/11] seq_buf: Do not pop from an overflowed seq_buf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kees Cook" <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260930235247.157921-2-kees@kernel.org>
References: <20260930235231.out.387-kees@kernel.org>
 <20260930235247.157921-2-kees@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 23:59:02 +0000
Message-Id: <20260930235903.71A481F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930235231.out.=
387-kees@kernel.org?part=3D2

