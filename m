Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B3E280CC1
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 04:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781325783; cv=none; b=ppne1wv+ZuNb85CKzW7qqCjWy9LbmnQaPyTnWHECaLBAGNJ3gLMR0lpYkIoKcQC6NgkYhR0rcI3a9BpzgiNwRd6qdwUxbK1682UNUZUhsTOOKqG22nXlYEAUqjY9E4oFTcwrGtCFdaFCibG8vTqYFphxdJpusHHErTG3Tf9KndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781325783; c=relaxed/simple;
	bh=XpMZTfJn4SU7AnKGjEKXDdYtXemzgJGsegxoZSehalw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdvJ5BTZGCqZSnaO3kAsFfZdaDc7+mwOXTol/gj5kGHU3TdmTKvKdMeqTBf9Tb7aUbH3ACsuzXRzoxr9fa8DvqR1Iy+DjtdSNGfj6A3okGiohvoIqhILk5oS9zLQKnu8kFwL1prLR7MpGzKsXd1joNPO27ftsouQFpES3Kr2iDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=JXXvnjaJ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="JXXvnjaJ"
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 692FA3F129
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 04:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781325780;
	bh=c1HOYyX8+tMocF3FS3l+nddVyJTmFQcD0aJbjm234is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=JXXvnjaJtjxS2X2470TqYOh6kwQ+zoFP9/2e8LEFFoQntvzFJgWXIxWXoXZfzUItb
	 dm0K5pVY87EXCExFCJsZl1/mbzmLwXnGV7VacRy0HjlFfmZmjBdntyAvWvDdeM+X3U
	 rn4aJhzeKw8B9OBIROLnsVP6IZihWmGCbtuLYfOsJ3TaP+/IBtkwCXoGS74wOV47bL
	 /0MEx+DyJZ35ic9EM2gVezvZanGBfIxW1Nc4P3YZzTY/SxzfiYvNKrYdcGPhDq5omD
	 rL1uYyFSEzEV9ycPpNw4WsCi3C82/89cFqb4/O0xDHVN1l5IagMtjCdWR54o0GEMm1
	 hSUQ49KZ05smG9jmLL5B3Duy7A6iwfk2/B/axvv8fYz+fJkrmNbchrrR4n7tiLJ0qN
	 PQ/yC80d6URA/bFfcMjPsznmI1K4eDHy/GE3ugWAdwi2j/vPmOqvtVvcx5W1JUOW7l
	 o6dg4vJ2XRuKz6wxja1z7qMTtzyoS/RfWKRxFR4g2q1FGyYK4X25nTMneyTPi8S/Gr
	 5GEkMb2uw07ptDrvVhphm3/Efg62n5sfcz/vI6aZzhM22b4jOFEOpH4qULVHghk/Pf
	 0uqBJ3Ml9Hot+RcMsb8K0H/zaPeirVq6ZbYYOqgQ/cp1uOg1De2ArI4qWHCq+zPms5
	 +sX8Uy8OcYbzwJLlZ0XltwT4=
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c2d0a8b5beso17441895ad.1
        for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 21:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781325779; x=1781930579;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1HOYyX8+tMocF3FS3l+nddVyJTmFQcD0aJbjm234is=;
        b=KOGRLpZjeqapBPHmeNC4o8Nn9cVri9WiUg5REyUJiwfRCsPNuSc5yMbshzoc2Yf1PX
         Q17oRzgUuoG7HUR68O8VOMifuuxgsVgZV6eR1EOhtw/PZbFAL7mO5l5qwSAf1uCCkM6v
         s8BywxiDxZ041Fj+Z+bdb4VUdYV2CR28HoW8iWY4ncl090EYlYDfYQXx8YSqHzdbIyec
         EC5B7GheRvxDx/MyOUf9sb5C7233eTeXO+mVFcinWVFtF6wPhZYOZ4XRX7mJRMAXrzAM
         BtbXWulgmvnKrq9e7rdbVkb359ab+9Z7pBbUH1ATusJKXwIJitceaxO5GY6mfyjJVPud
         ZmKw==
X-Forwarded-Encrypted: i=1; AFNElJ9CpU2vFkleSHcsRo+cIAw2xVJJ5B01rAoPtGoQoplEhnBcWJF5nZWsLhIsk1RLLZFWBFgcQFlFnr7pFteBL9VrZlIDA3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzU+2gicuEeVPiAaHvwskuXp9QEEehZa10D6ah0+WuOgrYHTEm
	SFXaYzZBBBFdVRdDB/iLCuQKID+QhjhYZkD+dAp8XglDed/56y+tUX3WEAoKNkj79nH2ANSB4T5
	wNJCtlxyFRF47DAqRVPiCv0mIk8FJhqfATUOQElkX8Le2mZ+pGYL0qCaMDifdHyQe3uWU99yCPI
	Sc77+wPDyqEmoh/Oa6mQ==
