Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136239F19E
	for <linux-security-module@vger.kernel.org>; Mon, 20 Apr 2026 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688363; cv=none; b=Mo+JjX3eTHDHe935NNJeEDO1PMbr3jca+KQwnU1NEaddqf7pxwq5he3gNXrGQtKkcVFXuEUgCfSpsYRDbem7FNiEmKd1tLL6bYy+JxN30Xi+lCY04p1R+xCpppAtc7p+YjoJc4Sopah/9j+axiPkZXGqxgbYbSx4YS3sPee7SQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688363; c=relaxed/simple;
	bh=mrnF/Wym7mp2XvioGnhhOSe51/kl7uiND0mhtfL/BcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEgSrKn9uKJuVuh2VAdm71dL5AuGau69pWt8pQE7m46ktshUGd+tJwi7lHkcb76fFXUnYn+UcVg1y9E4ABnSo5hdeW/c22AFA+lrp6vw7+gaC9UpGoa3RnT9GzCms1UR0wiVwqCVX725eWG5WsGvc+/yjfyIbeYjWcg++VViZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SAgiJBUU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SAgiJBUU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so83975e9.1
        for <linux-security-module@vger.kernel.org>; Mon, 20 Apr 2026 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776688359; x=1777293159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=99fgHE25P8Rf1g7JLxo27iNfMt0M4KYBWTaNW36OxW8=;
        b=SAgiJBUUGXgwB+3a5up3IW2VP2NXd1fi9bO2QlKPHqemJJooqhLcsCgZxYaT1HdxJy
         dasxz1tis+xZ00tpNhW5/OWMOgIq5NJU3w/Zl/iihWvi+BbyatXYIERe5BcwbPKm/+6H
         jm3HdRrxwxgsI1uwsDVEGdFzoXy9bEHGKZjnsr+P05AEEFnPoVrcIMEGaWmkAsE5ugHL
         ZYrdNAGxeWt5nt3SfHwprvL29TV3RUjK4iF4XXynjuoxjV74S91/5Myhfeyzsx5HJHW6
         W+2enlCY+GYFA7uyKUkpn9SUSjdE+5NCR5VRDeOHDI1uZ4onR+69xmQ0RTg+D9Oz/IjO
         NoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776688359; x=1777293159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99fgHE25P8Rf1g7JLxo27iNfMt0M4KYBWTaNW36OxW8=;
        b=NxnN7ElufmfLiAiiQvqyg1qaIHfdhgTn2M7z5PMAncqgaoUKlshDwX61la6QDVxEOI
         wORL2sNKHlhLgL703BR1ZmkISzfvU3TjICroZBLVP2GaskusttFwz1FAShc5i3uyFNRW
         iPGxPRSSxqzau0qJkVEAbsMhpr8zBePJ5Y2sfhZKYNoPe+xp6pHQhW0D+QdbvPWD20hq
         F8h6EzxJpU1/bFRVU+lxaZLxYo9uMQHAWzdt87pq/IVfB+O1ARdnWqqzmmBFWzgjxBF0
         P8UvMM3/cYeSi7WUUX+qV8n1WYujm6ObRLgthnA7X6snp3yyc4aB7m9WeUPuvhHHOHSM
         EsQQ==
X-Gm-Message-State: AOJu0YzFFZx0xSyP1evPdoXlB7yFTaeGXBEZBIeVeULgv6tep8Xi0oS0
	lxwXjGmfMAOQK2Kq6OCSJanWpdP8ziDmbkD5skJdY30sgAYPiZMtAscCPvVKB3h9tg==
