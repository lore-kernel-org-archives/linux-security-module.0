Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72B1C3C08
	for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768168351; cv=none; b=nALXSzNckKJ/e19EwH/+awEErCwy6h/VIdsyAmTCrJy6bTiusNMC3DZf1V3H8AWfy7iObs9D34XqWB9YO73DovXULknjs0wX9MS4YXt3cEGykA05GvWDJzdTmVLKASdx2vQEPNyfdzP2850efDiIw89wSy/cTERUv+26l6JVARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768168351; c=relaxed/simple;
	bh=7i9wmAonBkjzSpgC6TR17eMlg0LAMk/IRGLoNI1hGmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO6WGYfiX0ibqDrmIIyHsw8K5CkBLV1AYn6lqcsS0tbawnmhW2ewv/LwNIdcmVkdul3hGNztx9CrM3PaPKyGGVr9FWFMD3nByOMdBQMgJrUi42TU8WT4ZVfk86v/KrYFDvVdDs3W7ZcUDgc8GbiklgAq3pDFuj+4nPlkpfqXPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0cExjo/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0cExjo/"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b870cbd1e52so92620966b.3
        for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 13:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768168349; x=1768773149; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m/uqq4ietx//Tb37s1HPzlI+vkFg1h4dQiCqJB6xoAs=;
        b=m0cExjo/cxT0ZFKQvFGH0IM9tPesYZv0lm61gMq9vZgdCeSFBKjnQwWbZpYUyxTqIY
         W4RdhY5WOwO/crR5M5gBySV3/i3jRBIYAXhnS4KG2zNvAD9cv3EgZv34MILCzmxxYBvj
         D7OIy742UaIAE9zxSvABg4QRCCEXI6JoNOxyRHLwcJWQV/ShbiNQRZt0q3Ih+XtC5I1+
         TFa7KDN9Xr6OrFEgkrLcovMlC98dmfkBMgcny59nMcf6nB0i7g4QfXOoL1Tv1Xinqx86
         928o8XpfnhM2GkY7XMaD4UnQAaFJZhgYs9IAHG9KW0TfHafMs4fcT7xae3f1hVe7PH58
         R05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768168349; x=1768773149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/uqq4ietx//Tb37s1HPzlI+vkFg1h4dQiCqJB6xoAs=;
        b=cTL7HZTqrJJMn7+bnnCpEdFJbMsS/ENm9T2JE+fIu9RYxE3tAFUfpbrhu26zc/B/yz
         I7IwU0P8EkNkaeMWZ59j/ylZdtUotY4nA8xFRufS4iHFOPXatvVXQYbr3/nKxKA6aW6x
         WDQz/TJBcAySCRBnsg2uMXL8vmg3wpv2i6inC9FbwB9HAuBHyfn8HMvdp4vYNPSmA5Ks
         JuBduszDOcpkngNn+FP3IdHvFN9G+81RZU9kCOZx7U5BVOE+hSr8akfgGCdgaD7ufUvf
         9LVauLKM0+LfU/V1I6SIl966lqnIcoodheMyZ3B4m7SwN5UVPRl07OrM5ho2eQS3epYq
         dekw==
X-Gm-Message-State: AOJu0YzRaBvHUT+l+X6AYy7eFrTv1EP5hBUVaAgLHCtmIikZa+mE0bwI
	6QfGCNURh3Xj4GaBKK8SbHHkBx/BaNRaie+cEshCDm1PrUqAa7S1J06n
X-Gm-Gg: AY/fxX5aqnHQHosF8j4Ltxzyu1Zzeh13rB3U/EBp9i223OUUCQqaThHShFLgc2dQl17
	7Qi8sPrkR+n6DiX6uyeTDSpABMsr0Habc+PSYiDoMLTEaXt41Z7L/V0w1rcS9sNAF3r8Fd6tGTB
	CacjttuzqNGWr5YOmga55WI78dqcMSDP2gfLBUESkSIlgkar3TCnP6la8iBxalKX84edba0Zj16
	7oftH3fO0yYqbrjgJ+aqyGQ1iMVVou5xFxmybngGj0ksgcx+wNAM6nBQ6Ck/g5NvTvvA5cEWAI3
	p2ac9EDk5ec6PIhJ+h8uEj4r2XY5K89t9hfNwHxwF6f7zoZYV5k+7I9fJncbOVfseXemKX8vxUw
	DbUcO8kXeZPlI2S1Y7b7BP6OCHwaTJ4pFRuYX401xzQ27s/X0kA4SOWSnhdMw5DoNvZeS12eliM
	MoB7llyY+5PI0++cfEbKq2sOpFn36OG6YOx9tR
X-Google-Smtp-Source: AGHT+IENk3yqyGGAWkFtEDcFP+0rIJv03UG7+srXlDDhpCLmFG3sSt48UCc8QR/5rGxXzDdii0huJA==
X-Received: by 2002:a17:906:59a7:b0:b86:fca7:3dc5 with SMTP id a640c23a62f3a-b86fca73f83mr334238366b.28.1768168348509;
        Sun, 11 Jan 2026 13:52:28 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ee5287e4sm539044866b.52.2026.01.11.13.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 13:52:28 -0800 (PST)
Date: Sun, 11 Jan 2026 22:52:26 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH 2/2] landlock: transpose the layer masks data
 structure
Message-ID: <20260111.11c57c607174@gnoack.org>
References: <20251230103917.10549-3-gnoack3000@gmail.com>
 <20251230103917.10549-7-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251230103917.10549-7-gnoack3000@gmail.com>

On Tue, Dec 30, 2025 at 11:39:21AM +0100, Günther Noack wrote:
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 7961c6630a2d7..aa0efa36a37db 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
>  [...]
>  /*
>   * Tracks domains responsible of a denied access.  This is required to avoid
>   * storing in each object the full layer_masks[] required by update_request().
> + *
> + * Each nibble represents the layer index of the newest layer which denied a
> + * certain access right.  For file system access rights, the upper four bits are
> + * the index of the layer which denies LANDLOCK_ACCESS_FS_IOCTL_DEV and the
> + * lower nibble represents LANDLOCK_ACCESS_FS_TRUNCATE.
>   */
>  typedef u8 deny_masks_t;

FYI: I left this out for now because it felt a bit out of scope (and
transposing the layer masks was adventurous enough), but I was tempted
to go one step further here and turn this into a struct with
bitfields:

/* A collection of layer indices denying specific access rights. */
struct layers_denying_fs_access {
  unsigned int truncate  : 4;
  unsigned int ioctl_dev : 4;
}

(Type name TBD, I am open for suggestions.)

I think if we accept that this data structure is specific to FS access
rights, we win clarity in the code.  When I came across the code that
put this together dynamically and in a more generic way, it took me a
while to figure out what it did.

–Günther
