Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150632153D2
	for <linux-security-module@vger.kernel.org>; Wed,  7 May 2025 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615969; cv=none; b=EHC//tYMI6vqqTIG52VJzKW+NfVpV6ltuFTyz5e9D20vZswM3WQXqMCM33x52BRoFidKH9fNr66HMJM/DMUgldcPZYFRjhxFZ/aefTvW7B53TzuMAqY5CmmrmehIz9wrSqthMmFsDlpWgTSUzdvu+LlWlCXfq4+dqVqCexw9Owk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615969; c=relaxed/simple;
	bh=1H4TziJTxzOvm4bA7rrDdFpecfNpuR9V+GDe+zkJ5oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxQPxAu459dxGC/EPq5evuN5KCP90kchxclmKYH4+hPCTLfjXM67uwRkA2rB2sMXPUNM5zKQ1sN7GvLniyR/6hljj2CBclUMd3lOduVivsxjoEQbSCqLYR7fBvNDhbCUN37/ZngHe57nfiJ0+S7dkUBHte2QK2NPmujslNpNBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 547B65w3070030;
	Wed, 7 May 2025 20:06:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 547B65ev070027
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 7 May 2025 20:06:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a6d26d37-3475-4f3f-829f-0883dbf8014d@I-love.SAKURA.ne.jp>
Date: Wed, 7 May 2025 20:06:01 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] LSM deprecation / removal policies
To: Song Liu <song@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        Fan Wu <wufan@linux.microsoft.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler
 <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
 <295201ef-5299-4bf0-b0ee-6e1e2a74174b@I-love.SAKURA.ne.jp>
 <CAPhsuW4U5ULtOQ9ucucs3bs+jw+EbBzrCfhAuvOCO=1g5aWAHg@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAPhsuW4U5ULtOQ9ucucs3bs+jw+EbBzrCfhAuvOCO=1g5aWAHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp

On 2025/05/06 6:53, Song Liu wrote:
> On Sat, May 3, 2025 at 4:47 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2025/05/03 5:01, Paul Moore wrote:
>>> ## Removing LSM Hooks
>>>
>>> If a LSM hook is no longer used by any in-kernel LSMs, there is no ongoing work
>>> in progress involving the hook, and no expectation of future work that will use
>>> the hook, the LSM community may consider removal of the LSM hook.  The decision
>>> to ultimately remove the LSM hook should balance ongoing maintenance and
>>> performance concerns with the social challenges of reintroducing the hook if
>>> it is needed at a later date.
>>
>> What about BPF-based LSM users? Since BPF-based LSMs cannot be in-kernel LSMs,
>> it will be difficult for users of BPF-based LSMs to respond (that someone wants
>> some to-be-removed LSM hook) when removal of an LSM hook is proposed.
> 
> If a LSM hook is important for an out-of-tree BPF LSM solution, the owner can
> add a BPF selftest for this specific hook. This does not guarantee the hook will
> stay, but it can most likely detect unintentional removal of LSM hooks.
> 

The problem is that the owner out-of-tree BPF LSM solution cannot join the
discussion about LSM hooks being modified/removed. That is, out-of-tree BPF
LSMs will be forced to stay as unstable as out-of-tree non-BPF LSMs.



On 2025/05/06 5:58, Paul Moore wrote:
> On Sat, May 3, 2025 at 1:09 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> That's dangerously close to suggesting that the LSM hook list is an external API.
>> It would be really inconvenient if hooks could never change or go away.
> 
> Unfortunately, this is one of the challenges that out-of-tree LSMs are
> going to face.  As Casey already mentioned, LSM hooks are not part of
> the kernel's userspace API and thus not part of the "don't break
> userspace" edict.

Due to the difficulty of making non-BPF LSMs in-tree due to the "patent examination"
( https://lkml.kernel.org/r/5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp ),
I don't think it is fair to assert

  LSM hooks are not part of the kernel's userspace API and thus not part of
  the "don't break userspace" edict

without granting all (I mean, both in-tree and out-of-tree, and both BPF-based
and non BPF-based) LSM users the right to join the discussion and comment on
LSM hook changes.

