Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858403;
	b=CGSFSgI8w9dmxPjMFgypukgrhGs1E2LmJt9ZqeMZTtpo7d/QiKyKpHVn73a6qiMgiQ7d
	 F5IvAW0mad+58hFQM0Ot3iMAgtfrG2S1S4bcXh6cxeW6AXGlwT+vrW66L8DMmI4uWH1jT
	 MvCyokpRwDjEG8WGnH1CtmT3JebfERF/GmHFnEUgDRlzcJfhlziYJxr15LkcIAMgtuqmP
	 K9jACkO8KElX8MR00hWupaht07oZ3OI3XbeafBA4gdRRVYFpYYMQe7DBq8cabBe3N3S7r
	 5Qqj0ThF1ajDVdL9LnwFzobJh60WjLbuIDpXVdHIdK+1UNyTUCJjA6unQew7YN2+4/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858403;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=rb4amnB1VYxDSnvAGyLyVc2GTkn7Gl6f5gxVefQoqyA=;
	b=xpwlZDUnTEpp3aJ4zn93ROL+75aN2m+RTvTIG5b2Xo9Q9M6J0oH5XgBvkz9kVy11z5Uh
	 OLPo506KcqzNDzK85fxz4o24tX1idMJ+ezi5mfwnBGEaC0QW33L3U5WIdU+b00lrNLpIK
	 NnVXDPiK2GYfg3f1iUeZVpnLorKaWWGmAYuMu7v4MAAa+EvJRDq1M1ix4E4A07KUf3sMT
	 mv3mGO4cYP4gcJlm80dn+xIbsNWvCRhBibdAypEBKPH7iWUsuS7R9AxEQ/BMZxTaRatIU
	 hrDlLACp02pGa8dUY4fawgOfG6gOu85MmEztAYW4Lk8KTWHxv1OlCORIPCW9L87iEEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Whvh/yBW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88451606A31C;
	Mon, 16 Nov 2026 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Whvh/yBW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703D81F000C4;
	Mon, 16 Nov 2026 19:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858403;
	bh=rb4amnB1VYxDSnvAGyLyVc2GTkn7Gl6f5gxVefQoqyA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Whvh/yBWQP8P4jnBEcySSvK8dMq1EiELToOKyevOUi8LDPUsa0gdUd5im6CAlRD49
	 o6ZYCSMJ84ijHtui/M5Q/hhEsuKb3EXRXfBEudhNbp4d/rtuXULXn4dvidnIlCV+MN
	 9j0MDqdBd6STtQe7SI+r52mmHonGVoaY+pWbDIxknEzzRw7oQ3Au0v+6KX6uERmVVw
	 7NxxkpQc2bGdUahNmAn/XBW581869pURbIdG6tG0hncak77RW0EKZomYysa0q/R7H3
	 QsQZ9e/lpnq2WQ5t1InwB8P2JyXaaVz3dkGQI0u3ZB7/8AQ/pbC8Ad/jBqDJeC/+pT
	 iTu/nugQUTBkA==
Message-ID: <818e80bc-4b7c-404a-9c64-b103935eea15@kernel.org>
Date: Mon, 16 Nov 2026 13:46:40 -0600
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] lockdown: Prevent booting with lockdown enabled but
 IOMMU disabled
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
 <20261116194430.GD2452510@ziepe.ca>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261116194430.GD2452510@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/26 13:44, Jason Gunthorpe wrote:
> On Mon, Nov 02, 2026 at 08:00:24AM -0600, Mario Limonciello (AMD) wrote:
>> Lockdown is a kernel LSM that restricts access to sensitive kernel
>> resources (e.g. /dev/mem, kernel modules, perf, tracing, kprobes,
>> BPF access to kernel memory). However, without IOMMU, any PCI/PCIe
>> device can perform DMA to arbitrary physical memory, effectively
>> bypassing all lockdown protections.
> 
> I don't see how this is enough?
> 
> You can have an iommu but the commandline can put the whole thing in
> DMA passthrough, which is the same functionality as not having an
> iommu.

Well that's why I was suggesting that we explicitly blocked manipulating 
IOMMU from the command line when lockdown is enabled.

> 
> It is not like "any" PCI device can do this DMA. Lockdown
> systematically prevents any userspace from triggering such an
> uncontrolled DMA.
> 
> This is more about preventing someone with physical control of the HW
> from access all of memory, which IMHO, is not part of the threat model
> lockdown should have.
> 
> If external attacks through PCIe are part of your threat model then
> lockdown is the wrong direction. Leon's driver trust series is how we
> are trying to solve this issue comprehensively in a useful way.
> 
> Jason

