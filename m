Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807105;
	b=u7iQ3bFoJlE5t3pJZsqv/DkZkqZyjW6u6H2iXn7ATyjiC5KWXB0LI7qV8wRBNyCin4GZ
	 WpkAK8f3+MtAu3YnyeHv6uRDY1KdBogbv7gOMEn1NyfmLArVW/hnRWxjTN/UFgFE8qNdF
	 BEqRfvlyj++3JPDDT+5mjPtFHLBRcJWALMUe9FB89qczRZ21Ker66SgOc0VLEudbyFIdy
	 wcfp4Pd5WVqo4bz1Zo+xd4JVy7B+Ma9noTS6zO0pOLcWeDpPu33tF9n1JU6iqnaK4Nfxt
	 oK2JIW/lumVE4R4gf0k82K2FknwpkMNLq63HHyDjgHqjIGE6qLZfV95BrXPtbQqbnTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=W1FdGtSZDb7NmxvDylEt54duEw4UgMOOnUX7lvsLEnY=;
	b=quZiKIeF8RZCpT9KpzdqPFdxImS1smBywzDj/Gx5a69o1VzhxC0Fa55Iaksnj73thiWH
	 +OvHuzEijXEkiIcPemgRUTt3dkpgiCFlUiSFPfz7q1MgZaFVNJyVkLIDlPblcE3AjL1Jo
	 PSVs+0XhGQrM60VmSfdVKVgUFqChY3dLNeV3lxl8QLpJs7DY3OdRAVD+1sU+tx8+KYsq1
	 rHdJ6AY0bzTnzsix+MATHRQNJKZ3q/qXv5fQNWsjYfCu7edJhm8ZVdDSBc5V8en75sHr2
	 mLm2d6mKMEw15INBNgjBEOQniWmOhdL5700N3NqJ6H8HdB0rXdYVie059nULjPAzKAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Au2hPQjf;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146E606A31C
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 19:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E146E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Au2hPQjf
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-94960131b30so745440085a.0
        for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 11:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795807104; x=1796411904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W1FdGtSZDb7NmxvDylEt54duEw4UgMOOnUX7lvsLEnY=;
        b=Au2hPQjfRRLKqpzLdUlS4qTuMZfutWDMs3nxeZ6kBFtz5N2Xk2LtgNA1S5U0oOtM1F
         pUH04r+cU6kZ0kDgUOxrstM7z2Im5gAyxPSe4aD83cFjmAwAj+Fkxac12C/8nN6ofeLR
         MFElkoYfleQYMRT7phF4+sDQ9A/GDPgp08AagWSlO9SiwrCyijC940FqmwCDAQns8SPF
         vr8fSP2KNc3B6d+8S0JwcH7uT18lonZeGkS87z1MJOqJgxKlovDuQgZgrTINI217fher
         UuRXmrGlqd2cTXfhETi+BHgGNRW6PAqgPj4iVvWnFYjeFdjgAOpMLRYBPKKqoDP1GfuD
         ymIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795807104; x=1796411904;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1FdGtSZDb7NmxvDylEt54duEw4UgMOOnUX7lvsLEnY=;
        b=g+1x8TuOwa3ti3ctFxYbgTGZtWlUw1wAyl+Z9jFPjP/79yiOC/yYQlGZ2x/Tu7UHlS
         UVReIZQPw+Tbif5U/NTGz98pIDvqOmLHHyAeeO0zml11HxOZw0cQ8VkgXYvKO++OjVFU
         lsfVKeXS2lXS41C55qyb5Xm9ZriCGtMg7eL5QqmPzxmtbcBSR7iJ2rtNMc1qbbXfRAUk
         y/HHAeA72sxxpNZeJpe1TzHgWmpachNH3/+WnSSq7JUV+9fzDQrRJla8M02He/TkYx/p
         4H4RwpB9G9f1JcPuFCA7Ws5UDqEK9Gqgrvr9xvB0eeIL57mhKPxUSGR+5zcnNu7H2FUe
         htHg==
