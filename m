Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0CF4E8DF0
	for <linux-security-module@vger.kernel.org>; Mon, 28 Sep 2026 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611074; cv=none; b=qyiifbgk795gkEeL0AxFUzmEyH1Y2DQ/cdt3CQRXNaXZgac7fmahXnKGmj82ngulyGeSCCWrkIJixIEUWyxNu90YmQUuI6ntuXR7+lPewRtTG6AFesGCjyIFUoXqWHTlLZP3Q3Iz5zVxRzVvsTyIvhfMdyzrB96zTzw7OyBNJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611074; c=relaxed/simple;
	bh=6RkanIU8PVNUWTxE1K3cu7f8GzkfvZEBor6PzaFNVPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNUEcRh/6k4bOdNQ6XuX8ro5kv1xiDas3FZcVK7Fl5WIFLetmFXxM5I14nIzUQFhcoYop61DkMQh0+DUse7f5k0Z5Xx89a9NMpWnItkospOAKINtsJlW9hmQx6zgTL3OUcYHPjofmjwDHQpUlIHr7YKQH8gjTex2sz5zZnMadEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKH7K+3w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKH7K+3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E27B1F000FF;
	Mon, 28 Sep 2026 15:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790611073;
	bh=hmQfzqKBzpuF1e9TDzlCXiPdDH8rd6Ubz85gn3v4kGg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bKH7K+3wX23e4ItVQihBkkVik3pLCRXuJTMAd8HMnVX3YXjyAJqVJLUKLiybE5o7C
	 ZpxwT+RzRbV4YAaD9iG7Q/ZBw11zcaz1qCy4yEka2nHvR2+a7zzK9ZbrTTdgv9+epc
	 9ZxtOFIP+MtdBir45yoc+I61CzNmSu9gFtGH5WVuqzcMULadQKaC5U9mjTI0UYRVNM
	 YY8ZnE3wZa7wtXBNIYTfW0HyMZ6u4pgSGE06yfINXg3BlUJMD65DUvSaT4SwZ6HODj
	 2SSHFKO8zZTUPlIZQ0Cbinclj38kQ74w7ihuLPx7kJ5CD/MncuHdYjxRh4wU+A7ZdT
	 oSr8mvgO1/iuA==
Message-ID: <9699317a-df42-4ae0-986c-5602e66ae773@kernel.org>
Date: Mon, 28 Sep 2026 08:57:53 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: name the wufan/ipe next branch
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-security-module@vger.kernel.org
References: <20260926055223.3678216-1-matthias.goergens@gmail.com>
Content-Language: en-US
From: Fan Wu <wufan@kernel.org>
In-Reply-To: <20260926055223.3678216-1-matthias.goergens@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/25/2026 10:52 PM, Matthias Goergens wrote:
> The T: entry for INTEGRITY POLICY ENFORCEMENT (IPE) names wufan/ipe
> without a branch.  The repository's HEAD points to branch master, which
> mainline already contains.  linux-next merges the next branch of this
> repository (Next/Trees).  Name that branch in the entry.
> 
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
> This is part of a cleanup of all T: entries whose repository HEAD is
> not where development happens: one patch per repository, sent in small
> batches.  The plan is at [1], and why it goes out in batches at [2].
> 
> [1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergens@gmail.com/
> [2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goergens@gmail.com/
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 140eafcbbd78..fc42b68e0718 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12960,7 +12960,7 @@ INTEGRITY POLICY ENFORCEMENT (IPE)
>  M:	Fan Wu <wufan@kernel.org>
>  L:	linux-security-module@vger.kernel.org
>  S:	Supported
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git next
>  F:	Documentation/admin-guide/LSM/ipe.rst
>  F:	Documentation/security/ipe.rst
>  F:	scripts/ipe/
> 
> base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9

Hi Matthias,

From the related discussion, this looks intended to stop Sashiko from
picking a stale tree as its baseline.

For IPE, I only update next when there are patches queued, so it can
remain unchanged for several releases. Contributors should normally
base their work on Linus' master rather than next. Naming next here
could therefore lead to the same stale-baseline problem.

I also looked at your Sashiko PR. When the default HEAD is a strict
ancestor of Linus' master, would Sashiko use Linus' master instead?
If so, that's the behavior we want for IPE, and there would be no
need to add next here.

Fan
