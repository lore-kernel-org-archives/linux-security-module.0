Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD210F0
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jun 2026 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882269; cv=none; b=O/UXVh+BSNVOTdl0bQLiWspEYuNaqBvCtdDBCjwb2btWIV614/cRy79qPuPjZjIB03MN/NBDlIb4K8wcZ1PypLrG+xXs0DeWPmEm/GYfJvfUohX1bFzt6l5g62A5qyShRzOjyu/IAv70Ir+N9dCOcgGpaEpjB0dQDdq65chXKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882269; c=relaxed/simple;
	bh=Gy05Xt+WiUzQmWNHJR2G04BK5wgl0aWZ3LDZnJ65ekA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhYs9XynGJIwf7wFK53AasVzXxFXc9LEpD9WswCIqRYiSuzw/X7HOrnUlCvcAZqsM6NDQba04QpU1qh7VBdMBZn4wWR21fwlouAx1d7g0coajjbqRa1PfdVtae9E+/Rvhx11qGFj1eq+pUUXPI5O1ZgChCvrH6qrLIwKHoeVJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=cks0xG/J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dOhSJkQT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="cks0xG/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dOhSJkQT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E284EC0077;
	Sun,  7 Jun 2026 21:31:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 07 Jun 2026 21:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780882266;
	 x=1780968666; bh=hRRqP3zmI7aVPNYFhbC98dJ2jTmFsEwd4lKoAjavDns=; b=
	cks0xG/J7LBxDzhjNDpHUjXiJKEiv2tBGE+2DvNaSrelxksOrHCIbs6p7Nn+xqIF
	Mk43AEPn/iqRgTj5mgAcfvTej8+fLDpqAzOfHD5c547EXw9gEmGApGxaBW9GKVO8
	2GfIAlzMU7PpbSK85+2wOAO4+7zrOxizgR4a0eEsYi+wVtMhnlYq4YzUUh9VcgLf
	Ent+LkmelyrrfB6nvK477niXO0w/uiMvoGEE+tf7uvfsRCuQ56pSCshpRUtJtwDR
	o3V6b7+L+y/a+jQHz93vr6HUcKJfyqKbsRcTXA6vk2dZ8DJlSvZ1U40xhjX2uoUc
	z8QaKTnEMsEKCgJ4PrcDzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780882266; x=
	1780968666; bh=hRRqP3zmI7aVPNYFhbC98dJ2jTmFsEwd4lKoAjavDns=; b=d
	OhSJkQTX1QTYZccEXwjUzj7+4dOkRUMkGWmRGXlEfKrwOJdKh8wF3AGtPeblyRAQ
	w7YCxqnqINf0SzxVtQL+2H3A1u4GOhpP/aByNoiY4o5LyciXgKCbS+yaTYZshKND
	N0L4k7Y87BUK+9zWbu32QtUZwHFqYeb1wZ3assfji6OrhgiRAcRa8LCCALYdnh4p
	ADiPkxMPbRnwYoNalSc2hGtO3K5MSTvpAyOkPX7a+NF/QWbLw5PE66GtlPeK0Gqe
	G+MUdCrfyWsnHtKDtrn0GnEPuBcRzQZsRvdMaO4is9c8OH8PsmnIwtuatp7Y5qsE
	z7DrvYcmBG2UwtMeE3d1g==
X-ME-Sender: <xms:WRsmap7A3_FcSRCCrufbi5tGlCn8NKopHQckR67ADYwvH8zNDFkSmw>
    <xme:WRsmaqk4bJAQUrxa3VLuWjFZX9JjxSnDqW71xzPv1E7xFFoZCHyqUVzkQIw9OEChd
    JjCNuu-3_V-zIQtry6iSTAPKLPxraTL65snab1MupRASJFnh7pN34of>
