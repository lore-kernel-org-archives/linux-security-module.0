Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A6D1885A5
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767307100; cv=none; b=RHeeLWeD2xXz7JHjI7hlnsm6TOd1u35RLF+AXaEF4dM5yvrY6/4X10vljVav3ISuf9xMjS9byrE8ibqIaYuEA9CB2Dd11sO9whx6gvOdC6VgT0gjygS8h6yDQliQSLCwxyMoOXt7Zg5a1vPJhcYdjYkWXQ9Ze0PZCAwIIK8NaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767307100; c=relaxed/simple;
	bh=+hDAM2qtWmCcdxmVzvEsFn9QqOXfPUe1JPBc7jVJTnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvyir6MUjZFK0gv+N9z2k6XRKdrL7mvNjE8LWLgvHp8g71HKRtOoiutbMEyBMGf4yFHc/WQLivP/+4x31w8V/NvDfvBJrcyHHIW5lbT4jREWyNlc674U0tue5DwbE/t7DCu0yonAxNvrk+3Hct9jaKX3cjIfop/LrAcLkHv1irs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDnzutKY; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDnzutKY"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64476c85854so10320820d50.0
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jan 2026 14:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767307098; x=1767911898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/vBStwV683HygU64PGC8/WgSrMOvYvvX6NlYl0t2As=;
        b=hDnzutKY3KnOBoSMt5htfmnsKxMgXVhf5hlpaI1lXgxXX8yjJmikggxCPbHNs40vDi
         07cdY8Ja/UyRXnIhg0UvjPKveelddTHvsbYMY6bZ2hc7mzc2vDr/khRDmK0FxlCH4vGx
         +9d/fSZ/ty81hCFgMJf5oWu+YpU6ndGbLw51fR2t2gHXfCSQHh+1zHwZsFjzGqU3Vm8q
         Eykrr+ystEQ3vbRnMiDzBQ9HYpS2d3t9KLfdDSSaVAc/KLGI1Gv6+LzpXffLwFnH31iI
         7nct425DHgdZOdcozyVPGh1AZg26dKB5T7BSN6or9KAesJsDdKiXEv8euXJA9i0SS8Hl
         2w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767307098; x=1767911898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/vBStwV683HygU64PGC8/WgSrMOvYvvX6NlYl0t2As=;
        b=pRcwDBpgD+CL2QuifXMQWJRoDP8EJr+Vogm6EkAsseNdOcatpX2Erf2juevGUr2U8H
         KV7onCk81xxnTT2806Uz5V7TBsQMterJUDzgfhfCNhyiND1uOlT+BvsefVmCdag0t2/v
         EUxnHy4A1LIN6DxW9S+n6jpFtwG4S0VCU3BTFsflFkZukSH0wkdIHK6aUTIz1XLtuQkz
         p0NxV5Mx5fioIMLWOcvYH2qECUMyX2plSlgzHKD/xSk02EsoaD4zUxe/MbgN5Jezf4VU
         abUE150cGWKI8aXYmkiFMuRXXwmROcg8iuDt/kbCInCX15zOkXY6cMxvGusOBkvxYDqn
         r5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWRPntP8lfIMeqpubIU4rfEI/PRfATKBHUWc1PQvb5L49hwEnBVJMZhM7rzoU7+S9N3404E6edRpW0hffOLSSpQKxhWZbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkT2sQjrwUIE411p8yqM2RPvftuv8X7h9ZeKqWSQuB4XgQg8s
	7wKOHb8GmayPi+q4UTiSbZXqDWN8hv3UCu+v/r96cwS97EKZMLzwNOJ8
X-Gm-Gg: AY/fxX6E14KIK/qNY2pFrQJf0ddj15E1EHRaqxlGrVLsHtsc6rGjCIjEA3sMk+NcsMv
	JGtDt0ZQiYgx7jgp9Wb5FZnuK4EgoOGX0VDzJwVEmKGh4Ub1wGBM/jPGezELGqOhi8bZFdajLSZ
	9lQidAGnyfw7Wf/9lb8QUWQQU9h/FxxnsVnnOnR42OJYCIcIqHUfKw5vIUpgGmCy7wZAzLAnOVz
	Qwu3tMsMAl+lUU3gNEZaxR5K5fv95hM1mBhVm4L2hEHF13qxQny1WU6LMx2/lqIm3j7cstTGG8X
	Og+ABuQxMN/t7GuZOKo8Khy5fihYvS1qkfQYVcYzowfHObsX1q8XCouXVO5HgYGovfbJ2xEflrI
	ksM1kq6+59h6QBxTJX26hmXMZ/kPlExBqByv7t0+PmLEQJ52F3JktgOag3ArBykzfnUjCWT44CI
	OvSighXGmpW4SbN48x8QOg8fUbTnDR1JlthxPh2eAbjG13e02fNUh1VCvrUWFjwpp/nwNgMQ==
