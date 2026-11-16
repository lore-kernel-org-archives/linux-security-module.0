Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858549;
	b=XE5DoT2Th+r75ZczBJNlGNeorx2WXVOKDdrB7YjFs2M1YC0EmNf6wTENFyg9wMUvlszK
	 GJ3mwPvqxWwPDMzkHAVtsznRjmXyyUmBomZo2PvyWCWL8qOkToA5PvKyiHqgCm2QNTQP8
	 Yck6947WK/hKBhXhmypkFxSiVBlAUmuRJYjO7hYb/LW7/Ud7u1KUntAZVT4/BS2pEqh2o
	 Dr2ZejZBBNtggFn8smRyYTdXsQAqJfc21TWtXNYKbSsQ4D0SbG6xvBCzyrOQ7VNN86Phe
	 9UphBwYoVciIfVbPYfAMkz1VqwpL/1GcL594rtD1aA76QrNrlxvlwIf4Uvh4ojuH6MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JYgfM3NjhEFUFn9lrkoVqv9gAjE144oaGhmBbKw0DZU=;
	b=ohcMiMHudKfH776K6F+mPxxMR+LL4BpvFZgROswn8gfARejpHfprA+uSu3TGkhZVcWh/
	 YKghAd5G9oqA2tO3nrlactbsB2XWGmwJBd1Oo2gRhwfylwp4z9pfaReeDeFU5tshbE7AC
	 Id2U56DwGiCbdvRTWTQrHr2y88K85VxpTkY+QIu0Eq/JKWG4gDoXGC6QTBqaVL621qfCF
	 DnOGR+mv9wmMWHnzqDH3hDvp4fDi6IORdD8ykogil9TufMu3A91b6Tb5MUWbRV9iD3a0z
	 9nVAWvf/phFu80yYcONXc+5SADlcKSFWqWvaFmVjU0W1xA5qBVbzTuhnN/wAv8GM+DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RlFsvhsE;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47922606A322
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 19:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47922606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RlFsvhsE
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91eb46044c4so66842516d6.1
        for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 11:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794858548; x=1795463348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JYgfM3NjhEFUFn9lrkoVqv9gAjE144oaGhmBbKw0DZU=;
        b=RlFsvhsEKl8YczEStUDBJeHllrFOfIR6vjGNwd76/biP2I1kCjgE9VRwwg2fjXFiER
         Wzajb3Irdr2N8CSbPSvTRr5jWXP5ulgFMSOBkvDgvxvh7ArkHXjsOhanghA3a+F3u4qJ
         32pvDn3ODb+dJa73zjDJAXCvecG8vca26Ki/U+YYljPcr1CimqyVXAENEfahq1C1zIn+
         N7O3F6A9dCgtW+jTy/WROWUf1adGILfOyE6bm2jCx7BtyZFoDZvAU0RV/Lq3/RNxd2KV
         VMxOveLKWggfNQV5opTqiNXipyTrD7LR4TjpT9tj8CVHDbNWuyRoCfVfpkgAT5HmuuDg
         Gd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858548; x=1795463348;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYgfM3NjhEFUFn9lrkoVqv9gAjE144oaGhmBbKw0DZU=;
        b=YfnxXB7D3jSl9AGIzlU7TFUAr0ICyoJisnbGgO+90OXwD7SSJzvFHbgN4tg5kBMggA
         Tux2rPF2R8ulkKDi2ejywnIN9UmHbJQ5BB8ZU5Zn5eTz/QWKpMDIFVO+FO85Z0r/xthR
         lipgB9drUJQCt+tt+FmFxRA2sh4IssnUh3YwMBvkoZJxeqGPDD+WKifyJ9KDZKtK7WFR
         +vNRU478YipPHRMwO9pEucRPmORXqHwgxqV4oJ/oENr9BasnAMkaudTLMMEKq/2iaMzm
         sN4ww6LPnQGCbtUiPmuPmaT5TnhFKsImd80Lr1nQf96wZEfRUlpxdFkFSODCKPsXmoOX
         JBRw==
