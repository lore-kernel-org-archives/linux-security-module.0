Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9975A40FD9D
	for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036888; cv=none; b=LgbHANyFWESZUzUhKWvx7bFxLXZXGW/vckD9NU5xla5Xm8mjG2BfDLukhFSVVLMf64hmnJEIIylSHQkE6ER+9RpjnCHYXiy8omknN1Z9BKBfvfNSXUiiJv4X3KfAE2GG57sfDg9gKHcQ+CvNMsBmkAs4lSTRKZOmDciuii2mXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036888; c=relaxed/simple;
	bh=B7auFI5DOP0y8pn5JrY9sHQcrzSUrglplUJly+mvFFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAPfxSfy+znEyF+g/J++ldQ5OJ2zgj6QrTeBFWprznxcrTzbgOvqliOK4v+mLS1EmZ+moXnPW6no9J3JTfG3h3tLNgqA8XLBPcyDyEL7PFxN1lm36vsvThWxfAiaTes1LiToSg82oaCbrJI17srOhus24JZbpnDNTIXxZOLD0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4zMim0T; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4zMim0T"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78fc0f33998so3837147b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 15:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769036885; x=1769641685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlK7fJH8gziHUBGXOAFu3m+15JH9xk///Jw6Duq7b1Q=;
        b=Y4zMim0TkJCTuvgjYZpUOkFHwehWrCHfsLIgK1SrSGD0xz9WF+kPxCU39Bf/1QHt/p
         geiZfL1BTcVrFXhoGhSZTzXdFAHJ7ChG/hikzWlfQfX1Z/nbDFWJ2TTf91mYGESSa8SK
         MBYhqJXPO4NhEya5HZWoZoKh1lqaPoh6tOviaL3AmgjukW5liV996kFXvcQrVbqe7R0o
         2c9a8Jk9eL48vs14UOcSgxRx26oQDWIdxF5eUn8OlPXmjDnr15LUcObhu+UBgs5Gkybl
         gonN2U2ODoPuEIiIydUXtC4HsmYSZgDu7zbHUGuoisF0/z18oSMiKyTND/K7EC5IaPGx
         D1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769036885; x=1769641685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlK7fJH8gziHUBGXOAFu3m+15JH9xk///Jw6Duq7b1Q=;
        b=ScOVm7rgpYZxSbAqML9elgZC5L4MICcYAKlHjnVMxZAgowg6gVTEozpQ68TvKNgVYr
         Osk9NKmzYBkyZrV1Krky7olsWWRU8z0Wn1eU8yUjF4R0ykSOiJTy0UaGbex0Jqpg61KF
         WhY+mqpipu3OP79xijwOAyb2Gz1XjsFJdg3nKLj8qiJOeEn10At6L4tRAqPfcxn/+VmA
         e3MmGUduRbAbtKj/phhl7ujBFcSZDjHsmuyhXIVm5Au/pFNp0NYiCopTOPFN97OFyRi1
         qeSpIuc0a0fdr9vxs9w3w1Cn4Fl+5qEa8NkFOonMXSqwo0jucM0P9Kd5jLNOZM4IKek9
         dD0A==
X-Gm-Message-State: AOJu0YzISN8RjcKgNFWtmmiUDORHgZDivw/6QsRAzf8oOnOtavFUT5HT
	FQMnYqOfo5uHfiUh+Bd1h9GgJ2jv1Ypg3kiR+zbak/yTylveMoyBrnQ8
X-Gm-Gg: AZuq6aJT+ISEHkNoT6qJOk8TokQfZogQC6rOv8VFbPdnngujafVVM+i1LaEasRGQrGJ
	uRUQaP5bNWzMexb0f9VGK57Q4rbWQd/EO17UOlsVBN8k0dV+gghG4oDzLqjiNrzKwefZvwhOH3X
	Cj8F4yzGFKmxnfSnRvnJ/v3+5Fg6sliigxGAMcQOYIfHwmqwrMbJKHlHZz4emu8+QEI+LhlbTqP
	04wQW0HN7zgPSj1GY1dtYRTofUpJYYjkU+egyzjDdhp3BJZPcnT3aMNMFPZ+1MxVNnEZTlMTGDg
	K9nSagpQRPIYIqXYgxri6wjBnFEUTM4t1YdxC8TLJWdwHJS15gwKv8L+rN56gUc8ALbIPiNsF4x
	ul3Hm5V77PeEzavQuM/shnERmfUTUsbrIZgJ83Xprksh+zzYS7AMuMDzwrH70PaAUfJP2s4lOiQ
	ynN6T/+VYPsE79A/n3rA0TFruwu12L+EZSJTDFzo4MDgXB2IAyMkStGB+fHSnZacL6AjkXwDdAC
	kykW+gK
