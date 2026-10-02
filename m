Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E446EF8F
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945790; cv=none; b=YtT7HIhdm1TEJJSxKd+6/xuobC0pPqu3DPXC/UbW4+pZr9/H1wfhECPd1/l2eOSB+K6gkKaEsvMTVgp3+q8QNGmJYOLP9nH4tgsbRZkkpOkqqmhXc1yMeXgOg4VqZv/V6UcB8IOgKLNO8jFcaVtwMB/LYd4YjX+QrYKIz+LpWL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945790; c=relaxed/simple;
	bh=0S21ydbBDkH8uY4pGlkOoJI9U6rDXUQFDMWL6wPhypo=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ryj27tVAfTR2xy3UvGsqJVwDntp6+JWoX5F3OliYnGTBq81IfahFnGxu2QV3OLJn83fZ2i2GomnPGdNFLhaoJKBcxE6zPCvAZS3UsRXqVvVN0KsPznKZOJU1j3iKb/0/vNr23DmizYDFYxLHddvnQosCuItH8BEHDMuyBpu+jIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrqIJcGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrqIJcGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DE41F00898
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945788;
	bh=2ugXC4fGl41XNR3dSeoAiGAYBG4G0DJJDYEjJ+Igags=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BrqIJcGrOnMOh8zwjPYXfU8/N1lmsUbBSOgUEV8uAF9R3vZ4Ykmf7VscHwutLqVWf
	 MU4Mz4alkKyRgSvVXjDQQIW7kS7EWDhHOcKaQh+qz5ywQWUphE/NggusLAAGKoM+Gx
	 yEp9WDkNruyn6emwQXb84p2EmgTWhGxtJsJsmPSsllT1u7pA7d7SRD2fAC3p+qrYoP
	 DxoOD4gKtSG+eaxQivbv+P/nqeVpNeuJjwSOgld/wWxm5pd2y9fD2//FAIIT6I37Cw
	 QxnJ337Ku6hdtz2LeCAXjUOlpOS/k5W6BG1crkGH4+QcXtmryLi/RktfNf34LaPYRO
	 2EmboNoEPypKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/8] selftests/landlock: Add namespace restriction
 tests
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261002124409.1277970-6-mic@digikod.net>
References: <20261002124409.1277970-1-mic@digikod.net>
 <20261002124409.1277970-6-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 12:56:28 +0000
Message-Id: <20261002125628.94DE41F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/landlock: Data truncation of 64-bit namespace flags in au=
dit log string matching
--

commit 5fd29f953c165adc6df65241e36e43cef7dbf0ae
Author: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

selftests/landlock: Add namespace restriction tests

This commit adds extensive tests for the LANDLOCK_PERMISSION_NAMESPACE_USE
restriction, covering namespace creation and entry. It includes rule
validation, forward compatibility checks, layer stacking, and audit logging.

Link: https://patch.msgid.link/20260726161400.3010511-10-mic@digikod.net

> diff --git a/tools/testing/selftests/landlock/ns_test.c b/tools/testing/s=
elftests/landlock/ns_test.c
> new file mode 100644
> index 0000000000000..6faafc110844d
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/ns_test.c

[ ... ]

> +static int matches_log_ns_create(int audit_fd, __u64 ns_type)
> +{
> +	static const char log_template[] =3D REGEX_LANDLOCK_PREFIX
> +		" blockers=3Dnamespace\\.use namespace_type=3D0x%x namespace_id=3D0$";
> +	char log_match[sizeof(log_template) + 10];
> +	int log_match_len;
> +
> +	log_match_len =3D snprintf(log_match, sizeof(log_match), log_template,
> +				 (unsigned int)ns_type);

[Severity: Low]
Does this format string risk truncating the ns_type value? The ns_type
parameter is a 64-bit __u64, but it is explicitly cast to unsigned int
and formatted with %x. If a namespace flag exceeding 32 bits is ever
tested, the upper 32 bits will be truncated, producing an incorrect audit
log match string and causing test failures.

> +	if (log_match_len >=3D sizeof(log_match))
> +		return -E2BIG;
> +
> +	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
> +				  NULL);
> +}
> +
> +static int matches_log_ns_setns(int audit_fd, __u64 ns_type, __u64 ns_id)
> +{
> +	static const char log_template[] =3D REGEX_LANDLOCK_PREFIX
> +		" blockers=3Dnamespace\\.use namespace_type=3D0x%x namespace_id=3D%llu=
$";
> +	char log_match[sizeof(log_template) + 32];
> +	int log_match_len;
> +
> +	log_match_len =3D snprintf(log_match, sizeof(log_match), log_template,
> +				 (unsigned int)ns_type,
> +				 (unsigned long long)ns_id);

[Severity: Low]
This seems to have the same truncation issue as matches_log_ns_create()
above. The 64-bit ns_type parameter is cast to a 32-bit unsigned int and
formatted with %x, which will drop the upper 32 bits.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002124409.1277=
970-1-mic@digikod.net?part=3D5
