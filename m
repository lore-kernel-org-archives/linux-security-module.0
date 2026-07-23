Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844AF47D24D
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826743; cv=none; b=PO9M6UELm4UmyVsiMSZq1m6Z4ZuL4eTXjrrlv2m0QD2/RkWQJU0oKehB0wfhMxfxgXtFKVgaTXe2TlXpuoWW8vLDPdo3XPb5gYPT0JDGxH/ABHNrgDVeAuPRdgHYBDVJHrERS2vwyMvOMGpAohVbPENyLkHiz3SaLPCRyrHxItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826743; c=relaxed/simple;
	bh=+b4t7zA5yKydYWEW7FT6+69XQ6cwUHMnf1NMfsQ7t7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pe3gfZfpUsSRO89pHuUsK+3pDs927PeYoX0oOdoubBdbRLfFteWVRg+w0+9duPxAxHuN4GIEU7/LSLwkVJHam67WWbY8XfhIAn8iyERm1LdmZHysQHdWqi8llKo98DLV+95qkdEVWZzUdSM1q85+/fhyvli5ME9oFj39qarIxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjmx.net; spf=none smtp.mailfrom=jjmx.net; dkim=pass (2048-bit key) header.d=jjmx-net.20251104.gappssmtp.com header.i=@jjmx-net.20251104.gappssmtp.com header.b=Z7xZ0mz5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jjmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jjmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jjmx-net.20251104.gappssmtp.com header.i=@jjmx-net.20251104.gappssmtp.com header.b="Z7xZ0mz5"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cace91f112so11491915ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jjmx-net.20251104.gappssmtp.com; s=20251104; t=1784826741; x=1785431541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dT/UZ+gvx5fHXQebb45baOL1nEIiRacNil52A0Gpqg4=;
        b=Z7xZ0mz5A4qA/P5yiQTKtlHPiFC8qwvGqcnJeJ6C+dsRjTye8AFH/gB+y2q4jJ6ns6
         aWYkipRSI/TvfsE2YPDD+lyFLxzmYtwwaYS8jbQ6LJUrsCubszUelSRub4rXWr2fpKPc
         1D+ZcgX014Kvix4LDcSRV3L2UPZy5MMgg5eRURZ7J3/RCHFRJVzgsmM5EYBMp7HFahII
         V4a96GNWdrd+78A44nTzAOzvLVyX9F7+FFyZFEsfMGiEJ2K7tzTfneTn6Ngil92UcwfC
         nVikaVGopYEH7RA6KvsXG5LQp7hgQolJ+3nwmMyxZpTZm/S38X6DoF86BFw0+qtD6hjW
         AmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826741; x=1785431541;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dT/UZ+gvx5fHXQebb45baOL1nEIiRacNil52A0Gpqg4=;
        b=Yoimnkm+TR0x2V5HJuZ/O61puKODsDvbnkO0YjgBHlnLpeQQ2dWwMFDZA8DG4xmty4
         P9R9LGgAOyYIIOmDqXXPet7VJf+GkDccSB92JMBdn7WB0yvF/a+BnrKIekjcgwXL4aPw
         Z8m5isBLcrHPwjNbYuCHNfbXb7Q9VRR9FwXFBlzjwWEvRvTm5BGEzlDrwR/Sxc9e7bVk
         a5HgzgX3WrCvgVImESu+iJSHsOloRN6k4jXuWFuxSySZIbeZyfWgmzerCx85ACYHEZD6
         yiQLXQyetV1AhNLY9RpsEgKQNOaa0/byMKkPw28pA01bHHbkCVABKfJx+p0OWCGUogS4
         mczg==
X-Forwarded-Encrypted: i=1; AHgh+Rr94pAP7qsZw676IGHT3tEQ/zCCZVkhIWF4Hv/I9eL0jYUmoVzXbGv+7oz8gVoHdwmqY4OiSUJr4XQ2vNB15HesntFrLxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LTK8tR2KizTzmU/CHjDLE0bQ/UCCn/bmQgkan+mTfv/m0IzZ
	/fHKeZILBYyI1gzpOi+GFIThgyVzmQhp4lJ3PcUGw1ZtvZBAHL9h88CG2EwrkSbFj20=
