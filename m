Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C19495045;
	Fri, 18 Sep 2026 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789758157; cv=none; b=lXKM+E9SnVQK6mGVQQYfvW37yCaFErPt1/A9UqADqvrJr2o74dbjzCH2Qj32l8Ouj+FCX3GZ2PWLJfDpxPyIC8ZVlHxD9OSX8vfmoEP6MJNNmT5ms8jViMpDb8Y8KA4fJa0umrB0z9ITnUhYUDjMx0UKbL1HdwdZwk8GiDNRUgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789758157; c=relaxed/simple;
	bh=QPhs5TmGzKtHWwiUSgtnIxINZyre2JVeb8UFF72povo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iVLJqir4tO8u2GnMhvEnZS/Cnby260vqEVfmNZbMstA1r0bkeayvZgk34fgWkvqjNEHiOM7UWxnseJ2u2TLAHwSQo7nRXRRVZaclL4tnmKzpkHp+rgNK4ZWOjzLOx0Ut2ak8M5QoUnt6Wu2TmAZgT07OH6QjxP730K+wHxzfTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo3gPwjz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo3gPwjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727D91F0089D;
	Fri, 18 Sep 2026 19:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789758152;
	bh=QPhs5TmGzKtHWwiUSgtnIxINZyre2JVeb8UFF72povo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bo3gPwjzi81dn2ywlEhsVkXOlGYJLe4YL/1U2JE76Qxc92CBmUhMxA9NI1+6FwTCf
	 TsPWuVLsaSJcwBz4IGNRnzwAffp1LX76BcTieanreexv94DG99u116rj5j4AzmKLtM
	 3I0N3EhnYN1Tvb12ZgpxEtIfR8fmaI0Royto9Duhamp6dHrZCjworqiCpwDpYCrqY5
	 s+Okpma8Dw100TooQybRuFiKRHmq88R2UqcnUW2GFMpieDrbVMHAv5++k9EeFSFBBY
	 PDzxao/xDFDKcnVovf+h2n6AOsDrlaHwcp042I4SHukaxlWWieIo7mnH3YNsChIMj7
	 K2Is3J5UTrEHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 9/9] landlock: Fix tracepoint contract documentation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260918185036.608651-10-mic@digikod.net>
References: <20260918185036.608651-1-mic@digikod.net>
 <20260918185036.608651-10-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 19:02:32 +0000
Message-Id: <20260918190232.727D91F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The tracepoint documentation claims that denial and lifecycle events
> expose every input needed to reproduce a verdict. Instead document how
> denial, ruleset, and domain events identify the denying policy, checked
> operation and object, and reason for denial. Direct consumers to generic
> tracepoints for additional operational context.
>=20
> State the reconstruction limits: IDs are boot-local, rule checks have no
> request ID, and exported records may be lost or cross-CPU reordered.
>=20
> Also replace the incorrect BPF_RAW_TRACEPOINT guidance with libbpf
> SEC("tp_btf/...") attachment and refer consumers to the event prototypes
> for callback argument layouts.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918185036.6086=
51-1-mic@digikod.net?part=3D9