X-Gm-Gg: Acq92OHCjtI7twI8nX8ujX87fvI1drZmqgwjV6esScMNbjWgagjx6eiJDFMI7z0oJQH
	/2AVwdYJ/OCF90/PSo+vsiSbECFKgG1mjQeLznequT8fM9mweHy7WcUZi9ELwatqBVb1e6w1gkk
	sL4tMDGkPIsTKKz/Py/rUC8jopogB+Jn3/CRURvThGfSNSH4Iddmu1uaPNOVTwn76lthfIxHrN7
	MAtY69OYd0hxYiR46wAjdZ55CDYU/97gJneMFMqiWvQ9AbGt5+UxCs0WjMX6XV+nl6LWX69MSMP
	hjyLqoNTPOEy0QeCfXkDzSkjnl+cGBsNs/Kug0GofluzOW8zI0m/JjPPZagpvsglkXeu9DAONka
	P88qwv169+C7D3mt3/y6F6L3D6OXKLU3lEzHM
X-Received: by 2002:a17:903:2f84:b0:2c0:ccdb:e02c with SMTP id d9443c01a7336-2c4104114f9mr62518415ad.7.1781325779054;
        Fri, 12 Jun 2026 21:42:59 -0700 (PDT)
X-Received: by 2002:a17:903:2f84:b0:2c0:ccdb:e02c with SMTP id d9443c01a7336-2c4104114f9mr62518075ad.7.1781325778474;
        Fri, 12 Jun 2026 21:42:58 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2c4328a47f8sm33939485ad.47.2026.06.12.21.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 21:42:57 -0700 (PDT)
Message-ID: <8b8536e2-6d44-440c-84b9-b05fcd53f3e0@canonical.com>
Date: Fri, 12 Jun 2026 21:42:56 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor/lsm: Fix aa_dfa_unpack's error handling in
 aa_setup_dfa_engine
