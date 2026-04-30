Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5068C13777E
	for <linux-security-module@vger.kernel.org>; Thu, 30 Apr 2026 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509799; cv=pass; b=XZjMp3outFFFA2p/XVsT9D0XCDbUd+T4/TLSNFm8MXUfwRgcY70cvPCJ8lZQxVdMiGZStbVucqN1R6DZYP/O19HySNEVCAovjP2OCeTsnyGSlTk86Mccyu9vGB0nDeVkRl1ZBjAvjghCsBtSfOQ8jDXIMQma+EIWGsLctSMTySc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509799; c=relaxed/simple;
	bh=ZdaMDMnsE2bNTMd0UOmXsnLLXqtDt1Cqm9/WufJEwTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALe2nnomm5xox0uhcuoUoMLiC4kedPE0nFsD+8H7qb1ZMarGnIKrzBjTKTkjpRJ5To/A0q/5YQnZENYz8tPFyEO4+QE0K8KRu7fDwqwntMIqOUIYeBFGoxZ6Xb04x2KNXPEd3OpxIPGLPr+LHQ7zEibDO5vaFdoxjBhcz2Ca1GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G2yi90uS; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G2yi90uS"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d965648a2so325684a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 29 Apr 2026 17:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777509798; cv=none;
        d=google.com; s=arc-20240605;
        b=Jq+LiLIepCywQgeo3/Ou5LazWwa7SfY0JK7XKccHYRfGbV9/g9XHUx7NXkfow3FwR2
         1x4QijdVu2z7DKEh9RwuRZR8XP5tOFrolgyPZabN1ZkcvaNDTOWq7QufhpJKj94ds+1r
         t4i5iBzxkE6YYSjAuN67bQ9aHQ9Mcx+hnt6qnUpwcW5N47wmWx7erjZMzLmSPE9t1DYa
         aubU0BaCgFfcIk00DP7I5hwUyQ1VV1fkV9rwo2iOg+xTW9OpStbBkfrVDIIrHt260W36
         ABgC3xhwVLV26ljEke3jFAbcrGgwpB4eKZOZfHmdRQMFqiCuaEtH1Xr//vc9wwxqfKtd
         SFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+22Vew3O7NYuCAbB+MpAlEjTY5hterfUj3xJsaAyHE8=;
        fh=E9ePw1slIyvgfzXwO4otp+RDIcSR+aOXEcHKNluw5tA=;
        b=XtpgVZDInGKTAemHayX3HZnj62mAroSru/35PLw4JMup99po/vuZDQN9gyBppGdlug
         96vvGWgi4IakvRaFc8lP3pDAl3EDu3ifwHEf8W7kgpGJKMrqsB02QfWhyZTQutS1tohU
         hOkhTIRJ1RAjDyfN54O/so97Q73+0xSGRwiSoQooFbN/kXQffGXOl9cTiyyLW0G1U0Y9
         Gf3RBXJLGpe7ImpN0C+axwf0nTVH5KM8DQ9fzm+/4zalHkU3AbG3CY2t8soAY7Oy8kcQ
         T+e8DTwaiY6ou682+/sGB/56tiCoT5Y01+Fi4VwjDY644AVVkcul2hTQQyYChIIAULMC
         iCtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777509798; x=1778114598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+22Vew3O7NYuCAbB+MpAlEjTY5hterfUj3xJsaAyHE8=;
        b=G2yi90uS0VYAefuD0q4YL5MvIf+jTDDyZMDzTJucknJJFV7BwKM+BAPQtWErB6rAKo
         PcT0gaj+LkO07kcO8Qqjd0k7OEgyADrViPpLXjbCiFH21CLt9rrey5+fhRCyuoZ67nr5
         Ft8qm7H4gbesCMBczBfzrrgbgyXEE+6FM+by2f8JesasyRJUcFDTuTJpIEmm9UELeLnR
         qQY+oLDkiklsy3fCC3u4PuqRiFZ6/wA1Jv5XBilacVJ5UscbLNY6T+lBXuYZMpF6QOXf
         g6+mg4XWWbcGLdzVhal8kV9oQdVS35EiMlw2xfiln8MIQjmw3EQE2F4ZCPzmKDhi1S3T
         Pbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777509798; x=1778114598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+22Vew3O7NYuCAbB+MpAlEjTY5hterfUj3xJsaAyHE8=;
        b=RTmyRc5QiajI8HvBcSszCg383IMfGx9jqV+RXUb13zX9ES3z7u0S8ydJK/GA9wzGri
         8W7ARq/54J+duwT6PKilhMBiDPl/oqAkOyxmvyy9/o6tn0R4ccTzwpsG7/+pihEMZZCV
         SspgV9sZpqqTRarn6M95DtM5YJoIp12saQB4uiRySPhjDg9+8jgkU0yYVm9bjomnquzu
         Fr7sxC4HYpR85+0QbmYodDGj4UU4Sh9HJ5yhHqr5l7OCUGTfxDwBXmP/izy5E9kblD3C
         cDvv8wt0/atmoC4apQNoQsnfXZTRAUpFJg7h/snWDpxjHpKo0Q/AcOYPrd9xYdXZUWQ+
         e6Ag==
