Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A52489866
	for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318150; cv=none; b=Xfn/96TXpvHwQNyGIKwCHdrGXndbim2NRAA4UgKLB1yz1npXveLew54Hz3NpNsJ0sX1LhmkOBdc8Erf1PhFKfBGSUAV1j1AXb5AiINMf6uENH+C+zbNhV/15cc3dTH48XW9rrEI23ZG1zr4lBBUo0tVOROk6Xdfoqdwgi23XI9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318150; c=relaxed/simple;
	bh=TOgYQZ829UyU2jOilwn5+g3K5dTtN7xU+CJosTc4jVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzdcM+GwYPRpqmwheZjSDIvvWbbQ8cq86IGA+PvhW6imHEK2fr1xsGrpzRLEA20U4ZiiNrGXmjdbwvRoUtgf1kDuiJGY6MMADcUHzhyyA1YZ0cFBXk+Wmv1kANb/rZHEoF+nmnSsLgcdMrBmNlGDGvLttZ7zrR7Yh5yvO3WOI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMv6j9VU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMv6j9VU"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81ecf499af9so15153477b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 06:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787318133; x=1787922933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vH94uxfMfesjNr68TvUP5/weYC42qiuv499mvdY0TYU=;
        b=aMv6j9VUq+cFb/uq0Z438I+ZDp6BJvKZ/zxEsEacDqFOpbbz0pKLicmDd476xMtN5k
         SBcT83qoMKjq44cW68L3Jf3nbgoQ6TxhsJhH5gph+M/75MknsCC3gkgoBrb6DInYZ98m
         Fa2fYIeVkObfP+CTDRbIRMk/veMmwiFxXgXrKhhNFyuVlwp9uqAqEWrUmbLS/xxT2h54
         qAF4wkt3KgyrdLHBm18jcqX4HjFLPb7xEvqK1VurXTjP+jZVztuUb+08uvRIY4j1C8Uc
         +yC1u315UvFgitDEq4DfCotXT/hUs0qWJOqiNJSRVx2z1c467oHbEGuojGQWLct0CKZ9
         WmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787318133; x=1787922933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vH94uxfMfesjNr68TvUP5/weYC42qiuv499mvdY0TYU=;
        b=IfaAqeJHPjsHoGnW7/Mi67s25tN05FB38UwoXZwe2yf6p/ywyfHnnACyreXoGYSc00
         AQljck1tRHGbrgo0+rwjhLatiJZhmbKpvoQLEQ+m5ftsYku1Qzs79hefy268n6ORopoM
         TKRPryL23XDzaj3qcv5aIovJfpN9LqtSshXWLqs2NWkw1wCxfYeO5OhS3Qe96yoI4GXe
         +zfLubvB7bmb/BaF7108GR7y9g7xb6itGzpQga6D364EZmtQs2FpJI31ExgEwJLT1n4K
         YDWDilzOSVzYfyMwmxunq6bypa4JR+Fu8AKWVXMVapZtLb9hbPsdT/1UN+C9X/ckxkHF
         oH+w==
X-Forwarded-Encrypted: i=1; AHgh+Rqdc4DkAJ1T9v3+1u2KUrZtF9tTV+JHHQdf/+cW786rLFYNd9XjUBwH+EVIBeDX7e1phYU0+GC5G9LbWTV2d/xC3x0legI=@vger.kernel.org
X-Gm-Message-State: AFuF++kjrxonzGXJapGARE78Ceqvwbl+o7Dncrre1ZwxCkhuVYLqSWz2
	s4ypfw1xQDYJzuZk7+q/iFF9514NdZ0ywoZt7XVkc7yWdWoBJ7pXluei
X-Gm-Gg: AR+sD13ffThmXP8VpdmiofQKBSVwt5N9kuot187bS64H4YMuvS+iCDJMrGhfZFz41eW
	jAGuwFAMovQ3UEaI78CIIMlZPwipMjx+JOdAPBE2gB0vpYLWClDT1rm3HY8iBQaBp8yXAEALD2I
	Jb4O340Mol++6cVPSmgiEus+ZQC54aNOeG0zQGJBWlzrNxGBXWg0029CtdPYr31OKfPgsQCJ6bm
	eePP0HfH6NZc0L6hZryoAKnbMf+6twgGINCVPSM93P96V2d3K+HQ/SycDELgbCbbdjjI8AjyXCL
	D+st6Poj7bOyEOGzV/w2z8/c7HifptgLWPKZpfclS+vn7CPsBQDN4/6BgSGemHQP+/qHzP0DZYE
	5gqMYGo5BsR3Dk/WQ1kgwTma252qmRwQV2bd5lkY879nCeo74r9vxEGPU2iuxd1ed1+LmFklVbu
	wBYZ7vsAgr41+4Lw3wgvyLz/jVt+RZvnInNNgJjulwHOvrUAXzTD8Bdl9+XRCcKyu9Qe1QntLuo
	UactnfpqdnOZTETsrqmsA==
X-Received: by 2002:a05:690c:2702:b0:833:a89f:6cab with SMTP id 00721157ae682-849f0145609mr29244477b3.2.1787318132623;
        Fri, 21 Aug 2026 06:15:32 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:350e:631:3b2c:9519])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84512762addsm39350687b3.15.2026.08.21.06.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:15:32 -0700 (PDT)
Date: Fri, 21 Aug 2026 09:15:31 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: mic@digikod.net, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/6] landlock: Bump ABI for
 LANDLOCK_SCOPE_SYSV_MSG_QUEUE
Message-ID: <aohKoD4GqIFR4ni4@zenbox>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
 <20260727230833.138165-4-utilityemal77@gmail.com>
 <20260821.ad614a879e61@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821.ad614a879e61@gnoack.org>

On Fri, Aug 21, 2026 at 02:38:15PM +0200, Günther Noack wrote:
> On Mon, Jul 27, 2026 at 07:08:30PM -0400, Justin Suess wrote:
> > Bump the ABI version for Landlock SysV message queue scoping.
> > 
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> 
> The ABI bump is normally put into the same commit as the
> implementation for easier backporting. Otherwise, looks good.
I'll squash them.

>
Thanks,

I did wonder about if we need to use the landlock_object here?

I'm pretty sure SysV message queues stay open after process exit,
which could cause the domain to be pinned by landlock_cred_security,
if programs are lazy and don't close them.

So it probably needs to be a weak reference. 

But it's unclear what should be the behavior there when the domain
is dropped:

1. Should it become inaccessible and belong to *nobody's* domain?

(i.e when owning domain is dropped, the queue belongs to no domain and is inaccessible to
all LANDLOCK_SCOPE_SYSV_MSG_QUEUE scoped domains)

2. Should it be moved to the parent's domain?

(i.e when owning domain is dropped, the parent domain is the new scope,
and then it's parent, so on and so forth, more complicated, but more correct)

3. Or be kept as is.

(i.e Allow an open sysv message queue to pin a domain
for it's lifetime)

Either way this almost certainly needs to be rebased since it's been
a little bit and there were significant refactorings of the domain and
ruleset structures since the tracepoints series.

Justin

> –Günther
