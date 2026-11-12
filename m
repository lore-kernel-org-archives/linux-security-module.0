Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794525897;
	b=bgMwg1eZ4wPMZeQDr8NIG7MwKk1DT12Fzt2Phm4Th4tylfPRbc1ON4wtCX2tLJQl2p/f
	 jW0USsgB9PD46TRTXBUPLICNnm6xt3qkFqMN/6MlGkzZrf8jmszzvRCEGsW6oZ+a/3LX7
	 trBthSeCrll8cd5iD3gjiURaiLZdNf4/P7cyXuDoXD2jFQjk6lLBWvzZErHZhJaL7rmNb
	 0Cajaklv3BeFMrM6eOurXYLdqpJ2H0GRVqM8gAUWZ5E8Pzl11MleHn21i4CQ6DBzYwrJS
	 9LTqDEkZZYZhRQkaUhoI6nKlUvEz4CPb34KZUCgG1HbVtks+35jKjMnufm4CNCVahGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794525897;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=mtyHEAGiByFY5lsKYMz5TAnCflyHcUmZL5euxQYiwtg=;
	b=CYYTKuPEuA3YtskrHYJepoqplTEav2/Duge+05gb5Fb8zfilzY7SeHCZRoR0peAPDfN8
	 BBbMcDLj6wBR5WhwaMSlhr3uf/xOaOMrNSKQsZlLAFB1wsm2s5Ytt/PsvLjo58dtgGrQP
	 fy7GlSBArxegrlbL93PqBDZZU4YyEg55IqHyHpqbWVgqbuTAVjIzQziV4YQGaldXYBd2+
	 giusSuQEKZ9dRkaYa73gMApyqxG0g5u2EIpnXFrfLofEHNF1C4XrTZTpN+h7Eq6VA++m8
	 9uZrzDOwQzP+A4gZRnK1TmtI+vceLint3xUMYpl7RU8RlsOhXE42qtQmkI1ErzgFjwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=EqcL5ZXj;
	arc=none smtp.remote-ip=45.157.188.15
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6397606A323
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 23:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6397606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=EqcL5ZXj
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jQc1L60VYz12lN;
	Fri, 13 Nov 2026 00:24:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794525894;
	bh=mtyHEAGiByFY5lsKYMz5TAnCflyHcUmZL5euxQYiwtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqcL5ZXjZHKuei3g/Uf32yXqJ68R/Qxs3TCJFRrrKtyNdE9WT/hscVDMIAvDxX6lj
	 52IhglXlULLTn0FFmySa5l2yWXUq+vWH6t9aDwEr1nt5BLuEtff7bRFFoqKan2WGlS
	 rNebEI9b08P3gRV0d2dSGz/ZTagOv3Ll19IE2X+c=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jQc1K21pgzZvh;
	Fri, 13 Nov 2026 00:24:53 +0100 (CET)
Date: Fri, 13 Nov 2026 00:24:52 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] landlock: Fix REFER in layered domains
Message-ID: <20261113.eiChee8pohch@digikod.net>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Nov 08, 2026 at 09:23:47PM +0100, Günther Noack wrote:
> This patchset fixes a bug in Landlock layering,
> reported by Dwi Siswanto in [1] and [2].  (Thanks!)
> 
> The bug
> =======
> 
> When Landlock initializes layer masks for path walk based checks, it
> unconditionally adds the LANDLOCK_ACCESS_FS_REFER access right to the
> handled access rights.
> 
> This leads to a wrong layer composition, in cases where the following
> layers are stacked:
> 
> 1. A FS layer restricting REFER, but also allowing REFER in a rule
>    (e.g., handle REFER, but allow REFER on /)
> 2. A non-FS layer (e.g., networking-only layer)
> 
> When these rulesets are enforced **individually**, there are REFER
> operations that are allowed in both rulesets -- the ones that 1
> allows.
> 
> When these rulesets are enforced **on top of each other**, the non-FS
> layer starts enforcing REFER implicitly as well, and all REFER
> operations are denied.

Good catch!

> 
> This patchset
> =============
> 
> This patchset fixes the issue in three commits:

Four patches now.

> 
> 1) The fix, which should be backportable to older kernels
>    and which is CC'd to stable@.
> 2) Regression selftests.
> 3) A more elegant fix for newer kernels,
>    which is intentionally *not* CC'd to stable@,
>    because it would break on older kernels.
> 
>    In newer kernels, we already add the "REFER" access right to the
>    handled access rights when we merge the ruleset into the new
>    domain, so there is no additional calculation to do for it.
> 4) A documentation update to clarify the situations where the *_REFER
>    right is implicit.
> 
> Please let me know what you think!
> 
> –Günther
> 
> [1] https://github.com/landlock-lsm/go-landlock/issues/66
> [2] https://github.com/landlock-lsm/linux/issues/67
> 
> ---
> Changes in v2:
> - Rebase on master and resolve conflicts
> - Fixed documentation as pointed out by Dwi Siswanto in
>   https://lore.kernel.org/all/20261101125114.19009-1-me@dw1.io/
> - Link to v1: https://patch.msgid.link/20261030102411.12985-1-gnoack3000@gmail.com
> 
> ---
> Günther Noack (4):
>       landlock: Fix layer composition of LANDLOCK_ACCESS_FS_REFER
>       selftests/landlock: Test that layering does not break refer
>       landlock: Simplify landlock_get_fs_access_mask()
>       landlock: Clarify implicit handling of LANDLOCK_ACCESS_FS_REFER
> 
>  include/uapi/linux/landlock.h              | 17 +++++++------
>  security/landlock/access.h                 |  9 ++++---
>  security/landlock/domain.h                 |  9 ++++---
>  tools/testing/selftests/landlock/fs_test.c | 39 ++++++++++++++++++++++++++++++
>  4 files changed, 59 insertions(+), 15 deletions(-)
> ---
> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
> change-id: 20261108-b4-landlock-refer-nonfs-layer-fda8bcbe0b44
> 
> Best regards,
> --  
> Günther Noack <gnoack3000@gmail.com>
> 
> 
