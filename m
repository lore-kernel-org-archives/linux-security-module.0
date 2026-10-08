Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9632E141
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470037; cv=none; b=ZOh0B3vZqO6OBr0WqGu+R9Fww3TiyT3yRcHhOHbvH/UmRggZovYUXOR0wfrEZ8TbC1miV8qCt0RZ0sJCIhny6s4FMFYrVY8lHeWPCddyYv+zJ1o8NpdVizWtTPvWLxUf2EgdMpxPcQq5uk8rdi//GmRzTI2hHFWCFtp8rQlwzbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470037; c=relaxed/simple;
	bh=5lqxpESQ6V/XicaJ9Xaot+s0L3lJnZcBFbt0R2o49qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXU/I+0Hb2wrpC0YIixc97buwCDw/uKGj3LQ6THD3oByIkhMgxJbfn5ixqYHOa/jK0BzFNeWLD3rQP60hnXLbSmJrEWZwXSHoDbO8jNKRIvthDX+kihekzI87jIj0YYhIEo7VP9QWPabIUP6m1QjYJp3RqtfjY5HkrnjUAx7bRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3+ESSoK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3+ESSoK"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so4089715e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791470034; x=1792074834; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hXPzoBizfB3Zhzp9AvQgFrXj/t3qSr+rJK2orUNhlP4=;
        b=e3+ESSoK+uCegrZcJDnhCvg7WCuK7/Kuewr08hu3JWTgOEQ8m+uSuxe/ZM9HvRVjlY
         aGz9Kr4QgttA4apt/xsDKPUhAxvzRS1AT173njrRg1BAloGlXdnpnNAdCMNwqLUBIK6I
         eVtU415adglF0fsttk0tvMI92nTII0JWz5PjS+wFrZQ71Y+9oivtp4UYTQHaY6LELMu1
         1GcKQEHDAPAcm/IBGmPfPF3N/LnQu/jt/m95c8EbBqbuje858oybzfew8XDWVD+qVayO
         tugg9467ixL8Bzrx2Kiq//W8QvU7XNzucCzuCO15aTzlwsJ76ZIpl7EKwtS5yHP4T2C8
         u0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791470034; x=1792074834;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hXPzoBizfB3Zhzp9AvQgFrXj/t3qSr+rJK2orUNhlP4=;
        b=r/XHrFOkgMPa/9G3BrBDMPzq5y/FbxBPzU2KhzjiojNLW0jMatuCJQWDpz0m0oKxBp
         RxWwy7OHg5m9Qtb9JMBHldtrST3cTZrxKNYqMTVYOnwswmrjbOnklyOLuxWJ6Ij56TdB
         o/jF2jZNhWdORJgInAMEHGZeN5HDwmr0vctElqwZt3V8WWjBM66ou4cGior0xkyuBqmY
         NLu13Evmhz6adZM2nOa6HCgYSNsextBM5mKp7JTur4nQJigCTjItGfpJnPUY4ej5z9wC
         QctPKw4RN9aBv18GSzT10Zrz3c28jRIZaK451pkD2GJ+bDYZobDlFtqyJFfc9xnhzvD6
         ORDA==
X-Forwarded-Encrypted: i=1; AKwUvBxct/lXsJSg8z+i4Ot0tQo5X07on1WIu2pXMzhUSE0E7RZ9QhGoTQI2lCJZSP9BYBSGSNwawz7jRWczaP5dpMMAzQQ8/Q4=@vger.kernel.org
X-Gm-Message-State: AFuF++mpZBFGNV4EVVLd6NGbxd/wt/1POmKVHgNlWLhgP3LTWnPYr37I
	QG63m9L4UfWd9T/ZXIDdIC1nffESuMvgKPbO1BCEMF9Dux//kLehFGQd
X-Gm-Gg: AYBFou2C8/zZb2YMitAdY2WItAByGmKppi6hxJ2zOyfDFcfFTorq1p6e26T0QgG8C11
	GQrVKJ+KAkVe0tLg/PT4PBGrG510XVVwzHnzdLWj40Dj4py/lZvZwNejJE6Fka2Jqg8SR87+OKr
	LSVOBbE8TTx+amv7RmWByv8DmjnEzT+07G6BljT1SpqSozwZlrR3RVg/XJNQnymhw+nHmPeY//9
	SpQ+PxtGDmXSd371Z05L8EW5lZK0ISKD3R5l5byrIKSdLl6eNCOGtsTB+mR+Hz97W2EWAZ14IX8
	MooWc54R0deGI8vDaX2nKhp/e8wLbg7i2QFHw9KyFJTXuV2UXsOMYdTGMojAysw9Cg8L3IdV2DT
	qxFYptpMIALnGOjwefF+YZegjkGwggafa20DBu94PRwuBfp2AftugxuHwD0+Ryuyt0/nGMYxoCq
	zKetrqS2C9ftzM35rfb8e6gY93KgztaUThx4xAr8iuH5NJo9F6aAsLED5qumCsoBN5Fs3hwGslT
	cZ0Qwca74BIwCZi1f2mofg=
X-Received: by 2002:a05:600c:3f14:b0:4a0:1c94:7042 with SMTP id 5b1f17b1804b1-4a1802eab45mr119115265e9.8.1791470033804;
        Thu, 08 Oct 2026 07:33:53 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18360c5ebsm57776665e9.3.2026.10.08.07.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:33:52 -0700 (PDT)
Date: Thu, 8 Oct 2026 16:33:51 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>, linux-kselftest@vger.kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/27] landlock: Selftest fixes and cleanups
Message-ID: <20261008.ad487961b23c@gnoack.org>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261008142604.39107-2-gnoack3000@gmail.com>

On Thu, Oct 08, 2026 at 04:25:29PM +0200, Günther Noack wrote:
> The last few patches are a bit more cross-cutting and probably more
> prone to merge conflicts, as they correct cases where we have been
> using EXPECT and ASSERT in the wrong way (details in the commit
> messages).  I believe that the rationale for each of these is
> reasonable, but I am happy to discuss.

Minor post scriptum:

That's the last four patches.  They are large, but largely mechanical
refactorings.  If it merge-conflicts with another selftest
refactoring, it should be possible to replicate equivalent patches
relatively easily with the help of an LLM.  If you prefer to go that
way for the last patches, that would also be fine with me.

–Günther
