Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD030B528
	for <linux-security-module@vger.kernel.org>; Mon,  8 Sep 2025 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336757; cv=none; b=i550r9jiSwrdovkCpMpt6er2eqj4vH01/X8l2MktFAaQ7U9XmiLqlxU/FL3cQPLZaY3MPnySp4iz3BObCcBVPQ6iGDmjZ1j131hYYis3YIcQqv7PzgMif6k+1jqDMUGtj1IsQk24P6VQyfmASGWTooDifSM51VZEYTicyeggOcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336757; c=relaxed/simple;
	bh=BppaAQ4jD6WEzrdgKqVOPdodNLx/+Zk2oqkAZPgmM2Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UoH0ymBFdIQCxLSbICMENtmR8GEQBt6MSIBu/G9BL9O/Nl+8yK4tCqc9n4EJBvtRXWF/fzYbs3Y9nf3F5Zn5TzpmqpaTJ2sAwbqkp+1c/ZQ9d4Yo/p1dM8SFGwdrM8E7Zs5S/zJlvqcl8LX7VUblT9MwwKAPb0t0tdnL7cQxV/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 588D5kOL069269;
	Mon, 8 Sep 2025 22:05:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 588D5kwe069266
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 8 Sep 2025 22:05:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <91e6cbd4-9811-4890-84e6-4d58c22a02b0@I-love.SAKURA.ne.jp>
Date: Mon, 8 Sep 2025 22:05:43 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some
 cleanup
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
        Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-47-paul@paul-moore.com>
 <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com>
 <dd03266930a7b219c590c54bb2c210366f8d89a1.camel@huaweicloud.com>
 <e92064a4-06c5-4913-917c-f9aca02378f3@canonical.com>
 <CAHC9VhQPmF-RCSUjZo-pe1+sWyw5ZGdnD7P0CWb7yXQQoo+92g@mail.gmail.com>
 <CAHC9VhRjQrjvsn65A-TGKKGrVFjZdnPBu+1vp=7w86SOjoyiUw@mail.gmail.com>
 <6e4bb79d-ba8f-47fa-ad12-0bb79d4442e0@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <6e4bb79d-ba8f-47fa-ad12-0bb79d4442e0@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/09/07 16:35, Tetsuo Handa wrote:
> On 2025/09/05 2:52, Paul Moore wrote:
>> +               if (!str) {
>> +                       str = str_tmp;
>> +                       len = len_tmp - 1;
> 
> This needs to be
> 
> 			len = len_tmp - 1;
> 			mb();
> 			str = str_tmp;
> 
> , or concurrent access might reach simple_read_from_buffer()
> with str != 0 and len == 0. (If you don't want mb(), you can use
> 
> -	if (unlikely(!str)) {
> +	if (unlikely(!str || !len)) {
> 
> instead).

Well, memory barrier is more complicated; it will be

	len = len_tmp - 1;
	wmb();
	str = str_tmp;

and

	}
	rmb();
	return simple_read_from_buffer(buf, count, ppos, str, len);

pair.

Just splitting the whole { } block that follows "if (unlikely(!str))"
out as an initcall function is much simpler; no need to use spinlock
(because the userspace threads has not started yet), no need to worry
about kmalloc() failure (because the allocation failure will panic()
because the userspace threads has not started yet), and the memory size
saved by use of __init function will be larger than the memory size
wasted by /sys/kernel/security/lsm being never accessed...

