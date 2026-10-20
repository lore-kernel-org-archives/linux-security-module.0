Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489025;
	b=eZjDAg13mzgawbfbVe+A3hGiEILyGN425YKMaZDHmfpQPDaM4Pd1OXXvSdLnK3tXUHTg
	 3u1tmsusZG6DZ4oWeasuSGGSfQGWmYn+xsV59682KJuTotpX8UKXxcOwtCGevnVH5N8Ec
	 5CMyDwv1qefpboizLfsax8XvvCJcNjqFigktjXrD7BEUvay49DR+FUrgnkKx4b29ey2Pi
	 Uj0nm3nHhJj+3iCiUvwJZJWovgLzSbc2L7t3ZM+E0vCMZbsK+u8bXJAYTCpJcVw6yhPGy
	 fj32ubzp8PC7X8vyWF60M2/sBmwWlpgYriQALOZaJTjaMt9Ozwk5cpfwWNbycyfsyIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489025;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=pKWxhEQSNvo/BWqNTUN+8vLhgAbAXI23tyxrRKdGIUw=;
	b=STnUHQLcvwHQLxNwSlYaRQ5JoRk/u2cS5Kb1EAPFozJa64fEzmdhL4H0kSvR3cXaD7CD
	 KkTlIfC5Oc68dQNoXom3CnVfZ9/j3Rmk2vnWSHeIbCMm542WuNQUF/2vvbi+8bI4Qy+tN
	 CEDlfadQNY/zH+lIKDI2oPd4y7khxxVq03INJmeq35P8rlT1E5PzbhUdqrfpUnSGYyEUE
	 jS762Qgf4qzYNOQGfoErP1FWzi3tjJ+iwqV0b0sXYKeQo8YG5qYMkoiQbtpGX/pnbnwjH
	 KLku+qXee8u5w+YZ7ttfLY53DJPyT7vNzWRyYSG0w5TR7Avs4lqnqlI//a3W/s4n/tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b="Trx2GwB/";
	arc=none smtp.remote-ip=185.125.25.9
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD8F606A334
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 09:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DD8F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=Trx2GwB/
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j86kk1Ylxz29ZS;
	Tue, 20 Oct 2026 11:37:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1792489021;
	bh=pKWxhEQSNvo/BWqNTUN+8vLhgAbAXI23tyxrRKdGIUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Trx2GwB/tjncatznurxpfHn7+RlCBrnTpeGnp7JWMqXSkUa97AHE6DRefRfbGSpHT
	 hLPcgXxJKoh7wmgmP47MHupee04AUbIx9lKPg9cjut5YyT5uf4mAERRyV9P3ZjGgHu
	 fo634gQKlAv0oEpuwhulmv3sr+HjgyzeMnNG1TJ0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4j86kh5Zppz2Zs;
	Tue, 20 Oct 2026 11:37:00 +0200 (CEST)
Date: Tue, 20 Oct 2026 11:36:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Daniel Durning <danieldurning.work@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Shervin Oloumi <enlightened@google.com>, 
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 6/8] selftests/landlock: Add capability restriction
 tests
Message-ID: <20261020.eiT3bah4uy4a@digikod.net>
References: <20261014082718.1435842-1-mic@digikod.net>
 <20261014082718.1435842-7-mic@digikod.net>
 <20261017.63923e5027e9@gnoack.org>
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
In-Reply-To: <20261017.63923e5027e9@gnoack.org>
X-Infomaniak-Routing: alpha

On Sat, Oct 17, 2026 at 12:20:12PM +0200, Günther Noack wrote:
> On Wed, Oct 14, 2026 at 10:27:12AM +0200, Mickaël Salaün wrote:
> > Add tests to exercise LANDLOCK_PERMISSION_CAPABILITY_USE enforcement.  A
> > sandboxed process is denied a handled capability when no rule grants it,
> > and an explicit rule restores it.  Unknown capability values above
> > CAP_LAST_CAP are accepted at rule-add time yet have no runtime effect,
> > because deny-by-default still applies once the domain is enforced.
> > Stacking tests cover the per-layer allow/deny combinations, including a
> > layer that does not handle the permission, and invalid rule attributes
> > return the expected errors.
> > 
> > Three tests exercise non-standard capability contexts: enforcing a
> > domain via CAP_SYS_ADMIN authorization without no_new_privs, restricting
> > capabilities gained through the kernel's user namespace ownership bypass
> > (cap_capable_helper), and checking CAP_SYS_ADMIN against a descendant
> > user namespace, with an unsandboxed positive control, to confirm the
> > decision is independent of the target.
> > 
> > Audit tests verify denied and allowed capabilities, per-member quiet
> > interactions, and CAP_OPT_NOAUDIT suppression.  Trace tests cover
> > accepted, rejected, and no-op rule adds, and normal, quiet, and
> > CAP_OPT_NOAUDIT denials.
> > 
> > Test coverage for security/landlock is 91.8% of 2864 lines according to
> > LLVM 22.
> > 
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Serge E. Hallyn <serge@hallyn.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---

> Same comments as in the preceding commit as well;
> specifically,
> * some helper functions could call ASSERT directly
> * EXPECT instead of ASSERT in various places

Agreed
