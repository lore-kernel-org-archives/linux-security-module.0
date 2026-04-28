Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5200175A86
	for <linux-security-module@vger.kernel.org>; Tue, 28 Apr 2026 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777339874; cv=pass; b=nzw5FGAAfhBucDvOserx4OTWKOtbFUU8a1p+02yzPKxtbzV8dqBtgp8xUSBLvZ3TfqLGpH0rHUQlSZZHtP2ntDDS0fc1m84rRBgbPBCyHWdy5J4WnuhJvEq60u8k+Nov3yfq8+OZ8sYqQdFxoVpl+eNqn1xFPheszE4g3pT7ehc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777339874; c=relaxed/simple;
	bh=4LjWAlj5OfE6nPz04HGOSDf6N9TOZWCWJub84K9Shb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLld++xSdQvH5S5TlsjYP/qtpislMNm0AURdXZPHW3c1gMf7VFDAey4vwY8K4mGfslFcdEUP2fSMU+Rh6R6MgDeoB0CL/PihmhrGtJmU7jVlHdc8nnDbiv/tIs8Hk25UzHHS4Vtl5lKr08fz/wLIgV4TzduV7Mes+ilcUtLBy2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jshz+lx4; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jshz+lx4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b788a98557so53887095ad.2
        for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 18:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777339872; cv=none;
        d=google.com; s=arc-20240605;
        b=YRiCYreJ3KG1sUDuKNLrbmmvZJ02CaCez3IpJT3Li7n5xIt//ZbkcbJEZKoDNP/7s1
         ZZKgQIFhjvxthxbRzLWOQhpvxw0lXBe9mVJWX/0wekAdlTIU0vThWVGnQpQsBpJxHKfU
         6C3ESoOPac+1sTu2S/DAEkrZX6vIUBc5AYzlmHMi0rJeUFPzrg39NjMgvqJ0OGbb/REK
         WHuVqe3JUvNeDalfanGwFNu2DVCe6NJAW6GKq8v23I6SI422ZsRfR6S6yIbBGi6Or2/b
         HOol04qjDFsUdXYwGApMnjGCY2g1GMI48Q7BMOqyQ8SRK0kdI/iMFA3o6oV961iGYvO1
         oiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HVDB/J4GDc58D/rJhBbvpxXUYt1f3iejtI1opWBv6+Y=;
        fh=CJJNekD7l4VmvOpQTL0dNEq9X/haQJ0mT0vwIb+Rs6I=;
        b=OFfqlTha8Sflp9KFEWAvU+yFKntAaAP2pYXnv++gPibMrTmGIepLWLxq22hBe92bwn
         rZfughQa7FxMFPCM5ppnqfmUhgm57V97/iwr1TOA18sYYq3r8WR6ijzcehBu1+47vy42
         L0FRFy/ASvLQWSyY4U0VKHDLv1xTpjvcneaklAmOx4cQM2E0ZGQ13Kp+h04OH+BqnNN7
         A8pvZ13guZtfiBDWUVALIj9MTLMNclkmConL2HERUVwRi3wKBDM/HUlCRLzvQD2QF+Bt
         2hOHjHmZV4e311I4e0fduVHiw5Vd5wKAcTaNi3lCdahYTpeZOXAmShK81NB7Iw2GbAY2
         xpsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777339872; x=1777944672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVDB/J4GDc58D/rJhBbvpxXUYt1f3iejtI1opWBv6+Y=;
        b=Jshz+lx4V6ToxrGPKq5mfuy6KD4lr2wru9VyoQgBQb7JRcPMdXlWKbvz06kOJQOD2f
         hwpjUS0olBK3xC5Egm4efbPD9fRY5T+DVLvCH3RZR7GEnlj+oej4WIj+nBLEHNw6A598
         7JJqLEw/0PGyYGRztUTiE23EhZl+TXDheZ6I/uosHB0WB7ElOXARF2xmiRFxcsEU5/b3
         13g+LCMEIN+RMdRxFW6Q2AX+prm/ulYcYzrJ6ZQKukdfpPGxLnBYuKXzfzogEgmExGoZ
         zvw0RW27eGJ17R1pvo5HX/LlzTrGtLCVJMFm7IcPvfvAPZeSstw/hPgD4jNgprmWLB27
         9UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777339872; x=1777944672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HVDB/J4GDc58D/rJhBbvpxXUYt1f3iejtI1opWBv6+Y=;
        b=HREqrDSkzFI4PrA5YeT+j+D+h2Lv4H+0MKxS+n+k2525tJWlk1s4i3xfYikfIkuMmy
         Hn05X4i70SvnX+mZH/s1bno/XjJEdEuRBaKjty8LtL/401NVQGzS7sXTrPnHStOKzRCO
         GFXwQszRlICUWVkO/oO5IMLV6vgf93KGqlefGc4uZyqDKPi30ESpbFPCpMWTif+Exouu
         hs1j1MAAxL9eVwsRs9qtz+Q/oqGDauoFpwJJY0/qtbzHdFriAYmFBrBFDDOnCw2w5bp1
         mnCm0K+4+N/sHug/VNDOOrChINYAn/zWRUBrv1ZnrrOAEyb0Rniynk2oL7CBdDiUbKgY
         9rwA==