X-Gm-Gg: AeBDieuMoMxVoORCn+N9WlCd+0of88wHbqWU7qIZzDqiWPQDShKui4laO9QXBqFJ+HG
	l3AZjN/P+5Ii31sBbRBFLyK2k5FQwm/dLh3VpX4FSt2xRnZiWMOastBqPjJZ3Ar62zFjJkVBUYt
	Nakd+d4BCaLQNYbfQ3aczVCP2mNyQpVM47znYFrjLSSJi6dEbJUPDLUYHk2gublBdoSgUZnIeMg
	jb1TSip6Ul9QnoQirFl+31Se9PA/U+FeYHGaUwlZO0aGFSwudtcQmMrUhyQ+WZP/UodKGiiW9q2
	NBq7VzbRb/vzhvgkRE0x7Sz2eUtilsv6vFZwqREDGFb2Fh86A7m3XKb4vfEmCweRP68/ZR0fkwq
	t1ylMLE9E4+4L1glCugzGmFHRfhxPmqzXJjU/w3gyGm4jnpWS2jiWqJxAJxUsUK4Axygp4k0zxI
	UUw0eVtJDuOEL0HpbG78TGe6oWUsKAoT3BbuLw6/1+uX/+EMCRBq3a1inbf2O046lXqG/dlpOd5
	HU0lgLus0AgMam7gic=
X-Received: by 2002:a05:600d:848c:20b0:485:4133:4021 with SMTP id 5b1f17b1804b1-489013bd634mr1545925e9.7.1776688358586;
        Mon, 20 Apr 2026 05:32:38 -0700 (PDT)
Received: from google.com (117.15.199.104.bc.googleusercontent.com. [104.199.15.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm26265240f8f.14.2026.04.20.05.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:32:38 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:32:32 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <aeYbdmshGZJ4GhXd@google.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417175759.3191279-5-yeoreum.yun@arm.com>

On Fri, Apr 17, 2026 at 06:57:59PM +0100, Yeoreum Yun wrote:

Hello Yeoreum,


> When pKVM is enabled, the FF-A driver must be initialized after pKVM.
> Otherwise, pKVM cannot negotiate the FF-A version or
> obtain RX/TX buffer information, leading to failures in FF-A calls.

At the moment this already happens after you move back ffa_init() to
device_initcall().

> 
> During FF-A driver initialization, check whether pKVM has been initialized.
> If not, defer probing of the FF-A driver.
> 

I don't think you need to add this dependency. pKVM is
installed through KVM's module_init() which ends up calling hyp_ffa_init() to
do the proxy initialization. The ARM-FFA driver comes after it (since
pKVM is arch specific code). We don't have to call finalize_pkvm(..) to
be able to handle smc(FF-A) calls in the hyp-proxy.

> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/kvm/arm.c              |  1 +
>  drivers/firmware/arm_ffa/driver.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 410ffd41fd73..0f517b1c05cd 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -119,6 +119,7 @@ bool is_kvm_arm_initialised(void)
>  {
>  	return kvm_arm_initialised;
>  }
> +EXPORT_SYMBOL(is_kvm_arm_initialised);
> 
>  int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
>  {
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 02c76ac1570b..2647d6554afd 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -42,6 +42,8 @@
>  #include <linux/uuid.h>
>  #include <linux/xarray.h>
> 
> +#include <asm/virt.h>
> +
>  #include "common.h"
> 
>  #define FFA_DRIVER_VERSION	FFA_VERSION_1_2
> @@ -2035,6 +2037,16 @@ static int __init ffa_init(void)
>  	u32 buf_sz;
>  	size_t rxtx_bufsz = SZ_4K;
> 
> +	/*
> +	 * When pKVM is enabled, the FF-A driver must be initialized
> +	 * after pKVM initialization. Otherwise, pKVM cannot negotiate
> +	 * the FF-A version or obtain RX/TX buffer information,
> +	 * which leads to failures in FF-A calls.
> +	 */
> +	if (IS_ENABLED(CONFIG_KVM) && is_protected_kvm_enabled() &&
> +	    !is_kvm_arm_initialised())
> +		return -EPROBE_DEFER;
> +
>  	ret = ffa_transport_init(&invoke_ffa_fn);
>  	if (ret)
>  		return ret;
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

Thanks,
Sebastian
