Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643FA195811
	for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769377750; cv=none; b=TqC9rbGc9W25dqPzy0yUOAJlH5JBcaabJnX+9lk02X5L2SSAza30mvXeMBNG8p3dSwM5mLyPrsVG3PrLOx6mpnDl565+W0NanBxIe/lTyeo+EjX36C/HUlMMrSjN30LMZUTvM1Cwv5zfD9fm3irDJoDUVEyt0GykzZGincVdIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769377750; c=relaxed/simple;
	bh=fbWP+IzbRcDVueX4tuiaFWtgF4svQXaxbyEx/6T+cj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Si818Uin+e1u6OfKS9U9UR9Ea22jbWzPS5KAJkcdLMbg0FeLFGyjHvkrv6p+aFnQ+2nfP1MmD7HrH0InDTYRhBO5Bar3yqaRn6YR5xWkC5mh1z1MZgUQxQk3wpas25K/U/wwJl/ZHl6EkhratKWKeuyRtimmv5AXIxl1pJkXE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4dsipxoj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4dsipxoj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1b1dr8eJS4TM4DmpI6/fP6FW/axO67x3GtcI77y5URk=; b=4dsipxojvj3sCa0KooenYldijd
	qlLZgay1WXNrvo69PR9JGTC0DchVDcpdBS6Sk2r6hs/5R8r2x3voJFKF1CQ++YAtNlxKgB+Y2xxiC
	S3WgrKonOsXM8xsUYiEJ5L5jtp1rnoUpxXHzJxccVg3knafRNP4BVITljAzKrExBG3XyZNvgBaDoE
	w4DJkG0WFZP0NVstIikfDP5yLlZqM+okct6b0Fio8C1OWAj2zNsnzilGE0ay3nv9po8vuKSBDgjGz
	aEdoI2rgw8pBF1Vnos4grUGSLO3MSdueYnKAV+xD6Jc38y0uFZGPP2BF9geGucDqJphVUL1BnUFdL
	Td8D6GRA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vk7yX-0000000BXZ6-2KJT;
	Sun, 25 Jan 2026 21:48:53 +0000
Message-ID: <d9bc1018-82ee-43fd-8a02-097bb54190ee@infradead.org>
Date: Sun, 25 Jan 2026 13:48:52 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] landlock: access_mask_subset() helper
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
 Justin Suess <utilityemal77@gmail.com>,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-3-gnoack3000@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260125195853.109967-3-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 1/25/26 11:58 AM, Günther Noack wrote:
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 7961c6630a2d..5c0caef9eaf6 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -97,4 +97,10 @@ landlock_upgrade_handled_access_masks(struct access_masks access_masks)
>  	return access_masks;
>  }
>  
> +/** access_mask_subset - true iff a has a subset of the bits of b. */
> +static inline bool access_mask_subset(access_mask_t a, access_mask_t b)
> +{
> +	return (a | b) == b;
> +}

Don't use "/**" for comments that are not in kernel-doc format.
This function doesn't need kernel-doc comments, so just use "/*"
here, please.

-- 
~Randy

