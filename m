Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F10367F23
	for <linux-security-module@vger.kernel.org>; Mon, 20 Apr 2026 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693932; cv=none; b=SNhKkr3JzRHy9l0FsgxZ/81qIUEzYTJLaGa4bwwrU4ve+GkwC+C+3wTB8j8eXq6zLS5U0S3/L7YpqSntavWY8kpES5DSUsun1PjYHwFWg9OFm1vtEU4aDfmeMC80xibL0v0g/zzGBS/+SJfZ25HrcXD39iELwKF2+ejd3g2eQk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693932; c=relaxed/simple;
	bh=S2UHySE5XaH78WLFRWMsAh1zPx/419Y8+b7A7jvMIso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpDEXWZd9ZCM3D5FvG3Vexf2G8HXd2ijMiLQqWMR56CBkoDBpYUZx1Z/0SejoN05/LrawIon9GEBzwSPo2BGSrJ4LCgz5r4tv6SWuYgaWM89s/KPnHplC4NJstIj48KuWQkkhO4pmT8ylbZGJoK9eBAtR6juXQLXfIjV7qBnyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jpRPRMjH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpRPRMjH"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so94545e9.1
        for <linux-security-module@vger.kernel.org>; Mon, 20 Apr 2026 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776693929; x=1777298729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6q3FLtE0M6J2F/PfEuR3infOq1/jMGGhvYKqZy6+Xo=;
        b=jpRPRMjHZUWtLs22Mst1yPkC+bUQjpabQhJWVCAuxIuKc0dk1lIsRTjB+x5hYAhuJg
         enh9Nuiz4wTXeTAWGFbx3Kqecg8J5jTRiwEsBUGY6pybFi5fmtwfiUeTwZeKIu16LmPw
         01DjWMRq/q3wgxB+FPUrlX8A2Chz3PsDWfc7p6ioNrbjOvLYgZTyOatQTJg7R6Nf0NfJ
         g+fyDY223BvMsw7QsPTXcm/ugGHun2dYqJXikP+AKMr4722Occ3u0Kw46njjpA6wpJzD
         2rSMzz3ag89VvwixjwxCKTObuCEQ4fq/hyT7JscRmclbYgQOSG4m1eo0vYz4j5N8bve9
         edrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693929; x=1777298729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6q3FLtE0M6J2F/PfEuR3infOq1/jMGGhvYKqZy6+Xo=;
        b=mvmCP407WjjZoCwXmUy5rXrI+aI8VcLv3WaO38eUNyPzLJZ7ewTYCb87nJdXm8A+Yg
         +xtnPVq3Szy0EpQJkaFndMeBtbZAZN3OfrPYt3hczg+sFDwLVyo+/GJafuXsEWLPFNBh
         5lxuAYEKcFqFznR1dIdhE57psdEe72LPCBPajtYRl9K7to/OmZg3GIySZzuUb5/TbYVJ
         Wj9zIaewo9ayvodY+dn2hN/A9W9C6pVXg4eX6EuF7yCX1o6D0IYScwAehBL+BMGEVUW3
         JmJY9jNd8J/2dYmxZYlvVyG1IRJQ2eeo+kStMC940FsJ3kg604UwiSCuHy7+DK1UojSE
         pScQ==
X-Gm-Message-State: AOJu0YzgN1l9OE04R5NcKjMTM4eSOF2eDaheAMl2J/NbnJX+G4aWtEbD
	mrWX2gikvEWqVkdMMaSE8v0GxlGhGDddYLkhrvWdTS89UdRQhtBTOj3Mhn6eKuA3Ww==
