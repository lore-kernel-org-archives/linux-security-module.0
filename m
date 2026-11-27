Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799245;
	b=aKk6XvL3poyHFBB/AKlVlsPMqfZTyjUnTAR6uRQXnKgxpsHtheSJoSyeT8odqtrvMeE6
	 wxJRU7XLSnoT6t3f/EjF2Cjs9dH+s9CErFqC08Q5K/LiO4MfRcVZrJqea+eTj1+27YwKU
	 tBSiZ/JQGunHVfDdvKUh7fMTa0Z/N4qCMX0l1knZxfh2Mwau3UmTkhrdaB0vUjOEW8M1V
	 hZK9T3taBIUJRi5E/qXuwG7HNbaRbVwojr7npdCJHWRFcYGd8CNaxJLGJoabeDyzLTq9H
	 D7LLCK30lYqhYunGWRcvT85+U2/y20E4cJjXC85ptXWZG1VEZHlNb3oMBl3KQGZXkgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=iIDdrX9Im0YtrcnZJ8KtkgD4n/tK93wVoTEyhvvYAHU=;
	b=URp7wM0ZaLMvVNjyI+THwEngdpBtlvnkSGt71IyeK0nvgVjoUHLpVKeBx0+5ejT2qc3L
	 iCSCTURKkK3I80ruY71OEonTLuctyKetjoZ8ya58Y1d9LiEnFHIMVpI4hX/t2V8yPD0S2
	 UftR/caq/s1NQtb06KXc6y+fWv90oyK2j/L/pFkZSCVgaVzvNg/3a9Df7W40/irktGBr6
	 UPeO1tXBxVPu9NdtyPp7rw8giLXrxoaLElTdKaMP0yEt+OKCuWKcqctziA7kPXbAORUXW
	 jPXjOL6i66t6KQw3HjQaagGEysabyfNA6rLLKd+FmljuB26JHShAPCo3riDpluWzdNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hLpAPOWR;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D37606A324
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 17:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D37606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hLpAPOWR
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-55db674106fso33367851cf.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 09:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795799244; x=1796404044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iIDdrX9Im0YtrcnZJ8KtkgD4n/tK93wVoTEyhvvYAHU=;
        b=hLpAPOWRY7vTqoqj/VpAI3MIy/Dx8pPyh+PJKOuSfIcD254Kk/4gkRx3B2QyxSqbwp
         fSdzCyryN+vNUIa0tkYGg6M1xAaezMYdTW9co5HGl80FeMoyGjN2wXNcf32K9XKYm2HB
         gTEnzSjwz6Q0JhUNUoiqfDaPs617ZtzxVvpdee3ATRz9OIjqPuAzY5bUEQaX0Rg61YWN
         2NH/p2cucwDNSxXN1mXjxEj+OoVaSDtXHWj22NeH/QgwylG2TIuj5Y0KTcMDZxrLqjba
         K47jaNvOunsnzH0hBIkqJedgONyAnXTMLvQ9H/TGcfrRjPXzSdjuVpbwgVsmDB8Td5lo
         Ep8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795799244; x=1796404044;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iIDdrX9Im0YtrcnZJ8KtkgD4n/tK93wVoTEyhvvYAHU=;
        b=oCIQjsZf+W33ceGqkXTkfVFRSxmS/OfJrcWtig59JA2jMJlO5tFg43jrMTekTv7dsr
         Ci89uw4V/lJd4H2SnA2Zh3o9wgUkJpQde8Avt6nDq49x5ymAg2zbgt1MPilQ7oPhjVdt
         jCbpKGvxBR1HCenacfbqkv8EbG51hmBb0CGD9dLm8KzxdE2rjJi5GBh1JEfR+o6g8GtO
         11EYzqg4/3W8rC19Q9YZ8WaIRCJWGMyhbHTW2TMRtUzv3XmVSDgOeccS0DAw+pamJrvB
         szL82oZuzs+gIzYj0BY5B9DJb1lmyLeVkuKZp62Q4oxHKRkTbhHsFmcCakp4TGloimIL
         P8yw==
X-Forwarded-Encrypted: i=1; AL+hErGMPLTXSZtcmREIyQT8oENipaBmjHOj8/rJ0KoOSjpVreVJMW5560b+TROtkyyCAI9JxbsAq8m3Y4a94b/SMZ4SXI31YWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VxgwmAJYHwNeqpF60JyewBbZOfkvfXwIS9roecaAqbNLFyLVY
	x8ijuusrkV22wv5MHoo+S7+GlBoSdcFZhNc1tfJpSHyFpiGmFBANhO5YK5kobm90DUg=
