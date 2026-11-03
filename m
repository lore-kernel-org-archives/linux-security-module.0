Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692744;
	b=0Q21n1l3wN2gwBM+WJYYHBv6iSmajXDX4+xdzvGaRSTFUEN2Pmmqv6MTzcC6vIKqMU7Z
	 20IKtbQ97I2tcZzqHEFxiM75mXfPXXL8qXP32VNtDXHWZpLWnNRdRuOpxRC6zsV+f+ee/
	 uR66w8XvNjmiBIQisNQ64Em1N+ii52RJ3YYxk4y+K/ziI1bngVZ65zOJhS4ROl+BAptBr
	 Ct/QBQffhgRRIbN5qZ3Xlrh5JSGFabeI2/+vutcM/8Y/Vxl/keRu3QpVxlqKVqEGvHbVb
	 FUNT7QYQTg97ID5dAuUm5nqx4S1pf/0vZ40faXatXYGtMa7UWvP3ZvksGdHdbebEHeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692744;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8RIEFZIxxjExEYOfW0rPUAsKiLTzUJLj9ABQj2/LqIw=;
	b=XVsPIsDumynOGQnRyVpKAxcxy2HLSPEJ5Rmsk8ef4skBMF2E6XbFi1khWUrma1id+Y/m
	 ocjD4Lq2qjN1Fo/SHzhyRn0/az5rrCLfcZdRZkcFMyNdC4Tk1iAnZBrkJIVUKBkwFiXO8
	 1ATskWmyLAvtBTTh2wTKYtUjzr6ea4fhSck+axQTNi/RFHiZBf6Rg9JfBkCYQ/xBma1LW
	 dsr1U4SQG8mp7Ab6/3vya4cKlqF5gFbWaHD4/ronpXY5J9bxSKzM/QYwIzbyRtPs8SHv4
	 GjaAcaUBEpFzCmQybNd1HzLashH4+UevS5ReJh7yA5x4IgGEugeEra05TmjhxiENDPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NzWC0/f2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F0606A32D;
	Tue,  3 Nov 2026 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzWC0/f2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732D11F000C1;
	Tue,  3 Nov 2026 07:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692743;
	bh=8RIEFZIxxjExEYOfW0rPUAsKiLTzUJLj9ABQj2/LqIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NzWC0/f2l1ygGz63lKYAWakJHKyZ1R14sqK5YGr9FtpFHR2BJ6KePjgAmqwFs89Lq
	 IOP9hSMUBzv9Tg3NhLfz36VZ6QtUYNKK4baUQzVNzVPeVMMFxG0dicdZ2oR0v+Y3aA
	 lbJHHyncBgwGmdtRuq+n03DJTvtdN6DSdzn2A1suuYE+74Fz9aPYMmZKDFcxyBK+MD
	 YY9HZ7MEZjnQ38rf3HfACtcB5NOrqbx+GBUsauktl/oTAWR8dEhmcqxznJ7RWNm88H
	 ubosOMpLfRdlFgE57lDbe4y8KEck+INegfgRHs4gT3ORufSk3F+m63TYw0KW3Jg/av
	 i7+AXJUH3K2XQ==
Message-ID: <sashiko-outbox-194783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next 8/9] Documentation/ABI: document the lockdown
 securityfs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261103082421.3033195-9-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
 <20261103082421.3033195-9-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:59:03 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Documentation/ABI: securityfs-lockdown omits CONFIG_LSM activation =
path
--

commit a74113d4e117aa2187671cc1af3e2f7a75da9ede
Author: Cai Xinchen <caixinchen1@huawei.com>

Documentation/ABI: document the lockdown securityfs file

This patch adds ABI documentation for /sys/kernel/security/lockdown and
updates the LOCKDOWN SECURITY MODULE entry in MAINTAINERS.

> diff --git a/Documentation/ABI/testing/securityfs-lockdown b/Documentatio=
n/ABI/testing/securityfs-lockdown
> new file mode 100644
> index 0000000000000..490dc607492ce
> --- /dev/null
> +++ b/Documentation/ABI/testing/securityfs-lockdown
> @@ -0,0 +1,41 @@
> +What:		/sys/kernel/security/lockdown
> +Date:		August 2019
> +KernelVersion:	5.4
> +Contact:	linux-security-module@vger.kernel.org
> +Description:
> +		The lockdown securityfs file reports and controls the
> +		lockdown state of the running kernel.  It is provided by
> +		the lockdown LSM and is located at
> +		/sys/kernel/security/lockdown.
> +
> +		The file is present only when CONFIG_SECURITY_LOCKDOWN_LSM is
> +		enabled and the lockdown LSM is active: either
> +		CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set, or the LSM is
> +		listed in the "lsm=3D" kernel parameter.  Otherwise the node
> +		is absent, and userspace must handle its absence.

[Severity: Low]
Can the lockdown LSM also be activated at build time via CONFIG_LSM when
neither CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set nor the lsm=3D kernel
parameter is passed?

In security/lsm_init.c, security_init() falls back to lsm_order_builtin
(initialized from CONFIG_LSM) when lsm=3D is not specified on the command
line:

security/lsm_init.c:security_init() {
	...
	if (lsm_order_cmdline) {
		lsm_order_legacy =3D NULL;
		lsm_order_parse(lsm_order_cmdline, "cmdline");
	} else
		lsm_order_parse(lsm_order_builtin, "builtin");
	...
}

And security/Kconfig includes lockdown in the default CONFIG_LSM list,
which causes security_initcall_core() -> lockdown_secfs_init() to create
/sys/kernel/security/lockdown.

Should this paragraph also mention CONFIG_LSM as one of the ways the
lockdown LSM can be enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103082421.3033=
195-1-caixinchen1@huawei.com?part=3D8
