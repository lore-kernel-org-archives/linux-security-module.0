Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD434D3BE
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344863; cv=none; b=ljPl3PrHWqejE804kwXDUIqhD8CWlJmMQ+8kp0cdSqELlA1+TJ2qVE95deXUBkczaG2UPYzEv/vCKb9Ozu73uTSVbAFFQnI+jW1mgmyTUolnJP2hVjhpHKTZgvFlGjWevwK4QrAHwskD3FdE9mfinnhHfLF4943vKZ0GK+ugY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344863; c=relaxed/simple;
	bh=n74or8CmtAy6P8XFvul8J6jkByWoW5rZRSDmmHfhNBI=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tMES3YHLlQmz8qcexy5PbVlyR2XO/ftzebCWHVjpt/fCDm0vTHyHK3jA9nX5yHqKVrDBh3bFCLxRkt7dccUl5WDuij7yVTdFFksL+GFkYroOEroMnKuz50TIM//Yeq9Tgoi4XxhM8FFHgm5cef/J0xEIG9q5YGj6GqYTwCL7oCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VleOudid; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VleOudid"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210001F000C5
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344862;
	bh=n74or8CmtAy6P8XFvul8J6jkByWoW5rZRSDmmHfhNBI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VleOudidsm2RJV5bWFEGJWs/EY0hB7b2qf9gwtepXrn/DLI1y5aedNYetvy07gn8V
	 YnepnAiQ+rg8+wAoR2c9oFwqeBNVhOV4RArt1mhayfeSxm3L+3lQWH627wHf6ouSdx
	 n1Os0RarBYYx+570FJVQFoSDi376Uajs4hD/5lCDa30Oyg+7TbkJcrH7v4hBGc7fWx
	 ZcD9uC7z7wzLclbJ7ULwm3I8irQQJ1OcoNvx7yH9Ym3557bTEBZYQkMhVF3C98gp9L
	 hj3uT9pXhjDifVJe9SxUEQQQ++5LT+xe+kmwHidb6YktR7+4pKItxQog1QgNKi736h
	 Pb9xrjLajogug==
Message-ID: <sashiko-outbox-176324@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] MIPS: use cred_ids_allow_sched()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018-b4-cred-ids-v1-6-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-6-7bdf2db4ea9f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:34:21 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The FPU affinity code has a copy of check_same_owner() from the scheduler.
> Use the library there as well.
>=20
> No functional change. Compile tested only.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-b4-cred-id=
s-v1-0-7bdf2db4ea9f@toxicpanda.com?part=3D6

