Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806788;
	b=v7LRs8togadOhAVZjACtTVe3qpAlLnYnRBjUP0co8YLBPDTLgoyRhCKGiS2I5WE/8R72
	 7On5ysl91Tlx9hGRTm8jMTC2NuOQQkwUJtA7BhiyChfIEApjXJFQsxjWjhoN6Pf6hUcv8
	 w0tvZRVBrgUsLmsrbtkbpDLQnhrhdGnCsxehEk55x9IXW7bO619nDg9HuB5CUZ7Va+7+7
	 jjBcsKTN92rbM6cFPzCmN2+StBN5KJSY8FSzOxxWHgivM2Ry0JwL/gsttuFs0kKppzKLq
	 LzsRlHVaeGhFHqKkZUtHHsXMC9tWp0xFnU38Qw7VR9ySTvZk+yO/QtOGptDczh9u8Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806788;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=50QoXqpR5FtrwpAxWMllbEmdzpXvDytEkAHS/WeJp9w=;
	b=nJSAu1Rpr71Ya7P2e+ptd2ixasSKgZ4/4M+SviRY73VnOgfpgH+PyntM01zOFzi1A081
	 5gi2gTb3knmqa0VG82wcWBk65QmIK1meHU7IDd1vsE0UMAlcpRlEZo5V/lg8t7Q1syLFN
	 rtjfSGWGkl6NOeoglkuYz8oYX9obbB1rFcFwJ9srEU7jsDvrpklUZnlOZc2CRA3gMCYZk
	 L5+jAR3PNS2+tWbXFiJwDhsBZ1wfCb0KYJVi6m5ArC309RQuaohxGaC+35mdca8d81z4h
	 uSo8p96sz4ohoztx33vWKd8olGsLx/Fk4HmKV+11CpeEJLXPihEDm4RweOgUtvRTA8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bKotXA5Q;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8AE606A31E;
	Fri, 27 Nov 2026 19:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A8AE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bKotXA5Q
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C53E51575;
	Fri, 27 Nov 2026 11:13:04 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C6893F86F;
	Fri, 27 Nov 2026 11:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795806787; bh=Ptl2bXxMS7xhqgjXz9U4vKg515vAt7k3LH7ePZtgvo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKotXA5QgZjSJReV2swYQU/C2RO7PmpFn7BRjcuBNqWFaKCwuP4hbDKrmsPOvIIwn
	 aZwmWDyDO6UBQX8IrtnihOYwuQOtHr88uwt/UvMOc6ohDDIFL6IkidwixdmSs7ymGp
	 q4w+d48eDHFBmtFt403dFxzDN9I1sGv9/ZDAmPlo=
Date: Fri, 27 Nov 2026 19:13:01 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>, thuth@redhat.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 7/8] attestation: providers: introduce CCA Guest
 attestation provider
Message-ID: <awnWPfTFyFUDkDrV@e129823.arm.com>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
 <20261127170722.GT246011@ziepe.ca>
 <awnK2c3kMq8p2a_7@e129823.arm.com>
 <20261127183550.GV246011@ziepe.ca>
 <awnV5S703Rgf5sh5@e129823.arm.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awnV5S703Rgf5sh5@e129823.arm.com>

On Fri, Nov 27, 2026 at 07:11:33PM +0000, Yeoreum Yun wrote:
> > On Fri, Nov 27, 2026 at 06:24:25PM +0000, Yeoreum Yun wrote:
> > > > > +static const struct attestation_evidence_format cca_attestation_token_formats[] = {
> > > > > +	{ .vendor = true, .value = CTLV_ATTESTATION_CCA_GUEST_EVIDENCE_VENDOR_FORMAT_CCA_ATTESTATION_TOKEN },
> > > > > +};
> > > > 
> > > > should be the generic EAT token type
> > > 
> > > Is there?
> > 
> > That's the idea. TDX uses EAT as well.
> > 
> > > but the content seems to be different according to vendor, So would
> > > it be better to keep it as vendor type format?
> > 
> > EAT is intended to be self describing, so if you parse the EAT then
> > you should understand what the vendor and content is.
> > 
> > Knowing the EAT came from RMM won't even tell you which ARM profile
> > version it follows, so I'm feeling like maybe we just need to tell
> > userspace it is an EAT and then userspace can parse it deeply to learn
> > exactly what it is??
> 
> Okay. might this would be applied in the FIRME too for PAT once the
> attestation patchset is updated.
> > 
> > > > What is this and the related work? That isn't making sense to
> > > > me. If the token size is not absolutely fixed when the driver starts
> > > > then it should be fully dynamic and this just streams the variable
> > > > sized token.
> > > > 
> > > > Ideally directly into user memory so we don't need to allocate a kvmalloc.
> > > 
> > > In case of live-activation. I think in that case CCA-Realm token could be
> > > different by activating the new RMM.
> > 
> > Then the size isn't static and you need to just stream it to userspace
> > whatever you have.
> > 
> > I'm expecting these unsized tokens to work by streaming them into a
> > memfd so that userspace doesn't have to try to guess how much space is
> > required.
> > 
> > I also think it is pretty broken if LFA is changing the token for
> > realms that are already running. How is that even going to work with
> > an RSI API like that gets the length then tries to fetch into the
> > allocated buffer? Token silently truncates? You need to loop?
> 
> I think the problem is the *max-token-size* could be changed.
> once the LFA updates the Realm definitely the contents of hash of
> firmware binary can be changed. this means the token's content could be
> change including the *max-token-size*.
> 
> For this, the RSI host call interface has the way to get LFA eventlog.
> IOW, after LFA, there will be LFA log is genreated and then for the
> time of re-attestation, it should deliver the LFA logs together.
> 
> And userspace to get a token, it'll check the *max-token-size*,
> So I think it's enough with virtual address not needing streaming.
> 
> IOW, after LFA, the max-token-size can be changed and it should
> re-attestat, get new token and sent with LFA eventlog.

But, currently the LFA eventlog spec quite ambiguous for LFA eventlog.
So, It could be discussed later and for this RFC i think dropping this
is enough.

-- 
Sincerely,
Yeoreum Yun
