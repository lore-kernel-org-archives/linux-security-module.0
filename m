Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC86814263
	for <linux-security-module@vger.kernel.org>; Thu,  3 Oct 2024 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727924759; cv=none; b=DH6yffwtiL3N75urUxSDqFkdJdEmw4j7koxRWw2sgvu13vyf6VAn/zeSO/ivvLY/Pr9VharMiWWAnoPflHW9QEiPHMZeVkibYJYb4BQNBh74IX7IlIKr8Q0X5lU8fro0aCY4MpFGNjEtmjhwdgBQHJH8NgUm8MLFXUpY7hR2imQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727924759; c=relaxed/simple;
	bh=R0/3VLTmk0IcNQ6jz+qIJFGheLlPqYbslHc33PkZw3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kh4CICyxSQ0Znt0VtLgeuTbrVnrfGWj8tIIiaSNjLQH6ZuV01PzPpnnfi+aXcFCyJSVrV5rNqJ33Fi8uakxanxAvPIDUnsyXolmp4WPMuxgZmjfKrw3NmjpF2H7gCTZY6DyC3A5Znjjz4pKcTFHtWOg+AF6gjCPNjQfPzN7NyMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VrtTib7P; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VrtTib7P"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 65E3D3F24D;
	Thu,  3 Oct 2024 03:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727924754;
	bh=9NSWhLUvNE3M7TROEt/MiEFBePmk6FmDDuCFPYWKFZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=VrtTib7PADV/pq6SRTD38bNjqVnXwfYkCZTDdc3hmBeK85e4ouoHRXAtxzfvoBOo7
	 CKQffgX1Y7Ng1C0xsyv6OKqZNhdBXgJxgv7PUPj7LIzdVv1J5gh3CYdl7Xhc6TUaI7
	 LvDarn7NgO5t+4DoZQarEX+DcIz4LwePTsy965gNEzHVvXHY+5mfrimdm4gXzqv3Pv
	 tyKVXrxxmtGHLz3FtQ0jkWrb7DVHxixEC/bTZbjZglHHrDV98ynZdcy8KPY0a18o8q
	 cst/iW4BvHdXxYwOWnomQm9I4871SG1sUrFcj4ParTMftEeUkvyIeeDr84vpgemYQp
	 5ORufLD9WgBAw==
Message-ID: <75615335-cb4f-4195-ba28-845153be04ed@canonical.com>
Date: Wed, 2 Oct 2024 20:05:48 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Fan Wu <wufan@linux.microsoft.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Mimi Zohar <zohar@linux.ibm.com>,
 Micah Morton <mortonm@chromium.org>, Casey Schaufler
 <casey@schaufler-ca.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <20241003024307.GA833999@mail.hallyn.com>
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
In-Reply-To: <20241003024307.GA833999@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 19:43, Serge E. Hallyn wrote:
> On Wed, Oct 02, 2024 at 04:12:50PM -0400, Paul Moore wrote:
>> Hi all,
>>
>> Hopefully by now you've at least seen the TOMOYO v6.12 pull request
>> thread; if you haven't read it yet, I suggest you do so before reading
>> the rest of this mail:
>>
>> https://lore.kernel.org/all/0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp
>>
>> Of the three commits in the pull request, the commit which concerns me
>> the most is 8b985bbfabbe ("tomoyo: allow building as a loadable LSM
>> module").  The commit worries me as it brings management of the TOMOYO
>> LSM callbacks into TOMOYO itself, overriding the LSM framework.
>> Jonathan raises a similar point, although his issue is more focused on
>> the symbol export approach itself, rather than conceptual issues
>> relating to the LSM framework.  I will admit there are some high level
>> similarities to this approach and the BPF LSM, but I believe we can
>> say that the BPF LSM exception is necessary due to the nature of BPF,
>> and not something we want to see duplicated outside of that one
>> special case.
>>
>> As I wrote in my original response to this pull request, this is not
>> something I would accept in a new LSM submission and thus I feel
>> compelled to speak out against this change and submit a revert to
>> Linus.  However, as the LSM framework exists to satisfy the needs of
>> the individual LSMs, I've tried to ensure that significant changes
>> like these are done with support of the majority of LSMs.  I
>> understand that in a case like this, reverting LSM-specific commits,
>> individual LSM maintainers may not want to speak up on the issue so
>> I'm going to let this message sit on-list until Friday morning, unless
>> I see the majority of the LSMs voicing support *against* reverting the
>> TOMOYO commit above (and the other related commit) I will proceed with
>> submitting the revert to Linus on Friday.  I would prefer if all
>> responses are sent on-list, but you can also mail me privately with
>> your objection to the revert and I will include it in the count.
>>
>> Thanks.
> 
> Huh!  Honestly, when I read the thread, especially Jon's comments, I was
> worried.  But getting a chance to look at the patch now, it actually
> seems good to me.  No one is getting affected unless they enable
> CONFIG_TOMOYO_LKM.  Even those distros which have been enabling TOMOYO
> won't be exporting new hooks without a config change, iiuc.
> 
for now, but when that doesn't get enabled when does it silently
change from under us?

This is the wrong approach and it is going to force us to disable
Tomoyo if it isn't reverted.


