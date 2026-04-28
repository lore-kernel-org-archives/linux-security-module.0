Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AA3175A86
	for <linux-security-module@vger.kernel.org>; Tue, 28 Apr 2026 01:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777339925; cv=pass; b=Nj0o2Rz8RUunfWJ8afiQhq3ucUxpH9b1N1lH4GCfG5LRZcZUYbCsnRyJVaUlN4AvjNCfJqwfhi1vTLGxRd4pB+iOJ2kdSw3WfsrADDVYOnvoWZLEB9QWHYKETatFtoqtEN2S0Bmh0mi7sbyVv/pCAvr1pe1wgjC0gM7Z9+mxBA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777339925; c=relaxed/simple;
	bh=Lp0NVo10PoigQtDjm/3ukLN/BhlWLdcFx2DFRGXFAn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWhfo2oZRZ3Sa+L4j8lsobUjnQZ+vS8WehZsK+91CDZP0fah9ugmS+6+Y7eXC1YZrd6ec18NV6lXH6udLQpvanIi93zln8gQmfTge6eoNn5P2xjD5osRa8M9J4qiOR8OaX1fX/wYaQ6qMahAEHB4Jzgwgqqr+oJL900IQ7ymQ5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GR/9PU2h; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GR/9PU2h"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35691a231a7so7208310a91.3
        for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 18:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777339924; cv=none;
        d=google.com; s=arc-20240605;
        b=CfQS5UR3mBBiE4Fo30nhMafEq+ZEZwghimwKjR8YnoGsvDgL2yaTkn4WQ4P0SWHNjH
         v7T4rMsCspuVUKzeevf9POTeal2sVTXnPFOHAphywn1HDBTQhebuQn3BHsI3sqZ44il+
         I4zI4o5yqTDlehTzxhMiUCGeKsDN1ZDETt7w37RJWUMCAsknPh4fnoKvj7w2sgmrq/uS
         YnnxoFlAKteC4okbX57g9nrbn3PBSGj6cPyIPKLlY9JIrfl0k2iXIodFTVpDRmVHVrWN
         vDP9Sysjsfm4O8S0ZsHeaNSVIytCECSEd7QBLZ2yFe7sNME7PkgMAHN3svCqGqs7fnXd
         rqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dkNNLielDoU+waGJTxz6K7Cs44v4hc05yCRBP0rYkY4=;
        fh=DM4He+qR1Mk/7oA22YO5riWS7jCjAjjejCHR/vfns4g=;
        b=OBOQlDJTw7YSEToNtdpWHb1m7/iOtMN9DJZuQoj698tB0A50fAi3mFrP7QK9f86ZsV
         VjNZsdlW/yKjUneq+Vt/jnnNUNx3uO/WJ0X7sqPe61VkrG8bVgiUD0mWV8dKu1cUSIw6
         IUGFIF7WfjIoQj0KzFQGFpkURS3d0rpoeCmfnsjv7e9ZUi3zR00qlb+CbfwXpr+ppU3v
         lhInVEA/S7e7BFyJE33/M5cJKOOYhfhZLa6wAZ415fKxmN49ki9/bn+a2VxEmVaARHhd
         0ZbvUfMvgmFVW9/3FHPca/PwRAnEqSl7VKfHQaawPaVtsRjo0D3zyHo2ABwJaZdb6dhw
         Q6lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777339924; x=1777944724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkNNLielDoU+waGJTxz6K7Cs44v4hc05yCRBP0rYkY4=;
        b=GR/9PU2hhLx7g3YzIBrG4dXdPJ9kH1+PdVHWPcybSq41wCBOSQgKX+B6TC7siDjUs8
         8yep/jjPuYI1kjVeOIHFVuPlHkYJ4hEStOL90y/NmkWNcYMpxg4G8yInBnSxRIC6HaGj
         s8/H+9s72GWv7uctwp9XITxII7teYKxg16TVi8k0Oa7UznZn98mRSEGPn44pI1mCqhvW
         TYCe58xMm/2WjorpSqF1ecvRxzA+hQ1ezff1fl6plFq1aMYHiQX8laF5TBF6FVtg56Wt
         vKjoj77yLGZ0XLiHOjOX/7Uh47jotdGgKn4omjXWXDg23cmmr54TyzXKI7PF5govEX4+
         tCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777339924; x=1777944724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dkNNLielDoU+waGJTxz6K7Cs44v4hc05yCRBP0rYkY4=;
        b=ljCzVl02DI4CRhJIypTamJ8iAdCzSMYsRFrQAqPCRhFBzXRkwYq73aB+Oj++yqhymH
         WF7+fRdUA8RZfWkANoOr/c0iloDbSAl5HWnydlO8o1eHqHF7ybe6LfYl3KL55HKr+2ek
         9Bcr/Rj+y+Jzuen8O27PeqI3ETQ++y/gPsSh9lzDU24GXRPan+LON49MxRqKub1wyZzI
         zFE6tqGS2mjK3Gwa1vwm81TI1nB2wfmba0+hXYVXROcjz1MTUuPA0dML7DDifHJJ8gnS
         B7ULIAlvPi//aR4r2IRBA9UNBEI6Dpz5LIimYDaj766hdjCzQPs+0lMoVWRUYfBKeH09
         ZUeg==
