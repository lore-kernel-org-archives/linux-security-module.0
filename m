Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74D31326B;
	Sat, 18 Apr 2026 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776508479; cv=none; b=qGG0iuN9jO3+7i/00GJm5s3iHZMrJQvm2vGoXmdDwDnpqw39Mn+UsRF4nqCClf42Cysx7C7G/qWytifsUCpPQ2fcE6AB3Trdwz1nq5t6hkXbgjNDVibM3rn8ngmHIHj+u9TfIFFXS8/PDeRp82w774c53h8Lj+4+6owlslhh7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776508479; c=relaxed/simple;
	bh=Ciycx8QqHb67sqchL+YA+/lrYPi38l87mnERhghqxMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vs5lJTh4VKfWm8ZLsWrTkbBfPoXwu58cEFpJP0Oa7dWcors8Gz8fayEYvgc0KatvauKBlT0VgPQAPYpBafglzaOYGVeE+Bi4Nmz3Yc6Ep0HdfpZvOoerHjIi/Lj67vMFue2St6xus+NV/wL9y9vMtIr4w+hIi4Ol5COnfnxDLqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JKK5K+Om; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JKK5K+Om"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5A601764;
	Sat, 18 Apr 2026 03:34:29 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C27643F7D8;
	Sat, 18 Apr 2026 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776508475; bh=Ciycx8QqHb67sqchL+YA+/lrYPi38l87mnERhghqxMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKK5K+OmEERf3Ey1f9imniEVj3Xa2H4WCBBD0cVwO/iRQ6G1M1uI03ZJaaDRNbCP2
	 2QWiZECceul4y+JU1g5Jm+oLecljKqseZJpgPCKktH2oemMRsQWUFqaKqXnNEpzjBQ
	 e8jdnRcY1c4a2J1f5NY2s5/CXyCqNGfk9zY9/IS4=
Date: Sat, 18 Apr 2026 11:34:30 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <aeNeNjfO7i128TIP@e129823.arm.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <87se8sbozv.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87se8sbozv.wl-maz@kernel.org>

Hi Marc,

> On Fri, 17 Apr 2026 18:57:59 +0100,
> Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > When pKVM is enabled, the FF-A driver must be initialized after pKVM.
> > Otherwise, pKVM cannot negotiate the FF-A version or
> > obtain RX/TX buffer information, leading to failures in FF-A calls.
> >
> > During FF-A driver initialization, check whether pKVM has been initialized.
> > If not, defer probing of the FF-A driver.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/kvm/arm.c              |  1 +
> >  drivers/firmware/arm_ffa/driver.c | 12 ++++++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index 410ffd41fd73..0f517b1c05cd 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -119,6 +119,7 @@ bool is_kvm_arm_initialised(void)
> >  {
> >  	return kvm_arm_initialised;
> >  }
> > +EXPORT_SYMBOL(is_kvm_arm_initialised);
>
> EXPORT_SYMBOL_GPL(), please.

Okay.

>
> >
> >  int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
> >  {
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > index 02c76ac1570b..2647d6554afd 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -42,6 +42,8 @@
> >  #include <linux/uuid.h>
> >  #include <linux/xarray.h>
> >
> > +#include <asm/virt.h>
> > +
> >  #include "common.h"
> >
> >  #define FFA_DRIVER_VERSION	FFA_VERSION_1_2
> > @@ -2035,6 +2037,16 @@ static int __init ffa_init(void)
> >  	u32 buf_sz;
> >  	size_t rxtx_bufsz = SZ_4K;
> >
> > +	/*
> > +	 * When pKVM is enabled, the FF-A driver must be initialized
> > +	 * after pKVM initialization. Otherwise, pKVM cannot negotiate
> > +	 * the FF-A version or obtain RX/TX buffer information,
> > +	 * which leads to failures in FF-A calls.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_KVM) && is_protected_kvm_enabled() &&
> > +	    !is_kvm_arm_initialised())
> > +		return -EPROBE_DEFER;
> > +
>
> That's still fundamentally wrong: pkvm is not ready until
> finalize_pkvm() has finished, and that's not indicated by
> is_kvm_arm_initialised().

Thanks. I miss the TSC bit set in here.
IMHO, I'd like to make an new state check function --
is_pkvm_arm_initialised() so that ff-a driver to know whether
pkvm is initialised.

or any other suggestion?

Thanks.

--
Sincerely,
Yeoreum Yun
