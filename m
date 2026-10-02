Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3F13C3F5B
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945612; cv=none; b=V5oqgIc8Z/xGB2tTXSEuj5JuKDxbeL9O8TLAa7TGtP5rvR/+70X405G4OpBn3xDW1B1cmpjSJT0oyU3Ej3YZYHH5euNoDtwCfT8vnYHJuLFeBIvMAJiukWKyJjWwcu4GXqVVlWi2tCPgHfuLLnQBSa736GgIzFrQlok8JUg8mF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945612; c=relaxed/simple;
	bh=t0FNcuuutnVufVEMnNQDrDT7f1aMhbDfSCmr/9yeChI=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gPQGB7R2HSnBjkpR9qEtg7o8m5zyBZ/DQeVfSskvlRr1y8muUbYl4SEvAR0Q/16NlXHxekG04tA9TZBHRs6lTcdwW2HY2BONMW1DS9P2MWRlLygteF6Y+6196v33GWKPd8ae7Cc0y3io/hobopa7kezVRP+jsBfXIgMmecP1smQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awvK2xTv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awvK2xTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FA11F000FF
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945610;
	bh=bhiFW4U0x8vLf+1VFi+6/wN7e5jppqSGv1anjjDT85s=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=awvK2xTvlE7hrNveNVsCLjt8fd2b4fTM1AcyKIZW9v1m7aHqerRqZYsC09JbHZ3RG
	 vNeJ5HkePmv3eTXVwXntGhBGXNTx1qL1XoQP668zFU0TKOboPC5Chpu2qWkGgnOORF
	 OJd73OifjQIsh8uRnEUoYN7z6Q1fSLnVzGQCxxufxv6xVPu9xz8ZWBPzz5/bJMT9gI
	 mqWhOduZqScat7Ai37xBawk9lglgU6pifRVwZ5LcgRsJOYybTqXSCwfrHhWwMQ0Tlh
	 z2Gydolh2hx73O5z0VS5VrMct5mojsRoMCQsKruohDGnxQlt80i4SSJLgw40OWv0YO
	 tLUroZ8AEnEmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/8] samples/landlock: Add capability and namespace
 restriction support
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261002124409.1277970-8-mic@digikod.net>
References: <20261002124409.1277970-1-mic@digikod.net>
 <20261002124409.1277970-8-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 12:53:30 +0000
Message-Id: <20261002125330.A4FA11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] build: sample landlock fails on systems without libcap-dev
- [Low] build: missing fallback for CLONE_NEWTIME breaks build on glibc < 2=
.33
--

commit c88aebdbd55f6c34b61885d4e3d918bc61983af0
Author: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

samples/landlock: Add capability and namespace restriction support

This commit extends the sandboxer sample to demonstrate new Landlock
capability and namespace restriction features. It allows parsing allowed
namespaces and capabilities using libcap, adding appropriate command line
arguments for testing.

> diff --git a/samples/Kconfig b/samples/Kconfig
> index a75e8e78330da..b18efc19b85d0 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -166,8 +166,10 @@ config SAMPLE_LANDLOCK
>  	bool "Landlock example"
>  	depends on CC_CAN_LINK && HEADERS_INSTALL
>  	help
> -	  Build a simple Landlock sandbox manager able to start a process
> -	  restricted by a user-defined filesystem access control policy.
> +	  Build a Landlock sandbox manager able to start a process restricted
> +	  by user-defined filesystem, network, scope, namespace, and capability
> +	  policies.  This sample requires the libcap development headers and
> +	  library.
> =20
>  config SAMPLE_PIDFD
>  	bool "pidfd sample"

[ ... ]

> diff --git a/samples/landlock/Makefile b/samples/landlock/Makefile
> index 5d601e51c2ebf..b30239c8a281c 100644
> --- a/samples/landlock/Makefile
> +++ b/samples/landlock/Makefile
> @@ -3,6 +3,7 @@
>  userprogs-always-y :=3D sandboxer
> =20
>  userccflags +=3D -I usr/include
> +userldlibs +=3D -lcap

[Severity: Low]
Does this unconditional linking cause build failures during make allmodconf=
ig
or make samples if the host system lacks the libcap-dev library?

Since the Kconfig does not verify the presence of the libcap library (for
example, using a $(success,...) check), the build will unconditionally
attempt to link against it and fail when the dependency is missing. Could a
dependency check be added in the Kconfig to prevent breaking automated=20
testing on minimal host environments?

> =20
>  .PHONY: all clean

[ ... ]

> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 030583273f3f7..4a86ae6d4552d 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -232,6 +241,166 @@ static int populate_ruleset_net(const char *const e=
nv_var, const int ruleset_fd,
>  	return ret;
>  }
> =20
> +static __u64 str2ns(const char *const name)
> +{
> +	static const struct {
> +		const char *name;
> +		__u64 value;
> +	} ns_map[] =3D {
> +		/* clang-format off */
> +		{ "cgroup",	CLONE_NEWCGROUP },
> +		{ "ipc",	CLONE_NEWIPC },
> +		{ "mnt",	CLONE_NEWNS },
> +		{ "net",	CLONE_NEWNET },
> +		{ "pid",	CLONE_NEWPID },
> +		{ "time",	CLONE_NEWTIME },

[Severity: Low]
Will this missing fallback macro for CLONE_NEWTIME cause compilation failur=
es
on older host environments?

The CLONE_NEWTIME macro was added to the glibc sched.h header starting in
version 2.33. If the sample is built on a system with an older glibc, it
fails to compile. Can we add a fallback preprocessor definition for=20
CLONE_NEWTIME so the sample can still build on older distributions?

> +		{ "user",	CLONE_NEWUSER },
> +		{ "uts",	CLONE_NEWUTS },
> +		/* clang-format on */
> +	};
> +	size_t i;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002124409.1277=
970-1-mic@digikod.net?part=3D7
