Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319B61FCF;
	Tue, 13 Aug 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566368; cv=none; b=m3oLGvawjWYhZ5TpyKFRRUdsSGcJwM7R48x1n17TRur1Qkc78ioFhukOtcQr9atap9WhnGkmfzU6OrAFDtF7ZhGe8u1cjfBumW5g9v3i1uJOBPnJGLBcktsgROBBfmUX3clCRzDeXI6g3l5S4c0yujy13EW7CjBYAY0cl+vg54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566368; c=relaxed/simple;
	bh=agXT0dZl4Uk71PG6PzHE1NGe13Bgoa22tCvbIL+B4yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4XeZ05ILQWfsJT8u99ovegXbddFl23+ujqGh6oxevqN5y0oiqXNlnKCMlWZrh8VIPpMFTtcJwHn45IUbbELcGd3uAVLDgD0kPu06LfdqxV3R5oXi/tpPQbQOp/wGvx8R7XvbLWTb97pkjpKwF1qIZwbI3UDst0EqAFl2LiBIeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwkJ40gF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwkJ40gF"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb5787b4a5so3734216a91.2;
        Tue, 13 Aug 2024 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723566366; x=1724171166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TnY46YJjqTmhw3pbEcy+36BXHkNWaIA0UMO/jVkxsmw=;
        b=SwkJ40gFg6NTsEqPRMhDbqmZbMKsZ8ef8RMxp1gWuECsphN6KCturMH52QV9Hp8sXp
         ZEIJGZyo20dAyKKTegezNI3zV1yxZAqW60sWXyXETDghTnJgqb9H1g5fsZM1lhPemQZ5
         7j43KtPuVKH+kZ8YLi3HO4Yo2Y9jglpCIX+ULXhaxelWFyDoFezA4lOfXsnttbZvO58D
         LJh00N+4kt+FSfEXV51IPxUVQnLUWP0h29BAM+FIKvjM+hsi2asrv+tNJcYOU0RgYLVu
         nutL8bFlDVXXzjGg5fBPNXC6HhfToW/vHsR4JsPM6SK5UwqzhOsEoec7vke+Un0n7MYc
         hy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723566366; x=1724171166;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnY46YJjqTmhw3pbEcy+36BXHkNWaIA0UMO/jVkxsmw=;
        b=TBQKe2FY4gTzAgVtpvu/bplP4Ewh1AgLM9yV/r6/etXVIsnuhAJlWc7xlIMpHavjaz
         LqMv/qeyKlUo0lcvsuK+SNomfqscKM4irmPv9lSRIxPYH22JJ+LDzSfo4Qt5grNtvU0g
         maW1Kql6rP7Zc37F3v9jNNqZttW+gcMVIp47iQhAOzDUTEYVCDCM/oyA6VnlWkidFN7A
         h63PEvAr5ovxDC/bU26Kq/jGmbLD74C629nazV0eBGOL3ruFpKv8Z3l/QJ6nNkB0Z0p4
         0oavpZmv5GUU0e1j/nPvEB7yTuUbhDxbFARXnynRU+G6KV8p64dV7yaet59OdKDjhkNH
         hMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu3db2X8Pr5wm/2El9j2hzCzAJt9SlL3uSQ31uacp8ZhP/fm9Lm+IOsheZjCXcTdKfsprXEeb8Ovdo5YIcFGNC6emD8kMlKYJQYS3+CMqSsfU5O4kndGiA9WvWZyL3B6ya3t8MfJnAAvMUHnLMiG0YPo87
X-Gm-Message-State: AOJu0Yy6Q6v4L9j8ne7nHeSxewIvT6WS51yH8mkp2oOG810uh+zlSM0Y
	eepB/qs+gYHNw0DoQj37+ARdan0+x6JioY7wtj36sll7qxAa9J1L
X-Google-Smtp-Source: AGHT+IFQsWEvwruURKGXG4BhEe1HJ5Noha5qeeaZru71+xTTFp8sFwIUKSMFGHemyWTcJsx4dnA/iA==
X-Received: by 2002:a17:90b:4b03:b0:2c9:81a2:e8da with SMTP id 98e67ed59e1d1-2d3aab79c8dmr4042a91.35.1723566365447;
        Tue, 13 Aug 2024 09:26:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9ca749csm10685543a91.35.2024.08.13.09.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 09:26:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f088987e-32d5-4a86-808e-6cfc372c3c80@roeck-us.net>
Date: Tue, 13 Aug 2024 09:26:02 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Nathan Chancellor <nathan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 bp@alien8.de, sfr@canb.auug.org.au, peterz@infradead.org,
 ink@jurassic.park.msu.ru, richard.henderson@linaro.org
References: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net>
 <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
 <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net>
 <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>
 <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net>
 <CAHC9VhSKzxknTgKQu6ODoyxhc3skcjh_h11wSQrEvWb_vP5Ziw@mail.gmail.com>
 <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com>
 <CAHC9VhQjCHBii=CwMMnbs0hiiN-Dy49S+3gpDvaXp-YQyEHTGw@mail.gmail.com>
 <CACYkzJ7vC7OJWdgm6LbOL82eO=27cn7Gh8i6-HOp_A94-SU-gA@mail.gmail.com>
 <CAHC9VhQPHsqnNd2S_jDbWC3LcmXDG1EoaU_Cat8RoxJv3U=_Tg@mail.gmail.com>
 <CACYkzJ5J8K2D8xqT+CCrbvp57P=GbCB+XYXkAaKXojsFhuaWEw@mail.gmail.com>
 <b3c04f8a-b7e9-4dc7-849e-aeaed508b8cf@roeck-us.net>
 <CACYkzJ4eZWh2R_ZoeiNLLKFARWJOWo7Hkdp015fHEnmYLJaHGQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CACYkzJ4eZWh2R_ZoeiNLLKFARWJOWo7Hkdp015fHEnmYLJaHGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/24 08:56, KP Singh wrote:
> On Tue, Aug 13, 2024 at 6:08 AM Guenter Roeck <linux@roeck-us.net> wrote:
[ ... ]
>> A somewhat primitive alternate fix is:
>>
>> diff --git a/security/security.c b/security/security.c
>> index aa059d0cfc29..dea9736b2014 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -156,7 +156,7 @@ static __initdata struct lsm_info *exclusive;
>>     * and a trampoline (STATIC_CALL_TRAMP) which are used to call
>>     * __static_call_update when updating the static call.
>>     */
>> -struct lsm_static_calls_table static_calls_table __ro_after_init = {
>> +struct lsm_static_calls_table static_calls_table __ro_after_init __attribute__((aligned(8))) = {
>>    #define INIT_LSM_STATIC_CALL(NUM, NAME)                                        \
> 
> I think it's worth making it aligned at 8 byte, a much simpler fix
> than the arch change. Paul, I will rebase my series with these
> patches, better descriptions and post them later today.
> 

I think that would make sense, since it might well be that other architectures
have similar problems but it isn't seen because static_calls_table just happens
to be aligned properly there. Also, even if unaligned accesses that early were
supported, it is probably undesirable to have those in the running code if it
can be avoided due to the overhead involved.

With the above change:

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 539 pass: 539 fail: 0
Unit test results:
	pass: 370886 fail: 3

There are a couple of caveats, unrelated to your patch series:
- I can not enable (and thus not test) security configurations
   on sh4 and sh4eb; doing so results in immediate qemu crashes.
- I can not enable / test security configurations on riscv32
   since it results in kernel images getting too large to fit
   into the available memory. I'll try to work around it,
   but for now I can only test with riscv64.

Guenter

