Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7587A321420;
	Wed,  8 Jul 2026 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500934; cv=none; b=DxAekgwFvA10TW/KJZ5M6TSQWe0pXttPlJbrL/PevFhHtWXmvL8F0sQSrXgnOGJD47sMasiBCNw2ahegYxS/sG8GI1TPg9THARgr9RHTQ0YCbmlU6ucRsMAvlJbsF7flrDhy7Q97rwXopy/lGYVSWM2avzdrQqIM94bLdh+JRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500934; c=relaxed/simple;
	bh=tiol/AHU7dTYi9l5OSJnjc9K7lfvoyYeFZZEeACfITU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpp1+YLb8SfPRgdNtcgTfER9gXgc43d2Jth+98j2dxuBiyyIiXbexuQAxtGyf83nqjrBIli7jrln7HJg74orvg1yspLw6zdkK+UxEVOL6tSKYDb0D/xDdGgg5zqUqoBvw/1gHErmR5Lo/YxWPMpPzA52SpBb3lCdobzZ2HYI2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1QJWMSk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1QJWMSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007C81F000E9;
	Wed,  8 Jul 2026 08:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783500931;
	bh=vUscPJ1RtQkU94EkLuPbqH+MswxqdUl6zLYfaCC135s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K1QJWMSkDnkJXGNBLPb4fuLsCt+QT0M+xC2hw479J8mTbcCnpBVFtqyyelv2sUUTt
	 q+OKQsEYcNQY3AfXN4NA8ZY5r1opSqCO7gshwSDB4eDSPOBWq7ShTG6CREqbyZRven
	 k0a0AkcHJ+qV7aqCpPRkVtz+7zn2yln69IchESH3We6nZTg1TXQ8MRa3NeKdNe+5Zi
	 quPnYXZctUGwvf6Q5YQLbGlicV5/vzm48btymwAHo5S8hnW+1LZpDD4y1qExILbxyZ
	 vdFYtcbWWqyY1KcSeoCsDw8mH4lnUOLDpXQ/Fa2EM5trdDhpWhs3ov9qUDA7+sHU2c
	 NHwu0w2x2Sz0Q==
Message-ID: <996ce47c-d16c-4063-bd85-8afacc75016b@kernel.org>
Date: Wed, 8 Jul 2026 09:55:28 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 5/8] bpftool: Cover loader metadata with the
 program signature
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: kpsingh@kernel.org, James.Bottomley@hansenpartnership.com,
 paul@paul-moore.com, bboscaccy@linux.microsoft.com, memxor@gmail.com,
 torvalds@linux-foundation.org, a.s.protopopov@gmail.com,
 bpf@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260708075343.358712-1-daniel@iogearbox.net>
 <20260708075343.358712-6-daniel@iogearbox.net>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260708075343.358712-6-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2026 08:53, Daniel Borkmann wrote:
> bpftool_prog_sign() signed only the loader instructions. The metadata
> blob the loader installs was left to an in-loader hash check, which
> the kernel now performs at load time over insns || metadata.
> 
> Sign that same concatenation: pass the metadata blob (gen_loader_opts
> data) through to bpftool_prog_sign() and feed insns || metadata to
> CMS_final(). The excl_prog_hash stays a digest of the instructions
> alone; it binds the metadata map to the loader and is matched against
> prog->digest by the verifier, independent of what the signature covers.
> 
> The signed artifact is now plain data: both bytes the signature
> covers are embedded verbatim in the generated skeleton, so signing
> and verifying an lskel is an ordinary CMS operation that a signer or
> auditor can perform (or reproduce) offline, without analyzing loader
> bytecode to establish what the signature actually attests to.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>


Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks!
