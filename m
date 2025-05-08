Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E921425392E
	for <linux-security-module@vger.kernel.org>; Thu,  8 May 2025 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713638; cv=none; b=SKe40pCqJ2v6IH4RBAsw/22ZdNaiuQd3Xw5jyTHy8HWtwaGwlb3lfxC+MvJlpH2euTZkwYhXhGl+/BfK7zaYpiOiJVHdBYb4mlpsEefqte03jspCYsYo1temkHvLjysrtpNMHoEffWj1BujpyorBQBjmGXOkHkUK6xJPjcpctsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713638; c=relaxed/simple;
	bh=RPMKGS3ybf6B1JGyCxiEBSmzSILz6+XutQcg2aSpkFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jV8Z94hBMHNwsDymCcOwREmNwDbwjT19HMGDEq31mgGFzm3LLO90nAU2/tcorJ7x9EYzmS69F9Zvl4aXhAG64MZPf6gXzgY51MnigHdYJpKVeooszUh3AOCWqX2t8mvBMfKAq3+KBCc0dN2jv6uWfetfvXHqwcdjnaf4LE6zbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 548EDqBR066280;
	Thu, 8 May 2025 23:13:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 548EDpcU066275
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 8 May 2025 23:13:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4e25a66a-dd02-4c57-a6a5-4ccaffb48518@I-love.SAKURA.ne.jp>
Date: Thu, 8 May 2025 23:13:49 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] LSM deprecation / removal policies
To: Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org,
        Fan Wu <wufan@linux.microsoft.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
 <295201ef-5299-4bf0-b0ee-6e1e2a74174b@I-love.SAKURA.ne.jp>
 <CAPhsuW4U5ULtOQ9ucucs3bs+jw+EbBzrCfhAuvOCO=1g5aWAHg@mail.gmail.com>
 <a6d26d37-3475-4f3f-829f-0883dbf8014d@I-love.SAKURA.ne.jp>
 <39ad6f58-db30-4c3c-a3d1-f0af516025e3@schaufler-ca.com>
 <CAHC9VhRk1H6OVTF-peV-Rr9PK6aDmyUeM1G7bgE8e-pAvA=FSg@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhRk1H6OVTF-peV-Rr9PK6aDmyUeM1G7bgE8e-pAvA=FSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/05/08 5:14, Paul Moore wrote:
> On Wed, May 7, 2025 at 12:24 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 5/7/2025 4:06 AM, Tetsuo Handa wrote:
>>> The problem is that the owner out-of-tree BPF LSM solution cannot join the
>>> discussion about LSM hooks being modified/removed. That is, out-of-tree BPF
>>> LSMs will be forced to stay as unstable as out-of-tree non-BPF LSMs.
>>
>> The same issue applies to out-of-tree filesystems and device drivers.
>> There's no problem that is new or unique to the LSM interface here.
> 
> Exactly.  Out-of-tree kernel code is out-of-tree code.  Tetsuo, we've
> already had this discussion many times, and my opinion on this has not
> changed since we last discussed this topic.
> 

Out-of-tree filesystems and out-of-tree device drivers can be built as
loadable kernel modules whereas out-of-tree LSM modules cannot be legally
built as loadable kernel modules. And replacing the whole kernel in order to
enable out-of-tree LSM modules (or in-tree but not-builtin LSM modules) is
a big barrier.

Also, how many LSM modules have been accepted as in-tree after you started using
LSM ID as an identifier? I don't know how many device drivers have been accepted
as in-tree, but generally getting LSM modules in-tree is much difficult than
getting device drivers in-tree. Yet another big barrier!

This problem is new and unique to LSM.