X-Gm-Gg: AZFdTZc0r58nCjkCeSIb66Hzb4mkRGH+iDuBkAvEkW/USpeL195f8Ricb0jc1sCt5/E
	SO2m8yU6c/EU3argzUy8nrpkotFbsrD2Xs7jDNEvj3qWKBvhMoWZ8TTWUr9DQGI5f6pbAndNlub
	tg98rVSBtJqZUg/7rNJ8isd/JkJP8C7GcdnusIdg64cSpSGkXLXnPob79pYassMX+l9jk4iKFqQ
	O1rQtA2ziiKh/RPccQ2l3uVbmM7XK3wTkVuvhXxUCqWSzZ5HEqr153UoYqV3CKt/11uqgQVTNQ5
	k4iZQdoD0qx50j/vj5wUSgHRfs7lC6n2T8KF7RfuS6alQF0+ntKNgeung3NsI6T8Ye7wq0dluzp
	526vO21JN0IqqSOn4/yNt9Nj2oLUiRlxCIcy+VHtul30f//lomECikWJYztI5jnIAxapq6Htaxw
	eXuBw1Mh9ab9JBr43ES8CBLAIBMAofidUfZ5ba96WjBD7CURWm0l0DkY5yLaQnnSM968rud3gmV
	LKq2y8rord8q7A6b3L3C6KeZnc2nkEQWvXjeQqLD5XVJrdHUqnH0V9leuETogNULm30+/mw0CbL
	kiD15A==
X-Received: by 2002:a05:622a:400d:b0:536:7f96:915c with SMTP id d75a77b69052e-55d6fbfc5f7mr441942441cf.5.1795799243423;
        Fri, 27 Nov 2026 09:07:23 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882e32dsm214830511cf.13.2026.11.27.09.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:07:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWzPu-000000079Rg-05Sr;
	Fri, 27 Nov 2026 13:07:22 -0400
Date: Fri, 27 Nov 2026 13:07:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
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
Message-ID: <20261127170722.GT246011@ziepe.ca>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
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
In-Reply-To: <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>

On Fri, Nov 27, 2026 at 03:33:02PM +0000, Yeoreum Yun wrote:
> Introduce CCA Realm Guest attestation provider for retrieving:
> 
>   - RIM, REM0-REM3 measurement registers.
>   - CCA attestation token
>   - CCEL event log
> 
> used for CCA Realm Guest attestation.

This is great to see positive proof that the API fits CCA!

> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  drivers/attestation/Kconfig               |  10 +
>  drivers/attestation/Makefile              |   5 +
>  drivers/attestation/providers/cca_guest.c | 582 ++++++++++++++++++++++++++++++
>  3 files changed, 597 insertions(+)

But we need to do alot more work on this to make the drivers slimmer.

First, we need to pull drivers/virt/coco/arm-cca-guest/main.c which is
the evidence part of this driver into drivers/attestation and build
the MR stuff on top of that.

Second, things like CCEL need to be handled by core code. The driver
should only indicate it "claims" the CCEL if the core code happens to
find one. TDX and ARM shouldn't have any direct CCEL stuff beyond
that.

Similarly the TCG log should work the same way.

I'm also wondering if too much code is leaking into to drivers to
implement the uAPI. We should take a look at this vs the TDX one and
make sure we have the right level of helpers and abstraction.

I also can't help but notice there isn't a single comment in any of
this, it should be a bit more descriptive why some of these things are
in here.

> +static enum hash_algo cca_guest_attestation_algorithms[] = {
> +	HASH_ALGO_SHA512,
> +};

static const

> +
> +static const struct attestation_mr_props cca_guest_attestation_mrs[] = {
> +	{
> +		.id = 0,
> +		.name = "rim",
> +		.algorithms = cca_guest_attestation_algorithms,
> +		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
> +	},
> +	{
> +		.id = 1,
> +		.name = "rem0",
> +		.algorithms = cca_guest_attestation_algorithms,
> +		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
> +		.has_register_index = true,
> +		.register_index = 0,
> +		.extendable = true,
> +	},
> +	{
> +		.id = 2,
> +		.name = "rem1",
> +		.algorithms = cca_guest_attestation_algorithms,
> +		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
> +		.has_register_index = true,
> +		.register_index = 1,
> +		.extendable = true,
> +	},
> +	{
> +		.id = 3,
> +		.name = "rem2",
> +		.algorithms = cca_guest_attestation_algorithms,
> +		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
> +		.has_register_index = true,
> +		.register_index = 2,
> +		.extendable = true,
> +	},
> +	{
> +		.id = 4,
> +		.name = "rem3",
> +		.algorithms = cca_guest_attestation_algorithms,
> +		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
> +		.has_register_index = true,
> +		.register_index = 3,
> +		.extendable = true,
> +	},
> +};