X-Forwarded-Encrypted: i=1; AL+hErEMmv1Ld9irlLZMaXPpYhh8IhTgk8/uBYQT7zFHVYwpl+fzBBZV3jjN3xJid6yKWJnox9IH6gczIYU2HZxer5Zy3+hUEOg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ICDm8pv5vSy+UW+C3MFwZeOYrOw/CMzyJciEB774M6ZwIMVmE
	nMnsCwLrcjnjImnd3UUVBdul2/ZUrnGdW8fkicOY3mc3SuGT/fNbid7HC1YrayQ/mhvaFFKrIBf
	f4VF7
X-Gm-Gg: AZFdTZc3dVD8Edpp+ba18IAUDLhLx5PW6lIF6wOsEsBxrRvUZQX5OcU08viWUGgjhqQ
	9A6bgaDl67xmmEwb0Vhqp5GlhLe9VtzVxHaQVM8KXWy0lClcxeHQxc2ChP9yGGHkp41DI5j8e2y
	BJAeK54aSqSbvjwCNoa///won1q/twSbILaftos+l8wwgCjFtQjOxpJK7t1aYuiCzUTdA7HwNeP
	ZxmEw9V1TIbFibcI2n17oKYT//0SrHV1i2X8pRWaF7EQFRxbA54gnH6RMe4EgB2/wXt2Z3o21wv
	QawQiUjH9onJ82uLPmE3D0174eqkuaYGkJp0tQM9BMEBB9Qk7yek0qajngxTwUwY0KBkmt5xiJX
	/IxsZ4IC4vTmXBAKnXeL30dbplVTI89hE7GVa53RWHkFl1f36lfBofz68jrLOXXz+9gGK8Ng41u
	XJcEinhNeqLowjjwP/VYksT716jRjnERTZHt0g6w+DzjQd6rr4yRJF2V36BwUw2mBI+OdCQyzMP
	SkdqlE/Ja7MbbheU8TTxCh6gpvm44xcmAIvsPrNr+QttxXJnIyG+3zkPuPPeh67RdRyCVTO6km9
	T9fzkw==
X-Received: by 2002:a05:6214:2346:b0:91e:a519:270c with SMTP id 6a1803df08f44-91f241e0c23mr182367506d6.13.1794858548269;
        Mon, 16 Nov 2026 11:49:08 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23da6adfsm91844916d6.36.2026.11.16.11.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:49:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT2hO-0000000ALLf-3aft;
	Mon, 16 Nov 2026 15:49:06 -0400
Date: Mon, 16 Nov 2026 15:49:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <superm1@kernel.org>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/2] lockdown: Prevent booting with lockdown enabled but
 IOMMU disabled
Message-ID: <20261116194906.GE2452510@ziepe.ca>
References: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
 <44ac3423-0a51-4562-816a-fea881511afa@huawei.com>
 <a444421f-178b-49be-98b7-d34dfb147604@kernel.org>
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
In-Reply-To: <a444421f-178b-49be-98b7-d34dfb147604@kernel.org>

On Thu, Nov 12, 2026 at 01:27:50PM -0600, Mario Limonciello wrote:

> The problem I see is that in today's day it's incredibly easy to hotplug an
> external PCIe device and not "realize" that it's malicious.  For example if
> I leave a dock on my desk and someone inserts malware into it
> I might think it's perfectly fine.

That has nothing to do with lockdown.

We already have indication if a PCIe channel is external and
pluggable. If you want to demand that such channels have non-identity
translation that seems like a reasonable thing, but nothing like this
is handled by LSM today. Nor do I know how you could opt into such a
mode without causing regressions..

> The current mitigation that exists is that in the Linux ecosystem we don't
> turn on PCIe tunneling "automatically" unless the IOMMU is active.
> 
> Nominally this happens by way of 'bolt' userspace writing a sysfs file after
> it confirmed IOMMU was enabled both pre-boot and by the kernel.

Yes, and we are working to generalize this kind of flow to all of PCI
not just thunderbolt.
 
> How would you feel about at least blocking the user from turning off IOMMU
> (if it's present on the system) via the kernel command line while lockdown
> was enabled?

If you wanted a mode that forced protective iommu translations for
everything always that could be reasonable, but I don't see how it can
have anything to do with lockdown without creating regressions.

Jason
