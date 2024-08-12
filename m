Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F76F6CDBA;
	Mon, 12 Aug 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482307; cv=none; b=diCfBTWgZYZRldV5uvVcQG4FfMwdZpP5mojqNlB8Uk2Gh6r1ETKKipzWsc/fBnTf1XuQuf6YjVrem00cLqpqrvhXXC+PbDmbriOBHZHl/CErc/6Z52V77Mmg8RED+5hPcsvFbV4tkXMXgici184TDN3gndqJyzEaBonU181FlM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482307; c=relaxed/simple;
	bh=hBlsh2CO+Iqi6onlN7q+a10gM+tJiKbpXfKeVuOY/Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUes3TCZiH5Ol9OPjBNYEp7Q3KmT3VIXXq7wJziPLVmp2QBYyNpbiI6cqBLkut51IvV66efNOLMDRGSDfL8CTz39u+wYRC6hHbB7Dv85U0kxz15vA46+AI6a/FxQ9QHc8bIJRWPPwL66IymTdkv7PAL3O+13liG1ph3RJMvWYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ACfCGP+R; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ACfCGP+R"
Received: from [10.0.0.89] (S0106f8790ad4bcee.lb.shawcable.net [68.144.204.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 83C513F1C6;
	Mon, 12 Aug 2024 16:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723481756;
	bh=Ecb8WhQZ8tF5AmHlMe/3X72oi/AP77OCQiNYqYGsiDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ACfCGP+RIjeQpVcMyEbEWJSbPrHuRCjuJQz43ay1JpDfGYeisAayne+7WuZWxCPJw
	 2luvKnqmy5ACC2pYGVz4lZdkD5VklRboyfFd8pFh4GrAbKBQ3hIw0UkzmJzbweLq/p
	 fNx+Dy8pHmCBYjGERDaySWoYlYXLEjGXA0Mc7ZAh5BM5xNzFoWb4T6SFc1cOI+rESF
	 IFeZkO621kdhD1TJ6M8WMwSTJ75zveIlRljT/mUNQFyldoGWLXVxxYNzttPpuyaTlv
	 19sFcyZiQtNl7E+S8YsI2jWBCGx9cwBjZ+n+kWRyYo9QDl4tqVhBMsgupDOIUasCX2
	 Ki7BoElLwsPJw==
Message-ID: <6a0c69d4-f614-4348-a28f-0d4a6fe08df8@canonical.com>
Date: Mon, 12 Aug 2024 09:55:23 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix policy_unpack_test on big endian systems
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendanhiggins@google.com>,
 Kees Cook <keescook@chromium.org>
References: <20240808155931.1290349-1-linux@roeck-us.net>
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
In-Reply-To: <20240808155931.1290349-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 08:59, Guenter Roeck wrote:
> policy_unpack_test fails on big endian systems because data byte order
> is expected to be little endian but is generated in host byte order.
> This results in test failures such as:
> 
>   # policy_unpack_test_unpack_array_with_null_name: EXPECTATION FAILED at security/apparmor/policy_unpack_test.c:150
>      Expected array_size == (u16)16, but
>          array_size == 4096 (0x1000)
>          (u16)16 == 16 (0x10)
>      # policy_unpack_test_unpack_array_with_null_name: pass:0 fail:1 skip:0 total:1
>      not ok 3 policy_unpack_test_unpack_array_with_null_name
>      # policy_unpack_test_unpack_array_with_name: EXPECTATION FAILED at security/apparmor/policy_unpack_test.c:164
>      Expected array_size == (u16)16, but
>          array_size == 4096 (0x1000)
>          (u16)16 == 16 (0x10)
>      # policy_unpack_test_unpack_array_with_name: pass:0 fail:1 skip:0 total:1
> 
> Add the missing endianness conversions when generating test data.
> 
> Fixes: 4d944bcd4e73 ("apparmor: add AppArmor KUnit tests for policy unpack")
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Looks good

Acked-by: John Johansen <john.johansen@canonical.com>

I will pull this into my tree

> ---
>   security/apparmor/policy_unpack_test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
> index 874fcf97794e..c64733d6c98f 100644
> --- a/security/apparmor/policy_unpack_test.c
> +++ b/security/apparmor/policy_unpack_test.c
> @@ -80,14 +80,14 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
>   	*(buf + 1) = strlen(TEST_U32_NAME) + 1;
>   	strscpy(buf + 3, TEST_U32_NAME, e->end - (void *)(buf + 3));
>   	*(buf + 3 + strlen(TEST_U32_NAME) + 1) = AA_U32;
> -	*((u32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = TEST_U32_DATA;
> +	*((__le32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = cpu_to_le32(TEST_U32_DATA);
>   
>   	buf = e->start + TEST_NAMED_U64_BUF_OFFSET;
>   	*buf = AA_NAME;
>   	*(buf + 1) = strlen(TEST_U64_NAME) + 1;
>   	strscpy(buf + 3, TEST_U64_NAME, e->end - (void *)(buf + 3));
>   	*(buf + 3 + strlen(TEST_U64_NAME) + 1) = AA_U64;
> -	*((u64 *)(buf + 3 + strlen(TEST_U64_NAME) + 2)) = TEST_U64_DATA;
> +	*((__le64 *)(buf + 3 + strlen(TEST_U64_NAME) + 2)) = cpu_to_le64(TEST_U64_DATA);
>   
>   	buf = e->start + TEST_NAMED_BLOB_BUF_OFFSET;
>   	*buf = AA_NAME;
> @@ -103,7 +103,7 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
>   	*(buf + 1) = strlen(TEST_ARRAY_NAME) + 1;
>   	strscpy(buf + 3, TEST_ARRAY_NAME, e->end - (void *)(buf + 3));
>   	*(buf + 3 + strlen(TEST_ARRAY_NAME) + 1) = AA_ARRAY;
> -	*((u16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = TEST_ARRAY_SIZE;
> +	*((__le16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = cpu_to_le16(TEST_ARRAY_SIZE);
>   
>   	return e;
>   }

