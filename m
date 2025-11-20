Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E733ADB0;
	Thu, 20 Nov 2025 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645757; cv=none; b=CKY4VNVSiOcayOsYtJ5Svx/KV3Sw9Ll50Eb/2aPmmRe9z6IzyjbZTZydTOzybkC7EMjNq3nW/GfWYFO7G1+rT/lRsVo7L+kKzch0iUbPvtvsZUwi8swya2sN5CW2sUuVxT8OcUETQ//d/cB+0IUadXl18A8/7fHFJDOxNZuR12c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645757; c=relaxed/simple;
	bh=VvI2tTawJs8wtEYLxR5PxzqOLZ44kTu58RoGFzyfLCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejFyioFZJhu3NBy2dLRK86wZbGFjlZ/4oCQJV8zJaMNzRKaY3oYAeqQfaFPbZG+Qsmh6W1K/LDoQfAWJnWt0mr6OpX99VWmap4QymiEQScBb3dRVLi6B6AeMrZeHSoIg6n3wTiiNrJD8DECUHfu6hcvA841UvygTe8ehfO2Rljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dBzqr6VWnzKHMWl;
	Thu, 20 Nov 2025 21:35:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9D9421A0359;
	Thu, 20 Nov 2025 21:35:50 +0800 (CST)
Received: from [10.34.206.51] (unknown [10.34.206.51])
	by APP2 (Coremail) with SMTP id Syh0CgA33nQ1GR9p+DCkBQ--.11832S2;
	Thu, 20 Nov 2025 21:35:50 +0800 (CST)
Message-ID: <2a04339f-8df0-41bb-8fd3-23eff30a26e1@huaweicloud.com>
Date: Thu, 20 Nov 2025 21:35:49 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lockdown: Only log restrictions once
To: Daniel Tang <danielzgtg.opensource@gmail.com>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nathan Lynch <nathanl@linux.ibm.com>, Matthew Garrett <mjg59@google.com>,
 Kees Cook <keescook@chromium.org>, David Howells <dhowells@redhat.com>,
 James Morris <jmorris@namei.org>
References: <3641397.L58v44csPz@daniel-desktop3>
 <1961790.USuA9gRusQ@daniel-desktop3>
 <2f4a1af8-adc6-4cbc-813f-4cc8e9bc75ae@huaweicloud.com>
 <7645139.4DdEvYhyI6@daniel-desktop3>
From: Xiujianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <7645139.4DdEvYhyI6@daniel-desktop3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA33nQ1GR9p+DCkBQ--.11832S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1DXry7Wr4xtryrZrWrKrg_yoWrCFWDpw
	18tr42qa9Fyr17Z3ZrAr43Zry7Ga9Y9wnxJF98CrsIvF15tr1FqrySqr1I9a9xKrZ8u34a
	qFyUt3y7X3W3uw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

Hi Daniel,

On 11/20/2025 5:26 PM, Daniel Tang wrote:
> On Thursday, 20 November 2025, 02:37:56 EST Xiujianfeng <xiujianfeng@huaweicloud.com> wrote:
>> Is it possible to adjust the printk_ratelimit & printk_ratelimit_burst
>> in /proc/sys/kernel/ to reduce the logs in your scenario?
> 
> It's not working. Watching the console after setting the sysctl and
> repeatedly clicking org.freedesktop.login1.Manager.CanSuspend in
> qdbusviewer (simulating what the lockscreen does), I see:
> 
> ```console
> root@daniel-desktop3:~# uname -a
> Linux daniel-desktop3 6.17.0-6-generic #6-Ubuntu SMP PREEMPT_DYNAMIC Tue Oct  7 13:34:17 UTC 2025 x86_64 GNU/Linux
> root@daniel-desktop3:~# sysctl kernel.printk_ratelimit_burst=1
> kernel.printk_ratelimit_burst = 1
> root@daniel-desktop3:~# sysctl kernel.printk_ratelimit=999999
> kernel.printk_ratelimit = 999999
> root@daniel-desktop3:~# dmesg -W
> [14385.334698] lockdown_is_locked_down: 3 callbacks suppressed
> [14385.334701] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14385.614738] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14385.878857] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14386.166744] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14386.454771] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14386.750900] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14387.038795] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14387.334770] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14387.622696] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14387.926763] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14390.366582] lockdown_is_locked_down: 7 callbacks suppressed
> [14390.366585] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14390.798744] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14391.118802] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14391.422728] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14391.742754] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14392.046735] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14392.350745] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14392.654992] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14392.974797] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> [14393.270741] Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
> ```
> 
> At my desk, I lock my screen every 5 hours. In public, I might lock my
> screen every 1 minute, 5 minute, or 15 *minutes*. printk_ratelimit
> seems to be targeted towards things that happen every N *seconds*.

Sorry for misleading.

After reading the code, I found that the macro of printk_ratelimited is

#define printk_ratelimited(fmt, ...)                                    \
({                                                                      \
         static DEFINE_RATELIMIT_STATE(_rs,                              \
                                       DEFAULT_RATELIMIT_INTERVAL,       \
                                       DEFAULT_RATELIMIT_BURST);         \
                                                                         \
         if (__ratelimit(&_rs))                                          \
                 printk(fmt, ##__VA_ARGS__);                             \
})

It seems that the rate is fixed and can not be modified via sysctl.
While another interface with a modifiable rate, which is
printk_ratelimit(), is marked as "don't use".

> 
>> logs here serve a purpose similar to auditing. Based on this, I think
>> this change will meaningfully degrade the quality of the logs, making it
>> hard for users to find out what happens when lockdown is active，
>> especially after a long time running.
> 
> For v3 in December, I'm thinking of adding a code path to special-case
> *reads* from /sys/power/state. What do you think?

Sorry, I am not familiar with hibernation, maybe you can CC hibernation
maintainers.

> 