X-Received: by 2002:a05:690c:3345:b0:78f:b163:782 with SMTP id 00721157ae682-7940a36695amr140720547b3.58.1769036885446;
        Wed, 21 Jan 2026 15:08:05 -0800 (PST)
Received: from [10.10.10.50] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64916f47c8fsm8602157d50.0.2026.01.21.15.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 15:08:05 -0800 (PST)
Message-ID: <7de79223-3401-4fb0-85d0-acefc0651f47@gmail.com>
Date: Wed, 21 Jan 2026 18:08:04 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] landlock: transpose the layer masks data
 structure
To: Tingmao Wang <m@maowtm.org>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack3000@gmail.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com
References: <20251230103917.10549-3-gnoack3000@gmail.com>
 <20251230103917.10549-7-gnoack3000@gmail.com>
 <6a789aa9-c479-43f9-ac24-bc227f8388c6@maowtm.org>
Content-Language: en-US
From: Justin Suess <utilityemal77@gmail.com>
In-Reply-To: <6a789aa9-c479-43f9-ac24-bc227f8388c6@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/20/26 19:26, Tingmao Wang wrote:
> On 12/30/25 10:39, Günther Noack wrote:
>> The layer masks data structure tracks the requested but unfulfilled
>> access rights during an operations security check.  It stores one bit
>> for each combination of access right and layer index.  If the bit is
>> set, that access right is not granted (yet) in the given layer and we
>> have to traverse the path further upwards to grant it.
>>
>> Previously, the layer masks were stored as arrays mapping from access
>> right indices to layer_mask_t.  The layer_mask_t value then indicates
>> all layers in which the given access right is still (tentatively)
>> denied.
>>
>> This patch introduces struct layer_access_masks instead: This struct
>> contains an array with the access_mask_t of each (tentatively) denied
>> access right in that layer.
>>
>> The hypothesis of this patch is that this simplifies the code enough
>> so that the resulting code will run faster:
>>
>> * We can use bitwise operations in multiple places where we previously
>>   looped over bits individually with macros.  (Should require less
>>   branch speculation)
>>
>> * Code is ~160 lines smaller.
>>
>> Other noteworthy changes:
>>
>> * Clarify deny_mask_t and the code assembling it.
>>   * Document what that value looks like
>>   * Make writing and reading functions specific to file system rules.
>>     (It only worked for FS rules before as well, but going all the way
>>     simplifies the code logic more.)
> In the original commit message that added this type [1] there was this
> statement:
>
>> Implementing deny_masks_t with a bitfield instead of a struct enables a
>> generic implementation to store and extract layer levels.
> At some point when looking at this I was wondering why this wasn't a
> struct with 2 u8:4 fields, but rather, a u8 with bit manipulation code.
> While it is possible that I might have just misunderstood it, reading the
> above statement my take-away was that a struct would have forced us to
> address the indices with specific names, e.g. it would need to be defined
> like
>
> struct deny_masks_t {
>     u8 ioctl:4;
>     u8 truncate:4;
> }
>
> And it would thus not be possible to manipulate the indices in a generic
> way (e.g. the way it was implemented before, given
> all_existing_optional_access and access_bit, read and write the right
> bits).
>
> However, since we're now removing that generic-ability, should we consider
> turning it into a struct?  (If later on we have different access types
> that also have optional accesses, we could use a union of structs)
>
>
> btw, since this causes conflicts with the quiet flag series and Mickaël
> has indicated that this should be merged first, I will probably have to
> make my series based on top of this.  Will watch this series to see if
> there are more changes.
Likewise for my NO_INHERIT series, which will need some rebase work as
well. (my series is built on the quiet flag series, to reuse the similar "bubble up"
flag collection logic).

I'll keep an eye on your tree Tingmao and start rebasing my NO_INHERIT
on your patches if you put your work there. (Otherwise I'll do it when you
send it on the mailing list)