X-ME-Received: <xmr:WRsmaqRQi8tsYzsf3szlHL1XfsAL3NnuXU-R14iHgfvf-Guqyb_xZ5KCcSue6ulu_z7g5NzQEVVUNYyQRA>
X-ME-Proxy-Cause: dmFkZTF0IQBILUwW/+O31QOGJx2zUK/MxxP1aGBde++3FP4M5zc0SuR/Uc2z1t5CBiiSGh
    rx4drP05u6eWJvAToEeI9Py185axPH2OemebU9tCIwxq6s8aKlyWNl1LOpAo1y23zVCqFW
    u7xRb5iMm2EkxQt/hXwEyRPVVkilRHiwK1J0u9DNNCelIjwZvTY+ZGL7wdYviYhZ5FYHZ1
    flCvvc4KImDwYGefI31ad/jnBFeWozluTwiK3OHQUMVwwWpP0WQftQvneCKs+i4OxlL3jy
    3f1BDhuGbuMusdthF6AnjZzkR8iVWsTTKGG58seNDnbkuHbrve88vqIFHgqoDW+lQf4onl
    VBAfflu+ACEAZPpJcBcN7b51TnFmORLDfZZqmsRsBDlR+PjbmUWEqmT8N2mywd5iCdpDe5
    laMTelBHbVrmDwjetZ2SmT88rh3v/adCN8wDpdJ8CykQfm+Ayb8jXUbWLbRbg+qM/wv14e
    gThGZYa8xA1gNAvfalm+tVXRUoi5NTxP5dUXe7c+YAlWKafrpV/idIs3zTf1j+TF7vWJnt
    j5vvmvuHQHpXSCkl8W1sYIp1Z700sZUBdwq49U2y/N5ae201wRWtdVN2K0SsemjgT8eZQW
    NryKdUEmh+AgeRxd0RTJ9L4/x/sLYS580CL3pcAxWzBUefoHQciY05bkTyVw
X-ME-Proxy: <xmx:WRsmapEd4kdie-In1O9V7u92XPpJK8Le--VE2zYKWYNDcd6DCpVGNQ>
    <xmx:WRsmavGr-CdCxzmnljf_1p_OM-qTm5ZfYTe8bb-nSwhNo19NMIWVdQ>
    <xmx:WRsmanTat34nL6XFyOcavkJ-2MSOupabm46fPrEuCMAm7HNupwvlmQ>
    <xmx:WRsmagKyhCsuKc8GqdYBtV4buWGeYiVwQb_XlP0GWZYsRdKuFZJQkg>
    <xmx:WhsmamG4WZkHKUQX-SmpUbyFAtL67FIK4pp2lJyvf6sHrzncwBMkeiWW>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jun 2026 21:31:04 -0400 (EDT)
Message-ID: <84f468de-6d36-4131-aa16-6dd3e0846fbb@maowtm.org>
Date: Mon, 8 Jun 2026 02:31:03 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/9] selftests/landlock: add tests for quiet flag with
 fs rules
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>,
 linux-security-module@vger.kernel.org
References: <cover.1780272022.git.m@maowtm.org>
 <9208d19c3aeba778f317defcfee9c62c44600e3b.1780272022.git.m@maowtm.org>
 <aiMciEe6zVnisbQJ@zenbox>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <aiMciEe6zVnisbQJ@zenbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/5/26 20:04, Justin Suess wrote:
> On Mon, Jun 01, 2026 at 01:00:40AM +0100, Tingmao Wang wrote:
>> [...]
>> +				if (target->expect_ioctl_allowed)
>> +					ASSERT_NE(EACCES, ret);
>> +				else
>> +					ASSERT_EQ(EACCES, ret);
> This doesn't compile.
> 
>   make: Entering directory '/home/justin/Code/linux-next/tools/testing/selftests'
>     CC       fs_test
>   fs_test.c: In function ‘audit_quiet_layout1_test_body’:
>   fs_test.c:8456:33: error: expected ‘}’ before ‘else’
>    8456 |                                 else
>         |                                 ^~~~
>   fs_test.c: At top level:
>   fs_test.c:8474:1: error: expected identifier or ‘(’ before ‘}’ token
>    8474 | }
>         | ^
>   make[1]: *** [../lib.mk:225: /home/justin/Code/linux-next/.out-landlock_archlinux-base-devel/kselftest/landlock/fs_test] Error 1
>   
> The ASSERT_* macros doen't properly handle braceless if statements...
> 
> (easy to miss if you forget to recompile after clang format and/or
> checkpatch --fix...)
> 
> Adding braces to this as with previous versions of this series should
> fix it.
> 
> Justin

Thanks for spotting!  I forgot and was wondering why I didn't fix this
checkpatch lint earlier, turns out there is a reason why :)

Will fix in next version, after Mickaël's review.
