Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794598008;
	b=Ow/1LAFalzuUMppzuXgTn+Lo8E9x5LKGmuSnXn/uZcg9Fbu9lKPcihAE0fBEUOFBP5Pm
	 gfM2IpS19kg8QFkLS2t1RaBHdM+k8gz5UIAZoZOpizcKv09M/VH2QoYfpZJxu9il/WeP8
	 PuXownuErsVsyYqXtCGx3t73XYVBrD44lLPR5wGvF/QykdAKlY7vR4aZ5mOwjQ8EHXM+1
	 R54L5/7J2ZPrE6fvilVIrnOufZwJUqa4nczWvM6cm+DH6qpOmeqdm863ypc8jib2+q4W2
	 PHNDrM7q4WWKWx5DISOVg4kANI2kXOQln2NOtzEdx1W2KLL6X36Ncnskb64NnOBOkUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
	b=1DfI0l+mGf3enyXFtVfFkkz2+SxPTMjjQwxdgG9gtVcjnkH69D1Xma0srFeUWO5cw0BK
	 AuPgPWgE0wgYb+yrAjGrxo5A9De0QL9mpLAjxoMvtxfbxQBvRcvkwpK/7/G6wXG8qUh3I
	 vC+jq+EuNzNEtLU6o4k+6H1BR5pysN1EZxEOrcfq1lTh0GLWcnf865TUjrTZrUViQhjNJ
	 ZwQ9WUsHizUne9ye39njGVCvMuUF0G47OBn+UVp0MjGe9LRYForcvG6WZiuv/qgI2GB8i
	 bBMcswHxKuEpYATSwmBMINqNjVFP7VjihMT1dUoJPcbr8Nfu8etlnYzBHgwt8TraEkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Nmr0pfLl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007CC606A886
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 19:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 007CC606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Nmr0pfLl
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e946155442so19880255ad.3
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 11:26:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794598007; cv=none;
        d=google.com; s=arc-20260327;
        b=K6sjhvA55MNcLaCi7NWe3cw8TkIyWtAja7SoLsyeW7a53y37jy7astqchb8WH2UZLy
         6cQL4SyBbi5jzyfnWf877KqDGvK54to8r+Rh0DEwQVqK6mW1FwJTuQIxVT2jrgOQ1uRo
         7olwhagOIacM8AMBVlAIGZBxbqlxdjBSqQ2r3dbKt8cgXkxDfxWTSY7chJ18qUBspXA8
         zTfpqMz9E/A8ScKJXYAGCx9zF0FpqlRYRKgINf8m1VGP8qodgpYhyOyIUIAiI/Pganyl
         rls/3Awx3T1KsBAZkYe+qPVlTCk00O1/mW+vfcfNeYTSHkZ9svA8ewbs57UKuMRrl0te
         lhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
        fh=3/UyhTcdupRsA077vuzRab+4HoWKmFGgNvEXFILEwdQ=;
        b=r6EnzWC5AfoaIR/b+e5CX1pAeHj5KBlNpNvwxl24hfZB7HYfwglbUhYHeZrM7BClgJ
         OZI5rIlsx2chTp2WB+QxdTWrP3IqzCsqHgEo3Gm6RPqv+OsihVkCPm59aBF380SkBj6k
         cmgGwOh0YHnv13sTx5+HI1+dQ1S4izSMnYJzIY9ICGaE3KHnn7AnK3ThCd6bYv+iCORT
         vgpCcYe0c4799K9AnJZ6mcxazmBy8xQ5ejDhA0j/oZl1k2ap0pWPlPu/1oBrksk6DZ6U
         YCKvMbmVnBh7Uy8VDqtcS1iF94GthU2nsPZ4O5WIH/lw5CLdYT5i0uKlAYphmaENcrFH
         R51Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794598007; x=1795202807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
        b=Nmr0pfLlJ40O0dJ67qksgs+d9IhuS+a1YdupKLfLZLOx9Yd6Jzc4yMjF/dCnXK+4qD
         8b7YpJ/zyBjcvWbsM9y+zdcrEzsuPp8c7DNG5WugBpp6+ixKpf/dH2bGwXDG4b8Hy8yM
         WVbEMWRe71aE5MNO1zKxHaChPkaeRNbHI5NwKiNEvcV0SOTCWq3rICi3NrPwvqGsvmEM
         FW+ONk2U91vkXqRqq+JW2mFQwdtFQzUpX0T31sOtI8B+OfmxvtmMhwfop9dxCjR1/SIA
         AtjR3FFDJpbo483/x4burtlVpH/5Z8YVjlsMxSrEs8MYdt7iCdUHCFNNZKX5rvrT7Cb+
         CcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598007; x=1795202807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
        b=IYZ3R6DeTS4sPSid7of1PeGW7Q2Xlh33HEvTBQMqoz6fAOqR4g/lArClQ4DSq5S8bW
         liTAcq2VJg5fg1GuJyvOR07pf6zeLITqo1lnpbV8zWnABRcQPM1XlrklrL77ozSku4qJ
         fWyrWZ0hO23+HNF/1c2N7uYczw2z4ID6u3E/xkOyEIsJRyNoofL3Gu4BgEjh7dsbU1l3
         VS1NsMFc922u1MfpuiRGkaQPBynBZ4Q6Asv5FlzBfkIcOF5+gp8mEVnsC1XLbrkVU8sD
         Xj5rwJ0g6++TjnpNttbRtLx+RZJ7k7//VagokM35HAmg7J1n6yxkFmJZlc1u0/XhZ5sF
         S6IQ==
