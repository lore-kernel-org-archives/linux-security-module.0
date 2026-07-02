Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC3030C608;
	Thu,  2 Jul 2026 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021362; cv=none; b=FXF3R+f8L+rxdk1VVD00gDtD1sf0oAheAuOKOnz4gYaCr2BB8P+1qshFaJVkEGt30LNLhWhM7RfMWEApT+FJu19MFu/HsXARvsw+FjWBhnF0bvxvp5CSk+IU/bOxwn+HlYV7gNg+8O7ftKnlIrdXXm3WHAX5xrz6uchzirGZe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021362; c=relaxed/simple;
	bh=kT0tIHMWqxXgzZIfh9uQOG2m1Rut4BdoukkXoBlncog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klGkU6i5kcsqwRjm6EjxzBa/yqS6/p7Jndb69NWssT849Juwmi1YP7IFdiIqCLQfJUoabCbP7HHA9jHbOPoA40zGUD5sNjZWalLgY+v34UQ/0C3iizvue1VxdxhVffenlx3m0aaYvXUUiiV2YQgCFWs7MwsM/PYYnBN4zMDmWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FOgVA7ou; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FOgVA7ou"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9498235B7;
	Thu,  2 Jul 2026 12:42:33 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A2613F673;
	Thu,  2 Jul 2026 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783021357; bh=kT0tIHMWqxXgzZIfh9uQOG2m1Rut4BdoukkXoBlncog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FOgVA7ouFZU5z7hl5mRbCT24IkkXAO3iUj2seTOlK0EdJ1eHCIfYCZfv+M9Mv+jKM
	 Zi5CoWU/9usEzMUiA35mrSpLUAMLM5Vc3mPPyof1tCXjWuiZs6RXIgvDC77tlRO1cq
	 iimWvkzShCktMP4kpotLa3OwMQ/c4/Ja25w6nouc=
Date: Thu, 2 Jul 2026 20:42:32 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	roberto.sassu@huaweicloud.com, noodles@earth.li, jarkko@kernel.org,
	sudeep.holla@kernel.org, jmorris@namei.org, serge@hallyn.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v6 1/4] security: lsm: allow LSMs to register for
 late_initcall_sync init
Message-ID: <aka_KCX4ogBy2Zuk@e129823.arm.com>
References: <20260605144325.434436-1-yeoreum.yun@arm.com>
 <20260605144325.434436-2-yeoreum.yun@arm.com>
 <CAHC9VhQXwXHjKcr0SRNQyzKZgCwG1RLPT6kWDLLwEKExfXzzOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQXwXHjKcr0SRNQyzKZgCwG1RLPT6kWDLLwEKExfXzzOw@mail.gmail.com>

> On Fri, Jun 5, 2026 at 10:43 AM Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > There are situations where LSMs have dependencies that might mean they
> > want to be initialised later in the boot process, to ensure those
> > dependencies are available. In particular there are some TPM setups (Arm
> > FF-A devices, SPI attached TPMs) required by IMA which are not
> > guaranteed to be initialised for regular initcall_late.
> >
> > Add an initcall_late_sync option that can be used in these situations.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  include/linux/lsm_hooks.h |  2 ++
> >  security/lsm_init.c       | 13 +++++++++++--
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> Looks good to me, thanks for working on sorting this out.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks!

> 
> -- 
> paul-moore.com

-- 
Sincerely,
Yeoreum Yun