X-Forwarded-Encrypted: i=1; AFNElJ8Xc82gFNCubNyvbMGuXulRXbvJaHnx+tIpE+e5n/i3G728AaaSPxeyNZ9D+meJvuPpBPil97cfdUa9k5Y5ZgwhpE9Np+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3o24lLJbH0DZhRlDhxctdhv8eBoj64Wp9AUbUw8C8cgmDDYZA
	Xvf70ufgaoTsz18RXGAkCivBoFeK6rCOLucBia0gwXuVJ/DWnuJDBUW04hhEI/6QiQ+mM/F6+1b
	i3zZJ8OOPaZKFWoinvbdB+KdgHXyuPiHWW4aeOho9Ubb80jXIK+w=
X-Gm-Gg: AeBDieuUsKXQvCCnl6JfzBgOnMgQxftN4wUrOdYBFHz8ataYmI9P4lQyhQuvo3WlMVW
	pKZjXhIopOzZQqfZXySC8J2Gs3dunUdAaio7Bz8pptFpMP3SUtfAsJ4h83yQSwOoET3e0nr1P+B
	liyHMHdRklagj8JvUJMO4iORWN66bTEnn6798dyZAmAR0uIETZv7lAKmNNWzGzsy2fmcjOkzSFL
	OHX5JCsvj2OstUrrdIUi77VCGRNrF7H4MlsXhuwxbhiTiWtf9zgI4RKTt5MGbrUezEA/qS/x2Zy
	1Uw3+Qe6x8MWalbYcQ==
X-Received: by 2002:a17:902:ef52:b0:2b7:88d8:efee with SMTP id
 d9443c01a7336-2b97c479823mr8581955ad.28.1777339871992; Mon, 27 Apr 2026
 18:31:11 -0700 (PDT)
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
 <CAHC9VhS4JmPmCJrYTdbjxb3TO-uK6cB3Zij-ef=wswGce2BGzg@mail.gmail.com> <1e51c2fd090e5ceb07b1d09e50650c70fd3ccdb1.camel@linux.ibm.com>
In-Reply-To: <1e51c2fd090e5ceb07b1d09e50650c70fd3ccdb1.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Apr 2026 21:31:00 -0400
X-Gm-Features: AVHnY4KFlOUWIpfP4Gb0UYo42YH7fwp4lG0sflhn6Go0itDdLXH-l_OT6jI63ko
Message-ID: <CAHC9VhS_WgwhW_NDO91LoTeSzdieGqbwqnwPq8KpavH1_Lwi7g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, roberto.sassu@huawei.com, 
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

On Fri, Apr 24, 2026 at 6:49=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Fri, 2026-04-24 at 18:10 -0400, Paul Moore wrote:
> > (I'm assuming you meant initcall and not syscall above, but if you're
> > talking about something else, please let me know.)
> >
> > Saying that you aren't comfortable moving IMA initialization to
> > late-sync is inconsistent with allowing IMA initialization to be
> > deferred to late-sync.  Either it is okay to initialize IMA in
> > late-sync or it isn't.  You must pick one.
>
> Yes, we're discussing late_initcall and late_initcall_sync.
>
> I prefer to look at it as being pragmatic. I'd rather err on the side of =
caution
> and not move the syscall to late_initcall_sync, than move it.

If you were truly erring on the side of caution you wouldn't allow
late-sync initialization without knowing if it was safe or not.
Determine whether IMA initialization is safe at late-sync.  If it is
safe, move the init to late-sync; if not, keep it at late and figure
out another mechanism to sync with the TPM availability.  If needed,
you could probably use the LSM notifier to enable the TPM driver to
signal when it is up and running.

--=20
paul-moore.com
