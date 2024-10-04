Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892BC1465A1
	for <linux-security-module@vger.kernel.org>; Fri,  4 Oct 2024 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039015; cv=none; b=YWcq+ltUUP7uQZxGJ942glI+MJ6/vDJWoGHex6BRGLPhG26AQ07NXZlYXah8Ppu/OHDRVANVgPFL4PEEKGXFXnZrYtkeu7Qo0GWfcBf+p8buVnhGRcSzgezDvc2fmx6zxl5WtL5OGancFpoOiq96ySGj7pevMtrmE+jURivcBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039015; c=relaxed/simple;
	bh=aFpRPIm051C03Jhmg+n1F2c288gl81+09gq2/wWHdwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAvc5N8BPVWhzkrl52Mx/z5DNQsAZvXJa3SidFnEHVlPc5jzwoGJn84pvLqMamvsEg1GWFnD1cee4EIybKfOhRihyorFuBMT7j3znpfnSGgTZw3Mh39BWUZCae87r/j05UxP6de/BaxMuaejk2L3cj1FZNEsJEWpAplIiwTZp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 494Ao5Zx082254;
	Fri, 4 Oct 2024 19:50:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 494Ao5Fl082250
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 4 Oct 2024 19:50:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bc8bd0d5-ce58-4146-8bfa-1042c6575290@I-love.SAKURA.ne.jp>
Date: Fri, 4 Oct 2024 19:50:05 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>
Cc: Fan Wu <wufan@linux.microsoft.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20241003162940.GA848724@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp

On 2024/10/04 1:29, Serge E. Hallyn wrote:
> Well, this didn't occur to me last night, but what I'd be curious to
> hear is whether Tetsuo has discussed this with RedHat.  Because unless
> this makes them say "ok we'll enable that", it still doesn't help him.
> And I don't imagine them agreeing to enable the CONFIG_TOMOYO_LKM.

Majority of Linux users I work for are using Red Hat. But I have absolutely
too little relationship with Red Hat people to involve somebody else into
this problem. Too little attention/interest to make progress.
https://bugzilla.redhat.com/show_bug.cgi?id=2303689

Chicken-and-egg problem here; since TOMOYO is not available in Red Hat
kernels, I have no room/chance to help/involve with Red Hat community.

If I implement a subset of TOMOYO that does not refuse requests (something
like SELinux without the "enforcing mode"), can such LSM module be accepted
by the upstream kernel? (The "patent examination" is a barrier for doing it.)

You might think that such LSM module is not a security. But TOMOYO is
also used as a sort of system-wide strace-like profiler. Understanding
what the users' systems are doing is useful/helpful for users.

If one of Red Hat's worries that refusing requests due to broken policy is
gone, the barrier for enabling such LSM module in Red Hat's kernels will be
lowered. If such LSM module becomes available in Red Hat kernels, I might be
able to find room/chance to help/involve with Red Hat community.

