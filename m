Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116155208DF;
	Fri, 18 Sep 2026 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757872; cv=none; b=HX3C7fRdPAPE2fLLFkRWCFUgW4/QNW4m5ubUO4mEdu6L5bz4C7CE0t1YebXvudL4JUvWRhum6n4YByt/IPwcFG+spSolRhKpiZVTvMVn6cbMmVWwhNU1Ventv7ut/71gH2qv8Em2VdImpFFGDvJXePEUAsr94V7kwZ9NgLH9TLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757872; c=relaxed/simple;
	bh=DDv0htgjuA6Yzf97upzcahodKIyk5xpgklXec1gwokE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sXMQM8+8EH2wYmgevB8OJZJcRhaNKJ5g9FDAPg7J2TVRyYme7b/k6ciZHDAbqCPeoHwf5Ml/5nNK1Mcn+cHA/iN6hija083A0IbpkqDdhypPR7wtS4yXgRvFfvPIMHo2diRLIB8oUnoXYwqATgmYCMjHCFwoWPBJf/c+wFOvZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzOdbroW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzOdbroW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C5F1F00898;
	Fri, 18 Sep 2026 18:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789757858;
	bh=DDv0htgjuA6Yzf97upzcahodKIyk5xpgklXec1gwokE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jzOdbroWVa3Qxht2gmpF92gkaWEbqeYn1KzFOA7E2AMaDZZ6L4y9vU9nXqFAPXAHj
	 8YU8LQrHm/XqZKhPOIN8nxt8NPZqyOmuEPQJzq8A1ysMoTqcC2TFIOSP/34SAnBdA6
	 yTgcb+zXKj1IjB1gDHyOeTohVm6KJibmAKzh+N8Xm2aPPSfzpulm7jQblEi+/y9Vvw
	 8R6vqeZ+womWzIB0uN6IbKem2UscYePLvVCRHTCIyumYZzEnnQzRoDrVhDBUBNXVZp
	 LAh2g+1bUoXKF9qT8jDsqzQ1wdYK7v0RTuCpHu6LZglHa1op/2yP96r2MS0F80H+GQ
	 bSI4ToU9recxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/9] landlock: Report the effective signal number
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260918185036.608651-7-mic@digikod.net>
References: <20260918185036.608651-1-mic@digikod.net>
 <20260918185036.608651-7-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 18:57:37 +0000
Message-Id: <20260918185738.50C5F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The signal-scope denial callback identifies its target but not the
> effective signal. This loses permission-probe signal zero and makes the
> file-owner hook's zero sentinel ambiguous.
>=20
> Append an int signal argument to the typed-BPF callback. Preserve sig,
> including zero, in hook_task_kill(). In hook_file_send_sigiotask(),
> translate signum zero to SIGIO at the producer, where its meaning is
> known.
>=20
> Carry the effective signal and target domain ID in a private,
> stack-backed context consumed synchronously. This requires no allocation
> or task reference in the interrupt-capable file-owner path. Gate this
> context and the remaining scope-only domain IDs with CONFIG_TRACEPOINTS.
>=20
> Keep the tracefs record and audit output unchanged.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: bb91730f16c0 ("landlock: Add tracepoints for ptrace and scope deni=
als")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918185036.6086=
51-1-mic@digikod.net?part=3D6

