Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC5017C7CE
	for <linux-security-module@vger.kernel.org>; Thu, 14 Nov 2024 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604119; cv=none; b=aGkw1+qRAWYtHlCAQegIgsFy2RRu2bTFc8SboNY0K60NAL2wEQvpy+6cEgoNwCabZ9kHapQSN0khYXRJkERVOtlQzcCENTiEhzzJSO2nkQEzXHaZbEXoH5oqQ4wfxbCfpKcVr2PBZNsrCQ3339OfGzr/uY7sTSiCOOrkl3W1kAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604119; c=relaxed/simple;
	bh=yHELOSQhvvHp71OtVk5swb+nNSN0zFC0SuN+AIziXeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0WINMTOcvm03pifTSOoTSgiDJHe/O5OxBbT9VzwQPZNjfdu9+oIscEEWRGCVJpEXLA/srWxa/iAM++su4iNRN2Tz5cvM596hJH96XEEEyslkjfgv8d7mmjoOoXqfWY2oLQInbMSkSfN/Z8SPbqO4oM8u6xbAfr4jBpgKnE6SCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=go291JaB; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="go291JaB"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83e2d80ad51so31933439f.3
        for <linux-security-module@vger.kernel.org>; Thu, 14 Nov 2024 09:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731604117; x=1732208917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytkqD9XI/BHqVrDHS/oEUwpMJruMLfeh9lCP9HUJDm8=;
        b=go291JaBO/0KbNcbkIzVP4uTa0mUQhOk+u1vrgy/NE0lKA6gWHxUgmemXtUWLDNad0
         5WVxlnM/K/yGCl/0J6aA05Nd07/7b1XIMSgGhaX+DSS/7TzGVM1QEggAZ6cK6gByaWV8
         Emv/0+Et+bX9IblN3MhKr3roRMACRMjZr6J80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604117; x=1732208917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytkqD9XI/BHqVrDHS/oEUwpMJruMLfeh9lCP9HUJDm8=;
        b=o/HRhhi9lwk/fSHdZxfNNxZvSymX18PKVfKHqsF2wjc9n8Y2tFz2uP6j0rpMpPf2w0
         V1srV8lp/XdzT7EZuvOjUFAQirjAso1XovTaURagDIWW9g8tGud6uZyfmyJ1qpGyPoh4
         ErcgJ2FoHAybdUO16lS6EPE6s/6u05zBkF2fjWULNqnZysqzBH0hhN+Axi4DFYve6G3H
         hfejHFbzBBl6aVIE5XBghJUcN/ykm/FxqtfdwYEJCiVsQHbbit8lQFo+ZtIh1sRgSVIU
         HCEOtJS2XJ/AOxk1V+IjOzTLeIHi/L4sgW+bfJJXzLLw5PONlKsNhHSyywvqjciM0zFl
         zDLw==
X-Forwarded-Encrypted: i=1; AJvYcCW70q/sM2CM4wpuIy5D1F0H9k4w2rbxbGFc3CkCBgdzmVxdtqa0Od9vPHVg1ScsHp82iB/a9rSq1E2z4kZg1AxxN/aFqDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU6drs8iAxOtM0u1/0mN+9SxL2iR9JmlRWE06OiP/EXjJzbapF
	NqFonjPqVPynqakKReisPtkjVic4SGSqzkb9nnLkfBckXfomA5TlPjXtAcOZM5E=
X-Google-Smtp-Source: AGHT+IGUZJKnYN5ymfXEvQzdJKzRh/hKLacsxIQ6Yl6xQ9sfR7oYN33P5rDErUzL/+6dybCL0+GDgA==
X-Received: by 2002:a05:6602:641d:b0:83a:931a:13a0 with SMTP id ca18e2360f4ac-83e032e0050mr2741669239f.8.1731604117015;
        Thu, 14 Nov 2024 09:08:37 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83e6064901bsm35300239f.45.2024.11.14.09.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:08:35 -0800 (PST)
Message-ID: <196eaffe-c90b-4f44-a748-b786b46fd506@linuxfoundation.org>
Date: Thu, 14 Nov 2024 10:08:34 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: lsm: Refactor
 `flags_overset_lsm_set_self_attr` test
To: Casey Schaufler <casey@schaufler-ca.com>,
 Amit Vadhavana <av2082000@gmail.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc: ricardo@marliere.net, linux-kernel-mentees@lists.linux.dev,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241112182810.24761-1-av2082000@gmail.com>
 <52cc8e51-9e85-465b-8ee3-63a7a0a42951@linuxfoundation.org>
 <c16b7517-e490-48d9-a2b6-f0077cbb0eba@schaufler-ca.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c16b7517-e490-48d9-a2b6-f0077cbb0eba@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/14/24 09:55, Casey Schaufler wrote:
> 
> On 11/14/2024 8:25 AM, Shuah Khan wrote:
>> On 11/12/24 11:28, Amit Vadhavana wrote:
>>> - Remove unnecessary `tctx` variable, use `ctx` directly.
>>> - Simplified code with no functional changes.
>>>
>>
>> I would rephrase the short to simply say Remove unused variable,
>> as refactor implies more extensive changes than what this patch
>> is actually doing.
>>
>> Please write complete sentences instead of bullet points in the
>> change log.
>>
>> How did you find this problem? Do include the details on how
>> in the change log.
>>
>>> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
>>> ---
>>>    tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 7 +++----
>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>> b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>> index 66dec47e3ca3..732e89fe99c0 100644
>>> --- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>> +++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>> @@ -56,16 +56,15 @@ TEST(flags_zero_lsm_set_self_attr)
>>>    TEST(flags_overset_lsm_set_self_attr)
>>>    {
>>>        const long page_size = sysconf(_SC_PAGESIZE);
>>> -    char *ctx = calloc(page_size, 1);
>>> +    struct lsm_ctx *ctx = calloc(page_size, 1);
>>
>> Why not name this tctx and avoid changes to the ASSERT_EQs
>> below?
> 
> In the realm of linux security modules ctx is short for "context".
> I used tctx here because I was lazy. It would be much better to
> drop tctx, even if it means a tiny bit more change.
> 

Makes sense.

Amit, you can ignore this comment about tctx and ctx. Please do fix
others about the change log and short log.

thanks,
-- Shuah

