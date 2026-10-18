Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB83B14D6
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344856; cv=none; b=dIHpLB/psV243V3RcY4LPzsfrKTC4A889I8ICwTtT/Lt5dg9HpV3aWmz7IbmHGF9FoVnngcE7k55iC22eEjm1Sumc2jmYjT1c+Yh0TA6ER4mOcnWP5z6mJIiZ4DffpmkyVhdFOtXLm2OCmqlMP13GLuDUp41cEEcSx8BWszvev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344856; c=relaxed/simple;
	bh=KOyS5K5eJnlAKKk11xAbgdqn1kIhscgEtvJovQY1VH0=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=u2Dt565yxcmsHT6BnG/NJEXIrlGTE8pZlYuwSW+rseAyOcx95BYItMV4qTUEtGN+5AaHhE7DFxEX4DZsfQ1eH0zp3XNflEZp1Io4QYcZrmu8w+wq+iSbHyeRb/zbPSk4ew25RvVtp0O4oWt3y1R7XXMNxrtPFA5RKC6LcGERe84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN2SfHQV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN2SfHQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F298B1F000C6
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344855;
	bh=KOyS5K5eJnlAKKk11xAbgdqn1kIhscgEtvJovQY1VH0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gN2SfHQVqy0pwwKXOwIgBXxDzKWrjncNX8yxNKEgdWpOlF0TDZRLGkDav1Sltq5L0
	 GIRbjqyti6GPkeAo+xZonM4GvO0AYG9Gp3zkvxYf2kLY95rR6nnL52FtiKBJosJ+RC
	 1RquqppVBowKLxogH18vZtWC4XcUlqjalr79P9j4O5AcVvcyI1yCH/rOO9v+bfB4A0
	 phdC3r0huGxqJMUJ9AwiB0Kh0Yrmobl7YPcbqs6Sfhwv/DndHRKBavr7l5LAGogH3H
	 uBgpONHuNM2XrXlpVZUIrtVSeG5TI7wZ3b05pahwG8HkjrmEZFRscMyWM3o68L+EyO
	 lOfpuZWUjHrtQ==
Message-ID: <sashiko-outbox-176321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] cgroup/v1: use cred_ids_allow_move()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018-b4-cred-ids-v1-10-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-10-7bdf2db4ea9f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:34:14 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Use the library in __cgroup1_procs_write(). That euid 0 may move anybody
> is part of the rule.
>=20
> No functional change.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-b4-cred-id=
s-v1-0-7bdf2db4ea9f@toxicpanda.com?part=3D10

