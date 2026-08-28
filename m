Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E951359A68
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931526; cv=none; b=Yo+OVa0Tj6YWUMb2nuoUSNnXK2phjyuYlkWHCg21rRo5RJJog+fCmphkcn2lF3rFWECijE3YKnrCMoPggW2rLFm/QzmMzorsQogFcCynVHba3IVOjIr/PZz+66bHHjN6hBSGf6TpdBszaIG26e39nUmj4HU5oExo4iCZ+4mK7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931526; c=relaxed/simple;
	bh=jadBsUJmTVK0xon4tuwdHo3e8IxvlJSVcU78DrpzSpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXgvS9S+Pi0UVC2k998+H/bMKdnzvAZcJkpOGP9FwJtM+i/W1U2LX2RlV8PmAG05/Y6FJIwkli6k62s5J06Lt0sx9H5MamR/n4x39U2rIuzgTB2za5heeM6rAv5lI6OmzPI/oa+rgNFwNVQxi15kaR2/+C7bMpOqDGTH+nHv4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYucpsQj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYucpsQj"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso11916555e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787931523; x=1788536323; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jj9ODlKIunD8qkvdRUPX0Tdjfs5ngulGpZQbXqYpujI=;
        b=jYucpsQjPeY4HlXVzisa2NGlmF2RvkTUIYOzoPFtD+dlZavcnHOlUpWZomrzXGh9aY
         w/9WjU/jpEslvRKT6i/IdhOaVeMLlTlPMspWpYMjBvYsbu8MayrQ3Vl/0pEOEJzpgjwt
         me9dv/5bnwwkZ8y+TGrjQvu4vrN//PS5JQoE+83ean0K8kcdxGP10Hl3mvd5KzD3qKmB
         WLS7NbhNkugJHyGF883ncJSqdxuNKUWnkZ4NImq1+9zm90+tDZ+En2+GTgDNQocQazAE
         AI+8hhbN5tBS5eemuRYQm2fglMshw1oliz0LGxm6QhARzGR3KYi44aUx1KrUmx1mgI6S
         L0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787931523; x=1788536323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jj9ODlKIunD8qkvdRUPX0Tdjfs5ngulGpZQbXqYpujI=;
        b=V+SK4fK/GYpAicScVSv3sOyPuwdz0IUi93hNf/vbgmfATeWnbWhRFtIKigNaFBUJrY
         Pbi58OJuRvSpExcwX+gJZGtbzLz3zw2zbCKvoZSWoh+AKeGB7mWKoWDx4/u+MfXgP4+9
         6D74ZK20+IndkACYiquB23fYVIgywvXRnMf4I85QUPArQuW3ym4LBo7tvl4yciDrGQl2
         SV+U807n3Xp+qg6uB0+8giv5ULbBmDvhPP0CFvsEijqzgvhxf/ME2dcxwv8AWDbsC0MA
         ZRq0L7sTLqbKCxkBqjjyVq/2QhrpyTHMRnv0zpQlPLuSWitXKFQJgsw/RKaQlZVYPfjW
         ZfwA==
X-Forwarded-Encrypted: i=1; AHgh+Rqw65Ty8VkP/dn2sBOmUszlKJ8aReygJqAhH33oyYbNoClWQMWIcAduP5Bqj+GJ6nPzo4lSqh5CF4891WqtSfxnmHR0Hkc=@vger.kernel.org
X-Gm-Message-State: AFuF++mGhmp/DGpHpieQ7zrgQl9BkejpouW4FuBvrXFcpoiLdQYmw+U2
	HUEM02h1/W89og1GNGEeiNZaBmNg0BPDOY/rKU9Mvk2k9A0FL64g42p+
X-Gm-Gg: AR+sD13cLg8bTBf1QlBP4k4r3DSG1FqFIl3pbfThVBqx7is2pkacMzwozLvwgKpu0jB
	3g8Qp95uWQGH5w/DaotzvE1gxntMuTj24dghguBwMDqjR8C31w+M5QHfXQs9KYtVa3vLWajvSvy
	CUUmsd/SSD9fiHjOsWFrFwDRcWsgHdAQZ5ifx1ModflCm77zoiU84DE2/dLsNmUbJ9iC3nUZRVp
	aKh4HlxC7LK40vrp8pawsHiSBnLTJpJQQpsHze1epEH9ulPA8Zx1OD1pGo4mOZFzjuQajD7ppC7
	0z0LzOQ8q2leQE0LYYu06mwt1I7oQ9Lr+HkPZZuu/9qto6jAm8OcDSBxIThw5Nk3fFK7jQElnsf
	Ne224rbA/NGBLrU5trhE/T8rChB8Z2gqAvAA6fo6v/6+YI7loPizixPfIzEn79TOSTD7Js0/Wtj
	8mhBeoN1UhJM2t2NUNdk/9SKRwYVb4j7mLtbXqSeXMILeZJMYG5UQ2PTm27K2jMdfi1GEOBfq/9
	MBGlgMiw/jp6Q==
X-Received: by 2002:a05:600c:3493:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49b91c4792bmr123822925e9.10.1787931523449;
        Fri, 28 Aug 2026 08:38:43 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fba3cf65sm9665593f8f.0.2026.08.28.08.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:38:43 -0700 (PDT)
Date: Fri, 28 Aug 2026 17:38:41 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Tingmao Wang <m@maowtm.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v11 2/9] landlock: Add API support and docs for the quiet
 flags
Message-ID: <20260828.208b6abc08a1@gnoack.org>
References: <cover.1781228815.git.m@maowtm.org>
 <031184748a8e74c0bb02f1fa13d7a3f10918c627.1781228815.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <031184748a8e74c0bb02f1fa13d7a3f10918c627.1781228815.git.m@maowtm.org>

Hello Tingmao!

On Fri, Jun 12, 2026 at 02:48:48AM +0100, Tingmao Wang wrote:
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 0ea55c2c732c..ce63ec564229 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -775,6 +775,20 @@ remote port of UDP sockets (via :manpage:`connect(2)), and sending
>  datagrams to an explicit remote port (ignoring any destination set on
>  UDP sockets, via e.g. :manpage:`sendto(2)).
>  
> +Quiet rule flag (ABI < 10)
> +--------------------------
> +
> +Starting with the Landlock ABI version 10, it is possible to selectively
> +suppress logs for specific denied accesses on a per-object basis with
> +the ``LANDLOCK_ADD_RULE_QUIET`` flag of sys_landlock_add_rule(), in
> +combination with the ``quiet_access_fs`` and ``quiet_access_net`` fields
> +of struct landlock_ruleset_attr.  It is also now possible to suppress
> +logs for scope accesses via the ``quiet_scoped`` field of struct
> +landlock_ruleset_attr.  The object is marked as quiet within a ruleset
> +when at least one sys_landlock_add_rule() call is made for it with the
> +``LANDLOCK_ADD_RULE_QUIET`` flag, additional add-rule calls for the same
> +object without this flag do not clear it.
> +
>  .. _kernel_support:
>  
>  Kernel support

Friendly reminder -- could you please also transcribe the newly added
documentation into the Landlock man pages?  I added a tracking issue
at https://github.com/landlock-lsm/linux/issues/66 where I outlined
the rough process, which is mostly mechanical.  I am happy to do a
review.

Thanks,
Günther
