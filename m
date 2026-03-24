Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CC73537F0
	for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2026 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387883; cv=pass; b=bCIhyj33BvZTaOfj0HKKNsD1ydPPrCq8iqqTC3CMvnWJ3n07EgP/PUOkwoSigb3zAykZ+vO/VxbDS8Z3+3QLWaUMjOIm04RfvY541QNO4fSsWEGCEQErPWFTAOWaDjZyOqUOt0gUzB9WBOOFaTSQCGbm4yQ7V9N7KMOsUitqFUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387883; c=relaxed/simple;
	bh=Hm1dR7au5P+e5JwWReyx1Mro5MQiz3tvFOVbs+Mlmm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5UEwU+p8VlzXVka0ryTHlsrJkCFLYPxv6taqWK8EA+0boiW32XWKLQXQAjEPQU/TEORWAxQyYrCnMs/L+gVXwOdf8vBMjpM3HtPFPr+C9I52WZSdC2CMHwXVUxcn1EwM27yrP4BYGtbeo6SEf4SVy8EEXntGpmnWPR2plecYws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R6nGHowX; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R6nGHowX"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso3829961a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2026 14:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774387882; cv=none;
        d=google.com; s=arc-20240605;
        b=F0fiQuMkul/FZ300+laIgUxxRspoZOjb+rCQc34RGcPP8DD452fA9xRKlM8iQ4Ktvp
         jcisH6nPY/B7gG6uEjyXfqAYVBkuk3w76SAUn3N6jDRqrAj2He/ZaFKeCQhFGb8PfhNI
         zRFmPN+lt8ridghKWCCdjmMidouoU56v0tzy3ud6DKy6gEroJQn7sxFAbEAfcSD8IGXG
         38uIpS1MrWpWInbA5QuomhUC0Wa3+wmqqe9MwmXxQ7oVMtsIWKE9HGKQ9qx4mhmk0nPz
         2YfzSPQLaGbyfVKZ53PsTIi7WBBmp6yOi2a3+8gcWePDZY/p8l19idrtRh4TPlls+99U
         H9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=01YkIR3aFC7r0WNhjXFTgr1gQLf1wkJY5iRpaT1roY0=;
        fh=8f7gqcic+o03XL6ZtvHXRcn4FYJvF1+HyZIn6CitVFA=;
        b=inSXPJ04c8LrnNMig8RrlwA/5MVCVyP9WFxXqTKQ+h4MEesURqLioXk1R1/7KNuLlh
         QfCF43il42XxYCHtpVaLAgdFDcC0lQy52J8WxOo4Qiy/RF+CNuvoUizJ6MPcrdTrNGVK
         4zGTCdGWhrXST7ThA2W/n1oJM25O1kWs63FWBfTYyWxULufMcZ2dJ4cdFVpObI+Zxd7e
         5jtQtXh79SngrFyvV04VanTx2Zf17VQrAeHxgYC/Lbb6qGO+v+Zd2DIkr45xawWv55Ko
         Bkcqb3c8DVDtYrsbhdSACNGcfOJ0ia0+eXFdiLF2ZkELqWJTpK/neXwnzU37ccn7YI8l
         94iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774387882; x=1774992682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01YkIR3aFC7r0WNhjXFTgr1gQLf1wkJY5iRpaT1roY0=;
        b=R6nGHowXrV/VFdDdZZHkvCArA8xsiK1p/ZFxBbWTOq+1vZ1Ju0MVXBMa3mOiDFvxby
         AQKDFvtu0zZy1rrtn46+48AmCAYudWLK0GPJL52HIy0hY00sEuCSquViVVPx2pc7f94l
         ZmURWk9QE4FaCIk5x0PzGXiGucd6kFAikpZb3cJPDcvqJBQFxU3Tdj1aARtwFul1O+75
         5RlaWxn1BWmGeXb/7upUOHR2JTa7OvIj1BiaU6PDyjENYtX8+Zk/kv8s+X72CRyfjZYy
         iGHDPJ+4Y8G/Pi7NlIh5ziIyxrlHt7OxSZi4Jm+X0ExQo5PS9QvXdDDcvaVAL1AgfWWG
         cPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774387882; x=1774992682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01YkIR3aFC7r0WNhjXFTgr1gQLf1wkJY5iRpaT1roY0=;
        b=Vrm7/L/03H11GMATo49z16iObrNClWQ7BDFairyS4DTVI8zulfekfJgYrFK0NZQQw7
         qmw8nblLvcBhteIV+jfFZdmCj/eUJ9QMVO2M9tfoetJnTj24hzrPCdKtYev3Y3OZ2WbI
         DMpBUHXKwkbPkxChsf/dp+Biocl9kT1guzOy6d3E6CIxDIxIure/P1yCIq+6GpSh16ie
         33cxquxO3OrXVJECiqdaDmeLCvCTCj0Xf9dBcBg18bFFLudUsnigDGqw92krW5511lXT
         apQgqGsC+kSud4aNep7s+Y8A3xhoNHDB6+D3Z5y0reWr0nPda4i5wO/f7AL1cLdAV7tO
         KT/g==
