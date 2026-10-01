Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3055304C9
	for <linux-security-module@vger.kernel.org>; Thu,  1 Oct 2026 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867886; cv=none; b=t6pQJ9AWiiXDWAfnsiCiVyOgrJdpjyxsKd7w+ZrRh1dGFHaAwL4Vqll2PEG+znNSzjOhZgHjOJv+aP+134lpqpxHb3AshuMBI3TxGYb8PxYYiMXscnfxrksIcLGzvl25kw5DKAHhfoY3gO9LG6LGSUG2KdyG8YruMW+/L+BnCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867886; c=relaxed/simple;
	bh=Q85kZEspfRbBEZSBGOjOQeRPZ7EBf2+4Hi635vpRBZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO/7lHOxSzQ8aU9+yycjWybSYyg0JB2jM/U8p0zoYYDdYLMFVP0Rw9kWvJAwita6ISf52Pl9RfP+brwS4P7jTSSEyCycAEoEPGk5wpH/KF2XxRNPhoFNe7VX8ib+GQ/9RZWYFr/J+nyo1P4zzIZTB4ER4R+q6LtyfNfnH668cnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Wzr7qjDa; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Wzr7qjDa"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-81f707db14cso2917928a34.2
        for <linux-security-module@vger.kernel.org>; Thu, 01 Oct 2026 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790867883; x=1791472683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PiIPZwDVa/FTGpS0Ac/pTVSem1bCOOPpbOCOtMlbuUk=;
        b=Wzr7qjDa4/x4HNkCkGtcqfemfvbGJipDfnbEOi7Xswqv4/CqsiB7619RRhyinHvtn+
         Y5bp1fXu+1410xACXRsP/di2ssXWovqw4gGAm73gbBD/jmD+naaxnpuNI1F5zhAqiqo/
         fYuLcTIYkyS3k3rLclnWyn8Uqy+nSIAhwHYokVbvtAmbe/gOOtLqeuQvOH5T+ktpnzqK
         u/IgTCklKqd6ORi5Wr8cb8Ypjo1ozUa/Rp3Gg4i4SXpqGBlNCUXIe82F5mWWcBK2Got3
         bIe1ZdI42/PiVSy3hXsKmbTc3gaZ1MWQLNFJc4Y/SRVHbmyQgPsm+2mCDT+tCRfQXyRU
         g7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790867883; x=1791472683;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiIPZwDVa/FTGpS0Ac/pTVSem1bCOOPpbOCOtMlbuUk=;
        b=j5C/468g2NM9Si/UMqOv/Nw3nNrj0qnxhZDZnQnDCarlXfc5lqth5ddM3pGUdKhCI2
         ti9OuFOTqo+bBjgySirs6PHyyrVoD0Lr2zRQWn0x4Dz0Cko2erh65HJQjlpMARM9uYVN
         x/gTfsnkmpLgS/X1VvHVnleS8WEWuoK5Nj5hUpmlLFUmNXFT+DPlM/azEHHQwBW/Vt56
         qf0TsDq+Oxa3tQPYsxabWToyGXxaElRqeUqNNR4fiFluPwkf6WjywElwSvLTW4Db6ey0
         ILEGPYdQUyIMDCqUQbdNRGMDSmEATuSjFyK13YvZwX2mT39wa+DDog+2qdRY1BUpaX/R
         MmVw==
X-Forwarded-Encrypted: i=1; AKwUvByL1ScZDghGMLx+bvGd3ZLOHhszRgmEY7IbWP32VYRXKB9HK64UJvjhqffXhMA8es+pLPQZMXsTmOFV+zufeyl+RPh5TOg=@vger.kernel.org
X-Gm-Message-State: AFuF++niGX+EWaaNzf1cVwa+b21rD3pt/oCDgEC7mWZnMhvpeZBCpJza
	GjZCH/hOC0iuEdcrf2R5As5no3rvkVwKM40IT1stsQFRhanDGkp5YwP0H7UjepoKbXI=
