Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65CF32E732
	for <linux-security-module@vger.kernel.org>; Wed, 28 Jan 2026 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636300; cv=none; b=nRC7Tpq2bwZuoV/N7billQaCKK8cgeqK47D2OKxE6hCv2LnJ9QFE30pwzU5vuDcw9LljKK5/8gNWnm7ApsvZmzh2tz5thBqDliTYDfLFL+h0RPhO0h3CcyyAaeFalYItqTQJk2MxIB+Cq/6+2lYxJIeGRc5Fl2uGaBGw+Bln6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636300; c=relaxed/simple;
	bh=WYc6yVGFTskplgs4RC8sLKzhI4P8NcU5l+y8rtjtcP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRYBoaj7Dc4EAT3c3KfYQL1Pi4RIW59ImowN7rPkydkj9WkkhZcNIwlhbPorZcED4vS4Nq2ceJBKNFceT42657ZbqUTmSBZnTQ/4stDbuRmwuXNtJRn5yGuzvMlzQqUYb9A2tVieGvc8uTUD5sDf+WTp1+4sVv5zy780N1wvSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2+WvE7e; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2+WvE7e"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so2322085e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jan 2026 13:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769636297; x=1770241097; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oIcqgI/61wsdhLoOYDt2dcaN37j70DN6I8ZJKum8KEU=;
        b=Y2+WvE7eZn1BZAYoEo4D8yqDTReO/XKNF3Ht/zae+prg4hWyEIo7br/xPoDYIFWQPo
         lj0YpuTbWLLPvCKtJz/rDaUgNpZhP9sFuC6nfssLPrxYJwtW4LCaMIYfxQWBOB317dHJ
         Ovm5Sc2dhpglxLYFt1zcxEPZO+aeM0Svjh2dd+pAnXkIrj86B+UpcXkf3vkdq1evAI21
         JH4nUStknGlke+OdpyyQ9oPkKYIH0bEnpE/x1mZeZgPN2NacIXQkST22PtgLf8yqvRO4
         ekn0YLGGntmk755/GJ1AdxfwUG2jLYxnmVRc69o5oYQRB51fww+c1g8PSxElDedXID+s
         WGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769636297; x=1770241097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIcqgI/61wsdhLoOYDt2dcaN37j70DN6I8ZJKum8KEU=;
        b=gW9rtOdyW4beCUCV/RRuMCc1UnGd1vye6wCTV3maxotjbN/HSARGn6h76hUmFmD1fa
         9rLcU9+2ta9DE/i0Oo7P6nw2PfYhHNwncS5lSjUnRenBn+NvVEy82KVW+V6X/c9b15Za
         DGSgDJx3T67usibCzLMb5/ix5r22zDq0sp7KE0i6TQqeeZ+cO3w4tvLGos+B7EujK0FR
         rIGJeV21LOASyUPwAQQLZ/7DitgeY/s3dacPHp/Jr9QoDZhcwKEXcC3WAmCvL1eBGyhm
         IDILkQJzQAEmaP7n0C+6RiArGXiMh6e8FCQIo3Ese+aTqWK+5wk6OkiFjPTSXwnZfUsX
         RHxQ==
X-Gm-Message-State: AOJu0YxYIFfQ3GEMPI0y2cpIy9EIGBwgkd6e54xXFkWcUHzX2QQCHq4c
	lDYzAfF3G2Y6FZeF3YF2siWYIxKzpzqvTXXkiLJ3EDtDNOCL74sDlCyp
X-Gm-Gg: AZuq6aLCWzZF+FkeGrfsJp0aprnxeKBVjTguW6fBMz3TttL4lqOvxuAd8wENpx6+Zcy
	6VNs1gDNpmI8isVHCbF9RE1C2rPvMzjTbOj3P7Sj0SWZcwdB6LOzZnD+N7vUS7TGFP/d4l2lUPb
	HPLTwg6x4zTD9hbLr2/AwbSyguu2o9NR75M5Nqw9t9RHeQOnPeONM1uvBg20LnDRmtEHXz3UGgX
	9sKwN7SDgjNYFnCDXPj8FVAdD+BsO9CckdCfWVkSDmku96NvkYs4MfPw/VfXx5MGs/wS4U3vC3m
	nchEmZCEFYcVfFh1mP/dXsrd1xbsdUOuNK6J7aVf5hlJJAHvR0fxcM6NmfNdCNZAmLbzafxoqfz
	v48280hYuyUhCyLbfBxwjcwH1Tv60qFXmS+qoHE90ZNXNPZZ+2moJzoL0dKcJns4cHDvBlOgdcr
	z9FMWrmP+OGdtLsiLOmGz+vZJHA/vLTZNKhVm5
X-Received: by 2002:a05:600c:450b:b0:477:9cdb:e32e with SMTP id 5b1f17b1804b1-48069c206c8mr81474545e9.9.1769636297101;
        Wed, 28 Jan 2026 13:38:17 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806e2bb8adsm1835225e9.7.2026.01.28.13.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:38:16 -0800 (PST)
Date: Wed, 28 Jan 2026 22:38:03 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 2/3] landlock: access_mask_subset() helper
Message-ID: <20260128.bed7ae06d8db@gnoack.org>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-3-gnoack3000@gmail.com>
 <20260128.raiD8oseH2ee@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128.raiD8oseH2ee@digikod.net>

On Wed, Jan 28, 2026 at 10:31:52PM +0100, Mickaël Salaün wrote:
> On Sun, Jan 25, 2026 at 08:58:52PM +0100, Günther Noack wrote:
> > --- a/security/landlock/access.h
> > +++ b/security/landlock/access.h
> > @@ -97,4 +97,10 @@ landlock_upgrade_handled_access_masks(struct access_masks access_masks)
> >  	return access_masks;
> >  }
> >  
> > +/** access_mask_subset - true iff a has a subset of the bits of b. */
> > +static inline bool access_mask_subset(access_mask_t a, access_mask_t b)
> 
> What about renaming "a" to "subset" and "b" to "superset"?

Sure, sounds reasonable. Will be done in V3.

> > +{
> > +	return (a | b) == b;
> > +}

–Günther
