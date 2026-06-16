Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42793914E4
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642169; cv=none; b=HYQNnJEp2+B47gmoaNvPNn6KsqFpCuaMGw/OZsbSVt1sNoZxZsEwIhkpiJs7haatQ+i9KYLDRUBKYmLP9tOHf846KbRDcIbny6wL9aLKfoGU5htLwE/TWi32vqgeosgZ8G6R/+11pVmy9fqy1Hcx/Dkz+N3+Scj0aapNafPuPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642169; c=relaxed/simple;
	bh=mxMKe0jgsxOJM/p9h7RtsXKKJZ4vpt/rgkLudw2LN4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhAuue1ybAdUb2l+K7IFMcTafKa67vljl1H+LlsMTVJtKk6SMJunrEr8q7iJwrwpjfaPvDtoSrg+e3/ntEd0kWH8p5/hWvSl7NNOpW3ZKMhNBllxCpoDq+sxYFmlZk0Fi/Zel1HjYsRb8CP5k9pL2RvCltNme1ec+nFRVRtEvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=nE539p1K; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="nE539p1K"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6da33a561so4487141a34.3
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781642166; x=1782246966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2o1XTR7VeYkIhqu4UtENSoBuqpZfEyKyn3oza9yC94=;
        b=nE539p1KlGa15vI841yfbah1dtZVYsMGZS7l7VyiOhXxdDuGdyeaLXrJ+lsI9GgIzC
         hlN8xT7CDmPbxdA/hSHjsO1/rKq6mcNqDyrfSN9ZmYIcHrjBw7GbBVTJNWXb24JN3JkM
         fZbeLNHsNTvmWZRBOy8G4RtvskHoFDlO8onGcHWflTJbtbjj2ZlNt2hoMK60xMvTTGUf
         vG0549szZZKtEC8GVJS55dj8HqICEznt81kyxO9ao8QjVV7tpQedAU9/c7ysvjbgSB2x
         uPO6GJUsZiko8ofHKNlqI1JpUbGk7NL6TiT+JXoLst/0/bjdlF+WsmCWiVR4ZpDyMC5V
         s75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781642166; x=1782246966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2o1XTR7VeYkIhqu4UtENSoBuqpZfEyKyn3oza9yC94=;
        b=YsnwpdWKIW9DDkslLUsjKT9YAV1wLKFcccZk3UhlrwzQcaOjjjgODNlhMJh/5Aj83u
         9Smzb/96B8JAJhm6sU0clHSGdrjSZLDeVymDF/pe0rni/e3W3TQaVQIAMM6nmNo/On1l
         ShBi3s5LZxFIOJ6Aq/8OLBw4DnrQ9VInGcXCHixfrBUFvO2z62HpZ67Cf6/7DDZ89Z76
         nau6iuyxeH2+18f4Vx1n5UhlMrYqRvfy3labjb6kQRn1tQ3YuSRZQlihY/eApRMz4z7J
         h4A45gpgzcH8p3AKhCjJqcwIVHpVwVUWM782rNuOz7LAL1offnt5SyYr4YkwjPnsZHUH
         d4Xg==
X-Forwarded-Encrypted: i=1; AFNElJ//OEMWb1HdLtvAycX4s/NVqT4wWno1B/Ln1V2l/aR7LE37XOKNSeRqkEnBOzvDDcxkxH7XMDIb6kjDaqUfbZtPAThClBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4OwnYxnRueUS9iH0wokspie7xbY1N4glvqrLLCcSapzO6QPZr
	vy6acIpLkCf/wVnNjsANm1VFhDRjgEQpI93TzfXhvnGhCxRW32UXwutfktZ+LL0JNhw=
X-Gm-Gg: Acq92OGzGpZj57cfC1o7yZUl9E18qlvYRUD5Xmp1ntQT1Eikpu0zrpcW6Z6XDzfzpHY
	VR8Nkd0bGvB/qGZpfDbOdc/iKr1PFfG5r50jf27itRRXHGMV8/0fhxFqJBLrjJ3/Q80A8NFl++3
	OmO4PJOoYD+mMgauvbri/PFJIgVg3PlD0cxxDUJuNwBefnYdCrE6NYgqfvNn2JvZ2SngdVx2snF
	X7aUCNmqfCybQzFhPvr31y+pGP2OUszL8elZqYRimsI2ZZKQkKHeWyHZwtRsKChd22l3IakiZNl
	UzBLKPu6jqLaLBCKKRogHf45KWJjfa3gVDCQ8cprtR/ptQTtQc3MgaLwtHlUE198nziBdvQzGTJ
	eH6qizWdeJ1fgbaAG2jMMbekgwszKzPI8fhIYCl0EJ0YjzwSy+6uYbrlz3q9oh01wnR/gaQYNtT
	twsWKkKMX6Mn5hMEjYf9zpyWgPkPvEkG9wefVWFKuOcXKk0hlwRVLrkAWP1bfivE1w93atZjR7j
	pgXnyMTyg==
X-Received: by 2002:a05:6830:3747:b0:7e6:fd45:9cbc with SMTP id 46e09a7af769-7e90b3b982dmr1104256a34.14.1781642166451;
        Tue, 16 Jun 2026 13:36:06 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6de65bsm7523821a34.19.2026.06.16.13.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 13:36:05 -0700 (PDT)
Message-ID: <fcfa9bc9-4f7d-478c-90a2-ec4efd4c7d43@kernel.dk>
Date: Tue, 16 Jun 2026 14:36:04 -0600
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV bypass via io_uring
 IORING_OP_URING_CMD
To: Bryam Vargas <hexlabsecurity@proton.me>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Paul Moore <paul@paul-moore.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260616201633.275067-1-hexlabsecurity@proton.me>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260616201633.275067-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 2:16 PM, Bryam Vargas wrote:
> Hello Micka?l, and Landlock / io_uring folks,
> 
> A task confined by a Landlock ruleset that grants READ_FILE/WRITE_FILE
> on a block or NVMe character device but withholds
> LANDLOCK_ACCESS_FS_IOCTL_DEV can still reach the device-command
> surface through io_uring IORING_OP_URING_CMD with the IOCTL_DEV check
> bypassed: the request enters the device-command handler (block
> discard, or the NVMe char-device passthrough) where the equivalent
> ioctl(2) is denied. The destructive completion and the NVMe-admin
> surface follow from the code -- see Impact.

I've said this before, but apparently it hasn't been received - this
isn't an io_uring issue. If landlock is missing a hook, then that's on
landlock and they should add it. Other security handlers already have
that. Hence no need to broadcast this to a bunch of lists, it's strictly
a landlock issue.

-- 
Jens Axboe
