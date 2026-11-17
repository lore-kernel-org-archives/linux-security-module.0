Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911364;
	b=W7Mp4x0nSRvcg2JSlTR78875Ssf63Hvo+Gkhbj1ed3GyeLIJgQDFO7ElEfRVoIDgV3Xh
	 PHElmfatPLGiBij7rx7z+SPvUWaBK1Ipz/0vPeensySHJQZacN48R9ZToX3+QR5MP9H7d
	 LuW5Kc9rpvFKyuyYxGOXcbkksJFLpWUMsLybvI6RpB0BcbuSq9QbsP/0Md5TKhHPF1bB4
	 CPseF83MABeeyHpLCk8kjpbtBWn286xtBLOm0oQ7xkRAFUSi2NO0VzE+QnC2nkMA4Gnnt
	 VJa95VqST+FTUwfnPJdBer9xrQLEJhn9UUWz0rJF/KEd6UDXUtPyECC++1Zof7mZj3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911364;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rvXMn0qMIm94Si7KQIyKX21A6U1twU0v9FU9lZ57D9A=;
	b=MJWnb+D8CzCChfbaqJZAq3/PHrkklad5O3Q7nx49X17hTAqyYhNKjRV5EM0fJareyAs6
	 AVgKzz3D5c9tQnNs6KbUUd/ne8QVjELbvG6GcaEz+lsZVMCBoLIouKVYSxtCI8R05kY99
	 3HA3HOSG4Bp8IKmsGY/oQmTILmy7mcCAS/SNAfRjPwZGmiik2JFICyuWW8urcKsAtzXna
	 oA3M7jMIE2U1TYViIjFOZfnoCpkBkYdFIRJDlWO3zD943Fmwpi+gqSUetdU5jOqO+mX1n
	 uwfUkX97rcXOgILasiPW7xm8o8lYIj5aNomxDFbLcBzn2cnsXNGOoSscPuXMovWzJgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMFvC55r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60B9606A31C;
	Tue, 17 Nov 2026 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMFvC55r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB921F000C4;
	Tue, 17 Nov 2026 10:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911364;
	bh=rvXMn0qMIm94Si7KQIyKX21A6U1twU0v9FU9lZ57D9A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gMFvC55rQRz7FFgPlPsHkAGoH7S2zVikDsllWAme1z5yOTDR3h0J69RSt4Pby3myJ
	 Kzu0eB70JEoaiE/JgSCBPSiY5t0MSAEmMzeF22INbR20llPGLNzy3EFd4xoFOV+PIg
	 /bdy21LjTqS6g0nVojgdS1yS8YIUuU1qlcgawskvwuEABDDjyPfzYzXO2vBcOOT0xa
	 96hKVohxk95Ql2oh+VJ4/aGVdpFk/8P5yOoVho6TRnigg+yF0UydIE1Qvx6r0FlGfb
	 BHrZjdWBOqqeGHScYlfo5O/sn69128lH5F13Ypmnrxh9L8HZStSldG+8BeFY0qRrEa
	 O1DdFyGK9zl+Q==
Message-ID: <sashiko-outbox-218622@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] landlock: Distinguish namespace creation and entry
 denials
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261117102110.2524197-2-mic@digikod.net>
References: <20261117102110.2524197-1-mic@digikod.net>
 <20261117102110.2524197-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:29:22 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Landlock reports denied namespace creation and entry with the same
> internal request type.  Before commit 08471914d6bb ("ns: allocate the
> namespace id before the namespace_init hook"), denied creation carried
> ID zero and could be distinguished from entry by ID alone.  That commit
> moved ID allocation before namespace_init(), so creation now carries the
> ID of an unreachable new namespace while entry carries the existing
> target ID.  Namespace IDs are object context, not operation
> discriminators.
>=20
> Split the request type into creation and entry.  Keep the two namespace
> values together before capability; this renumbers the unreleased
> capability request in raw and typed trace context.  Report
> namespace_op=3Dcreate or namespace_op=3Denter immediately after blockers =
in
> namespace audit records and trace event text.  Placing the operation
> before namespace_type and namespace_id lets consumers establish the
> semantics before interpreting the following namespace context,
> especially whether namespace_id is the creation-time value or identifies
> an existing entry target.
>=20
> Keep namespace.use as the policy blocker: the new value only describes
> the semantic hook context and does not add a policy control.
>=20
> The creation value covers namespace_init(), including clone(2),
> clone3(2), unshare(2), open_tree(2), and fsmount(2) paths.  The entry
> value covers namespace_install(), currently reached through setns(2).
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Fixes: 15dd86021b57 ("landlock: Enforce namespace use restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117102110.2524=
197-1-mic@digikod.net?part=3D1

