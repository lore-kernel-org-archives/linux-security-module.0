Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806700;
	b=jOFqsTXrynbg6svmeTOZwAxLW8Rq4YFcujAQwwRgubeNEM0ySVW/F8MULQFtHgP10H5Q
	 NQBqSrgg9I2c8DProaiS6S1RiLQnQZKHFA3CvS/NXCieqO/CKUcyIzRId9/6uS04B/jjR
	 6Bb11rF/eFFUQK8jG1xAN74YXv0QrOZdcyd4rOy3Ermu9NP5C+cEEjkNIGtDy0pSHaxBl
	 /ErRdcSasuMNn+lKv1Dgdl26F9iGvZ/Q9YoLRI3rWIzQcUHxD5eqKpc52GnpaT+T1U1lu
	 AVpGqy1sXNufjXUggb2/Ti51Roo3HOUiIbgL7YEW6bnfcuQ0Xctx1TdynubpN4kdADA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806700;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Z5ynsES00wYEUeedNs4jtHwgichiF18CXZfx/XgmedE=;
	b=r+/DuHMKjloSb5uxgAYP5A4J6+oTKHIKD3LBv0bQtmmI8ZCz4Yh3/MF7vcYENYpV1SZy
	 Hv42uU2ulUPZ4p0LsJDf7csJ6HHIx7gAfAAUGTPUUnh7OE6gcLkTrc+kRN+S5s4Aeh7oa
	 cdvUR7EDFkjxl3W84kXLRLHQU7UwgqawlWTXq53VmsJafEY7j8SqZmkyUFtLOQ0bkL6Kb
	 6Sii9X5EWwI3qOKO8xQlC8vG5lSCZm7iUit/Sq5baVeR21j6mBnKXfNSluGKjen0yW6GY
	 hJo1nA+FOBVuxamu3kvHAhcgF/55haFBd0mWOj6R05t8XuJKzKZ1IRPMl4n9mbMuaQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=K2lPE9jj;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23AA606A31E;
	Fri, 27 Nov 2026 19:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A23AA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=K2lPE9jj
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E15231575;
	Fri, 27 Nov 2026 11:11:35 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A401D3F632;
	Fri, 27 Nov 2026 11:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795806698; bh=JdKubajU0Ssw7SHvFWHr6lht5z3s8WLxzysColAW2jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2lPE9jjBra7em4MB8/Ba7uuYvZTFFBbnH4UkDOCn1jPrFuqN3NaedvG0f/iA14t5
	 xSTGOJ9TEbVyFbPWAeSUnykq0ZzhaZ+Bf+Cq9VG6RmPP0KLVBuGoaqb8VE0VjuJN9h
	 hFEpZ8z1UdOYcFrBpKGNplVRM5wbCItZIUnvUIrE=
Date: Fri, 27 Nov 2026 19:11:33 +0000
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
Message-ID: <awnV5S703Rgf5sh5@e129823.arm.com>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
 <20261127170722.GT246011@ziepe.ca>
 <awnK2c3kMq8p2a_7@e129823.arm.com>
 <20261127183550.GV246011@ziepe.ca>
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
In-Reply-To: <20261127183550.GV246011@ziepe.ca>

> On Fri, Nov 27, 2026 at 06:24:25PM +0000, Yeoreum Yun wrote:
> > > > +static const struct attestation_evidence_format cca_attestation_token_formats[] = {
> > > > +	{ .vendor = true, .value = CTLV_ATTESTATION_CCA_GUEST_EVIDENCE_VENDOR_FORMAT_CCA_ATTESTATION_TOKEN },
> > > > +};
> > > 
> > > should be the generic EAT token type
> > 
> > Is there?
> 
> That's the idea. TDX uses EAT as well.
> 
> > but the content seems to be different according to vendor, So would
> > it be better to keep it as vendor type format?
> 
> EAT is intended to be self describing, so if you parse the EAT then
> you should understand what the vendor and content is.
> 
> Knowing the EAT came from RMM won't even tell you which ARM profile
> version it follows, so I'm feeling like maybe we just need to tell
> userspace it is an EAT and then userspace can parse it deeply to learn
> exactly what it is??

Okay. might this would be applied in the FIRME too for PAT once the
attestation patchset is updated.
> 
> > > What is this and the related work? That isn't making sense to
> > > me. If the token size is not absolutely fixed when the driver starts
> > > then it should be fully dynamic and this just streams the variable
> > > sized token.
> > > 
> > > Ideally directly into user memory so we don't need to allocate a kvmalloc.
> > 
> > In case of live-activation. I think in that case CCA-Realm token could be
> > different by activating the new RMM.
> 
> Then the size isn't static and you need to just stream it to userspace
> whatever you have.
> 
> I'm expecting these unsized tokens to work by streaming them into a
> memfd so that userspace doesn't have to try to guess how much space is
> required.
> 
> I also think it is pretty broken if LFA is changing the token for
> realms that are already running. How is that even going to work with
> an RSI API like that gets the length then tries to fetch into the
> allocated buffer? Token silently truncates? You need to loop?

I think the problem is the *max-token-size* could be changed.
once the LFA updates the Realm definitely the contents of hash of
firmware binary can be changed. this means the token's content could be
change including the *max-token-size*.

For this, the RSI host call interface has the way to get LFA eventlog.
IOW, after LFA, there will be LFA log is genreated and then for the
time of re-attestation, it should deliver the LFA logs together.

And userspace to get a token, it'll check the *max-token-size*,
So I think it's enough with virtual address not needing streaming.

IOW, after LFA, the max-token-size can be changed and it should
re-attestat, get new token and sent with LFA eventlog.

> 
> > > This isn't OK.. We only get one struct device per RSI and it gets to
> > > bind to only one driver. Given there are other drivers that will need
> > > to use the RSI, like the TSM and others, this needs some other
> > > solution?
> > 
> > Currently, this attestation driver is enabled when !ARM_CCA_GUEST only
> > (IOW, when this driver can be built only when TSM arm-cca-guest
> > disabled).
> 
> I saw in your FIRME series a solution to this problem, I think that
> would be good to get out on its own and apply it first to RSI as
> well. We will have the core RSI stuff, the realm attestation and TSM
> driver at a minimum..

Hm,, Does this mean do we need to create two device one for TSM and
one for attestation even the functionality same?

-- 
Sincerely,
Yeoreum Yun
