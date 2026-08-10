Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34BD3FF882
	for <linux-security-module@vger.kernel.org>; Mon, 10 Aug 2026 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406199; cv=none; b=XrW5q8TfEyjmSFAUZ7p6ZLQZtc2YyGmsgP9BMnDvnGxTtmVDSTqDg/bA8M7wc9InqP7NW1pYidv0ED6qgnHljyVzu9k3d8dHpe+cOwTU8ss2EczMDRWnTOPjgH/UzPFElwA8VvnzxUANvtcUF5taLqrZKpqH5kV/vECDBGnl7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406199; c=relaxed/simple;
	bh=ADQOirjU72mVcc6wSNOZbe+JuR1dENCZg1800WPjve4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4YelSde+vwGfZo0uSIEIayoTLbVo0obTm4dYMz/QFFALny+vT7ook0I9sVndRkuL08R6HRLUchx/gyLPIepHz9FnjmMg/prYBeme+JOYGVVlPToByycyw0QHuAh9IzvzTUpvBsgx4kW0kzqlASpUnREeEnwVRcc8Qz8w/Z9daU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=FAVHmH7k; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="FAVHmH7k"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A7EE33FBBC
	for <linux-security-module@vger.kernel.org>; Mon, 10 Aug 2026 23:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1786406193;
	bh=6ekbPwsEu8bDrN4kb77aw2MPow/5mWjqbFYOqb8aStU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=FAVHmH7k5HESIkyDkBt+txhFS0K0EFaym2qfk9/9se63ZhS0xmWuKS9dSYtAETqy3
	 WfwZzzkUdzMYkApauZqjrq/d4e+DMIfdhOg1cZNeKY8Zz+PfDpbT//DnhF8U9ZCrHI
	 dyXZ0LNNu0cqyWTjAN/M+sCCkhdk3nGekWJxoVi8F61h4Phv8V2xCyMwj51ATDLfYX
	 VjXUZ1dhwz5Uid7hsJwl1LFkZCG8IBjg1g6eIhqvuBnKv9IfT1ZNHdthMjzYghxzjD
	 kRxUttJziAjUw1BXl9WZKJzHcaZ4pCMExlcmwUnm6s08lVzpsgzojH+JSOE7lK6Z8P
	 mUdkOkCJmBcjcGatE5usN9jHAagMAzQQWee4fEKCF1c3dIHe0FePLKjdU9lpikJikH
	 PTXPM6FBHsH82wFlM3tYAqrWruiV8QZH+jSiKrorZ5Fe6zisKP5/clFWdCbywe3kuG
	 IJacEFheENhCnZRlHc3ZNHNhRCJNrVzrAbtcfk4dKqnURAHYZk8L4di0xkwIle3f/S
	 S5E0w1Rk0/ZdyvSwuM0dedDBGU3Q7EHhjg6AvAK/bKO1ZdUPvab4o7JDWTxK4VkfcY
	 9qkv2OadddYhl4IddhO98AV7UuouI7n4xHDvFpk+W8unssFFLxo/fNX+/+kX+Fk2wr
	 bgBI3YPcIyPBjUodu73NkhQw=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so4041447a91.3
        for <linux-security-module@vger.kernel.org>; Mon, 10 Aug 2026 16:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786406192; x=1787010992;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6ekbPwsEu8bDrN4kb77aw2MPow/5mWjqbFYOqb8aStU=;
        b=D3xpAQ37/rdeYI+KE1H7QCIoWOiUtJhQViPojEyeUm38B4YLbRxCkH0HOtnsEmOQOS
         ZhkkvFGUTMsqV2rmxdqzVcDU+2Rvr++3kFIvBC7uZzYQgZv0mOfxBAMvCZiq8v8S170O
         oO0sxr9EPt+rRfh4EZKNUFVOGe2BM5QwWRoIn5zxAEFFFEZadlrJaeNwEdsfqi68/pKQ
         xg5ExJJM9qbhxlO8FEL1C9A/1MZSITIvEX057ZCOgxudkTxSqSSOM9hhiEJMTJOkbzvc
         oNHOucHozil77IWvGLYHV+PL0a/tp8ZjjF9Wed9RQ5uj+vQTEevoCqn5i9Ipr1AV0VdJ
         Ot2A==
X-Forwarded-Encrypted: i=1; AHgh+RoBvQ/8APhd0bkAogiVgpphVz4knVtPaatEcpvZmZxqBjx4Bu1jc8kTy6JkhbaHLhF5p23YzfYHwT1gGBjX+T+Dbr0Asdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5VeK3hIxnuFVwlu5uo8gb/wvEzZZkzaE+d9W5x34+QToMt3m
	Ab+0o3LL9SijAKqVe/1m3Mj6ozO6ZFhdhZN166SusumHDkN8+JAfzGbojTMfuvoRT7arW2aZzLn
	gelBbaqQar5bP6MJfDCZFmxJ3iy1frSBufOsTDlW7tAg5MouJlFpY3hdYOyKuRrJm7d2vv17txe
	G8StSBMkZ8smC2jgBhPOdfIRwLZoCU
