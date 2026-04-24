Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B5243956
	for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 01:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994065; cv=pass; b=iQKBbxUxsgtIHnYCSJkcqYmi3hGfTemEa49bHL4alhfb3LVJuFDOol7oXuF5LYM9REWUc8CKOTkpIeUEaqa5jSQ14C7fIDBEFxLJxxX2dR0cNdX0H6A5FGPbZahx5zGqtvjgM2A83dwU11HXfUQdxTW+GBC5nFb8tSyoTuhqmj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994065; c=relaxed/simple;
	bh=omKa/2WdgusmHEfGk+KJhSzPUsH5UhfYeEoCCOvHE4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VV8cCTTFc9/qyjv5FzSq/sWKuXqpht3V2FIbJ2vcpgTMbm15r7ta4XN5SlyI8NzdXHxFNwUTWGpZqtJAAPLn/AKgxI031FAx0+SdHl5FcHzKlzc4CRqKdIKX76HDwEoev6g7MXZgvAWBbLVX/LP9BLuYeY9LVVmTiBc/Vi/wqZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JrEsM9iF; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JrEsM9iF"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso8163457a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 23 Apr 2026 18:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776994062; cv=none;
        d=google.com; s=arc-20240605;
        b=DJ2fvnUP5kRK/Ud57JghSPQBpYdcyJ52+TlOSXvj9I7oMFGraHeNKlVhEANqtLtud+
         Ahf6DV1CyE/56M4ni62LGGvo1UUn/9ctlyDUBcTJW0azXMeAO8PNVIevDGm7FXWuq2uS
         o4J+cBGQR37aE5j5mgmQE+TUO1F7tu8rTeEFqFDDDmNYbrGVmYWhn8GC+PH1j6FqzsFM
         SbaZ5KiVUccty6IPkAO0IrAC//aImPlnH3oKaMYEkAi/Ky48WPmP8tbhLimAFf6t443H
         PQE2/WVH9b0hViXQhX5uhPatLKGzyHC+/Dx5nuGLWwwayoc6uwVhSM53eyHTrpPE+DKO
         bhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RYR42p7JO/QHsKTGPNBeEQu2D0vGgM3DHEt/tjHMAQQ=;
        fh=Tuj3vBFyxnSDHn/b0geZG8dpavYIb7HcEar3h6jqNzs=;
        b=Ddxql9Kuk/OGVJUvtZWAlkElTdbW+hKl7K+n5D45+xx9aLHd34rfDYVWplKgUPK1Gd
         T4NUcixBISGFDwbnzf4glJRzkZxeaiEW02NzMVo86llY+mljMTCtT1hoXgdPd1R5LTyi
         jFAFERymcCl0UFHir0ewpd7fQF6Pe47FArrhJgrR47c/dthPiX46CHRKzuSs46DfEptZ
         yW/d4HeHV/GfEj0y3ZGBNl0mgMAY6acYRHanByTbqBDQQI3wD0HjPOY9Z8z9Fk6m/NNr
         Co1b9ShCB2JUx4ozr5FR7E/L3spAZfpq5acL5nMEN6gXpzYAIPcvoQ5ikieQQhTjnV+1
         1yNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776994062; x=1777598862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYR42p7JO/QHsKTGPNBeEQu2D0vGgM3DHEt/tjHMAQQ=;
        b=JrEsM9iFt/sejyQa35LiP8Dq5cNpHlGt5/aaRcTkGq7mpXlONG2rPE+YhdCcJhbAKP
         qd1GGGEkQ+ldyZ+7Dn61Cjk1qm46BvCq9DO0RVHVHaBFL3U/l2K/DjQIE7oRUAfjvize
         PcwgAt95PeIuLA7BHo2KrnDz2YUDRIj6FjhdgPWYfZx0umumFlyCYLTRTOe/WdzYVQ6c
         TUDsksgmlKz5t7FP6PK8ei7HzUPpJgjtoT6CdRqiTTb5mYi4MR0Ec7bmhKTLPCqTqp/p
         pArLgcH3iSfosqaC91dH4HmDLTcwYBZeftXwcLRGaZbkt+1itAU6gkrmxENRMsCr7Pq7
         bwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776994062; x=1777598862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYR42p7JO/QHsKTGPNBeEQu2D0vGgM3DHEt/tjHMAQQ=;
        b=WiEvheffP6112X5jQn5EXZzz6DC6ao7uRE/9YHO4EuE0iLtYupG3aQ/71RQtwS0Pxl
         H3tcWfXCrh7XZ/gPyvj7Y1eX7drfl0Da5Ny9txCBRUGPDmZ9eF8KNlFp8wQjsokA5H9R
         OxTOVIGOWrf2ESP8CwR8Fd+fkm+os5vm9TOTVIBZya6ZUV4Btr8QZ7e3Js0I5m6TEot0
         xZcqiTQgYlcLO/KU3bWFjeKJS64xz56UhH6UqRfQL4Wwz3vI6EV/YDMvmzM4iUxv/XCA
         50y+dPyKHI3B9rrRp8qzskMFSkWKJW6Hx6IzmbmP0oZVGEArJO5973MUVRHhjNn6PfOU
         TMEw==
