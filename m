Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3AC35E952
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967534; cv=none; b=hy8f+U7p1CHrDpTcdHfA38Z0LVQL5aFtVx1DzAhh3YL73uSHg0orRiHdq4Pvo55UlpdH9Y2kmRR0euiQpDJ5LPB8d6f29qGYWyLpQrbGkpxJH+VbkcmQkZfYJMN8Vlko0nFETifBEGFB3THqflpRaQcOR/auu8IbizpxsHyzFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967534; c=relaxed/simple;
	bh=y7SBDDWHbXGoSmYRMu9gtj/nEGiAAxz7LQVnhFImVCQ=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WElRfW0PEkceIVVM3jrZTRmCF5HUMvv4UsUN2g2pmpdulgqIB3+aFbgJjG3mdfB+lkW08U3JOVAjDM5kw3cwgKc9P1SNAwUZTdcFVY4ylTnqVleq8ZoGqjb0RDwgUXT7i4Ni3edSbDyXks++tUwypG4ZwZR+CcrFurTX8cNE8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ4IoCYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ4IoCYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E921F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791967533;
	bh=b4Td2CYlwJlUauPSnKKpp7Yw82P8T/QA2CpH38h9P1I=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EZ4IoCYBaAz6LVyXLhI15yY5o5xVsGOPmbMC1ya9+rbIJRfWwd8jwPixmeMouGNHK
	 FUeitC0Xx5u4fga98C/EusjUQsb6TXcgdLF3cKOEF+iXgwl24qGg9aNrGpQi/7z8vU
	 NWNx6P39idUZqb22yQmB8xG93Z0EgjdA9mhfWhYmvskmkNaWsh0YC8UQ3Y5kGwy3rH
	 DYjc1v6OvtqfIHqRHHUyXwjv+Rpu5bjjs5behjvMxE1uNDNopsPqTyfwzyFTaLC9g1
	 6AfDjRevJlCv8nNveT1PGqyzLnLhk11TTAbM56i5nySn5OM1MvGx+9eqmKzOrmKBIt
	 IDjgMgX5uJGsQ==
Message-ID: <sashiko-outbox-171036@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/8] samples/landlock: Add capability and namespace
 restriction support
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014082718.1435842-8-mic@digikod.net>
References: <20261014082718.1435842-1-mic@digikod.net>
 <20261014082718.1435842-8-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:45:32 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] landlock: sandbox configuration leak via stale envp
--

commit 89caad8ff02abf64d07b124b6bd1e3374e39181c
Author: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

    samples/landlock: Add capability and namespace restriction support

    Extend the sandboxer sample to demonstrate the new Landlock capability
    and namespace restriction features. LL_CAP takes a colon-delimited list
    of allowed capabilities. Numeric values are always accepted, and when
    libcap development files are available, capability names can also be us=
ed.

> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 030583273f3f7..1362f08ff14b9 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c

[ ... ]

> @@ -597,6 +824,32 @@ int main(const int argc, char *const argv[], char *c=
onst *const envp)
>  			~LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
>  	}
> =20
> +	/* Removes namespace handling if not set by a user. */
> +	if (!getenv(ENV_NS_NAME) && !getenv(ENV_NS_QUIET_NAME))
> +		ruleset_attr.handled_permissions &=3D
> +			~LANDLOCK_PERMISSION_NAMESPACE_USE;
> +	if (!(ruleset_attr.handled_permissions &
> +	      LANDLOCK_PERMISSION_NAMESPACE_USE)) {
> +		unsetenv(ENV_NS_NAME);
> +		unsetenv(ENV_NS_QUIET_NAME);
> +	}
> +
> +#ifndef USE_LIBCAP
> +	if (getenv(ENV_CAP_NAME) || getenv(ENV_CAP_QUIET_NAME))
> +		fprintf(stderr,
> +			"Warning: Built without libcap; use capability numbers, not names.\n"=
);
> +#endif
> +
> +	/* Removes capability handling if not set by a user. */
> +	if (!getenv(ENV_CAP_NAME) && !getenv(ENV_CAP_QUIET_NAME))
> +		ruleset_attr.handled_permissions &=3D
> +			~LANDLOCK_PERMISSION_CAPABILITY_USE;
> +	if (!(ruleset_attr.handled_permissions &
> +	      LANDLOCK_PERMISSION_CAPABILITY_USE)) {
> +		unsetenv(ENV_CAP_NAME);
> +		unsetenv(ENV_CAP_QUIET_NAME);
> +	}

[Severity: Medium]
Does this code leak the newly added LL_CAP and LL_NS environment variables
to the sandboxed child if environ is reallocated?

Looking at the end of main() in sandboxer.c, the child is executed with:

	execvpe(cmd_path, cmd_argv, envp);

The environment variables are scrubbed from the environment via unsetenv().
However, if any library (like one loaded via LD_PRELOAD) calls setenv() bef=
ore
main() begins, libc will reallocate the global environ array onto the heap.

In this scenario, unsetenv() operates on the heap-allocated environ array,
while the local envp pointer passed to execvpe() still points to the origin=
al,
unmodified stack array containing the un-scrubbed sandbox configuration.

Could we use execvp(cmd_path, cmd_argv) or execvpe(cmd_path, cmd_argv, envi=
ron)
instead to ensure the properly scrubbed environment is propagated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014082718.1435=
842-1-mic@digikod.net?part=3D7
