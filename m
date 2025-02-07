Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB01B86E4
	for <linux-security-module@vger.kernel.org>; Fri,  7 Feb 2025 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965301; cv=none; b=SynBEGlgfbZG+Y6YB/r7vpsywxXqSUi8hL5ev5XwqQIjxMF2pbotsLvx70tCI/NxxGOB8nG9u91flaLBsRrsLAwUrB9LD1f2G5evn6bRRp17rLIQU8W8LU5cs4eBF8066QHsvqvL2U4pU53awU+nBFHp9rHJOsXWa03iSuEQmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965301; c=relaxed/simple;
	bh=1gd0yH30pcxmkVpUUSXoevvZ1wIpN/0PdpaN6tVQ7vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odN33qSRf1qfC/h9My5TlthwLyIohNo+AiGi12i4qJ7NNvguKjYjK0lTX8oLc8wYJJJ4wVkXrxUry3CMUl475tPB07JPiClbpLlvOdrWPYXj8DeBh86Sb0NzlDR4uz6gLExL7B3qLfcF5ZIGaFDyORNq6n7jzC6N/VBdLkvabBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bOUR29+4; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bOUR29+4"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844e7409f8aso73605739f.1
        for <linux-security-module@vger.kernel.org>; Fri, 07 Feb 2025 13:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738965298; x=1739570098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5IBqtH4R3jDvL4rKWTD+iWS0bbTvtCiS0BwL590tGJ8=;
        b=bOUR29+4mFYUIO2dUBGytCdkMQbvdNnM3m52dq7b1tfsmzMKvLZBf2aBmNnWfgXbI/
         LyOFDSdXnB9jVjdaBVKkjlcfxrFyy+S7c2fzBEcfNJSBKqBdczx/jkkqTZ5zjwXsJrjd
         VI2tGyDOcD+EZB6FraiWIQrDm0fFnhivbnQUF9VpotAZzJz57IZhz1y901FecGm1T5jz
         NJRXTjKHACHO3YX7M+i3WMZrHSHH1SE5Fdg1YC5H/SwY7IimQxR5RewKW+X+tkY8gDGD
         AR/9R5WwHdgzir8850P8HJacX0qZJ+VUkrSOX9X8gaXTC7c2t0AoGFQ94DD5xXaEiCii
         NSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738965298; x=1739570098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IBqtH4R3jDvL4rKWTD+iWS0bbTvtCiS0BwL590tGJ8=;
        b=QKkwiQsX4kUIlIvxGfomrfzYPDS/w9vgvy4bNjzOKwkS57XxPHKspd/twzM94o0VnW
         RXHOkVzPH0GRhpD+Q9cd1tuv5H5T64HucjF5XwNEknx2QRyPC5o43eOWvCbSftTZQlZn
         nY2PZuiykwH28tn4UQQ+tPEKWeYcaBuxOCco70YRToCAUd7ZpnAKcikJjdz+GYkXZHcY
         KjdlgEanDcRSs1aw2JdtyDHpiH5y78n3yZF2/SMyEt60qNPsVo4oslPsy+zudNNjatha
         qsMaEZ7iwfLCB/SGW8KwWKaeFj6zDWxMxmjV4+q+fDZM+oPhGBoLPNGuZAGaNXk/oF3X
         t72g==
X-Forwarded-Encrypted: i=1; AJvYcCWqfT6YhXaXtnpj0rOB4BEia34beKBuZpzi3XdYSC6bOhzxG+qUVgy3S5mMlUBgyQhmO5XPr3yCclYMKAQfR69eWQ/lzhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNXEmZoEm5BNTb0II4TG6bkXbbOO68EhiPYeXGAtTKly5pUY9
	K0xbBqiFoRrNRj7IuLQLCXml3I2zvFjZZTA0zo1KuM7xvGx5VlLeaIzKbX0Q1jw=
X-Gm-Gg: ASbGncuVP/jlcFo03lrvF0syqQwcqtJwKyI55UwMENGSigTSdHoVF110AM3JxyNV+zb
	CaI0/N3FgtdQToImE1LRARirvPx6nW9FG4ihYKYCFHDqD/wRHKi3jgeFPWRCERZIMaGsLscCkcd
	Sczu0mXfjjxo9vNtOVE1W2xAawz0kejTj4JYGebFgtN/KghSsm8Gd8ValVpKy4WBbYO2S/N7pSg
	CVbtk5/BnniMJQu4q9Pwh76o7eJwA6eYpsaLx/n6j5sjBukwnZyKGHu36F32V/cBrkjaDqknlr9
	hE6WcQC4dhA=
X-Google-Smtp-Source: AGHT+IHtZu3iwfSrRceCWPHMvjUaJ4b5MixZUsAk664E4N5LXxNLDuIGyZG7eeJAsl3IlpSL0Ym+fw==
X-Received: by 2002:a05:6602:3946:b0:84a:5201:41ff with SMTP id ca18e2360f4ac-854fd886d54mr481503739f.3.1738965298354;
        Fri, 07 Feb 2025 13:54:58 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854f67b90b7sm87271439f.40.2025.02.07.13.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 13:54:57 -0800 (PST)
Message-ID: <f4efd956-ebe9-4a02-8b98-b80e16db95af@kernel.dk>
Date: Fri, 7 Feb 2025 14:54:56 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] io_uring: refactor io_uring_allowed()
To: Paul Moore <paul@paul-moore.com>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?=
 <tweek@google.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?=
 <cgzones@googlemail.com>, =?UTF-8?Q?Bram_Bonn=C3=A9?=
 <brambonne@google.com>, Masahiro Yamada <masahiroy@kernel.org>,
 linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250127155723.67711-1-hamzamahfooz@linux.microsoft.com>
 <8743aa5049b129982f7784ad24b2ec48@paul-moore.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8743aa5049b129982f7784ad24b2ec48@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 2:42 PM, Paul Moore wrote:
> On Jan 27, 2025 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> wrote:
>>
>> Have io_uring_allowed() return an error code directly instead of
>> true/false. This is needed for follow-up work to guard io_uring_setup()
>> with LSM.
>>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>> ---
>>  io_uring/io_uring.c | 21 ++++++++++++++-------
>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>> index 7bfbc7c22367..c2d8bd4c2cfc 100644
>> --- a/io_uring/io_uring.c
>> +++ b/io_uring/io_uring.c
>> @@ -3789,29 +3789,36 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
>>  	return io_uring_create(entries, &p, params);
>>  }
>>  
>> -static inline bool io_uring_allowed(void)
>> +static inline int io_uring_allowed(void)
>>  {
>>  	int disabled = READ_ONCE(sysctl_io_uring_disabled);
>>  	kgid_t io_uring_group;
>>  
>>  	if (disabled == 2)
>> -		return false;
>> +		return -EPERM;
>>  
>>  	if (disabled == 0 || capable(CAP_SYS_ADMIN))
>> -		return true;
>> +		goto allowed_lsm;
> 
> I'd probably just 'return 0;' here as the "allowed_lsm" goto label
> doesn't make a lot of sense until patch 2/2, but otherwise this
> looks okay to me.

Agree, get rid of this unnecessary goto.

> Jens, are you okay with this patch?  If yes, can we get an ACK from you?

With that change, yep I'm fine with both of these and you can add my
acked-by to them.

-- 
Jens Axboe
