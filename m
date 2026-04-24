Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949822DB7B7
	for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061744; cv=pass; b=Pl9eJRE/P3oUG0Qpmr7ymuR/BlreWVgpf7Wi/yxkuneq5mAllcO5j7wkzckO/M2SGHEpOxhpSLFKd31g9Vlg1UaMkh0bQAbvynmOJYE0FKZVAphgg0mKgC0Zq+Pr9ffA+b2PZQL/1deE62LJQOGpD/AFg/jMNYS6VT0DtG5ZQfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061744; c=relaxed/simple;
	bh=Vbb/QbHuW7LGihD/Z5UNc4YCg0mP3LbwRcOYR2R1TWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKAYTmUmpDK+0UIc2xhdFeb4b6FMUZSln1oPMW/gLHHuJ3kQ6I9pHoksUePlERY6VIv0lr89sW4xgmF1hAUdq59S3eBIJm8i+D+BaJ4PTZA2snQKfZB1zALQiR3gBD6IUFyTpzvMbgfSXujLo9tMIbv+iU+25OE94+HVWEgS4yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Lrk3+Dyh; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Lrk3+Dyh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2adff872068so41589665ad.1
        for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 13:15:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777061742; cv=none;
        d=google.com; s=arc-20240605;
        b=jTB0PzYB0DMBBX8hueWZuhtPcwQrShscVOeedNa1yrETE5yEOGi1iG8Unf98hq3ic4
         UdhwAbEqdL3wutd4RTz0tFJ6gJyxR/d7MEtJ2CL90MNJ/A13wJu1Ue/fmdt4p29Uv91c
         creL+wVVVunGfCDOWBQXo8mYwIVHcCVw6PIwQYNWUWPLXXryqilJW3xYBs4OL45iHk6e
         SOKGMk2zYFIWrosRczcP0lka3RjVPA4jOSqwrKYJqJ7EeWux2CL98jDTROGc7NyUj4uz
         3gVa9a39pFpqdjVOtj4GuFav8hG2woEUqPHgV5PQfaUVWixAgMlds4m4OqVngl7hOKoi
         NuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sp92EwCFMmdCctd+G8p5NZ1F+m0+I8XgaVk8fcD+2Os=;
        fh=c6RdoQrlvbZ5MY3/8es/cfcNpZDxJ01Li3qCcbDijkk=;
        b=Trjzhxx37mqWE1VEMDldTLSvY8B61H7yUPo7l4lM6MDt9YXGTF24JVARYnxgTodZbc
         9fO7pmH8EXGtvAxwewwjpOCMHGVcvS08x5sEVli/GhJRX02fsCXxzjzTfGWGtuaqd+vV
         y85drMuOHMEXBjwx0/Pfixr8+cavN/6XRShnS3rEhcW+epwvcwOt59qpGmMA9bO7ZlEm
         n1q3L4xmvAQTtbecK/HKCxnFQRyxR/ikMMAyUuD7gKAVKnrmVuJj6MhFdwZiSZ6mOB4h
         iwDJ/vwgystaD0+pymLsTypQ9pWuDHv7FNg99087BD8XYC8fQGT2MRNnFG/ICC/Ppgk4
         99sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777061742; x=1777666542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp92EwCFMmdCctd+G8p5NZ1F+m0+I8XgaVk8fcD+2Os=;
        b=Lrk3+Dyh2N6zYAjXOqDaMBkh1DH1fZBTh1nBQ72Y3OP2cJmx95Q9G1T2ozsvaMbDIR
         czgEEnJYPmVyEEHEkDYAv+JOZ0qCim8IVfdOIb2e30B+9VO9j5Z/O09Ll1Fx2vDvicwO
         B74VIXYM+6kyBdIjnE10sv3TopUlU+LpG+Be/Y79LrgrWUfTlwCf2muQ/cWTL/ozGE/h
         9pHR/bhqwyKtlJD7fsEFClyMu52t3GbJQ41/9v88BtQ83JPPO5CbizduYWzrnYHxZlXO
         G0JrvAGhSxZVBCFcZWdUdKzvAKY0qYo8FS3sLaY94xlKHHnTwjd9nRf160WW/Pwp3sgC
         Bhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777061742; x=1777666542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sp92EwCFMmdCctd+G8p5NZ1F+m0+I8XgaVk8fcD+2Os=;
        b=rip27zPpbtL+J2/DEm5HuF+IyfjgJK4dHsNMUPL2NGp8jLj8BZenkGJ/p2HxvfmAhg
         ZerlpB+bKoGON1dk+507GATdis2ZayKvcIZV2Kri2Fjab9I7DZ0j3e1uzQMZZjAhepdQ
         jxBXijbb/hJduhdmnf6nEJrMrmkRCdz0U3Is3smBjrCNmNTGNHfETlK8q+Yqqc1O4KQ9
         oCTkFCzip4tbC6GGISUo04IuU4/ewVBwh3TYMqYVGF/M86kCoE/HEsNM+NlS+zn4mtxd
         MUhuy7o4KDZqVvF1DgN4cghDPM0OB2xkA8AFHgBGzjekC0ypP7O7qB+ygUAnv71EeznG
         7k/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8oxQKJTvk4vSC+VZZX2mnYOZprZK6kSf6TP6BCdxpgQcYqULS63sn5D8k5+QqMNR30R9vgbNIVKXEG24Lo99b/b2RUGfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS0KSr1w1eWONRoBmqvI/ZSgZgguFh4DBjqvKLsLYfHhTfhajK
	paekh6vO6/xm3gxPu71RCjyozE5cTkhr8wWqBq4FJyiXSyXoYs/rd3m1zlzZ3dENVxpEBKSBwb0
	9T5pfkitVbYNjsj2cqbQdfiGAk/0MH1C41fiu0TJj