X-Gm-Gg: AR+sD11f8yrvMGo9iufINC00jZDrIhMBwXkq99qWEVRHJ3F3NEX3t/Q6SPvp0PFVqYT
	NZtiI4UJOCR9DHfeJ3dSoRHGrQpApwlMWrhnFtDaNF0DCBubaMMeJu8u3412CvSdpvtXIJ3D9RS
	jadVBQ48QKukX5ZHM6ciNLD02ozXmXUwBmdpy/JuspyQDDuvOk6EbtA3jSnxKsQSdYbP/YIAsWj
	b/mymjTkdaYGH4BpAANXX7Aht9JU/qLydf1899HAs+9ZRFslmJKMuVi+yqV0vIHF1Qe7QPdet2Z
	RukGZXJuwpFRp9olMXe3jYxggufaM0+31UpEfNHaWUsPI+ONeKjA3Gxz0BHWV5eVA0nPf25Bdz0
	Rpx02hCvuS5G81dIWxfz5EphaLg3f+dP3s0HlU2bcFy0QmJNu8ea0L09VkgRPQZgGuenTR+rLJA
	==
X-Received: by 2002:a17:902:f70b:b0:2c9:cf62:6f61 with SMTP id d9443c01a7336-2cfa6b75449mr44387115ad.17.1784826740736;
        Thu, 23 Jul 2026 10:12:20 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2cf8f2e797asm37185995ad.39.2026.07.23.10.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 10:12:20 -0700 (PDT)
Message-ID: <bf88cee2-c398-45d7-88e8-c5740e0aeddf@jjmx.net>
Date: Thu, 23 Jul 2026 10:12:18 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: update website link
To: Baruch Siach <baruch@tkos.co.il>,
 John Johansen <john.johansen@canonical.com>
Cc: Serge Hallyn <serge@hallyn.com>, Ryan Lee <ryan.lee@canonical.com>,
 John Johansen <john@apparmor.net>,
 Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org
References: <2ce1d4ec18b2b47ee7ddd9c1ad7be68e185aa69c.1784632742.git.baruch@tkos.co.il>
 <CAKCV-6vP2FKgTj5PT3xB_TDL+zLk7xYf2BNw6mKXfPb3OO2TWA@mail.gmail.com>
 <48d44625-7fa2-4e1c-8821-4d22208421ea@hallyn.com>
 <ba05df8c-fb79-4a14-a9b9-15e50e7dc4bc@canonical.com>
 <87bjbxodw7.fsf@tarshish>
Content-Language: en-US
From: John Johansen <john@jjmx.net>
Autocrypt: addr=john@jjmx.net; keydata=
 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
In-Reply-To: <87bjbxodw7.fsf@tarshish>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/23/26 09:43, Baruch Siach wrote:
> Hi John, Serge,
>
> On Wed, Jul 22 2026, John Johansen wrote:
>> On 7/22/26 15:36, Serge Hallyn wrote:
>>> Jul 22, 2026 11:41:27 Ryan Lee <ryan.lee@canonical.com>:
>>>
>>>> On Tue, Jul 21, 2026 at 4:40 AM Baruch Siach <baruch@tkos.co.il> wrote:
>>>>> apparmor.wiki.kernel.org redirects to the current website.
>>> Sure, but kernel.org seems less likely to go away, and the redirect can
>>> easily be updated if needed.  Up to John of course, but i would leave it
>>> as is.
>> I am unsure of the best course, but atm I am inclined to leave it with
>> kernel.org, Like you said the redirect can easily be updated.
> Another problem this patch fixes is the use of unauthenticated
> HTTP. This is less than ideal for a security feature. A MITM attacker
> can easily redirect to somewhere else.
>
> So a patch only switching to HTTPS should be fine, right?
>
switching to HTTP is fine, if you want to submit a patch that does that.


>>>>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>>>>> ---
>>>>> security/apparmor/Kconfig | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
>>>>> index 1e3bd44643da..472aa38254be 100644
>>>>> --- a/security/apparmor/Kconfig
>>>>> +++ b/security/apparmor/Kconfig
>>>>> @@ -11,7 +11,7 @@ config SECURITY_APPARMOR
>>>>>             This enables the AppArmor security module.
>>>>>             Required userspace tools (if they are not included in your
>>>>>             distribution) and further information may be found at
>>>>> -         http://apparmor.wiki.kernel.org
>>>>> +         https://wiki.apparmor.net
>>>>>
>>>>>             If you are unsure how to answer this question, answer N.
>>>> Reviewed-by: Ryan Lee <ryan.lee@canonical.com>