X-Gm-Gg: AeBDies+iHLihJYxVEStzTN9kCqHk3RftM5br+2u7i3zLO2lxUE0TeUFrDuyFNPfDYo
	4mJ1pA4QKCZJfoSicZHlQ/ae6qXQomtfQTc4UP+TXE8nmBhx/0izC32Hf89a5G2A0q28i1QDgud
	4EgIkvY4XbPQTtS6i19peod1OaEr1ZdyHOVDY0Omp0uXMitsdhA/XON0aTtWrKep5gq814PX+TT
	oGvgHvMIwkQGpNmEllzEzfgaqFcBv8BqF0R2ax+3TAnSKpZX6KllEgxTUhumcIXRhzawygenpu3
	/G8w3ypsBpwOquk7oRaFn6kaebJM/syNMWl5WaQA/ASVzYSjkiJvv3aSjKuugHwOyyoGL4JaLzw
	0RTOEYIDU7/M37LelCCK79+vZmQU0CTHeqwpg6HY+zB0LL95itgJLuQZSIKq3cSPNT3/spSWIms
	zJ//IuoWXl3qm7B1uX6zaMAxOBSGYb9jlfWlrOz+bBJq1nU2cbDe0u+8avebrK936/EQRlouxoF
	XWtPk3a/LnowxH8Tso=
X-Received: by 2002:a05:600c:55cc:b0:475:d905:9f12 with SMTP id 5b1f17b1804b1-4890095cc81mr2067335e9.4.1776693929074;
        Mon, 20 Apr 2026 07:05:29 -0700 (PDT)
Received: from google.com (117.15.199.104.bc.googleusercontent.com. [104.199.15.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a341sm32798494f8f.24.2026.04.20.07.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:05:28 -0700 (PDT)
Date: Mon, 20 Apr 2026 14:05:24 +0000
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
Message-ID: <aeYypF4lv6LMH2ch@google.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <aeYbdmshGZJ4GhXd@google.com>
 <aeYjiaPtAl7SMVkL@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeYjiaPtAl7SMVkL@e129823.arm.com>

On Mon, Apr 20, 2026 at 02:00:57PM +0100, Yeoreum Yun wrote:

Hi,

> 
> Hi Sebastian,
> > On Fri, Apr 17, 2026 at 06:57:59PM +0100, Yeoreum Yun wrote:
> >
> > Hello Yeoreum,
> >
> >
> > > When pKVM is enabled, the FF-A driver must be initialized after pKVM.
> > > Otherwise, pKVM cannot negotiate the FF-A version or
> > > obtain RX/TX buffer information, leading to failures in FF-A calls.
> >
> > At the moment this already happens after you move back ffa_init() to
> > device_initcall().
> 
> How? the kvm_arm_init() is device_initcall() if both built as built-in.
> 
> >
> > >
> > > During FF-A driver initialization, check whether pKVM has been initialized.
> > > If not, defer probing of the FF-A driver.
> > >
> >
> > I don't think you need to add this dependency. pKVM is
> > installed through KVM's module_init() which ends up calling hyp_ffa_init() to
> > do the proxy initialization. The ARM-FFA driver comes after it (since
> > pKVM is arch specific code). We don't have to call finalize_pkvm(..) to
> > be able to handle smc(FF-A) calls in the hyp-proxy.
> >
> 
> As Marc said, the before finalised_pkvm(), smc wouldn't be trapped
> to pKVM. IOW, in case when both built as built-in,

They are, I tested before replying to this thread. The HCR_EL2 is
0x480080000 so HCR_EL2 TSC bit is set so SMC/FF-A and trapping is enabled.

In __pkvm_prot_finalize it sets the HCR_VM bit which enables stage-2 and
then write the HCR_EL2 from params->hcr_el2. However I wasn't sure that
this is seen as a 'hack' and not expected to work.

> if ffa_init() is called before finalised_pkvm(),
> it couldn't proxy the FFA_VERSION, FFA_RXTX_MAP and FFA_PARTITION_INFO_GET
> called by ffa_init().
> 
> How can you gurantee hyp_ffa_init() which is called by kvm_arm_init()
> comes first even kvm_arm_init() and ffa_init() are on device_initcall?
> 

While they are both on device_initcall, the only difference is that
kvm_arm_init is arch code which appears before the driver/ code in the
linker. That's why Marc said it is not a solid construct to rely on
this. 


Thanks,
Sebastian 

> [...]
> 
> Thanks
> 
> 
> --
> Sincerely,
> Yeoreum Yun
