Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AEB45D182
	for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587436; cv=none; b=GeitHmYvSYdyYJMwnoYpWhODoYIwsNUsrzK0JA50ugzdqf+FWUy65TF4S0mDxSuppO5PhXWT11Nvpml6J4dypTzlAOI8f6N4/H9kj79PuD5IQNkX4C6uN2SIJblf16Qh4O1m252ZKDrmwqHFHbO6uVLsw3jWrIKy+Fi31RWPPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587436; c=relaxed/simple;
	bh=7zQx3GnM7KjvtJZrpo7rMHkOTIarYOBO5QCYE26EmNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLePVcJjOHklf5qBEexML2z52s3bkLi/iC35jbAFE9ziTaaUUvrtigKaAPPCO1aTpTvC5zW3uXF5bWJO/VUAIrCk5dUgAQJ3QO/r+tI0eo3dzeAF+/IJtQU+vw0VqKiiRNz2rUKd6ec4ckyINQasQyTgZ2bExCUnA2fcBP9P/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XFMA9uwp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFMA9uwp"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2022323c37so578182166b.0
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787587433; x=1788192233; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c2tljJuoFxVknx0eN209NVYTMTtwPyJgSuYRQ+fZhAs=;
        b=XFMA9uwp48fa9srmtUsbn5Id8RKvoc8SIdWoYgW9G5xqOSPXsuVTIQIUUkuPG4WTRa
         EmVmVMzG5zmZBTlRB1N8D6OOr282NmgjtsI9ndIzi2D82BqFAMXJ6bCg8GSLJ1WAoCKX
         i/YMB9jplL7FXj6KNT3Kw1tGVHUxl08USVfSPVJlVZTsm7KPDY9fjpJmGhXdDZLaAkYW
         2+WXZx2/kyOPv4oz0urPEG4gWxBZU2Se5Ds3RT2xEUH0WxA6x0csR/cRYKSiH+tHotsM
         wHsXeqRkaxWCtdQsrFEwoaIhadTBOCP+7F/vE8PAeiPt5tV98nw0ItIPbps6rxkrOXye
         GnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787587433; x=1788192233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c2tljJuoFxVknx0eN209NVYTMTtwPyJgSuYRQ+fZhAs=;
        b=L5vVno4Xwf2mxGfJIL1Yzr12Njy5s0y40+E5CxyWMK277MtO5vYf0anMXcnn+VWne7
         3HDJRjAwNtiLW8v9Pbl4v74abw4zemC954WNlMJLPAH3r0BYmAWkXqLmtE29JWhVvCdE
         2Bnuql8Ua8tDeSnUZFcJgNnKBzPxxAO3QayUZHMhNflL4pWMZfZzPYc+tMlr926mR88g
         bb0Q/PJsqdUjNIGsw6HtzANEXPg7HlVeLts5o/6sRNjamwClV+2bFbdd3XpgIotYKYck
         U7gMALeMawsybfoXTd6MSBU305bJFe1lkQHzp8rcI/CPPWTiSfLI2c6o0vpJKOrOkWMA
         TM8g==
X-Forwarded-Encrypted: i=1; AHgh+Rr7oX8jLro1flAWsKZT1tDi4LYAaiZvo6Qnnl8BoPVXhx/63CbvFAuxlj/afmUO84ixhzSm8dMQ+IjbkmtMzqs3MOYWx3M=@vger.kernel.org
X-Gm-Message-State: AFuF++lEg1CYdkMidP3yjRtjJ9be3L7auRoHB//Loh79wylfvIALTHtk
	nY9jnpZA0Ifv/k+Sr0BlGWhsyYuw5iftlXSiZnW+hpDLFT5badO7qw6JhTgohgTjMg==
X-Gm-Gg: AR+sD11Fo5DL1M1gudwCVppT1AfHl8NUGFPK2ECjIwzwpgbid0Xcq1Kz21iYY7tzTDB
	v5EFmI6nSNHS14ItNKgfjE4NmXkzVvcnYLsPZZ71r7nqIpvsX4HDfwVE1dK/WhzgW3AIFWP3uwf
	L+SDVSkilKLyCXsSlc8l8RdoTy5H13wLW6nFVInqa8Cn85DPX5y6NccK3qZ7h6SjsbJ/YhmR6Rz
	uTfMOn7eSc1nobhwEZFduospMD9EKuIg7ieY4SXCQHcI1m7P2kQjuGmz/O3f1Z8p0pM4SGTR1Sc
	jcAOeFzDFrRC67KylhuDFVTG2FWiBxCXSMLcvxJEw9AihGQPg4HsrstPIX+MOGSFhY/9G5tpRzf
	H3wijiRw0h3wEfHHW44n4kWCI0NwZhg4snwimuXSB8xsFudVjaUhogXc7UX+kqzSBihuvmW7Jmj
	AfxmGcODlo+ykKwel46YeUdbSRADqmHM1RqT+vNwhWGRJ5D5AXPne/7hk/6kRSbGXDpWhpG6Q23
	suWddqSRoiLZpE7uGg=
X-Received: by 2002:a17:907:e901:b0:c16:769b:9838 with SMTP id a640c23a62f3a-c246a2eba8amr3008972766b.5.1787587432258;
        Mon, 24 Aug 2026 09:03:52 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:c1fb:9c12:150a:ef4a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24967383e5sm1269779366b.45.2026.08.24.09.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 09:03:51 -0700 (PDT)
Date: Mon, 24 Aug 2026 18:03:47 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, mic@digikod.net,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] landlock: Add scoped access bit for SysV message
 queues
Message-ID: <aoxrY9Iw05UhrYI6@google.com>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
 <20260822.c9dcabf4999f@gnoack.org>
 <20260822.3340c3dd2a46@gnoack.org>
 <aooS2VVhwWjY7ugo@zenbox>
 <20260824.abc934a59c55@gnoack.org>
 <aow07i8dFO6EAB-K@zenbox>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aow07i8dFO6EAB-K@zenbox>

On Mon, Aug 24, 2026 at 08:47:28AM -0400, Justin Suess wrote:
> On Mon, Aug 24, 2026 at 08:36:10AM +0200, Günther Noack wrote:
> > Agreed.  I am personally leaning on the side of closing the gap as
> > well, even if it reduces functionality somewhat.  SystemV Message
> > Queues are used very seldomly (as can be seen in Debian Code Search)
> > and it would affect few programs.
> >
> From msgget(2):
> 
>        A new message queue is created if key has the value IPC_PRIVATE or
>        key isn't IPC_PRIVATE, no message queue with the given key key
>        exists, and IPC_CREAT is specified in msgflg.
> 
> So more specifically, we will disallow if all three of these are true:
> 
> - IPC_CREAT is specified
> - IPC_PRIVATE is not specified.
> - The queue referenced by key does not already exist
> 
> Or if these two are true:
> 
> - The queue referenced by key already exists.
> - The queue referenced by the key is not part of the scope.
> 
> Effectively, this allows as much as possible, including msgget(2) on an
> existing queue within a scope.

We technically allow msgget(2) on an existing queue within a scope,
but if I understand this correctly, there is now no way to *create* such a
queue within the scope.  So effectively, that msgget(2) can not
succeed, no?


I agree with your sentiment that we don't need to implement the
allow-listing approach right now.  It seems like significant effort for
a very small number of use cases.

—Günther
