Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4D19D075;
	Thu, 27 Jun 2024 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520086; cv=none; b=sWUDtWluiMa6GsT9NMmDlcceJrs2oQpky952CCm+GzXKCjvpwB4x10+ihJxayHdTGXy/luupMrQ+bB35u9Q/2xLHUoQpTpaql6t/0y9BzgnRTsMHnDhh/TrEQo1z88QaNOOzx4XA0R0+MpGf1lrZwsQzHmQxWTw36a7pupLW+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520086; c=relaxed/simple;
	bh=ctF3ngmlwveZ80Qb9k25CNAC+n8BO7bPBHAC37329d0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JgbDieEI0tP99CHekP6zWZwVlUQvqi39pQJeSTD1FHSc5Uv9oveJ6yGiyj2xtND466GhiWKXBfkVSwPGWQMtV4It5SCASxEsA8Y7quRwFYiE2+vAC4W+h9CFKC1Uw+qmTKCu34dgSE6BZg5+MmZLSYCpH+jj4Gg7P24Drzu+iOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Lt1M+PIU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Lt1M+PIU"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 08E1845E2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1719520084; bh=mHnZPGMh368CZQ4ngNCoaVmtdmRz9s+78qEKmLsnVH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Lt1M+PIUDY19YZ7cJgwdhMbjS44aiRy5bxHEmO78UgG3F4q/eIMeCHF4l5/MrUn9u
	 fyCujeN2nzHPQ/7kbXQqmp1CEMei0yC5WYzmjOA5J6spSDZjSHZa+BXORUjUWiDG6K
	 5YZmuWyKQ6tvLEs/dxFPIVIaGHRIm3hl/f6A+PxnIXyA0O/fjw/0ZrxwEs0dMb2uLS
	 VGAvTtg0FFBdPaSBDreotbeHmJX8ngUiSY6RCrSzdDgWEB0nY3KcMQve1FktcUMAG5
	 RkHiuZqQrM8259pyPSZtJrvjyr37be9nbmDtkMCtoFRhrXyLTf9t6dRd7P9akjiL1U
	 ibOvIaP6tDoLQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 08E1845E2C;
	Thu, 27 Jun 2024 20:28:03 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
 andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net,
 renauld@google.com, revest@chromium.org, song@kernel.org, KP Singh
 <kpsingh@kernel.org>
Subject: Re: [PATCH v12 3/5] security: Replace indirect LSM hook calls with
 static calls
In-Reply-To: <20240516003524.143243-4-kpsingh@kernel.org>
References: <20240516003524.143243-1-kpsingh@kernel.org>
 <20240516003524.143243-4-kpsingh@kernel.org>
Date: Thu, 27 Jun 2024 14:28:03 -0600
Message-ID: <87ikxuuo4s.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

KP Singh <kpsingh@kernel.org> writes:

> LSM hooks are currently invoked from a linked list as indirect calls
> which are invoked using retpolines as a mitigation for speculative
> attacks (Branch History / Target injection) and add extra overhead which
> is especially bad in kernel hot paths:

I hate to bug you with a changelog nit, but this is the sort of thing
that might save others some work..

[...]

> A static key guards whether an LSM static call is enabled or not,
> without this static key, for LSM hooks that return an int, the presence
> of the hook that returns a default value can create side-effects which
> has resulted in bugs [1].

I looked in vain for [1] to see what these bugs were.  After sufficient
digging, I found that the relevant URL:

  https://lore.kernel.org/linux-security-module/20220609234601.2026362-1-kpsingh@kernel.org/

was evidently dropped in v4 of the patch set last September, and nobody
evidently noticed.  If there's a v13, I might humbly suggest putting it
back :)

Thanks,

jon
