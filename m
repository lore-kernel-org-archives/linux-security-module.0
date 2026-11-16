Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858273;
	b=qomVNV2xKIwSC4svwto4YrqP4J7RtFYRtI9yBak90+/tgFGLUjH7y52XD45SUNG2vsEG
	 BkVUGo+8UMb90D3r+HO4c65xjV/YsV2p3Vu6pWLZvRUn52CLUHSe9QASHW1OQHW0l3nVu
	 z/xbiVo97IE1+YKxJYrgKnErgEyXM8+X98AKipC0onO3zprgrDwsGeoOu/b9sMXwHsEsZ
	 0zgMEv0beMXfTmg2OUcbmNtsjD0QO99sOvW6pbV+2Skm9a82J/22xphf6TKyDeyotzEsg
	 qUPKyggZHK866TRrMgbyw5VHsO+42zbpsKvu2MHv9sOCspljcdsbV0LaX4kYAtD+pfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5a8RTlOneQoQgmIZF/2HgV2WGmUNnodxSu/n0rvD61I=;
	b=WaVT5+I+45YqsR2bxTzY5uG6m0jFHolCotfntaLbgdhXBWV7bOEQFCbTyuC52KbqSa/7
	 Ip+n6cCRAvhX6AtSgwctUB6lbK/NeR4vnkgxxl9KKJ28Df6IGDknwSG7idnViNX8LXuIu
	 NaOPVfgtCgJu/jGU1Ts/FR9kq5bK7ORpbTI9a1fExh2g8CyCVTRkBD+7SIFEotCSVtRzQ
	 9UdmqZ53Ma8Hc+KQNe4c07inKG5TIQdOfwgKM0LkjtbsHOpo6Y3ek7VLGWkpjbIS6ooVe
	 ebuxoInCwzbvolk5YfTjBW3VWxkih+TqhRxwJdTXmyHfXpbMI0AojBdnyvXaUowkc8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=SHBpWSfR;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD1606A32A
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 19:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1BD1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=SHBpWSfR
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-949589c1495so317288385a.3
        for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 11:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794858272; x=1795463072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5a8RTlOneQoQgmIZF/2HgV2WGmUNnodxSu/n0rvD61I=;
        b=SHBpWSfRjtSVDfCjuB4AftB5V3Ersf1C7hVWdgVvkY4iz9ugysMlfr1zYwf5I7iYsN
         6p6KDbWx9awEOyWSuqmI4Xsrnv/6qcr4W7ah9rCTsOebqEHEzErhcl3NtGGkkBdq+tdK
         /E/Rh/eLOh7jevSrdzpDbBrasQ6yXyPGw0VQ6OD/75X8PThZXEfPFkVQ5BURPl8xACAD
         5slnwJ8UIvmqGgP6cEGjZqzkPG27qXFOETpw0TXeJURq3IXW/NxfGpafWF5SGp6hk9tF
         YerCYoVQKv5t3xy4WIBrXykEOsEBoBg4cNbNWqyJxZNUYx6jocwga+l2JGTrxBnv3vFG
         NYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858272; x=1795463072;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5a8RTlOneQoQgmIZF/2HgV2WGmUNnodxSu/n0rvD61I=;
        b=uZLNjGA1kdUPabbR7IFUPBhRSdTyRTJWGB1DImKkf5m+k3IvkAr1kp2YLNa6Av5V5B
         3IOjlyW+4g9UCoydUkBqTXPayBcNtlikVQ5ViEHBuGu7Ljvat5daBGoP4XW+6NRTX0Ha
         YYoMLK1y86gATBP/N4dBrnl1W2zkz+G77L51128kvrS1rmBSjCVYu4vd0G7Rax7J92Ci
         04poIQPZa7V1SgOtkAcVJZKUhJbRklIEf9T4YiZy6hozJNdJ3QbMTGpOlhcaR0lDXmAm
         JgJRuJKuHMeRLgu2C89EA+dB9fwF8elUppYwBCG72U9RI3dmiajANEdRht1+0qCKLY+k
         f2Aw==