X-Google-Smtp-Source: AGHT+IH/aLlnxqsHeADSOduJme5rNIBmEnYDvV+vQlx+HBnkq9KTxdlyplOfpaht42Aj1cFD4HETbQ==
X-Received: by 2002:a05:690c:7091:b0:78f:b163:782 with SMTP id 00721157ae682-78fb4092d13mr697778247b3.58.1767307097653;
        Thu, 01 Jan 2026 14:38:17 -0800 (PST)
Received: from [10.10.10.50] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43cfae9sm150866207b3.23.2026.01.01.14.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 14:38:17 -0800 (PST)
Message-ID: <43c0515d-afd3-4e00-a0fe-4d651a1d5cf1@gmail.com>
Date: Thu, 1 Jan 2026 17:38:14 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] samples/landlock: Add support for
 LANDLOCK_ACCESS_FS_CONNECT_UNIX
To: Tingmao Wang <m@maowtm.org>, Demi Marie Obenour <demiobenour@gmail.com>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: fahimitahera@gmail.com, hi@alyssa.is,
 ivanov.mikhail1@huawei-partners.com, jannh@google.com,
 konstantin.meskhidze@huawei.com, linux-security-module@vger.kernel.org,
 matthieu@buffet.re, mic@digikod.net, paul@paul-moore.com,
 samasth.norway.ananda@oracle.com
References: <20260101134102.25938-4-gnoack3000@gmail.com>
 <20260101193009.4005972-1-utilityemal77@gmail.com>
 <423dd2ca-ecba-47cf-98a7-4d99a48939da@maowtm.org>
 <22e29fd8-2f39-4a64-b08c-2f41153e3be8@gmail.com>
 <2d02eefa-bc86-4f04-b190-beed304337d4@maowtm.org>
Content-Language: en-US
From: Justin Suess <utilityemal77@gmail.com>
In-Reply-To: <2d02eefa-bc86-4f04-b190-beed304337d4@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/1/26 17:19, Tingmao Wang wrote:
> On 1/1/26 22:11, Demi Marie Obenour wrote:
>> On 1/1/26 17:07, Tingmao Wang wrote:
>>
>> (snip)
>>
>>> Looking at this I guess it might also make sense for the kernel side to
>>> enforce only being able to add LANDLOCK_ACCESS_FS_CONNECT_UNIX on socket
>>> files (S_ISSOCK(d_backing_inode)) too in landlock_append_fs_rule?
>>>
>>> Also, for the sandboxer logic, maybe a better way would be having
>>> LANDLOCK_ACCESS_FS_CONNECT_UNIX in ACCESS_FILE (matching the kernel code),
>>> then another if(!S_ISSOCK) below this that will clear out
>>> LANDLOCK_ACCESS_FS_CONNECT_UNIX if not socket.
>> A process might legitimately need to connect to a socket that doesn't
>> exist at the time it sandboxes itself.  Therefore, I think it makes
>> sense to for LANDLOCK_ACCESS_FS_CONNECT_UNIX access to a directory
>> to allow LANDLOCK_ACCESS_FS_CONNECT_UNIX to any socket under that
>> directory.  This matches the flexibility mount namespaces can achieve.
> Right, I forgot about the fact that we also need it on dirs, apologies.
>
> (But maybe it might still make sense to not allow this on files which are
> neither a socket or a dir? (If the file later gets removed and recreated
> as a socket, the rule would not apply retroactively anyway due to being
> tied to the inode.))
How do we handle IOCTL access on regular files? I think that landlock will let you put IOCTL rights on regular files even they are not valid for that operation.

Sockets seem like a similar case where the operation is only valid for a subset of file types.

I think we should mirror the existing behavior is for consistency.

Besides, restricting which file types can have that right also makes it harder for applications that may not care about the specific file type, but now would have to check the filetype before making a policy on them (also opening them to TOCTOU).

Justin
