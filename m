Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421BE1E9B3A
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588544; cv=none; b=Uky/JtsK7yfpHnWmNIeGyBVTQgF0pOiPvK4V/8RSo9G9XJDnvZzLTRDzCPYhrf7juJxWnHR+J73MBwvwo49TiQQsJZt9QFiW+Oaq+y2xqUnNwRPM+1yzpi/Qex3b3bF5+PRAL7EC8or0ql/3fZ1Fgdrj8xRVvuWqzjey/Wpjatw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588544; c=relaxed/simple;
	bh=A0dZxMKsbipHr+YmpPxr1arqOmaB/CImRgyj4hZWBZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGHU2uFwHF5GpD+YdqGHm53Xq6AmeQZ7PcUj2+pG+Clv7r2j3nSmEiOtr0yikL1tir8CfOpVsRVo3rVTypXSgiLfPlv76pMRIzYwCYnUc6QvxEnktJS+/qCIM2+VFDTfCVs2yBGy4ZjxZoCGuyc2kGIxv1AZ5RAVCeKfIAUn4qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtJt6pzs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtJt6pzs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso40627335e9.2
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775588542; x=1776193342; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SRNDi0acuS2EGtIgjauyvPjO7GwuUOFiV8WNTsIqSok=;
        b=WtJt6pzs5Gbz83gxDesHC+ElJ6rmks/QqhyxrGEr8J+2yp6pLYsj79tnZZjNzF2Ve6
         bcGZkojw/jf6exikiMebFrI6V5lTsa5J1ZgRBIkT8zxaF1/6OPlDoh3hr7Ya/WrQHbvY
         MMiefDGWZxFlHUKV/iUUwESFZoNqXL0S2Ha6I8kJJ3ialFQpUlruBQC/+at435K6dUnv
         Qj1nNoodK2maw2KO/vbKez2PS65/SaQ7A7w+fFwvC3ziXiWFQyUqvWBkqyDpGqlnf38f
         OVnjzCdPFjDJaAwFMCRpb+EO044eNWxM7RprdOA9RDUK9rQWlYxtOmdNvKcGbUjfjymU
         eBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588542; x=1776193342;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRNDi0acuS2EGtIgjauyvPjO7GwuUOFiV8WNTsIqSok=;
        b=LRmPzsbafiHVOtZJ37ownqL9ALBHnbACntdDXW5de9Lqfsha2YSAbrSdztagH9fpfm
         dzPMODmq1gFDjLJbX+LRUWCr3AccYQyn4w1dm91f2oasMaun/9HsNHZFyENHFPrQErhA
         b/P8U8xxRm61wegOcMM2vAtUXbJqmcWpxu4REmtOiIhuka1IfBlJ1fmO4byXz6Qbl0zF
         2OGLj9T3t4FMWpKi0knbgJO9HKxV2KtSj1v8VjYzvzMHpqhlvJmfpKifx6PsLXrb+c6x
         MSgJ9e2sLByl9ldinKVyAsF3H82RBI38imYWP13O3sXvzX4tvidWd349jSWEt1MzB5kL
         9cKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBhDsKQ6Y5vfrDW5FZwyuVxiPce6lm4DRObBjj9MAqMl3Wnh4pmn+udeHI778jqYbB7T5TGdOHfAFByWnrTMyKZvtRnls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRBb/oxXewDDxIbLIPkATNa4Y/ABa2rcya7eOnepRc3Slgtih
	qAHaeIBldwV71xq3DvB3asTZpQg501HLyimxFtyWaNGloxsJgogxejHi
X-Gm-Gg: AeBDiesX6PrOaKjOWzxMdcIfG4PnhBPI1lo7N9STnr7nwEf5Ft8MALTApcfWJ3XgQF7
	pWT9yvpfTJZWKC0f8yjJKd8prrAXlJgHTWHCDbAxXdBYQyV5LBg2SDcoJ8+BrWZQ6ovPm3kTvvk
	OFMCuQ0KfVNxeC+vz+jIBHWdd8Iym5ktPgJHHvCa8u/fYDylxeaVwBQ0PAQXC/x5C8BDfqZRLvN
	6F3cmpqQ+gtBLVRzgk0+4BlZ6EUomjys55lPG3J4mGDWDYjmlImDZJxrGYKvL5Zd1LRyPiNcSE9
	YgeyRrAmqp7z0/BIyMXrGWp667UhZbLnExfDWfxBixPgIa2g071MpiQFGbcr7a9I/VEj0ByA8Cq
	4lPzKWwTqSVQV39gNa7Y7XJq1uSKlAZcByp9Mta52pU6WmiJP+PKgZAx7IgOAEBC/k2B8LbuRHH
	0mTzZU5365PXutvDuJfUPgzUu/JzePQ9d97JIO7RuMRo3wcGZnfNHj9Pdj2Ck=
X-Received: by 2002:a05:600c:8b06:b0:486:fdca:ea8d with SMTP id 5b1f17b1804b1-488997b7b3cmr252429445e9.25.1775588541621;
        Tue, 07 Apr 2026 12:02:21 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889f6843dfsm375944555e9.12.2026.04.07.12.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:02:21 -0700 (PDT)
Date: Tue, 7 Apr 2026 21:02:19 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] landlock: Fix LOG_SUBDOMAINS_OFF inheritance
 across fork()
Message-ID: <20260407.c5bcf75b96bf@gnoack.org>
References: <20260407164107.2012589-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407164107.2012589-1-mic@digikod.net>

On Tue, Apr 07, 2026 at 06:41:04PM +0200, Mickaël Salaün wrote:
> hook_cred_transfer() only copies the Landlock security blob when the
> source credential has a domain.  This is inconsistent with
> landlock_restrict_self() which can set LOG_SUBDOMAINS_OFF on a
> credential without creating a domain (via the ruleset_fd=-1 path): the
> field is committed but not preserved across fork() because the child's
> prepare_creds() calls hook_cred_transfer() which skips the copy when
> domain is NULL.
> 
> This breaks the documented use case where a process mutes subdomain logs
> before forking sandboxed children: the children lose the muting and
> their domains produce unexpected audit records.
> 
> Fix this by unconditionally copying the Landlock credential blob.

As before, LGTM for both patches. Thanks for the fixes!

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

–Günther
