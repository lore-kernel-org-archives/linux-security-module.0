Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B7D5684
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jan 2025 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737929168; cv=none; b=Ke/f43iIk4HfjMzjTQut1yEibFUXh0ej/bd1D+duKjiTomHZ81dGFeBC7sSSsLrSzrdfMHhk9PiYtsUDPAg9otAmYzeA3gsUHO7xRLO3t0rGUJKhxjMiO89HzHZHJsmooD3cCOXzyCbNDU9fzAPvjiDnDWQF+SFYH5+2tfrb/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737929168; c=relaxed/simple;
	bh=bJelYN2AittT6034KMNmjT5EajmP6ahQSxjqiJ99ULo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=jV+/RoJ4gVWiQa2dSR/8acIe1QmM2C0CyXk/PW/1zLi0rA+BbQvmQcoykkg1UhgUcReQkg7vpD9lXBWKniplT8XJohau2CIid8F4YGXL4UcXsFDPADnEBU+hE4DskWy5CC1BqbQWrwLGQvP1r4WMEfovBgBZZL9YClbwOzx56iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=jqmOinVz; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="jqmOinVz"
Message-ID: <8f84a564-678f-4787-8d80-ab7f93852f18@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1737929159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VhXQoW0YR5q9y8jXXFOEyusKKzfiSgs+3hNddQpGC0=;
	b=jqmOinVzJUhKWxHVG4NsTMFvwSISPJI6r5BHi9zdaokjyJX2hb1zoPP6QI+Sw7RzotsIPP
	2ryE6zxODizPGwK2uBkbYjflsUc49+mcP3bjcFCtWyLSUkI+tvalqReIPz3OaxBDFCl6zt
	4w69GRnGrQyz4IbG1VHs7QxGVZdSp2E=
Date: Mon, 27 Jan 2025 01:06:45 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re[4]: [PATCH] smack: dont compile ipv6 code unless ipv6 is
 configured
Content-Language: en-US
To: Casey Schaufler <casey@schaufler-ca.com>
References: <20250117163645.3069927-1-andreev@swemel.ru>
 <40046ce8-1117-47a7-80a3-650f7adb1ecc@schaufler-ca.com>
 <72077b25-4f5f-4a64-ae35-ee2fe72f49c7@swemel.ru>
 <c65ad1a3-64f7-4101-ac26-d72fbbbf85ee@schaufler-ca.com>
From: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <c65ad1a3-64f7-4101-ac26-d72fbbbf85ee@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Jan 2025 22:05:59.0084 (UTC) FILETIME=[7AF6CEC0:01DB703E]

Casey Schaufler, 26 Jan 2025:
> On 1/26/2025 6:15 AM, Konstantin Andreev wrote:
>> Casey Schaufler, 21 Jan 2025:
>>> On 1/17/2025 8:36 AM, Konstantin Andreev wrote:
>>>> I want to be sure that ipv6-specific code
>>>> is not compiled in kernel binaries
>>>> if ipv6 is not configured.
>>>
>>> The IPv6 Smack support really ought to be replaced with an
>>> implementation of CALIPSO, now that it is available. The
>>> conditional compilations that already exist have drawn no
>>> small amount of well founded criticism. I will most likely
>>> take this patch, but if you want to be extremely helpful
>>> you could have a shot at CALIPSO for Smack.
>>
>> Actually, I am sharing the changes
>> I have made to SMACK along the way,
>> during development of other feature.
> 
> Thank you for the work you're doing. 
> I'm curious about your "other feature".

Well, you may remember the concept of multilevel ports,
that ascends to Trusted Solaris (2.5 as far as I know)

The approach to allow a single instance of a trusted service
to serve clients with different labels.

Given the idea, we decided to make “multilevel” not port,
but process, and we limited protocol support to
tcp/ipv4 and unix/stream.

Implementing this in SMACK turned out to be very simple,
and we found the result highly useful in our use cases.

I guess that `@' label was invented for similar goal,
but we consider `@' approach less secure.

The interfaces we created are not yet stable,
and the feature isn't generic enough to be offered
for public use.
-- 
Regards, Konstantin Andreev