X-Gm-Gg: AYBFou21ytEoVw6iP3FLme5UkFYkS9+nOGsrnX0uCjlJGDADNEtXVp2nVTeUafTFhY4
	ShQfZ9MO1EALcRehgogiZy9Wpcu7GaiiAQLCEE/eMKPq0m38QX43tQ+5RJFW1+AKuGY09cM+0e5
	y4NXKgMJpElkL1pzgFx8/tFY2sX9QF5hHINmZK/IMA8qAETBdUm6f3fwaXa2p2o/6vT85zkMbU8
	NXExDhYkq0jq1HgZElaMRKyg763Dw2ugPRg4i5SDznQb+DxbHk6bs/pKQRtCvR5hDtTlJvaK5KP
	B9dT5t9WIGf0/+rzrX3Aj5VXesVpFRe/kwijuGAcAIhSEnykZGJ4EdfaoLIrTWaORCXOg7PVHBS
	PCLJWyEvuy3b8chj2HO1XnsFQA2mFgKej5ZSvkk9MeMYVBfjNCVYNHgQ4MDCyBmj3b8WZYJrbdL
	+wol+h45dw9TyMlMcrZAPeNZWry1ZCvC9VQfLcqaR6Fc5n
X-Received: by 2002:a05:6830:6d0b:b0:813:baf6:c644 with SMTP id 46e09a7af769-8204b2bd01cmr6068580a34.26.1790867882898;
        Thu, 01 Oct 2026 08:18:02 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227a56e124sm18793a34.21.2026.10.01.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:18:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xCIXp-0000000ENnk-1pv5;
	Thu, 01 Oct 2026 12:18:01 -0300
Date: Thu, 1 Oct 2026 12:18:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, gongruiqi1@huawei.com
Subject: Re: [PATCH RFC 0/3] security: ima: support TSM measurement registers
Message-ID: <20261001151801.GC3019323@ziepe.ca>
References: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
 <ebe68f6463f8ece8a5cd8ce70bba292ec4f64a41.camel@huaweicloud.com>
 <c4fe5315d70fc162f1e5648e3fccb1676710d5e6.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4fe5315d70fc162f1e5648e3fccb1676710d5e6.camel@huaweicloud.com>

On Thu, Oct 01, 2026 at 01:45:26PM +0200, Roberto Sassu wrote:
> On Thu, 2026-10-01 at 13:27 +0200, Roberto Sassu wrote:
> > On Wed, 2026-09-30 at 14:43 +0100, Yeoreum Yun wrote:
> > > Confidential computing guests without a TPM can use TSM measurement
> > > registers to record IMA measurement digests instead of TPM PCRs.
> 
> + Gong Ruiqi, of course.

We are working very seriously on this same problem too.

For some time we did investigate extending tsm_mr to do more things,
have a better uAPI, but that eventually evolved into the realization
that tsm_mr is simply too narrowly focused. It looks like James got to
this idea before we did. I agree with his remarks in the 2025 thread
with Gong.

So we've started work on a new comprehensive "Attestation subsytem"
that will pull in all forms of ROTs, TPM, CC stuff and SPDM use cases
to give a consistent user API to work with this class of HW. In many
ways I view this as a rename of tsm_mr (it will eventually fully
absorb it), but the name evokes the broader goal and encourages
everyone to come in, not just CC world.

Our overall goal would be for something like systemd to have a single
uniform kernel API that allows it interwork with any ROT someone may
have. A uAPI to do "Extend", "Quote", "Get Log" operations so that the
existing TPM support in systemd can be improved to work on any ROT
flexibly without having to hard code specific ROT behaviors into
systemd.

I've felt the ultimate end goal would be to make all the in-kernel tpm
users go through the proposed attestation subsystem so they can have
ROT and "PCR profile" agility. Certainly I've heard enough people
asking for this.

This is a broader topic than just IMA. For example DRTM also has to
use the TPM, and other ROTs. It also brings in a global shift of how
the system wide "PCR Profile" should work as post-DRTM has a different
TPM locality and access to the protected DRTM-only PCRs that are
normally blocked.

Jiri posted his current state here:
  https://lore.kernel.org/r/arzr32ZDComnfmny@FV6GYCPJ69

While we plan to start with SPDM and CC topics as the initial launch
Jiri has enough detailed plans now for all the main use cases, PCI
SPDM, TPM, "CC PCRS", CC attestation, and Caliptra that I'm feeling
confident something like this is the right way forward.

Jason