X-Gm-Gg: AR+sD10jS0LzuVOGEJYXPsb7P+hsjQuEey0Gof3OKhx8D9vc+0tBUAgCVjxXJrv/5GZ
	2o3FX/BO9lIK31u5PSq82hl8Kcx+eQUpeYNeKZh1549MwkFFemtLPCxuNb/oi9G23r0kil7S8u4
	5E0R1HPqtat5RJjiNikHAAiLnd4G8RVXar3PNn3V4FvmmUGvTTJZ8BMjd1Dygnv4Q176R8upe+U
	ffRJGyYvisoiB3Ld5+sosCveLqL2W9qMzpB+w7Y1aABVuzbjnFtZKTl4xx2c595JL0CTsqrcAqj
	lHMXUYX5McDRFW28mbDUdS/FjszBk6c0QW7eMzGpdVx9gCFF+XBjxLVJpJzwGzeYvItTZ1AG1/r
	XUGd0o9ESwLL2GM+QKNi5MSUkifUJPL9+1upVz4WHiBCzfWFBG+53
X-Received: by 2002:a17:90b:2748:b0:380:7688:fbe9 with SMTP id 98e67ed59e1d1-392823a4a2bmr25849723a91.8.1786406191878;
        Mon, 10 Aug 2026 16:56:31 -0700 (PDT)
X-Received: by 2002:a17:90b:2748:b0:380:7688:fbe9 with SMTP id 98e67ed59e1d1-392823a4a2bmr25849688a91.8.1786406191425;
        Mon, 10 Aug 2026 16:56:31 -0700 (PDT)
Received: from [192.168.50.156] (S01061056118100b4.lb.shawcable.net. [96.51.42.105])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-392e586977esm4878a91.3.2026.08.10.16.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 16:56:30 -0700 (PDT)
Message-ID: <af80a13d-e778-4664-a688-d4428b2d8904@canonical.com>
Date: Mon, 10 Aug 2026 16:56:28 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix out-of-bounds write when null terminating a
 label vec
To: Hyunwoo Kim <imv4bel@gmail.com>, georgia.garcia@canonical.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 maxime.belair@canonical.com, cengiz.can@canonical.com
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <anmfJev64DOumiA9@v4bel>
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
In-Reply-To: <anmfJev64DOumiA9@v4bel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/26 02:51, Hyunwoo Kim wrote:
> aa_vec_unique() null terminates at vec[n - dups] when VEC_FLAG_TERMINATE
> is passed. If the components are all distinct no duplicates are dropped,
> dups is 0 and the terminator goes to vec[n], so the caller has to provide
> room for n + 1 entries.
> 
> aa_label_strn_parse() sets up its vector with vec_setup(profile, vec, len,
> gfp) and then calls aa_vec_unique(vec, len, VEC_FLAG_TERMINATE), but
> vec_setup() does not reserve the terminator entry. Up to LOCAL_VEC_ENTRIES
> it uses the local array of LOCAL_VEC_ENTRIES pointers, above that it
> allocates exactly len pointers. The terminator therefore lands one entry
> past the end of the local array when len is LOCAL_VEC_ENTRIES, and one
> entry past the end of the allocation when len is larger.
> 
> len comes from the number of "//&" separated components in the label name
> and label_count_strn_entries() does not bound it. An unprivileged task
> reaches the parse by writing to /proc/self/attr/apparmor/current or through
> lsm_set_self_attr(2), both of which go through do_setattr(), and the name
> is parsed before the change_profile permission is checked.
> The query_label() path behind the securityfs .access file, which is
> mode 0666, performs no permission check at all. Every component has to
> resolve to a loaded profile, so a system with policy loaded is required.
> 
> The other two VEC_FLAG_TERMINATE users work on a label vec that
> aa_label_alloc() has already sized with "+ 1 for null terminator entry on
> vec". Reserve the same entry in vec_setup() and DEFINE_VEC(). Passing
> len + 1 from the caller instead would move len == LOCAL_VEC_ENTRIES out of
> the local array and into kzalloc().
> 
> Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
>   security/apparmor/include/label.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
> index b5a722a47fd2c8..37cb135de32320 100644
> --- a/security/apparmor/include/label.h
> +++ b/security/apparmor/include/label.h
> @@ -23,7 +23,7 @@ struct aa_ruleset;
>   
>   #define LOCAL_VEC_ENTRIES 8
>   #define DEFINE_VEC(T, V)						\
> -	struct aa_ ## T *(_ ## V ## _localtmp)[LOCAL_VEC_ENTRIES];	\
> +	struct aa_ ## T *(_ ## V ## _localtmp)[LOCAL_VEC_ENTRIES + 1];	\
>   	struct aa_ ## T **(V)
>   
>   #define vec_setup(T, V, N, GFP)						\
> @@ -31,10 +31,10 @@ struct aa_ruleset;
>   	if ((N) <= LOCAL_VEC_ENTRIES) {					\
>   		typeof(N) i;						\
>   		(V) = (_ ## V ## _localtmp);				\
> -		for (i = 0; i < (N); i++)				\
> +		for (i = 0; i <= (N); i++)				\
>   			(V)[i] = NULL;					\
>   	} else								\
> -		(V) = kzalloc(sizeof(struct aa_ ## T *) * (N), (GFP));	\
> +		(V) = kzalloc_objs(struct aa_ ## T *, (N) + 1, (GFP));	\
>   	(V) ? 0 : -ENOMEM;						\
>   })
>   

