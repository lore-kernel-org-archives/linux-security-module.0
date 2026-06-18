Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21280258EF9
	for <linux-security-module@vger.kernel.org>; Thu, 18 Jun 2026 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813508; cv=none; b=Lxer73A4+k3+ltEcSFEeylZanRHOCgMVudO/Bp1pXLqASuAKNEnH+rY64ThemQhlrlHuEvhyYuEb1ZvoAvCEHdueoobjusDJVsQYpFf9RWRKw9lpaP9rtiNSZD9rL4N/P7MkyH5TygHlCWLSxOfJUYxPL2qTqvtmZaNJFh4U8c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813508; c=relaxed/simple;
	bh=gffuCjE21LCdR0doLi5NWmiCEJ4LhBJ4/G9SPEC3chg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOYZTs6SzP/8ANc/J9DjOX//LFQaAJcwrIEEtvV8C/ttO6vRJ5sK9u5Smk8FtDxkvbh4FzMhjDz+RUR7dlw8k6R/lI+IDEX77lvPnGa6Fp+GhU4l70CnZ6Z0A9H0MJpPx00R4lhu+pW3GSGlNhGkhMUf1v1ZMARdeOElYJorXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jSvu/teu; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jSvu/teu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781813493; x=1782072693;
	bh=gffuCjE21LCdR0doLi5NWmiCEJ4LhBJ4/G9SPEC3chg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jSvu/teuI9Al6/fvk72J3Bgb96Ci6P8g6BLA8Qdf70pjeKZJ+Zi6A49yoJuvlXH+/
	 hz11VL9T02sPx5ARm+58EOk43QfIr/EGBykQEEcBkxTwrCehBH3/lwfHkqYfqImQgm
	 RU0Ntf2OwCuo8TXh6Zo3pVuUEXsy4fk9ZZxrSMUcS7b4N+uCsFJ7z9/9edgL//1fjk
	 c4Di4XfiG8du8eFn9HpnrwCd6jl4/36ZzcS/7JDHY5i9UOqNw0MgrnhNb6lWSukOh9
	 wkEwFbw69nGRBip/ZPXJegz8fr4Bmnqsqv7C2GALTQAWdaq32JOvBviKCwChGDWTOD
	 dGhO3B6GVpcZw==
Date: Thu, 18 Jun 2026 20:11:27 +0000
To: =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, linux-security-module@vger.kernel.org
Subject: Re: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV bypass via io_uring IORING_OP_URING_CMD
Message-ID: <20260618201122.219963-1-hexlabsecurity@proton.me>
In-Reply-To: <ajPhlNSgUcmBoFcM@google.com>
References: <20260616201633.275067-1-hexlabsecurity@proton.me> <ajJtTHyqWTmX7lHo@google.com> <20260617230237.14718-1-hexlabsecurity@proton.me> <ajPhlNSgUcmBoFcM@google.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 1eac1dfa45b2f1c0d1c3687effdcc30e3706f49a
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

G=C3=BCnther,

Thanks, and #65 looks right.

On the approach: it's a Landlock-only change either way, both hooks already
exist, so no io_uring core churn.

Coarse (block ring creation) can hang off security_uring_allowed(), the exi=
sting
io_uring_setup() gate. That matches the creation-control direction Micka=
=C3=ABl raised
-- the socket-creation work he said would suit io_uring too -- and it's a f=
ine
default, since most sandboxes don't need io_uring. One caveat: it overlaps
kernel.io_uring_disabled and a seccomp filter on io_uring_setup, so the
Landlock-specific win is mainly composing it in a ruleset.

Fine-grained (gate device uring_cmd) is the only one that closes the asymme=
try I
reported. It uses security_uring_cmd() -- the hook SELinux and Smack alread=
y have
and we don't -- and needs no new right: gate device files on the existing
IOCTL_DEV, mirroring hook_file_ioctl_common(). All-or-nothing per device, s=
ince
cmd_op is a private number space.

So I'd go coarse-first as you suggest, and keep the uring_cmd gate as the g=
ranular
step; it's little code and reuses an existing right. Happy to prototype eit=
her
once you and Micka=C3=ABl settle on the shape; I'll hold until then.

Bryam