To: GONG Ruiqi <gongruiqi1@huawei.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, zhaoyipeng5@huawei.com
References: <20260423031056.563527-1-gongruiqi1@huawei.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzStKb2huIEpvaGFu
 c2VuIDxqb2huLmpvaGFuc2VuQGNhbm9uaWNhbC5jb20+wsF3BBMBCgAhBQJOjRdaAhsDBQsJ
 CAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAUvNnAY1cPYi0wP/2PJtzzt0zi4AeTrI0w3Rj8E
 Waa1NZWw4GGo6ehviLfwGsM7YLWFAI8JB7gsuzX/im16i9C3wHYXKs9WPCDuNlMc0rvivqUI
 JXHHfK7UHtT0+jhVORyyVVvX+qZa7HxdZw3jK+ROqUv4bGnImf31ll99clzo6HpOY59soa8y
 66/lqtIgDckcUt/1ou9m0DWKwlSvulL1qmD25NQZSnvB9XRZPpPd4bea1RTa6nklXjznQvTm
 MdLq5aJ79j7J8k5uLKvE3/pmpbkaieEsGr+azNxXm8FPcENV7dG8Xpd0z06E+fX5jzXHnj69
 DXXc3yIvAXsYZrXhnIhUA1kPQjQeNG9raT9GohFPMrK48fmmSVwodU8QUyY7MxP4U6jE2O9L
 7v7AbYowNgSYc+vU8kFlJl4fMrX219qU8ymkXGL6zJgtqA3SYHskdDBjtytS44OHJyrrRhXP
 W1oTKC7di/bb8jUQIYe8ocbrBz3SjjcL96UcQJecSHu0qmUNykgL44KYzEoeFHjr5dxm+DDg
 OBvtxrzd5BHcIbz0u9ClbYssoQQEOPuFmGQtuSQ9FmbfDwljjhrDxW2DFZ2dIQwIvEsg42Hq
 5nv/8NhW1whowliR5tpm0Z0KnQiBRlvbj9V29kJhs7rYeT/dWjWdfAdQSzfoP+/VtPRFkWLr
 0uCwJw5zHiBgzsFNBE5mrPoBEACirDqSQGFbIzV++BqYBWN5nqcoR+dFZuQL3gvUSwku6ndZ
 vZfQAE04dKRtIPikC4La0oX8QYG3kI/tB1UpEZxDMB3pvZzUh3L1EvDrDiCL6ef93U+bWSRi
 GRKLnNZoiDSblFBST4SXzOR/m1wT/U3Rnk4rYmGPAW7ltfRrSXhwUZZVARyJUwMpG3EyMS2T
 dLEVqWbpl1DamnbzbZyWerjNn2Za7V3bBrGLP5vkhrjB4NhrufjVRFwERRskCCeJwmQm0JPD
 IjEhbYqdXI6uO+RDMgG9o/QV0/a+9mg8x2UIjM6UiQ8uDETQha55Nd4EmE2zTWlvxsuqZMgy
 W7gu8EQsD+96JqOPmzzLnjYf9oex8F/gxBSEfE78FlXuHTopJR8hpjs6ACAq4Y0HdSJohRLn
 5r2CcQ5AsPEpHL9rtDW/1L42/H7uPyIfeORAmHFPpkGFkZHHSCQfdP4XSc0Obk1olSxqzCAm
 uoVmRQZ3YyubWqcrBeIC3xIhwQ12rfdHQoopELzReDCPwmffS9ctIb407UYfRQxwDEzDL+m+
 TotTkkaNlHvcnlQtWEfgwtsOCAPeY9qIbz5+i1OslQ+qqGD2HJQQ+lgbuyq3vhefv34IRlyM
 sfPKXq8AUTZbSTGUu1C1RlQc7fpp8W/yoak7dmo++MFS5q1cXq29RALB/cfpcwARAQABwsFf
 BBgBCgAJBQJOZqz6AhsMAAoJEAUvNnAY1cPYP9cP/R10z/hqLVv5OXWPOcpqNfeQb4x4Rh4j
 h/jS9yjes4uudEYU5xvLJ9UXr0wp6mJ7g7CgjWNxNTQAN5ydtacM0emvRJzPEEyujduesuGy
 a+O6dNgi+ywFm0HhpUmO4sgs9SWeEWprt9tWrRlCNuJX+u3aMEQ12b2lslnoaOelghwBs8IJ
 r998vj9JBFJgdeiEaKJLjLmMFOYrmW197As7DTZ+R7Ef4gkWusYFcNKDqfZKDGef740Xfh9d
 yb2mJrDeYqwgKb7SF02Hhp8ZnohZXw8ba16ihUOnh1iKH77Ff9dLzMEJzU73DifOU/aArOWp
 JZuGJamJ9EkEVrha0B4lN1dh3fuP8EjhFZaGfLDtoA80aPffK0Yc1R/pGjb+O2Pi0XXL9AVe
 qMkb/AaOl21F9u1SOosciy98800mr/3nynvid0AKJ2VZIfOP46nboqlsWebA07SmyJSyeG8c
 XA87+8BuXdGxHn7RGj6G+zZwSZC6/2v9sOUJ+nOna3dwr6uHFSqKw7HwNl/PUGeRqgJEVu++
 +T7sv9+iY+e0Y+SolyJgTxMYeRnDWE6S77g6gzYYHmcQOWP7ZMX+MtD4SKlf0+Q8li/F9GUL
 p0rw8op9f0p1+YAhyAd+dXWNKf7zIfZ2ME+0qKpbQnr1oizLHuJX/Telo8KMmHter28DPJ03 lT9Q
Organization: Canonical
In-Reply-To: <20260423031056.563527-1-gongruiqi1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/26 20:10, GONG Ruiqi wrote:
> aa_dfa_unpack returns ERR_PTR not NULL when it fails, but aa_put_dfa
> only checks NULL for its input, which would cause invalid memory access
> in aa_put_dfa. Set nulldfa to NULL explicitly to fix that.
> 
> Fixes: 98b824ff8984 ("apparmor: refcount the pdb")
> Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>

sorry for the lateness of the reply my mail wasn't working when I pulled
this in for 7.1

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/lsm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index c1d42fc72fdb..ead2f07982b6 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -2465,6 +2465,7 @@ static int __init aa_setup_dfa_engine(void)
>   			    TO_ACCEPT2_FLAG(YYTD_DATA32));
>   	if (IS_ERR(nulldfa)) {
>   		error = PTR_ERR(nulldfa);
> +		nulldfa = NULL;
>   		goto fail;
>   	}
>   	nullpdb->dfa = aa_get_dfa(nulldfa);

