Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808B13B42C7;
	Tue, 13 Oct 2026 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880920; cv=none; b=SAyUFJ5CGQRQZfExllYFKbrI4y5aKksizcZbwP9a0pzEyE866fER8sHbafsXmh46Rn1GdOdqbfoReIodH/0EJs2fUMaQgNudyTisSvY9euLmUwLawyT3ZfZF6nSBSYvl//SxI9dRPiOdY/DgKLovJ/6ZstGo/BNHG+vO7u+ZpAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880920; c=relaxed/simple;
	bh=NI8CmL/lnRoC7aE++YpF7fiq+bAGnCCUDMqbYkmDDew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLLq5FJRA5/x7iyR4SkX3ocsC0RM1sx5yewA5XAgYeWHxORnEf8L7T3LxjVIA0yD0exShE2VpYqk88A0d306lq4ScijplzeaH5ypolXC4CRMYjii+sFvE4IohUJhtRwsuPb+KiZV4NG2pwDA+wLuZo8scIEVFgrus7DF4rn3acU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bZqkt7Lf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bZqkt7Lf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FDCC169C;
	Tue, 13 Oct 2026 01:41:52 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 702B53F66F;
	Tue, 13 Oct 2026 01:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791880915; bh=NI8CmL/lnRoC7aE++YpF7fiq+bAGnCCUDMqbYkmDDew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZqkt7LfHhgrP+LpLkfSWkgVJSZiTZFy4lKziZu5iR37k9EFAy02+ty8P4ISH7oZJ
	 KekFmta7QOPeZeaIU4GpQdPFpSIaN4Jm43CjCrlwnAe9zBdYufWXPGSmiCV/ITKyn4
	 5OZk62xDJBVPfh1/7axdbnw2G3tJM7jWkrMYzZEU=
Date: Tue, 13 Oct 2026 09:41:49 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: GONG Ruiqi <gongruiqi1@huawei.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Dan Williams <djbw@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH RFC 0/3] security: ima: support TSM measurement registers
Message-ID: <as3uzQ7L6tJ-Lu-Q@e129823.arm.com>
References: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
 <ebe68f6463f8ece8a5cd8ce70bba292ec4f64a41.camel@huaweicloud.com>
 <c4fe5315d70fc162f1e5648e3fccb1676710d5e6.camel@huaweicloud.com>
 <ar5tOUor0bp3MtQ6@e129823.arm.com>
 <9e74ff9d-e8a3-425e-bf7c-f973d06e6cdf@huawei.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e74ff9d-e8a3-425e-bf7c-f973d06e6cdf@huawei.com>

> On 10/1/2026 10:24 PM, Yeoreum Yun wrote:
> > Hi Roberto,
> > 
> >> On Thu, 2026-10-01 at 13:27 +0200, Roberto Sassu wrote:
> >>> On Wed, 2026-09-30 at 14:43 +0100, Yeoreum Yun wrote:
> >>>> Confidential computing guests without a TPM can use TSM measurement
> >>>> registers to record IMA measurement digests instead of TPM PCRs.
> >>
> >> + Gong Ruiqi, of course.
> >>
> >> Roberto
> 
> Hi Roberto,
> 
> Thank you for involving me!
> 
> >>
> >>> Hi Yeoreum
> >>>
> >>> a similar patch set has been sent to the linux-integrity mailing list:
> >>>
> >>> https://lore.kernel.org/linux-integrity/20250630125928.765285-1-gongruiqi1@huawei.com/
> >>>
> >>> Could you please work with Gong Ruiqi to have a unified proposal?
> >>>
> >>> Thanks
> >>>
> >>> Roberto
> >>>
> > 
> > Thanks for letting me know and I think the proposal is almost the same
> > with the different terminology only.
> > 
> > @Gong, what do you think?
> 
> Hi Yeoreum,
> 
> Nice to see this topic picked up again — I'm glad the IMA RoT framework
> series I posted last year is still of interest.
> 
> Yes, I'd be happy to work with you on a unified proposal. It's been a
> while since I last worked on that series, so I'll first revisit my
> previous patch set, and then follow up with you to discuss the code details.
> 
> Looking forward to working with you.
> 
> BR,
> Ruiqi

Hi Ruiqi :)

Thanks for replying and I'm happy with you too.
However, I think we need to rework based on the Jiri's patch [0].

Any thought?

Link: [0] https://github.com/jpirko/linux_mlxsw/tree/wip_attestation_pre_rfc_draft1 


-- 
Sincerely,
Yeoreum Yun
