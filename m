Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421698;
	b=WXeNld8m8MioIVtSzDdy5YrqB0OTc+N5GtAGd2iwjOYbGFBslk3mB/fJVk914YS5O8T1
	 o7Qg8//pr+E4y+hTaDUcLPXjkqwiembxxMlp0Tj1Yn2vcz5FuQBaC21lvVNF0lvujNVEL
	 lnsKImOtlNUgnzX5FYKnr/MQXTW9HKvGLz6FfqcNXIUkRoc+lWq3c2EPY1KklxlDRfXeh
	 D4VRuAko80OG8skeeCYW9+3gLql52gZvOhTwc1JvR/lc5X472KgoC2FNWGYHlKXGPycm8
	 rJpkV6XAE63R0b6Iv/8O71BHRlA7I02Y+z8gHpM298Y59uPYHCcrxyT4myAeSk1S/aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421698;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=GO5yKriuKseN6O1pLOiVfT7JCT95pfrtrxH+15p0okc=;
	b=gTaxkd8Tf2Wa5J+SoGqCrNmJ+Mo2SrPDOtRirvtn2LBifDOtOEfBuGP+vlew9AdF+soP
	 xwnkf8eDUgUflaLKX+gv2dSlPriD5CMyJqPmGq7GXI6tMA6R5+JPPBGdwi5rF5OmArgZK
	 SzdIt7wAyOSb9IPJaB5hsCfZNyLRkdNsFTJoSYh5EQU9P1jFqQYnIiE0B5iSStndoIAka
	 hztMuDDm8VWMHcoHdR/q9QEOqBnalYeg2Uy7NMQ9eQTA4SaqqWaPGcryNnMsCwcwETWwT
	 IACfzYvGH5K6jFNDC1Hi5oK4FX/djg7ZD2LC4IBnimdo5gcUn+AEhinIKoVVbQC3lmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4TPyqnP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD7606A321;
	Wed, 11 Nov 2026 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4TPyqnP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EC51F00A05;
	Wed, 11 Nov 2026 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794421698;
	bh=GO5yKriuKseN6O1pLOiVfT7JCT95pfrtrxH+15p0okc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M4TPyqnPU7NasQ/rK8N8AaC9osAkcFRF0Emr/g1SmS0UXO5Vvy9k8l/PbCkTFQEDp
	 ebD8+i93pd4puFJbe3hYVoJEf5e3B+awxvmJzmO4cxSRcjz2qFCEoRTmtgaSlOq8tt
	 7OVniil0PU7O0aS6xKrRnHWrdZWa3JrvoPMz3UJUcSzbVZ2D3BoaV8mJNFcwU4O42/
	 x5sUCVKCQCLpQFNTF0sv//TJ+usywHrH6LOwpWCOqZQA5vgjmGAcgagJtKIfiUSTa0
	 WoBWtClxcQh/1cnJ2Hkzf1opztXDXeVPt3MfoTeoyO+iMeLE+/hEF6RDV7dNaQXElf
	 F0lFRV1nl8IZA==
Date: Wed, 11 Nov 2026 12:28:12 -0600
From: "Serge Hallyn (AMD)" <sergeh@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Ada Smith <adasmithgt@gmail.com>,
	Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>,
	kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/6] Fix Landlock mediation of commoncap's capability
 checks
Message-ID: <avSzvNROhDFEzdCl@shallyn-amd>
References: <20261110202436.2408244-1-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110202436.2408244-1-mic@digikod.net>

On Tue, Nov 10, 2026 at 09:24:28PM +0100, Mickaël Salaün wrote:
> Hi,
> 
> This is series 1 of 3:
> 
> * 1. fix Landlock mediation of commoncap's capability checks;
>   2. fix PR_SET_SECUREBITS mediation and add focused Landlock tests;
>   3. fix Landlock mediation of capabilities guarding LSM policies.
> 
> LANDLOCK_PERMISSION_CAPABILITY_USE, merged for v7.4, denies capabilities
> through the LSM capable hook, but commoncap's mmap_addr, capset and
> vm_enough_memory hooks call cap_capable() directly.  A domain that
> denies a capability can therefore still:
> 
> - map memory below vm.mmap_min_addr (CAP_SYS_RAWIO), which defeats a
>   mitigation for kernel NULL pointer dereferences;
> - add inheritable capabilities outside of its permitted set
>   (CAP_SETPCAP), which lets a privileged sandbox without no_new_privs
>   gain capabilities through execve(), although the domain still
>   restricts their use;
> - use the admin memory reserve with vm.overcommit_memory=2
>   (CAP_SYS_ADMIN).
> 
> As SELinux does, patches 2 to 4 add Landlock's own check to these hooks,
> with commoncap's conditions, so they only deny what commoncap granted
> because of the capability.  Patch 1 factors out the shared check.  Patch
> 5 adds tests, including audit tests, that fail without the fixes.  Patch
> 6 fixes the documentation, which overstated what the permission
> restricts and how its denials show.
> 
> Two other direct capability-set checks are fixed separately:
> 
> - PSI triggers (CAP_SYS_RESOURCE):
>   https://patch.msgid.link/20261106120004.90041-1-dennylin0707@gmail.com
> - user namespace uid 0 mapping (CAP_SETFCAP):
>   https://patch.msgid.link/20261110144205.2404088-1-mic@digikod.net
> 
> Regards,

Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> 
> Mickaël Salaün (6):
>   landlock: Factor out capability denial checks
>   landlock: Mediate CAP_SYS_RAWIO for mappings below mmap_min_addr
>   landlock: Mediate CAP_SETPCAP for inheritable capabilities
>   landlock: Mediate CAP_SYS_ADMIN for the admin memory reserve
>   selftests/landlock: Test capability checks outside the capable hook
>   landlock: Fix capability restriction documentation
> 
>  Documentation/security/landlock.rst         |   8 +-
>  Documentation/userspace-api/landlock.rst    |   8 +-
>  include/uapi/linux/landlock.h               |   6 +-
>  security/landlock/cap.c                     | 110 +++-
>  tools/testing/selftests/landlock/cap_test.c | 535 ++++++++++++++++++++
>  tools/testing/selftests/landlock/common.h   |   4 +-
>  6 files changed, 650 insertions(+), 21 deletions(-)
> 
> 
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> -- 
> 2.56.0
> 