X-Forwarded-Encrypted: i=1; AL+hErE7o76O0OcIHuCRqKnebVyo8d2hmEGX+lvElT8D8DsYLu4tzuNsdAU8z0mBDGH+65fKr9kTraF7BV5SwV7/wN7+OCzWjXY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/4BFBZ1SVPN/+g7Bn/nsyGXExOAsmwsP9EecSE75VrX3Fizdn
	qYuE79aBphAHC0vXnUEhzmFlvz9AwajbjUe/SNp/L6RZPZdUvC8e0GZ+kKwpwOkGFW8=
X-Gm-Gg: AYBFou0Z7DA1OaPVkIrvhzgVxFakT8VYbVGGAYAdn2Bi2aWki/uU7HuA3tzzfh3AncR
	xjrDkfyvcgeA5rlz+duaM/hGXCGlXB2rSJ5F45Kkor5Pj2rR4qTMHDxuK7uOnUFFxqxSS2tAzFO
	PZkTtmD0+fWdn2uemCiNGWtUl4pFWZ0JcoomjyW7Hvzq+WzxlafGS4sjZfqf0pYaAA7gmP3v21k
	RVtPZbrcfQKOf2H7pyz3J+6woyH0QzBjtuFdyjC8VIVMi0g+peOhcHvPp9x0wZ83CaL8V0OE3nn
	luL8NIHrKl5BFh5k1YKlyb0Gq+/rPR0ufLTos6ifGBMVoiJiDCXnsd89hxL8I9U2Pw/GTzMyBKe
	2jjfizzTfrNhkqkX2tYJOES+R/R2sooplfvBJYTLHKL0c9LSJO9vyi4/5qc5DBtw4xLnd77L3YZ
	QwFbDDZ+u6vGdSTnTVlMhzDY3P+47HiLHifo88s5BWAhHH2VnxRr8aeqpOgn45Pf1QBRY9S0eim
	uTztCM1UehzDgyW1i5BsQCSx4KlSkFC2V8dRGFbDRHZ+4TFec8vY7GY8aQl4pMcPuoa1zdNCrFr
	pEV9zQ==
X-Received: by 2002:a05:620a:d8d:b0:93f:1d5:9973 with SMTP id af79cd13be357-9494bcea5c5mr1799354985a.73.1794858271993;
        Mon, 16 Nov 2026 11:44:31 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8e1c94sm917649385a.39.2026.11.16.11.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:44:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT2cw-0000000AKjk-3CZC;
	Mon, 16 Nov 2026 15:44:30 -0400
Date: Mon, 16 Nov 2026 15:44:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/2] lockdown: Prevent booting with lockdown enabled but
 IOMMU disabled
Message-ID: <20261116194430.GD2452510@ziepe.ca>
References: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
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
In-Reply-To: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>

On Mon, Nov 02, 2026 at 08:00:24AM -0600, Mario Limonciello (AMD) wrote:
> Lockdown is a kernel LSM that restricts access to sensitive kernel
> resources (e.g. /dev/mem, kernel modules, perf, tracing, kprobes,
> BPF access to kernel memory). However, without IOMMU, any PCI/PCIe
> device can perform DMA to arbitrary physical memory, effectively
> bypassing all lockdown protections.

I don't see how this is enough?

You can have an iommu but the commandline can put the whole thing in
DMA passthrough, which is the same functionality as not having an
iommu.

It is not like "any" PCI device can do this DMA. Lockdown
systematically prevents any userspace from triggering such an
uncontrolled DMA.

This is more about preventing someone with physical control of the HW
from access all of memory, which IMHO, is not part of the threat model
lockdown should have.

If external attacks through PCIe are part of your threat model then
lockdown is the wrong direction. Leon's driver trust series is how we
are trying to solve this issue comprehensively in a useful way.

Jason
