Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803872;
	b=FM4KQPkScydFIjXoW7XShIp7EXjv80juV2KHOk2PhYESfY+4mnX8GCgTP4JCBh/JyjQD
	 1kIsGKsjEfKycLMYdrrhAARjk/qcLjbeW4nCg45Gdtz4JHm3keanYK/lqHmK8o/GKq2xo
	 T1Kk43v8ZX7QMBUL634S69vg7KZ9YKDZQBTN62O21vsRMIv/oqy404muEe0U8EHU4yeyT
	 PpAShQJx4gS/tU0YAtJQyfvkCmJBCZE2bpcuF/jXpCWukq6PsPI5f/xk7KdKQtXs2zViu
	 oil32/nG2g7lHcsT0mxBVrfEfe1BAaJDOuq3F5HQHr6LK5KBnC90nqxE2waCEqiyUXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803872;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nPX0jKAZGslc2s414W7GnzS0L4XLdhKncic17g8wWB8=;
	b=SUxYQ0DqimXWzN0jgMwvmfl+J/IGrFlloIx4PAbNCG8X9V/Wt/+/dyIS5K0C3LCaO7Si
	 NbyoCaLlBPxH3cuD3uxSVxubS0Y86O0EkLUEAGEsnzoRPcXqrgugJ450by5p6c0G44QEI
	 pakJYk//IHvqn4V8dJLEcwh+2jKjVnhcmxzr8bdEAhHQs/TsOEzsxydzyLGkt/0nVuulp
	 5KwlhxNIlQwXdfhVR9Fu5VGNL/A72V+z4OMRCIipOt7tNmwtqpCKx0r6cdvUmaYly/no9
	 xkYr/0tpadJm7gMXBL/sedeXgZ8bH5b/krolEwZo3LM7UNg1dEtAdn9gVmrlDt+zJQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LBSQKh+U;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678ED606A31C;
	Fri, 27 Nov 2026 18:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 678ED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LBSQKh+U
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F1A51575;
	Fri, 27 Nov 2026 10:24:28 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 957C33F86C;
	Fri, 27 Nov 2026 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795803871; bh=tLEGXyc06QuVymTp9AwMRLhn4C3VvPR79JGgV7rqNd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBSQKh+UnuZvEmzVBMoqvxhxLlX4y9VCVIQ06t73ABXPt10R9qy/X5Y6ugaS7NPOo
	 d1AuoDSzKGcEpaQ259M2A/qNGnaky9MIv0reMcaXWdUmoiyfRYZaurw1lOYjN/TUTF
	 DBomwlpBErcMcNrZvxnSsO5JZUxKZNTysnK2dpM0=
Date: Fri, 27 Nov 2026 18:24:25 +0000
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
Message-ID: <awnK2c3kMq8p2a_7@e129823.arm.com>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
 <20261127170722.GT246011@ziepe.ca>
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
In-Reply-To: <20261127170722.GT246011@ziepe.ca>

Hi Jason,

[...]

> Similarly the TCG log should work the same way.
> 
> I'm also wondering if too much code is leaking into to drivers to
> implement the uAPI. We should take a look at this vs the TDX one and
> make sure we have the right level of helpers and abstraction.
>
> I also can't help but notice there isn't a single comment in any of
> this, it should be a bit more descriptive why some of these things are
> in here.

Okay. might next around, try to add comments.

> > +
> > +static const struct attestation_evidence_format cca_attestation_token_formats[] = {
> > +	{ .vendor = true, .value = CTLV_ATTESTATION_CCA_GUEST_EVIDENCE_VENDOR_FORMAT_CCA_ATTESTATION_TOKEN },
> > +};
> 
> should be the generic EAT token type

Is there? but the content seems to be different according to vendor,
So would it be better to keep it as vendor type format?

[...]

> > +static long cca_guest_get_max_token_size(void)
> > +{
> > +	u8 dummy[RSI_ATTEST_CHALLENGE_MAX_SIZE] = { 0x00, };
> > +
> > +	return rsi_attestation_token_init(dummy, RSI_ATTEST_CHALLENGE_MAX_SIZE);
> > +}
> > +
> > +static int cca_guest_get_attest_tokens(const struct cca_guest_attestation *cca_guest_att,
> > +				       const void *challenge, size_t challenge_size,
> > +				       u8 *token, size_t *token_size)
> > +{
> > +	int ret;
> > +	long max_token_size;
> > +	void *buf;
> > +	unsigned long granule, offset, len, rsi_ret;
> > +
> > +	guard(migrate)();
> > +
> > +	max_token_size = rsi_attestation_token_init(challenge, challenge_size);
> > +	if (max_token_size <= 0)
> > +		return -EINVAL;
> > +
> > +	if (max_token_size != cca_guest_att->max_token_size)
> > +		return -ESTALE;
> 
> What is this and the related work? That isn't making sense to
> me. If the token size is not absolutely fixed when the driver starts
> then it should be fully dynamic and this just streams the variable
> sized token.
> 
> Ideally directly into user memory so we don't need to allocate a kvmalloc.

In case of live-activation. I think in that case CCA-Realm token could be
different by activating the new RMM.
But, in this round might we can drop this part.

[...]

> 
> > +static const struct arm_smccc_device_id cca_guest_attest_id_table[] = {
> > +	{ .func_id = SMC_RSI_ABI_VERSION, },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(arm_smccc, cca_guest_attest_id_table);
> 
> This isn't OK.. We only get one struct device per RSI and it gets to
> bind to only one driver. Given there are other drivers that will need
> to use the RSI, like the TSM and others, this needs some other
> solution?

Currently, this attestation driver is enabled when !ARM_CCA_GUEST only
(IOW, when this driver can be built only when TSM arm-cca-guest
disabled).

-- 
Sincerely,
Yeoreum Yun
