Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230120ED
	for <linux-security-module@vger.kernel.org>; Thu, 16 May 2024 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877078; cv=none; b=I1xSgHrTkLdzv9g/eGk/HvFH74jm0FPDbJAnk83SEdRAzEL5Tjp8dlX7CXUreh+w9jV6v05Bk831tgMoimGl3Pp8I1ciz1eUaXX8700ERUDdSMZP0mRfZJwXv7cwvQ3eYeJO85ETLwNLplI0ufs2ntvg6+zwmZor1DYiuo/0wQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877078; c=relaxed/simple;
	bh=xkfznAhSXPPgMUvz2RZcB9OT2Zux0dt6kJDr+ShFPrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGQ+j+oQd8S1JNI9kAK+P5h0AdayUL93+biI6uA+bWLBbGC19CR5CLJepR5bU4km3AlC6ZJIWM3OpMRwDDBEivSI6QhO25N+AaGgMqdbzE8hq/+/OD5zent47CVrMDIZXWbhB0qnki6Nsu4R8C+nV+cuUpBECPUbg62+jKZnn3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TGZ+rhCh; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TGZ+rhCh"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7e1e4508b7aso1329239f.2
        for <linux-security-module@vger.kernel.org>; Thu, 16 May 2024 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715877076; x=1716481876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDnoiv+aAilJOglosMLJSLeZ15PVLhndVRN5KP2yh64=;
        b=TGZ+rhChyRj5oWtecIQsAYYU5joL5ZarwVOJkKi6LVVn1xVoi0hSNjEtIObQLT8hdM
         WIx5VkA6oEqMxG6aR2Yw7bwo1q4jd2ADzaHp2AXIyzKhZO4n3mtUjsfANJL7Et5QhgEA
         8kIUJIrRB90zzkeSDU1NGARAEQHe6sXTJsed8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715877076; x=1716481876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDnoiv+aAilJOglosMLJSLeZ15PVLhndVRN5KP2yh64=;
        b=KWBltUF1mXeNi9lm4dJJY4JFuq9Gs1MHKIRaAUcA/YKoEZUOlEtuUsoIP0SMvzuHe9
         RLRNLaDBeV/vd+T9H/LzQ5F40GTshvoMbuQHWrkLDQesPsW8DHkSgp0uirjT1HTBDihP
         /c4OdVtHEtRnbqciNr61NC6pvf2ylpJjKuQNRtEdiM1VU01o7lFX1iWIoVscmw8HzRRH
         zhRwLNgi6t2C+py8hfxB+5l83MOa1RYp/KRv26A30J23mqY1UppmLrK3krGXsGDogGku
         VOghyZ07qVVJZN5SIaR4iPDW9gUO/c76o/fNaaHUpSNmBB1ZkgYaCx9ON53SG4oTla2u
         VRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3tzvxpuyDOviM2ZeTTvd94YSa6g54UO7qlIC/HGQD9md0t9xthEQGg8By0p8Z4qPu0/z/F+MeJmt5ZnUmcvrV3Nb3VbzteDx/DjquZdk+sFuf+HqG
X-Gm-Message-State: AOJu0Yz3HripmrPw0xW0+fdwmy5CUzEfeSEQpAhuuUo1Ykw/lTNhZjAM
	6mOr5Gat5+KplNsQwYa9Gf+lNaU4SD5oGOfIbrFx5saU5TeVFPf8CkjL2Bw5syY=
X-Google-Smtp-Source: AGHT+IHC7NWHiVtGdW49HXEWLPpD9poqjpxpz8h5HFbktLyqnUrR9q12B55ixwuwmtZx24K1zeLkFg==
X-Received: by 2002:a05:6e02:1c8b:b0:36c:c599:698a with SMTP id e9e14a558f8ab-36cc599af7dmr211295495ab.2.1715877075869;
        Thu, 16 May 2024 09:31:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36dbbd191b0sm7514315ab.17.2024.05.16.09.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 09:31:15 -0700 (PDT)
Message-ID: <9e72d97a-9a04-4423-a711-0c21c1c8b161@linuxfoundation.org>
Date: Thu, 16 May 2024 10:31:13 -0600
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/66] selftests/cgroup: Drop define _GNU_SOURCE
To: Tejun Heo <tj@kernel.org>
Cc: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Zefan Li
 <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-9-edliaw@google.com>
 <ZkJHvrwZEqg6RJK5@slm.duckdns.org>
 <bec3f30e-fc9a-45e2-b6ea-d739b2a2d019@linuxfoundation.org>
 <ZkYymMDd690uufZy@slm.duckdns.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZkYymMDd690uufZy@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/24 10:21, Tejun Heo wrote:
> On Thu, May 16, 2024 at 09:50:06AM -0600, Shuah Khan wrote:
>> On 5/13/24 11:02, Tejun Heo wrote:
>>> On Fri, May 10, 2024 at 12:06:25AM +0000, Edward Liaw wrote:
>>>> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
>>>> redefinition warnings.
>>>>
>>>> Signed-off-by: Edward Liaw <edliaw@google.com>
>>>
>>> Applied to cgroup/for-6.10.
>>>
>>> Thanks.
>>>
>>
>> Hi Tejun,
>>
>> Please don't include this in your PR to Linus. This patch series needs
>> to go together as it is causing several build warns and some errors.
> 
> I'm afraid it's too late. The PR is too late. Do you want me to send an
> amended PR with the commit reverted? If it's just temporary issues in
> selftests, maybe we can just wait it out?
> 

I am exploring options and leaning towards reverting the patch

daef47b89efd ("selftests: Compile kselftest headers with -D_GNU_SOURCE")

Your amending the PR helps me if I have to send revert. I am sorry
for the trouble.

I can all of them together in a second update or after the merge window
closes.

thanks,
-- Shuah


