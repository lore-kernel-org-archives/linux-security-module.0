Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6719D8B8
	for <linux-security-module@vger.kernel.org>; Sat, 28 Sep 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727515507; cv=none; b=NhDQ0u4Q/qIPY/KHUtBRbw3o72JJC1KHB2+ycFyWyJqGXRxBisQL4BVc2QF2+9uFG5aFG0TMAobPeqfe0yQiF15FM7a2IF/AaCw434ZEbjLQ+UCTyvE9/dHpWtaYGOyhfKHeoV+gHwp3P9iPAfD9YfhhoMe9Lf1rg34dvBZrHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727515507; c=relaxed/simple;
	bh=aXnYmNA3D4Zi6MT4JWf0ODz8h/3lfqb0mT5NJS7phNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYOnSLOqzo4HEpeXN3SBVTJlc7JmwZMnupHVcL12M9fX8R1kTfuKX2RuiWHgi5LlHaBv2oMNbiiWycYRJmAL3r8nqlqTifsTphqhH2l7AohL/ehc9PAZInTQ7s6cByn55mH6hC8XL0yRBLish/Csm8plgTNvXPJmAOOfLDtrxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 48S9OHbo075641;
	Sat, 28 Sep 2024 18:24:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Sat, 28 Sep 2024 18:24:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 48S9NtdO075537
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 28 Sep 2024 18:24:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <deff904e-5c56-42ae-b8b0-7b55580b023a@I-love.SAKURA.ne.jp>
Date: Sat, 28 Sep 2024 18:23:53 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] Monthly lsm report (Sep 2024)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        syzbot <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <66f12e9e.050a0220.3eed3.0009.GAE@google.com>
 <CAHC9VhTxCzWvM+j8=J08JVs=1cwk9rtBSS7qFBkdm-_neAwkJQ@mail.gmail.com>
 <03c3a47ca225050d37dca6a9249c1f978f1fc56b.camel@huaweicloud.com>
 <734977390eeecba39789df939a00904e87367e5e.camel@huaweicloud.com>
 <nqxo5tqcwbwksibg45spssrnhxw7tabfithgnqnmpl2egmbfb7@gyczfn7hivvu>
 <owdoubzm3jqf4cuhawaavver5mzko32ijuh2nrm5vhzegmjbmf@az3mweawrni6>
 <ceb762ee-2518-44d1-b73c-fd165da7fbbb@I-love.SAKURA.ne.jp>
 <pdghzlvw6ypcju6ldsngka44cjp6g56bjjsmxm3sd7dqev4g6y@x72zm7vurxyz>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <pdghzlvw6ypcju6ldsngka44cjp6g56bjjsmxm3sd7dqev4g6y@x72zm7vurxyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/28 17:57, Kent Overstreet wrote:
> On Sat, Sep 28, 2024 at 03:49:27PM GMT, Tetsuo Handa wrote:
>> On 2024/09/28 10:25, Kent Overstreet wrote:
>>> And looking further, I don't see anyhting in the console log from when
>>> bcachefs actually mounted (???), which means I don't think I have enough
>>> to go on. It's clearly an upgrade path issue - we didn't run
>>> check_allocations as is required when upgrading to 1.11 - but it's not
>>> reproducing for me when I run tests with old tools.
>>>
>>> Can we get some more information about the syzbot reproducer? Exact
>>> tools version, format command and mount command.
>>
>> Reproducer for this bug is not yet found. But syzbot does not use userspace
>> tools. That is, testing with old (or new) tools will not help. Please note
>> that syzbot uses crafted (intentionally corrupted) filesystem images. If the
>> kernel side depends on sanity checks / validations done by the userspace
>> side, syzbot will find oversights on the kernel side. Please don't make any
>> assumptions made by the userspace tools.
>>
> 
> You seem to be confused; how do you expect sysbot to test a filesystem
> without the format comand?

Please find syz_mount_image$bcachefs from e.g.
https://syzkaller.appspot.com/text?tag=CrashLog&x=17441e80580000 .

syzbot creates in-memory filesystem image using memfd and mount it
using loopback devices. For example,
https://syzkaller.appspot.com/text?tag=ReproC&x=102e0907980000 is
a C reproducer for an ext4 bug; check how setup_loop_device() and
syz_mount_image() are used for mounting filesystems.

Again, syzbot does not use userspace tools for managing filesystems.

