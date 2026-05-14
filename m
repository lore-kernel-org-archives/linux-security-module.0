Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7C314A9F
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777857; cv=pass; b=bmVWPSNdTCHhBZC3dz7p0BbGWRtFzduZtjiG2wYXjFucJrKqpnmkfuY4FE16T65NLiHgDm+wgNPTeHm99fjYenkTDW6+Sl4KNna01y6BpdXol/To7g/TtwOnNtGp/bGWBa16gu9l5NdxpEP/6kbn1MxuDKQAX+yqemXoSoikr8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777857; c=relaxed/simple;
	bh=6NTxa7tp/OLWv26yjkCHVokRcnansibzen70L3fgY5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfC2lulbORAz9U/ipmmCEQ6BRFRKhbTUwAFKWfGEKRaubvXmkU5AhJS4sfQ+v4TuMRhvwA0IrcXq20KDIgiR3tBFU3jzbAo4+RYOYCquXkNYQ5VrwhXcJJ7zodhM1kh0heNbpZzOlr8k+9SeYfL7jZ+haOA3EjerKJQrakj4S+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UFX6SqmE; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UFX6SqmE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bccb978bd9so468795ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 09:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778777855; cv=none;
        d=google.com; s=arc-20240605;
        b=Gib8pZ+RrujQZDNXVVttAEYtZO9JJ3eM5aTseoAFzaoFn6YsIfE42+Okn9fNyV7HKc
         2PvsXtT3l4CU43Ob2vUKxOSSK9dU3vT12KW5tCaHFjp6N93JCACy5B1fGHCZXg4EMGU3
         s8ichYXlWv9KiZTAQpPfkEjD/gIDiS6FcOkqsQNHxuZDAD8gDh+wxr4RwADljoPupEQB
         EVa5uCSy+C+Ix6WbhTL+afxcuqB+9nIDv5jxJAGRpppYj5Dgm0uyUyEs/eVnOiFYOwmZ
         DFzEPEtze4ONMPuJLcqM2regUQRU7PwCOrgmMFxncbyVpC43ABGhmm9/Cq/h1zTPj1We
         izlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kGYnTbf7c/VUf+1RMKlUT/ARw3FwaI7DSLnbEn3RtOg=;
        fh=g7lKKsem1+02cpvMNJSeb/JlIrZwL+41uH0zDH+d6rE=;
        b=eVddQoTSbeWJgSL1ZoNuA6ZklnJ2AvOmyTWIr/6xUHDX0t3zoqY079/D6sMGsYsNvA
         fgZm/t8OWbm0yVmm1RgsemmHVz2E6YZ/FeTfGsmSyvms0MsoF0lcOqdssPrDpMOS0pHf
         1jkgY14w3QdWrH28rOBewx+6arboZMQC8MMH809Dixu1sgSG4UVwBchSXSHNNbiY53kE
         uYqX/IMBNOWz4EyOusIqIWRMNGSfqdH2mxIetDRhvk7fn4dknvRawYD/fhBGCPh1yipZ
         c25fzrY41OCYPN5xGNnHvUHjPYF9gQMK77EGJZg3dio8qM16B3w8UvGFgvgxLyITWjki
         B3hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778777855; x=1779382655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGYnTbf7c/VUf+1RMKlUT/ARw3FwaI7DSLnbEn3RtOg=;
        b=UFX6SqmElQvjvyk8tedoucUiOlwm1WtLiQSphA+5bvZIzkGKEOvwzeHzqa1D/5oiZP
         xrSDaOA9HntiPxFaCjqOMiIFa2RiV7zG9Qb4dseGM1a+wP6ruBDzbddV6fYO0Cnl/ISV
         6Pvdsy6MtikFZwe38cQnHO6mXK5Ij9GXOy3N7gTnQOUGZ+Tc7ddayAY4hbqIPFDA7ZFQ
         nevPL65akZVWpRqA9Vu7s/7cAgOk7OooarfxDZ3b8aU+ek7hVBIR9IDNnm7/UVTBImdH
         V8TBHHDrqMENGRcqkbcgsOaAtZvPPjHac0sOrpNWf0yb3/mIM83v7f5+H1yKdJBNvyJA
         ALqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777855; x=1779382655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGYnTbf7c/VUf+1RMKlUT/ARw3FwaI7DSLnbEn3RtOg=;
        b=S9AOGICtobRXO0j1THnl4/06QrZAATgSQqgPp7IatMpgNHC28mowr6SDgRVsVJl8Kh
         hoR0RREEqUqZfuu7UineE0oXMc38Knm19qfFVMNyBuTObxI4avPY7BzsRHYmieTf+Uz4
         lO6VN+NRoFkLxLovBC8QR6L6rlfiVG9am41Hd0APVNXGZ7BNWxezvu0AAZo0hC7Wy2xk
         U/EnAwVFdNMkXYMbs7G0ap9IxCK6sGeq+4Dm7G0rBS/BNLnf8OLb/tFQoULBfx4V52SD
         7N5jSJzjxLGGO5frSC97Ihn8lhlYNXSwmQ91GATrjCfIa0phq/q2XB9FRHd8ttNwEcHQ
         Jr9w==