X-Gm-Gg: AeBDiesQbnT4YAC/dBmPSNdsSqHzN6VDV9iOzn/9/oL6o0/RK3eeoQG98EOHfB8KXS2
	YlPQa6yj/Wsta0uwDBMDduezEAXiovBOyPZLJsLbO+lS9ctGIanoQtknKLS5/hNx8r6ggImlcj+
	fHdBGsO3ZkEMQXKU8dookRGE+Gn6LZ0UiG8C3VcELXR+EaGZ4dXTYYRFFPAwSUouuM+WulC6QnT
	pRK5LwpCCgfL1Mc46QNHVxsGuarJGhH7Q8/d9JxY2ok+9raM7o03EeJ4zkaG0hmP7jBupW+e9Ev
	MH5xG0MPm/V8620+OA==
X-Received: by 2002:a17:903:883:b0:2b2:9f45:2266 with SMTP id
 d9443c01a7336-2b5f9f8302dmr254143155ad.21.1777061741644; Fri, 24 Apr 2026
 13:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeoAlVEwzRUPrlVe@e129823.arm.com> <aeoRxWPyOHGJd+Jh@e129823.arm.com>
 <aeoWO2Cwo04YYu2l@earth.li> <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
 <aeokwrC86WI7uT+K@e129823.arm.com> <aeomlp3I0eVE5mce@earth.li>
 <aeotq8nPVu4wvEx5@e129823.arm.com> <e4e242ae5533d5762a3647186a178764881bf9ff.camel@linux.ibm.com>
 <aephL3MzYoqFGaT5@e129823.arm.com> <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
 <aesGU8a3mbVzvteH@e129823.arm.com>
In-Reply-To: <aesGU8a3mbVzvteH@e129823.arm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 24 Apr 2026 16:15:29 -0400
X-Gm-Features: AQROBzD85SjPMTZ-_HyOS5lMf1XvZbjXC0wu_RfpvlwIboP78qicPJqw2hn2ACs
Message-ID: <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
To: Yeoreum Yun <yeoreum.yun@arm.com>, Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com
Cc: Jonathan McDowell <noodles@earth.li>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca, 
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com, 
	sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 1:57=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
> > On Thu, Apr 23, 2026 at 2:13=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.co=
m> wrote:
> > >
> > > Sounds good. Once the patch is posted, I=E2=80=99ll review it as well=
.
> > > Sorry again for the noise, and thanks for your patience ;)
> >
> > My apologies for not getting a chance to look at this patchset sooner.
> >
> > This seems like an obvious, perhaps even stupid, question, but I have
> > to ask: if IMA can be properly initialized via late_initcall_sync(),
> > why not simply do the initialization in late_initcall_sync() and drop
> > the late_initcall() initialization?
> >
> > Does any IMA functionality suffer if initialization waits until
> > late_initcall_sync()?  If so, it seems non-critical if waiting until
> > _sync() is acceptable, as it appears in these patches/comments.
>
> This is the way first patch did, and here is some discussion for this
> (Might you have seen, but in case of you missed):
>   - https://lore.kernel.org/all/a6a0e15286c983d720de227c6827adbe976c5b9b.=
camel@linux.ibm.com/

Thanks for the pointer.

Unfortunately, my concern remains the same: it's either "safe" to
initialize IMA at late_initcall_sync() or it isn't.  Attempting to
initialize IMA twice seems both odd and wrong.

I understand the need to ensure that the TPM is available, but if it
isn't safe to wait to initialize IMA at late_initcall_sync() then it
would seem like this is a bad option and we need another mechanism to
synchronize IMA with TPM devices.  If it is safe to initalize IMA in
late_initcall_sync(), just do that and be done with it.

I'm also guessing a two stage init process, e.g. some in
late_initcall() and some in late_initcall_sync(), doesn't make much
sense here, but that could be one other thing to consider if some IMA
tasks must be done in late_initcall().

--=20
paul-moore.com
