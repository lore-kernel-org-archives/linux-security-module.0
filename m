Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DB61E98F3
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750110178; cv=none; b=RI5RL2LqyNILJBu/6+/qbqGXCnG9vYqDRDW4vhtvHc7HS52Dr9AUpN1ydh32mG39h6ZaiX68bNQhZzSt74Xhv4nhNFelkURKcCQ74MZGvGY8Ou10EjROHPXQAYqDwi7SEIeDzsMhXTiyjPVl4SxhI1F6b5BnBwyd+dTfsgPmit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750110178; c=relaxed/simple;
	bh=4omPnc8/kmY3dAJXfH8NAsh5NBJPfPfRL69fynJQ2m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgNRbwSjoNER+VspY5qY4dah7nX6N56EpcwimD+TpWwCiktbQSdWOJhTl0zhyCL49dZm45+9wVbmOp7m2lXKw/Fy3OYwcNBWOBoKqxLs7EFndbM+c7GVsDwALYB59oZhx8jd4OOB11Z/htgvrk+FPsQLrzHPjWWqjA9rvP8vyTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=tx9ztyow; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="tx9ztyow"
Message-ID: <3ba5fff5-7e24-45e3-bbec-c326cd3b0dc7@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1750110169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnKyocSBGngO9NUNU/RlveEWMkS3YYGJxZ/hFx+Z6CY=;
	b=tx9ztyowMaquk9x2u9SOT8I4pj5R2VntYpWcOpYaAbqDrxEqWd+h+uGW8Qgu5HxTtS3FM/
	yr5lxWeVpAkiqeivmKJNPVXsDJN0d0NOO2l6NNIb9sDOqMDPvBKUfzr/buOpa8XV7vziMN
	f/54UxWahuyp8bvjgHW3My+TxB8DXLs=
Date: Tue, 17 Jun 2025 00:43:46 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] smack: fix two bugs in setting task label
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
References: <20250315015723.1357541-1-andreev@swemel.ru>
 <0c8e9341-d044-42ca-9332-2b284a0e3e5f@swemel.ru>
 <c512e831-796b-4a97-9ae2-5eeea7321e62@schaufler-ca.com>
 <225c8775-5213-4a9c-af32-b80e78d98abb@schaufler-ca.com>
Content-Language: en-US
From: Konstantin Andreev <andreev@swemel.ru>
In-Reply-To: <225c8775-5213-4a9c-af32-b80e78d98abb@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jun 2025 21:42:49.0661 (UTC) FILETIME=[9B0C6ED0:01DBDF07]

Casey Schaufler, 16 Jun 2025 10:22:23 -0700:
> On 6/16/2025 9:58 AM, Casey Schaufler wrote:
>> On 6/15/2025 6:52 PM, Konstantin Andreev wrote:
>>> Konstantin Andreev, 15/03/2025 в 04:57 по Москве:
>>>> These two patches have distinct subjects,
>>>> but work on the same object,
>>>>     security/smack/smack_lsm.c`do_setattr()
>>>> and the second patch partially overwrites first,
>>>> so I combine them in a series.
>>>> ...
>>> Hi, Casey.
>>>
>>> If you have time and you could have a look, that would be great.
>> Looking at it today. Monday rc rituals must be tended to, of course.
> 
> I don't have your v2 patches. I have the 0/2, but not the changes.
> Can you please resend them?

I resent them in a private emails,
to avoid extra burden on this mail list.

If this is incorrect and should be sent to the list,
please, inform.

Just in case, here are links on the parts
got to the list earlier.

PATCH v2 1/2: https://lore.kernel.org/linux-security-module/20250315015723.1357541-2-andreev@swemel.ru/
PATCH v2 2/2: https://lore.kernel.org/linux-security-module/20250315015723.1357541-3-andreev@swemel.ru/

Konstantin