X-Forwarded-Encrypted: i=1; AL+hErGlrvqrgf9OLWPJzQK4Ky8uWM+zvu3l2yFcTs7rWaEufs+zeUBf7KO2sp3Upkg30Qt2Njp0OO+FPC+/f+C2FUGNCo/ft5U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1o781sQq8+pIS3shsd67wIyM7aiUTXWkVgqqgWUo7SerhJoT7
	L6dEHUZy+sztIfaY2RgW36c2tEER8yS01WSjImA67t4U6/dg1vn67Az5osFMtsIakl01kmw40pi
	gbHTCxz/DPnI675qLorjUY0sVdRbyLZtBRgqpI8mZ
X-Gm-Gg: AYBFou2dri4KJtywmRNxgVkJL1tIDgsTf7XG2TxFd2CDCvqBNUybGPA7e8Ejxe9wvle
	amSTB4r0KNQDelssg66S//efImNwNLE2Faavu7uerw2JZBXn/7eLm0cCD0xWuhwWp63R88NE8Mw
	yYE1zS760D4jN9oJzhDsetB4ndV6JqsOV3Fhjs0L1oP28qyGubjqlqFbPU7c6YONDSvlZKMUtu2
	g3FxBoHjMCpL4uMLiZyToQ4xdvaMVWlKuIPHujg9rlKFemWiMydg+OrPttQax3nfNGa2wYObpkf
	WIbhHKZwrPyROvO0MrpNzjuVC8qxeUfvDbGWQNMS4e7CcS0UqXH9H+xsu3RWpscUJAExvhrMYVy
	fyS3brtwJNkRujcjM7y0AQclDf7Wx+f4dHDclol2UYbCZBq/7jFjjcsfeB1IiXKygI9J37hvgsL
	LgBN4MxoXtXmeCCA==
X-Received: by 2002:a17:903:22c1:b0:2ea:192a:13b8 with SMTP id
 d9443c01a7336-2ee0daa3657mr34970525ad.20.1794598002581; Fri, 13 Nov 2026
 11:26:42 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com> <ad935fe9-31c6-4b64-a715-4af428b389b5@schaufler-ca.com>
In-Reply-To: <ad935fe9-31c6-4b64-a715-4af428b389b5@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Nov 2026 14:26:30 -0500
X-Gm-Features: AclHuK8_VELfOWb6QxDH9msFQuAihFI-MTzoli1CQDJEubxRePim00n173V_ijE
Message-ID: <CAHC9VhSzdLiJyRfv2+rScvX=6ObQavHvs_UbNKFDabJNzwC0Ew@mail.gmail.com>
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jann Horn <jannh@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 12:17=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 11/6/2026 1:40 PM, Jann Horn wrote:
> > cipso_v4_delopt() operates on the ip_options_rcu of a socket or a reque=
st
> > socket, and tries to remove CIPSO options from the middle by moving all
> > subsequent options.
> > That's not allowed - ip_options_rcu can be read locklessly and must alw=
ays
> > be consistent. For example, ip_options_undo() reads trusted offsets and
> > length values from the options buffer.
> > Fix it by doing the modification in a copy.
> >
> > The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> > propagate memory allocation failures.
> >
> > Triggering this bug requires that the system is configured to use CIPSO=
.
> > (Setting up CIPSO requires privileges in init_user_ns.)
> >
> > Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Sorry for the delay. I have tested the Smack part, and see no issues.
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks Casey.

--=20
paul-moore.com
