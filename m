Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804610;
	b=X8NVL4MnWOjU265DhCYy31VAsoTujsuia9Dx+YINpGHDhU7u76l7v7C9yXeuCRZojhDG
	 +3GDl+cGytnvA5rb9nRyTFqg92WNvKhjLu0ZmG13t7fGKyqWa7w9lEzRjVU6OsnmvdCUC
	 axcVhayHHBqAUkV3Kq3h5Tty1ZNvxYi/+YMo36D4w5feAKuzisIqG9xHT6Fe+EPCJ3VYb
	 fIIJPASnzpUUggseUKPEjJmb6yMfXX1Xt4sk6fqLcN1vYEp0kCoSBOqFZ86lp9M/D5Z6c
	 WYSFkNA2i7IKiColSkRl7ydN+wpVYbeGZwMrn7zhAoxBab+qurmUzjjGeWEgBkZpUKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+9Dw/wen6g6fWY32jCYKXg0uC2F+6Oaru/Dn4CTkyZM=;
	b=PKWdJflJDPwvTt89F9FeUqNew8HmnozGk5tB3AspzrZGxFs98fJFbh6kWKIcdlaIg4ob
	 JlObWDLmVV7ixaNIJZsbsqF+SwnPmSxJVXqbb32JhRVAV+nbNRWOEkt0Q0NsoNXn1yveI
	 HiWMga5e0xDmgwmcmB2VdgEQHnYcXBlsU72lFRcwmXdxAuZhtK66Jt5VIOuSUBcjQqkZ0
	 SHzTeZdEIj8jR6dX17fXE+dE3ZGiJIxvfwW5MCPlO/frDEsBOsi3nMP3cvRq4jgi++KlW
	 0ziLKgDWNiPSQ0DYUgGB5xNnndEXSdjuOvxhhR6n06m8FvzUosnxN8iFfIUv1UStutA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FQqDBy6J;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ABC606A330
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 18:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76ABC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FQqDBy6J
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-92157f2e8c1so68389256d6.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 10:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795804609; x=1796409409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+9Dw/wen6g6fWY32jCYKXg0uC2F+6Oaru/Dn4CTkyZM=;
        b=FQqDBy6Js8XrvXmyD8SL/u+yExsfiOIjX+3Qv8PFjqWbEOS/J/sDfstl24lcNicd6M
         PkL4KLFLOjm+xuNYdQwqUcHAIrXcJ//DNqWVnzEugXxJV52uk6eRNVvaVxXJbY5Bl7ou
         7rubMrQs8EdQfsO5xRzjEsGHJQpkeR1g0nRGIcWUrMhQ+w2TgK1gza7wJaMgYVAeHUVG
         ges3+956+qMurZGsh19qeYrM1aQmOnZrNaBhNPYHVU0VuU1IhVr1vVlTiL1tqNFxWPhg
         YdOIvlBcF3YHxrQhupM7z96IFAXcMGRFNkKk+1lOeoAkMMQd+mWGr1YNQMt75thCP0QE
         XNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804609; x=1796409409;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9Dw/wen6g6fWY32jCYKXg0uC2F+6Oaru/Dn4CTkyZM=;
        b=dCd5iyeh1XR54hXSLIZC7aq0waqy0UTofvdhjeV5F20SEQz02qLk5s0vgEF82Wwasz
         GR4fFnnnMs/v0F17z908T+k1+tXuAiSLkdJK7xMUFltbkDE9l4Y/rQG20ziUqznQ3jj4
         4DE67S+aVynPFNPxpqmU5+e5H2fOdBkJ3Q+0Hyz5It9nXjoGo2KrWsIcykZtbXZYjub6
         zG4KoffJSEYi02SwsJgba0kvCLoHqik43JvsqvJKhgZkG04G2SE8NSnbBPX2ffc7c00q
         s9Flk97YEL517dfhM7xcm+BOq3FAYxUGgWgslIsyKho+ydKVJzjUZOYkXoo8nDJUtmjJ
         rfAw==
X-Forwarded-Encrypted: i=1; AL+hErH26k+3IT2VHoxppyL0fagKnanjPTnBKQ/x0vCCpEokyXthvYnM/S5tATrEaneG224KISc6iPDNlZMxIzy6HLZjaz+FvWs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BydVxPYoLrkwvGBZGUZkMsqcU0IzdtiJrmxYSzIwG0+YAOlQH
	JcIffl+ozPJzfEdQbS+BU4grLiJIvMy6HpL6TbUbAhU6tX00tpvSa2wczKP3YT37nFQ=
X-Gm-Gg: AZFdTZe4qCspv0gerNXkmedv0kYmmxl/BH5/r77/d5Hi+TeyWJ8NUUgcl70kIu0k+Jl
	QfCFZ7ADzNebkCdYz+deQ7JWl4sTXRVBkVVeX5l7DLT8S5yaAvylFjTPhVpiuF0DTHV2p9FjoOj
	WZoPEa3UaMKAsnJ3pY1B9ZRKoTbuQmC7buc9TNlNOgLYKeOpH50Xor3PRsb3LbPFXWaI+18AI7s
	OBPYV/soOGzbJmMT1lzk+e8Z4OunGqC3oknAphWFMZIFj6l1+vwpSg0wDE/TSGmPInctVK+258g
	R37C4SVIyQ/jeBl5tbMA7h9QLJ0tEfBTcUIq325gJeLbUEcGHF4mIvHofrrM0XYkfc8I9NAlGbf
	nn3qRDCvYMV9KmCf1cdRJkFA18YQ/aa5slxvW/gEi0cE58GS3TKk8mbSMhK+LYHiuR4w7WMtiPb
	i+32PyZKrCCtMqqCH+zeg+Stc19odH6sNXwek4DRGpQXzVvXDTYRmSKc5i5oN50LqEH3tqihDeT
	zBzX2WrTRq3MexBUFaV3qujj2flDlYU7iY/QmFQfTg408mqGQ+S1xK1+UBC4H7S4rsVQvAzlgZQ
	/YDY18g=
X-Received: by 2002:a05:6214:4686:b0:921:1ac1:34e2 with SMTP id 6a1803df08f44-921653a9042mr254285806d6.24.1795804609400;
        Fri, 27 Nov 2026 10:36:49 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b253csm225559716d6.15.2026.11.27.10.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:36:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xX0oS-00000007aS6-1aU4;
	Fri, 27 Nov 2026 14:36:48 -0400
Date: Fri, 27 Nov 2026 14:36:48 -0400
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
Message-ID: <20261127183648.GW246011@ziepe.ca>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
 <20261127170722.GT246011@ziepe.ca>
 <awnLgFZIhRZENiE4@e129823.arm.com>
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
In-Reply-To: <awnLgFZIhRZENiE4@e129823.arm.com>

On Fri, Nov 27, 2026 at 06:27:12PM +0000, Yeoreum Yun wrote:
> [...]
> > 
> > > +static enum hash_algo cca_guest_attestation_algorithms[] = {
> > > +	HASH_ALGO_SHA512,
> > > +};
> > 
> > static const
> 
> No. it's a scaling issue since the attestion algorithms could be not
> only SHA512 but also SHA256 and SHA384....

Then don't init it here and do it entirely when you query the RSI to
learn the right value

Jason