X-Forwarded-Encrypted: i=1; AFNElJ9x1CmlNSE4UY3ccwS9EKD81R4Jartj7v0q2rU0dcPARt/PgHTsN2sFOopAaANHPqmxDANY1BwC7LN40EMbbSS4GEi+1nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwO9Y/eFuJUhEhQ7tuBHKwixa14pSH02fIwROS9gjJytbnIV8i
	Ms6mk6abQYSpilZ6ueqhgGGqhPQP7YCW67X3JSu9tWBkkiXarHjhgI9hEuLlKrF5vFCx3z71yxy
	GmfndcWY0NxF0VwJQtUW3W/Y2HGnyPFBTNipBb8zK
X-Gm-Gg: AeBDiets7hFOQ7HhDNKzTJKXLjFEDBKcLyFnUBl1GYoPmP4fkKhidK4m4OQAp5TbrVq
	Wexf8CLkz6ygBy9MXKVAmfVOaFwzvB68q65lOlGzRdROkV7cPJLTvsXYNPHKcotZnJJc2JxSzlk
	54VWFeQDUHMpStkPVY9/50is3QLapfK9g5rfVd9zORskxn2K3P7hlflc3I/Gm5XfubiwItPIldG
	mUyMfb+vF4YYDv5qmRRjx2pwGmkGgaoDJhxhkZRzGNGI5+O6VFK5oZcKQtN9q4jIDVwiEUtP02o
	22+M/yQyMqBKK2NTjg==
X-Received: by 2002:a17:90b:3b8c:b0:35f:b5df:450 with SMTP id
 98e67ed59e1d1-364c309b046mr561429a91.19.1777509797729; Wed, 29 Apr 2026
 17:43:17 -0700 (PDT)
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
 <aesGU8a3mbVzvteH@e129823.arm.com> <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
 <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
 <CAHC9VhTW3=RJ8L91RWXYYA9tFjfSXGN-DMEEwdiD6big9H57Ew@mail.gmail.com>
 <1f78fc75b2e95239973612a4b6c4cc782960b7ac.camel@linux.ibm.com>
 <CAHC9VhS4JmPmCJrYTdbjxb3TO-uK6cB3Zij-ef=wswGce2BGzg@mail.gmail.com>
 <1e51c2fd090e5ceb07b1d09e50650c70fd3ccdb1.camel@linux.ibm.com>
 <CAHC9VhS_WgwhW_NDO91LoTeSzdieGqbwqnwPq8KpavH1_Lwi7g@mail.gmail.com> <e325b7a8041b7122e8415de9193f4fe1be04bb02.camel@huaweicloud.com>
In-Reply-To: <e325b7a8041b7122e8415de9193f4fe1be04bb02.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Apr 2026 20:43:05 -0400
X-Gm-Features: AVHnY4LHifXVy7YvtGHgR9F7kahKzv5vW_Z8KfHyWJ-dvateuzzdMLdc0MOzfBY
Message-ID: <CAHC9VhTqYgc6fE2v+ZY4QXuCDkvNMKZcM4Wi+7Vkxspff08K0A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Yeoreum Yun <yeoreum.yun@arm.com>, roberto.sassu@huawei.com, 
	Jonathan McDowell <noodles@earth.li>, linux-security-module@vger.kernel.org, 
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

On Wed, Apr 29, 2026 at 9:33=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Mon, 2026-04-27 at 21:31 -0400, Paul Moore wrote:
> > On Fri, Apr 24, 2026 at 6:49=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Fri, 2026-04-24 at 18:10 -0400, Paul Moore wrote:
> > > > (I'm assuming you meant initcall and not syscall above, but if you'=
re
> > > > talking about something else, please let me know.)
> > > >
> > > > Saying that you aren't comfortable moving IMA initialization to
> > > > late-sync is inconsistent with allowing IMA initialization to be
> > > > deferred to late-sync.  Either it is okay to initialize IMA in
> > > > late-sync or it isn't.  You must pick one.
> > >
> > > Yes, we're discussing late_initcall and late_initcall_sync.
> > >
> > > I prefer to look at it as being pragmatic. I'd rather err on the side=
 of caution
> > > and not move the syscall to late_initcall_sync, than move it.
> >
> > If you were truly erring on the side of caution you wouldn't allow
> > late-sync initialization without knowing if it was safe or not.
> > Determine whether IMA initialization is safe at late-sync.  If it is
> > safe, move the init to late-sync; if not, keep it at late and figure
> > out another mechanism to sync with the TPM availability.  If needed,
> > you could probably use the LSM notifier to enable the TPM driver to
> > signal when it is up and running.
>
> Yes, I agree with you, or transition or not.
>
> However, all of this looks very fragile and easy to be broken. If we
> want to be on the safe side, we can use any notification mechanism that
> is suitable, but at the same time from IMA side we need to deny any
> file access that would require a measurement until the TPM comes up.
>
> If you accept this, I don't have any problem to move to late_sync.

To be perfectly honest, I don't care what the solution to the IMA/TPM
dependency issue looks like as long as it doesn't involve simply
trying to initialize IMA multiple times hoping that at one of those
times all of the dependencies have been satisfied and it isn't too
late.

If the notifier helps you solve this, great.  If the notifier isn't
helpful, that's fine too.

If you need to decompose IMA initialization into a multi-step process
spread across multiple initcall levels, that's okay; we do that with
other LSMs.  However, calling into the same init code across multiple
initcall levels is not okay; you need to figure out what is needed
when, and establish some synchronization mechanisms to provide some
assurance that the system will boot up correctly.

--=20
paul-moore.com