Jiri this probably isn't going to scale when we get to 32 PCRs on a
TPM.

> +
> +static const struct attestation_evidence_format cca_attestation_token_formats[] = {
> +	{ .vendor = true, .value = CTLV_ATTESTATION_CCA_GUEST_EVIDENCE_VENDOR_FORMAT_CCA_ATTESTATION_TOKEN },
> +};

should be the generic EAT token type

> +
> +static const struct attestation_evidence_format cca_guest_attestation_log_formats[] = {
> +	{ .value = CTLV_ATTESTATION_EVIDENCE_FORMAT_CCEL },
> +};
> +
> +static const struct attestation_evidence_challenge_length
> +cca_guest_attestation_challenge_lengths[] = {
> +	{ .min = RSI_ATTEST_CHALLENGE_MIN_SIZE, .max = RSI_ATTEST_CHALLENGE_MAX_SIZE },
> +};
> +
> +static struct attestation_evidence_supported_object
> +cca_guest_attestation_evidence_objects[] = {
> +	{
> +		.evidence_class = ATTESTATION_EVIDENCE_SIGNED,
> +		.formats = cca_attestation_token_formats,
> +		.formats_count = ARRAY_SIZE(cca_attestation_token_formats),
> +		.challenge_lengths = cca_guest_attestation_challenge_lengths,
> +		.challenge_lengths_count =
> +			ARRAY_SIZE(cca_guest_attestation_challenge_lengths),
> +		.max_length = 0,
> +		.binds_mrs = true,
> +	},
> +#ifdef CONFIG_ACPI
> +	{
> +		.evidence_class = ATTESTATION_EVIDENCE_EVENT_LOG,
> +		.formats = cca_guest_attestation_log_formats,
> +		.formats_count = ARRAY_SIZE(cca_guest_attestation_log_formats),
> +		.max_length = 0,
> +	},
> +#endif

Jiri, same scaling issue, CCEL should be handled by core code so it
needs to be inserted dynamically into the evidence list.

> +static long cca_guest_get_max_token_size(void)
> +{
> +	u8 dummy[RSI_ATTEST_CHALLENGE_MAX_SIZE] = { 0x00, };
> +
> +	return rsi_attestation_token_init(dummy, RSI_ATTEST_CHALLENGE_MAX_SIZE);
> +}
> +
> +static int cca_guest_get_attest_tokens(const struct cca_guest_attestation *cca_guest_att,
> +				       const void *challenge, size_t challenge_size,
> +				       u8 *token, size_t *token_size)
> +{
> +	int ret;
> +	long max_token_size;
> +	void *buf;
> +	unsigned long granule, offset, len, rsi_ret;
> +
> +	guard(migrate)();
> +
> +	max_token_size = rsi_attestation_token_init(challenge, challenge_size);
> +	if (max_token_size <= 0)
> +		return -EINVAL;
> +
> +	if (max_token_size != cca_guest_att->max_token_size)
> +		return -ESTALE;

What is this and the related work? That isn't making sense to
me. If the token size is not absolutely fixed when the driver starts
then it should be fully dynamic and this just streams the variable
sized token.

Ideally directly into user memory so we don't need to allocate a kvmalloc.

> +static int
> +cca_guest_attestation_evidence_get(struct attestation_dev *att,
> +				   const struct attestation_evidence_request *request,
> +				   struct attestation_evidence_result *result)
> +{
> +	struct cca_guest_attestation *cca_guest_att = to_cca_guest_attestation(att);
> +	size_t i, length;
> +	void *buffer;
> +	int ret = 0, ccel_obj_idx;
> +
> +	ccel_obj_idx = cca_guest_att->ccel_obj_idx;
> +
> +	for (i = 0; !ret && i < request->objects_count; i++) {
> +		const struct attestation_evidence_object_request *object =
> +			&request->objects[i];
> +		struct attestation_evidence_object_result *produced =
> +			&result->objects[i];

I feel like the core code should be doing more of this for the
drivers... Drivers should have an op to return a single evidence, for
an ID that they control. ie the core code should be returning the CCEL
for its id, and when we get to SPDM other common code will handle ids
too.

Maybe the evidence itself needs an ops?

> +static const struct arm_smccc_device_id cca_guest_attest_id_table[] = {
> +	{ .func_id = SMC_RSI_ABI_VERSION, },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(arm_smccc, cca_guest_attest_id_table);

This isn't OK.. We only get one struct device per RSI and it gets to
bind to only one driver. Given there are other drivers that will need
to use the RSI, like the TSM and others, this needs some other
solution?

Jason
