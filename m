Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428CA158214
	for <linux-security-module@vger.kernel.org>; Fri,  4 Oct 2024 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052474; cv=none; b=QLkGfNHeu+WwouBbJm3BTF8s+lZXOyJzHakkxfwCAZwS6UpsSXSx5d+yQV2Cz+wF/HXPjk4gyS+9DzJQWOVkLwA/TFJbr2ZwCN51JpbxgApkmd/hUo3FV5KoaKOO3mtGS88BgvI99F3zAB8O9eti8wYvGLrwV61unoAsD8iicOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052474; c=relaxed/simple;
	bh=T8mzWlYRuYP+w4F7uAawXjIXRos0QfOqVheiUuWmxZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceFM+9h2zKb1PYhWAKwR9Fzgflw4VA4Nga2tQ8MK16YELnhLOUu1ZNMSly8QGtCv+YZBy0912LTg/xFGXBFWAuHO/r2yNwqyqOaj3Yp4OWlzju+as525zuAYm9LZ4uKcoCbu0ZpC1+BfJpBC269Tf9mfqg9D1mQ05RCEbq2ozno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 494EYTdD067393;
	Fri, 4 Oct 2024 23:34:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 494EYTw1067386
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 4 Oct 2024 23:34:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0bbd6f2f-6248-4fd4-bd95-7d974d3b7bba@I-love.SAKURA.ne.jp>
Date: Fri, 4 Oct 2024 23:34:29 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
        Fan Wu <wufan@linux.microsoft.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Micah Morton <mortonm@chromium.org>,
        Casey Schaufler
 <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-security-module@vger.kernel.org
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <20241003024307.GA833999@mail.hallyn.com>
 <CAHC9VhSa-Jpqmej=3WsLFvSKWamZjFDwUpLHrJOyxaPPujM6ww@mail.gmail.com>
 <20241003162940.GA848724@mail.hallyn.com>
 <bc8bd0d5-ce58-4146-8bfa-1042c6575290@I-love.SAKURA.ne.jp>
 <20241004.ohpie8Ing5bu@digikod.net>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20241004.ohpie8Ing5bu@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp

On 2024/10/04 22:11, Mickaël Salaün wrote:
> On Fri, Oct 04, 2024 at 07:50:05PM +0900, Tetsuo Handa wrote:
>> On 2024/10/04 1:29, Serge E. Hallyn wrote:
>>> Well, this didn't occur to me last night, but what I'd be curious to
>>> hear is whether Tetsuo has discussed this with RedHat.  Because unless
>>> this makes them say "ok we'll enable that", it still doesn't help him.
>>> And I don't imagine them agreeing to enable the CONFIG_TOMOYO_LKM.
>>
>> Majority of Linux users I work for are using Red Hat. But I have absolutely
> 
> My understanding is that Red Hat's customers must ask for a feature for
> it to be available (in a future version), so you should ask your users
> to support the request.

I myself is not a RHEL user. I use RockyLinux and Ubuntu for improving quality
of the upstream kernels via fixing bugs syzbot finds. (Unfortunately, currently
the "static call" change is preventing me from spending my resource for this
activity, for "static call" broke AKARI.)

My customers are RHEL users, and I'm working for their RHEL systems, with my
feeling that how their projects becomes easy if I can profile their systems
using TOMOYO. But my customers do not know about TOMOYO. I have no channel to
introduce TOMOYO to relevant persons who are in a position of giving
permissions for contacting Red Hat support using their RHEL subscriptions.

>> You might think that such LSM module is not a security. But TOMOYO is
>> also used as a sort of system-wide strace-like profiler. Understanding
>> what the users' systems are doing is useful/helpful for users.
> 
> I think an LSM is not the right tool for tracing because it only sees a
> subset of the access requests: other security mechanisms may deny
> requests before they reach an LSM.  Linux provides great tracing
> mechanisms though.

LSM is the best-fitting tool for my purpose.
You can see an example at https://youtu.be/5cgqbQI9bEM .



>> If one of Red Hat's worries that refusing requests due to broken policy is
>> gone, the barrier for enabling such LSM module in Red Hat's kernels will be
>> lowered. If such LSM module becomes available in Red Hat kernels, I might be
>> able to find room/chance to help/involve with Red Hat community.
> 
> The question is about potential maintenance cost vs. ROI, not only
> security policy issues.  I guess Red Hat would not care about bugs in
> non-default service configurations, eBPF programs, nor LSM policies, but
> they will if additional code potentially impacts other parts of the
> system and may increase the number of potential bugs, and then the
> maintenance cost.  Open source is not free for everyone.

Without ability to do conversations, potential maintenance cost vs. ROI
cannot be evaluated. And I can't gain chances/ability to do conversations
with relevant people...
