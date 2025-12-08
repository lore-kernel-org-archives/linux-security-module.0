Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4C1E9B3A
	for <linux-security-module@vger.kernel.org>; Mon,  8 Dec 2025 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765172418; cv=none; b=DESS6+5jyYi/abSRMBEBmERul4pmvoE3lYdbCFrGLli/pQtkewfLkwKr4XQe34/iTVh62gzusW0T36ZHyYAyj5lF2PE/2JU4np8dK7cn0N3IPkc2KrcuUG286ZASxroo3En7OOSPY67n1dVmQs4AF5FMLjJRFWVRJnLC3oT28MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765172418; c=relaxed/simple;
	bh=jqj2LaxlKv9yaIn5YdQAnHyLwHHSslZDmntyQAHQweQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTqqf4vwFQAbD2e1kxC3qhSVHbfuJGUFaVFnjln3TI7TgpYOSjlYihqNE4peu3fg8jgGRrlX3R5DGoR2Dm+KnUcQPb6eAyiiuBRYn9an2f63D8fXBwoCFu2fkV6AWtsGnifCFloRqIpvSHO1ENdemHyl6F5mIooL7KlxflYfP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW+I+YRi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW+I+YRi"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b75e366866so1659909b3a.2
        for <linux-security-module@vger.kernel.org>; Sun, 07 Dec 2025 21:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765172416; x=1765777216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hxN5XIHVhI8gQu6AgmfaacpuQnWcYXpKmcS4GkwbYus=;
        b=VW+I+YRiztJsuNZP6OeW1lXue0lRwCW1lrnNCXe5zb3YBq/qpQ3d9OUKweASWrj5l5
         BPPdgoMdR0LaQP0jHpQMmQlh6xkhVuq9rSxKlVn5VVzMg/y6pM5Cha17OKE8EoPhDJ9Z
         i1mvHP+iufP9FLQ9LGLP+p/tf/m4A2m3Bb8usTSv0Fait+nQv8MZ41er9K7Zl+VBUNnm
         z+LnyNmdkAf/xkCPXxQijkAjjxgZxJJdqE4wJD2NMjX8Bt2ST0gY69gD+UnbkL6TQsSr
         ab2mnfdN0lA6EX44zXx4QFWRJ7jMzxwyLp0V/83iG4xzKslGaMjeR+IvY+TWhZgPVt+6
         5//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765172416; x=1765777216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxN5XIHVhI8gQu6AgmfaacpuQnWcYXpKmcS4GkwbYus=;
        b=OOu9CeZpMRIHWtUHnc187ot3VVaP9a1+8CDR/8RW5FCPcxC1atFPcyip7lNM1eBSeo
         niEcnPe4/JmLJj6CQ/9GuueOsfdU+ex0sw71EiQSX+Lh+2Eu7jPi0p76pOMvdf4m7qWM
         lbTlYt+eMncBLxDicJY1UuhdYv5exCCG6sG1Eg7NGPTgihqAWhE1OMg6o8hpEvRy90Ao
         MOENCBzKvgM8oaSNAJk2u7E2mRFhI2hmV4xr4O4aQoWZUneJwyyrgDuQvMt5PoqOzemq
         pg1FhUIR0LL8vqLq8MmfWC1fC61yypzlGAYip6JbzeAPe4kJ+p30vAEzCTOYjwZE3dsb
         Y2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXVjLPh4qya2HrHLQStzc0DreJxLl2KKFnDGGZgqd6oSKN7hnRv7Q0bwCAg6KE5/l/lsblLeaZUgTtI7ULURX3tB5pqq8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdl4kwV5yO7Eegqucp5L71HpRf5vmKcMkPsjJCtnVwQv12ohH9
	MyCnIIWUxXnb+bRC/Yvp6+BP5YSCEZfJq+fwUIOaeUbQE4CUlwSJotm3bly12HoX
X-Gm-Gg: ASbGncteqddJGoymdZq2h2ljWnCw4EKPPoTUIH25itfHGIbW3P7SgyNMgQjUBJ9WB60
	hGnMLqgg6J4LIHJz8OSdB8aSoDOTlyPNuEXcxLpxktn+O83zH5hOBhAOADvwQR1bu5sKM+fScdk
	/pBPipjLv5o0T25g7YHnI7kf5BRLGETBgTk67y774uSTDFO3teNASyePzm3uYFLwJDPv0gyb0rm
	7gYILdO3MpGweunF3141tHMfIZOLNSZOIpSi+v26C/Ll+K128FC7hZe3XCierIhHfGiG3KJv6T5
	DgFxZJL5CzoSeM20gP7nSAOjhvdD18Y2jfp+mr02eHP7ze0khol0hqSXwTrL2ZDW52PwIsEpuO2
	kqayBBmHTZntEcRrQaU3mURdPgNAyzJes9KDtMsckccyrO6rkVoI7TBIKrJJxkRpZ3k2fmxX5S1
	soxyDI0tKz87k=
X-Google-Smtp-Source: AGHT+IE6EhVL5EEpK+RmBSfpxr2nVh6ZFD+Brx3RTeyqST6qGCNGRzY27erlARCDKIDGSn/ZVJ++sg==
X-Received: by 2002:a05:6a00:12d7:b0:7e8:43f5:bd51 with SMTP id d2e1a72fcca58-7e8c5048a0cmr5923390b3a.61.1765172416116;
        Sun, 07 Dec 2025 21:40:16 -0800 (PST)
Received: from fedora ([110.224.247.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2a0533f08sm11790114b3a.23.2025.12.07.21.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 21:40:15 -0800 (PST)
Date: Mon, 8 Dec 2025 11:09:30 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] net: ipv6: fix spelling typos in comments
Message-ID: <aTZj_AFt6bR9_a2F@fedora>
References: <20251206083813.240710-1-i.shihao.999@gmail.com>
 <aTQCXJ7MUvnJpG6B@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTQCXJ7MUvnJpG6B@horms.kernel.org>

On Sat, Dec 06, 2025 at 10:15:56AM +0000, Simon Horman wrote:
> Unfortunately this patches do not apply cleanly on net-next,
> and thus can't be processed by our CI.
>
> When applying manually I see:
>
>   Patch failed at 0001 net: ipv6: fix spelling typos in comments
>   error: corrupt patch at line 58
>
> Also, net-next is currently closed.
>
> ## Form letter - net-next-closed
>
> The merge window for v6.19 has begun and therefore net-next has closed
> for new drivers, features, code refactoring and optimizations. We are
> currently accepting bug fixes only.
>
> Please repost when net-next reopens.
>
> Due to a combination of the merge-window, travel commitments of the
> maintainers, and the holiday season, net-next will re-open after
> 2nd January.
>
> RFC patches sent for review only are welcome at any time.
>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

Hi Simon

Thanks for letting me know about this i am still new to net-dev
so i did not know about this . I will make sure to take care of
this next time. Again everyone thanks for your time to this matter.

shihao