X-Forwarded-Encrypted: i=1; AFNElJ+e8xZ9x+Z+xPtNdXCHByrVomyzHvX/nROmgkvXneM1StJ1s+dKyt08voHRQO5olgSpKWGUj44/XqPEXzWpIYmRUIbBqdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQcOxpxHAqUmOdzHO++9FiP3KfLEJ7gTV3yZ52QaaJLUWwA/Bm
	yHYZisiuv2DCPFQBNVyES1izDXZtF2xfdTkq/s3WVAxgCQI/u1ZNZPj6MGLQvaYOR5cBGjb8K+V
	9k1IH38TKBH1aAQZNMPhgfwoozM9Fl6Ce5nd3Q8M1
X-Gm-Gg: AeBDietlj2ra8RjBBVKKMYsT7GX7IKYs8TTJ1sT/y2vQYBHOl8dcuu6inTfOOu1nRkw
	HvwU8cpe0Qoc9KflH8Qy5/O08tbb5OqNeQ9khXL4KpEeIkSAaTQDiBwkXhlVszKgPpxGt/4i5/U
	6qNh2vvTR0f+Z/JDBe0WAUcip81aehybMTaXgTqVn6Byk8J5SEvdPLWVak4zYxKAHyPwHhVl2lf
	uI/n12CWYGIjDJCwSynSx3yYXkATtsVMb537LjX+RnEwqah5zlbiteY0u0LN+No/erG2/2LEzum
	YjfRs3CL/Weo5LIADA==
X-Received: by 2002:a17:90b:52cc:b0:35f:b714:e516 with SMTP id
 98e67ed59e1d1-3649202f6b2mr1031930a91.16.1777339924049; Mon, 27 Apr 2026
 18:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
 <aeokwrC86WI7uT+K@e129823.arm.com> <aeomlp3I0eVE5mce@earth.li>
 <aeotq8nPVu4wvEx5@e129823.arm.com> <e4e242ae5533d5762a3647186a178764881bf9ff.camel@linux.ibm.com>
 <aephL3MzYoqFGaT5@e129823.arm.com> <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
 <aesGU8a3mbVzvteH@e129823.arm.com> <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
 <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com> <aexIwJpno3iPIdRD@e129823.arm.com>
In-Reply-To: <aexIwJpno3iPIdRD@e129823.arm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Apr 2026 21:31:51 -0400
X-Gm-Features: AVHnY4JvmD_vpNd2uBimzy27N58OmiHGYAhJK_BGt8LuvH5xnPjA0AMhCSfE4Tk
Message-ID: <CAHC9VhRT1v3mM9CFvz7Dh5Zrv_MF3vgBk+BZ=q8wOMkPB6O6Fw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com, 
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

On Sat, Apr 25, 2026 at 12:53=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> =
wrote:
> > > I understand the need to ensure that the TPM is available, but if it
> > > isn't safe to wait to initialize IMA at late_initcall_sync() then it
> > > would seem like this is a bad option and we need another mechanism to
> > > synchronize IMA with TPM devices.  If it is safe to initalize IMA in
> > > late_initcall_sync(), just do that and be done with it.
> >
> > Within the same initcall level there is no way of ordering the initiali=
zation.
> > Yeorum attempted to address the ordering issue in commit 0e0546eabcd6
> > ("firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_init=
call"),
> > which is being reverted in this patch set.
> >
> > Ordering within an initcall level needs to be fixed, but for now retryi=
ng at
> > late_initcall_sync works for some, hopefully most, cases.
>
> Ordering within an initcall level is not good idea.

Agreed.  That's why we have the different initcall levels.

--=20
paul-moore.com