X-Gm-Message-State: AOJu0YyVSdqsU6r1iBKVlUk98wWgGA4RUHSBzj89xllYVQ+gzLqLVHkj
	6i9Jxp2d5RNsWYjoKV62sMisdQD7qDiU8Ro48Tx3T478pmOLA+sj/LR1zYgnQQ16FUh4N6qmiW1
	HWE79VvHW+5I0lbAX2LDffnVjBtTnazCrwu8KGNzVYV4lHOwnyOw=
X-Gm-Gg: Acq92OHKxP4eYzgUHhkdeXRzSr/mcq9cCaIp4iy492Xm+JcCK05gnf1QqWuDKkIlZmf
	9Rila6/uONd5vPV2Bep6DSp4UEcADiXqDMtdWQM3DcAEqS6fVNKUlzGwCmZLZI63RtsZ92bVPXg
	Vk53J6lJr3mxPjLFjpeGb0AZ8NPRweCYVfjdbS3XVrW2bJx2d3YIuhIQL8SXuCMydLbWjj4TzaM
	7Z3jgoYkLfGrFNc7/LgTOrIdkQ91pJTSjQS/UqH+cEibqkR/pmOzE+lTOoyJ8vfaTJxWwfw1Upz
	w70SMWc=
X-Received: by 2002:a17:903:3c48:b0:2b2:4fc1:f653 with SMTP id
 d9443c01a7336-2bd7e7f4c8amr3807035ad.3.1778777855039; Thu, 14 May 2026
 09:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514011456.504527-2-paul@paul-moore.com> <87fr3u9fvx.fsf@microsoft.com>
In-Reply-To: <87fr3u9fvx.fsf@microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 May 2026 12:57:22 -0400
X-Gm-Features: AVHnY4L-QzAd_TUOgYyX9xnWVI0NoCauAo4_4ThJDWB-6ISUOu4KS42Q7GZWqLI
Message-ID: <CAHC9VhQ9+-CoT9UH1KUH56ayRCp4H3Q9zBAKvvcpfKZoYPEDgg@mail.gmail.com>
Subject: Re: [PATCH] hornet: depend on CONFIG_SECURITY and CONFIG_BPF_SYSCALL
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 11:20=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > Hornet only makes sense as a LSM if the LSM framework is enabled
> > via CONFIG_SECURITY and eBPF is enabled via CONFIG_BPF_SYSCALL.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202605140655.YX9jzufG-lkp=
@intel.com/
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/hornet/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/security/hornet/Kconfig b/security/hornet/Kconfig
> > index 5be71d97daee..537ad015958c 100644
> > --- a/security/hornet/Kconfig
> > +++ b/security/hornet/Kconfig
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config SECURITY_HORNET
> >       bool "Hornet support"
> > +     depends on SECURITY && BPF_SYSCALL
> >       select CRYPTO_LIB_SHA256
> >       select PKCS7_MESSAGE_PARSER
> >       select SYSTEM_DATA_VERIFICATION
> > --
> > 2.54.0
>
> Acked-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

Merged into lsm/dev.

--=20
paul-moore.com