X-Forwarded-Encrypted: i=1; AFNElJ/z1mXQ4gkg1yIkEAz7hDcTg+V3KqK6Lx6c+dyW6dYlT3ucvz8FtfTaYbEP/Xh2h5pPsxrOXV6drnfIT/PlwPVhDGRrX50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaMC/WCmTWYBl46cLZEsgivujv0dJRfcG1SUijvI9em/XhgkBp
	EtlimiiZRAbPXfi6AQ9+AvTjwHsik75qywcoLgrMMhoa77sydnRV8cUNygJ/kWNBYuD2CwHpgD7
	186p1PA5Xz7G64WZE+WOnebhoSsp7grxwJoTmIWqD
X-Gm-Gg: AeBDietVDezeAzWM3mQuWKZuOXW19MKcgPM5VhZ/y+rfdd8mZPcxR7XBiRITnDfsgwE
	PpEPtvPaWKkUdpEcEDn6RYi3YPrGB7sewDrh7ruEaIT7YU5NgT5t0kHECmUid53S2+OMkXC0hhL
	1jZsDdenrRLXJNLyNNjZkzP9oMZ1HqcLo2ACyC+RpMo+JYuGhW9Efpp+i9R90WjyVLIJHBE+x5l
	eo1ltnh79EM1VzBFmiWy/AIvgwW/CtrUTURaSH9u79D/6o394r6KQ9T+zgza9iep0BKJlOZC+eK
	+WOqKFTDRLCJgGJDrvAaoy1ND9cs
X-Received: by 2002:a05:6402:28c5:b0:678:7da5:2346 with SMTP id
 4fb4d7f45d1cf-6787da52508mr2108038a12.25.1776994062317; Thu, 23 Apr 2026
 18:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aem0SSQuE1e3pGOS@e129823.arm.com> <56a8aab50a3b5ce0a345fc2079fb2abc7d0f1b23.camel@linux.ibm.com>
 <aeoAlVEwzRUPrlVe@e129823.arm.com> <aeoRxWPyOHGJd+Jh@e129823.arm.com>
 <aeoWO2Cwo04YYu2l@earth.li> <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
 <aeokwrC86WI7uT+K@e129823.arm.com> <aeomlp3I0eVE5mce@earth.li>
 <aeotq8nPVu4wvEx5@e129823.arm.com> <e4e242ae5533d5762a3647186a178764881bf9ff.camel@linux.ibm.com>
 <aephL3MzYoqFGaT5@e129823.arm.com>
In-Reply-To: <aephL3MzYoqFGaT5@e129823.arm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Apr 2026 21:27:27 -0400
X-Gm-Features: AQROBzCKchqlqq4fwimM8FvKvU-_em0HAaY4O5iQxKuvqQBuL1WqJdLvyk10CT8
Message-ID: <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell <noodles@earth.li>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, jmorris@namei.org, serge@hallyn.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jarkko@kernel.org, 
	jgg@ziepe.ca, sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com, 
	sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 2:13=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
>
> Sounds good. Once the patch is posted, I=E2=80=99ll review it as well.
> Sorry again for the noise, and thanks for your patience ;)

My apologies for not getting a chance to look at this patchset sooner.

This seems like an obvious, perhaps even stupid, question, but I have
to ask: if IMA can be properly initialized via late_initcall_sync(),
why not simply do the initialization in late_initcall_sync() and drop
the late_initcall() initialization?

Does any IMA functionality suffer if initialization waits until
late_initcall_sync()?  If so, it seems non-critical if waiting until
_sync() is acceptable, as it appears in these patches/comments.

--
paul-moore.com