X-Forwarded-Encrypted: i=1; AJvYcCVvi8EFtZ7B3hw8efn90fe8xyT0vAzUKL/5VVZNCH+otpzeuyywM2fi/kn7FgPocV3sowtyhANfcky8t+vdKi8iBtxUAB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEki+LUTxGOMK+3ptI3FYcww+xx8k9DTC6HePaXsrf7T4t5mn
	ZzHIOIn14MCrX/2Bmk57HtdyRF/cETTdL4sf2wbPPCbpMjPmaguyg5Hj5gdmn+u2FI4PY+5BwSD
	TOaVZKR4ljJ9I91noAnoZ1C46kd64c1I+uWmmvq9Ofqgpc0P21EM=
X-Gm-Gg: ATEYQzyx/sVmwLxx17/lQgAJ2GYAQ4885mMgApsO/0L1+1ej7JBdrYatNyG3S7n4JYY
	NQrj/ze2+F9/sXIZPTTeH82ugpB31/Nn3Wt8Qk+7M5uTywFipj8kbhbtKcrB9MADyVYNBi/k65e
	4nJCVB2sCcTUPDOVXuE7CY66UW5+FEB5hB7kQRunqYE7WieWZct6NcIUPViHLQvujpuB+FAkLim
	W5tjtd9WmZoJ8zoiAPV9g+0z5/9twCWarQp6MLjsMmZ0oTB66PsspWib+Kmt7XVWUJPV5M4WPEk
	S40Z4Q0=
X-Received: by 2002:a17:90a:fc45:b0:35b:e51b:1936 with SMTP id
 98e67ed59e1d1-35c0ddb20cfmr766067a91.16.1774387881757; Tue, 24 Mar 2026
 14:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
 <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com> <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
In-Reply-To: <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Mar 2026 17:31:09 -0400
X-Gm-Features: AaiRm51f402GZXFLfjQp9lpoOMUGhMYulpZL258uSDKKLIGIRxrcxNY2DsM4x1g
Message-ID: <CAHC9VhRgi8_gdx0nKwkOws1VD6EFG+bHNTN5Q8YCxZ3HOCu5PQ@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 11:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> I'd really like to hear from some of the other LSMs before we start
> diving into the code.  It may sound funny, but from my perspective
> doing the work to get the API definition "right" is far more important
> than implementing it.

It's been three weeks now, and I haven't seen any strong arguments for
supporting the clone() API at this time, so we can leave that out for
now and stick with just the unshare() API for an initial attempt.  We
can always add a clone() API at a later date if needed; going small
and expanding over time is usually a better decision anyway.

So to quickly summarize, here is where I think the discussion landed:

* Implement the lsm_unshare() syscall

I expect it would look something like 'lsm_unshare(struct lsm_ctx
*ctx, u32 size, u32 flags)' with @ctx specifying the particular LSM
being unshared, and @flags being 0/unused at this point in time
(unless we can think of something we want to specify here).  Like
lsm_set_self_attr(), only one @ctx can be specified at a time, so you
can only unshare one LSM at a time.

* Implement /proc/pid/ns/lsm and setns(CLONE_NEWLSM)

As discussed previously, this allows us to move a process into an
existing, established LSM namespace set.  The caller cannot
selectively choose which individual LSM namespaces they join from the
given LSM namespace set, they receive the same LSM namespace
configuration as the target process.

Any comments, corrections, etc.?  If not, if someone wants to send me
a patch{set} implementing these changes we can merge them into
lsm/dev-staging until we have a LSM which implements support for the
new API.

--=20
paul-moore.com