X-Forwarded-Encrypted: i=1; AL+hErFm4Wtyvp+k2FD9ntIczJt1Tbjvz62gjiBV9xGcF6QCvb9lOJ7qtSUv+xeipc9vCRBbuskJCHrtzLXiGRv1Fvkc0jvnzWM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2jo33HwpgulaBmeUCLR5czcnb2u8KJoQHZPcwGhOAnl31SDhV
	XCCR6sw3jLrZk8BSYDgL5v1pAmXiNiyWSL/7RG5sz3wzSYn3ue87iKT3nKe7odqoGL8=
X-Gm-Gg: AZFdTZcHtrQRwF6uKopNHtfKNBwkvUg9KUg9wZLP3Kh0SMoSeS37UUwMSBsW0AKVQXT
	ocFX/YrHtiGss0PQ+VIH8/TqxZV/rgbKZn48+qN8Pc5c8lwdfm/gEE8ExYAmofMXgok67vCN0iN
	rQgT/ciPMldSxkaIQMcsECns4PXL1SUrUovk8y4SMR7jcLLmqh5GRwoLwVAMaVGZvdjbLQZIVGG
	FznC6XiPGKRW2SZUS/hcklxMptmv9QUV4GlAMKbLYhFgfMTgw+WXck1SQmGxouNnhe1GrTCNN+B
	Wzhtqlqj19CvgfYRbLXq2TKy0uCxj0oPy1mkDVYSDJ+/CvYf7c3vxnx1WKY5e3hXqgHlQUOVkUL
	amIwqehO0maULxQPDdzq6qRFezQ8L5aHZ+81P1N18+hTnKpXGRz/szjcpxQBEE9MV8VIgHAHH8K
	B+zaRDJkmEmbyvg8PzsY3S4XHRspcQZ30c2YVfp5WTlzdDUZVJ9sIcs15aWY+o5RcpQ8haZecHv
	6EipMLMtLcpx7wOToJ8DaTun2MPc6t32XXAvWtKt2KQM0mwBNdxNgKbw0JEcFNcxFYDnrnfIBAz
	wGuY8g==
X-Received: by 2002:a05:620a:6f0d:b0:939:6dea:374d with SMTP id af79cd13be357-949ba9d1fa6mr4395559985a.49.1795807103939;
        Fri, 27 Nov 2026 11:18:23 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb418241sm1867466985a.38.2026.11.27.11.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:18:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xX1Sg-00000007nGK-3YSV;
	Fri, 27 Nov 2026 15:18:22 -0400
Date: Fri, 27 Nov 2026 15:18:22 -0400
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
Message-ID: <20261127191822.GA1856591@ziepe.ca>
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
> I think the problem is the *max-token-size* could be changed.
> once the LFA updates the Realm definitely the contents of hash of
> firmware binary can be changed. this means the token's content could be
> change including the *max-token-size*.

I think that is broken, there is no good way to make that work in a
sane manner.

LFA must stay under the hard wired max-token-size limit, not try to
change it while a realm is running. Take this to your spec team.

> For this, the RSI host call interface has the way to get LFA eventlog.
> IOW, after LFA, there will be LFA log is genreated and then for the
> time of re-attestation, it should deliver the LFA logs together.

The detached event log is even more reason the token should not ever
be changed by a LFA.

> > I saw in your FIRME series a solution to this problem, I think that
> > would be good to get out on its own and apply it first to RSI as
> > well. We will have the core RSI stuff, the realm attestation and TSM
> > driver at a minimum..
> 
> Hm,, Does this mean do we need to create two device one for TSM and
> one for attestation even the functionality same?

They won't have the same functionality. It will be the same as you had
with FIRME where there is a driver doing CPU attestation and another
one (the TSM driver actually) doing link IDE.

Jason
