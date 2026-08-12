Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673583905E6
	for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2026 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564137; cv=none; b=hVNrwUqP/dYVZB4e2fcbzTcYGZdDEEEi8lws+3ZuNjBdJ8VE7mH4YbAUiUXxqT2aQgaZ99qvFJkl+ScDauk3/1v7tX3gIVmu2iOI/4iccSWV8Oq15+v+Z8940AbTyqQS9A3mEtPr/6pkMeEBizoYRmqJ/Q0gCohYreBj5Mm8tT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564137; c=relaxed/simple;
	bh=grlyRpEoKiE3hA6tNWew7G9WF0nObQh0gnuy+mbCOB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtcyKMQxzHFWUNDG3/FsMmewI/ddV0euOb82VtEt9peXl5rc0cJDXBRLFHyGUDKEP9Xi7UQJ6EWfBCEppKX8RyM/dTMMml6LdFwlpTgmuHSfvgKIyvbNcynzkMmwa2ooXR26BYfj/OBLs2fi8XqtNgNdK/iVn0uzb4B2I57WU1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb/PAF3y; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb/PAF3y"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4997581cdc1so11288915e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2026 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564133; x=1787168933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pk1y5kPX81RVdKPhNumEwqKCXNR4n1vRQ9pjE5pHsAU=;
        b=Jb/PAF3yXfbCfI+BPD3ZvycYtEb943lTc+6oyJPKcfQ3guI/HbWJnjqgMV8Ir2IVBQ
         xa0AxucHt+ap1T8gscG5IUmSvHGr0HuueqgktWGSQS0kRlH93wGC5yd+U0sNQwXCGvJm
         AAF/PXJHALkAgMmU7+/UMhyoS3xLBrHml9mn4camHEehRWNnI8VNTPShqQWuhiPqvedU
         aCVg2fHzsRAgs02vlzAQ7Sm3IHrYEeZDFhWBUuXESd0MiEI52j3vWELNGkBVYit6n+GR
         oPQMqNV7HMuveI4bverfmRjB7WxHba/Z62F3eDNVmRV4HMs9K4dZeC0AOJ3KGOQ9JkC6
         d9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564133; x=1787168933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Pk1y5kPX81RVdKPhNumEwqKCXNR4n1vRQ9pjE5pHsAU=;
        b=kSZ8+hN9kbbMzWrvxpEyd439HHlBRUUzzy/mmMzYaDjz47Y8bbt2+9m57oMJYrB1ur
         31tSuV6d7r+xCPFulDdv0tv1yWbEyI999I4VuKdXLJZi9e4e5N/bwl/gOp+odOjt/p0Y
         KkdGwuD2KXhGKNIqyNygjeaaJHPwR6J13Yo5coUI7BnUuIjsoC66l+N4neZwwuBPMf05
         a1OBYlic9PM4bHSSrhuM3dBjbhIkSSEPb8Kc8pdk6B+P/HfFQZIPJAHsHXAlr5Uf0VKH
         iGoxt+DG7fyreFQKsTQffsd19Xk4Zy5SVjfjU6U9Q33SErrSmcpL/DfvHOiAcI2NsoUN
         G9Qg==
X-Forwarded-Encrypted: i=1; AHgh+RpCCkOfHr4tpRZh1H84TtWSnGBoMPXoG/gwApleggisvZX6obcoPg31bPCDdwEMapRjceBe7uHvgm3BcMkzJ7/m9EyRPP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNEVOEZ7DfR1S+zM2FaY+VYU00cUW7J/gGXOKFPv86H1UzTR9s
	KZJ6OBmUaxUEEAs7WObsJKBkQVNs+i7wiuB6oj1mtRs9NncYKFUhzR4q
X-Gm-Gg: AR+sD12lp/jZOv73aeEv58VbOzqUr71UdBlvSLznapQ/S21oti1e/8b42MKReOsFpiq
	xyAdeC/Mq/5rk4sCd+BCkAYKxkoyftWli9GdUYEfFTotzwg146ZD0bjjr6ebIprAwjgnSZ2CzkI
	7Puqy895OFGZfKR2w2qfyrEBlqun4MTkIvDUyVoZMHfnKw9FrqNRQBK723RhHx1jD2j1vpWKk3c
	c1sY5mRYX+Ylr3EYQbHrs2gpWKVFqQkGiozA454cxmJiT2giJcXcB46eAhFX71XJM2FVWHZ7FQN
	TlACkS3snf9iI66v2KOZuxU/cbMv8K5tsheIMoJ+YQ0YUmd0EkVaZY6YGCr3v69M6rl6iHa75oY
	af9cInB0gZLg5x4xY4CeT9x7Xqs1aE62hCrcNIHSi/J/kRYiKwcASDCj2nGlPrQ1j/Euv6gb+Cn
	PI1C37tQA/q443nneR+0jOL5gi6BKREZR6DPejpj/hTBMegVHzeohUyeybAEpEIz+qawuMDyZ++
	/F2mDSNRqkzlA==
X-Received: by 2002:a05:600c:4e4f:b0:498:261:dd93 with SMTP id 5b1f17b1804b1-499821a4a65mr1504065e9.18.1786564133353;
        Wed, 12 Aug 2026 12:48:53 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981e3d3d9sm4775875e9.3.2026.08.12.12.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 12:48:52 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:48:51 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 2/5] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
 whiteout creation
Message-ID: <20260812.ebb43b3e31d6@gnoack.org>
References: <20260731154353.1790268-1-gnoack@google.com>
 <20260731154353.1790268-3-gnoack@google.com>
 <20260731.Shalee5tiiki@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731.Shalee5tiiki@digikod.net>

On Fri, Jul 31, 2026 at 11:35:14PM +0200, Mickaël Salaün wrote:
> On Fri, Jul 31, 2026 at 05:43:50PM +0200, Günther Noack wrote:
> > +static __attribute_const__ access_mask_t
> 
> The __attribute_const__ is incorrect here, you can just drop it.

Thanks, will address.

> > +get_dentry_access(const struct dentry *const dentry)
> > +{
> 
> const struct inode *const inode = d_backing_inode(dentry);

Done.

-Günther
