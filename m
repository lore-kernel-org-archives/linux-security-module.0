Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9275C33FD;
	Mon, 16 Sep 2024 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726447156; cv=none; b=BVpbgpdu5v/w+EDuAYWtaVo6REgpi77msidA1zeNkPWMMxQ4yewO6R2Ar7q8+E1WccvrLVg+YCvAYk2ErAckr7CB/Z6xpC1/TRC5oTd5hQgG41V/03DR4zgwaNDfq+biwTxGwTzEhNis9wnWLmeqTdBXkjXJPRzGXmUehL1uBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726447156; c=relaxed/simple;
	bh=kEeOLLovFT4pOdm53DvzxP4C8corA25kyqKlihlz4AE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V4egx3I4tNMu+6nsvd/uzta82K7EAxUdCd7UlJfpFNHYr/zVi9TSawYa749gj+98gV38cK+HE6wqzbODR7h2haM5Tnn1VOWm2OUrvbFllJbNRr/ONWeHb5beXTYncGa7Km35ba9Zv1MwXkCEWaLc8mzp7NwDZdNmoXMeiklYd54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 48G0chip073317;
	Mon, 16 Sep 2024 09:38:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Mon, 16 Sep 2024 09:38:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 48G0ch68073314
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 16 Sep 2024 09:38:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <69e4014e-0a34-4fde-8080-4850a52b0a94@I-love.SAKURA.ne.jp>
Date: Mon, 16 Sep 2024 09:38:42 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] lsm/lsm-pr-20240911
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Paul Moore <paul@paul-moore.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com>
 <960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/14 0:28, Paul Moore wrote:
> I find it somewhat amusing that you are complaining about the LSM
> framework not accepting new LSMs in the same pull request where we are
> adding a new LSM (IPE).  As a reminder, we have documented guidelines
> regarding the addition of new LSMs:
>
> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
(...snipped...)
> While I have no intention to negatively impact out-of-tree LSMs,

What I call "patent examination" is "New LSM Guidelines" section within
that link. That section includes "here are a list of requirements for
new LSM submissions:" and "The new LSM must be sufficiently unique", and
out-of-tree LSMs which cannot satisfy it won't be able to become in-tree.
If we apply this requirement to userspace program, this requirement means
you are declaring that "postfix" (or anything except "sendmail") cannot
become in-tree because "sendmail" is already in-tree. This is a clear
intention of negatively impact out-of-tree LSMs. People have the right to
use whatever subsets/alternatives. Even if a new LSM has were completely a
subset of existing in-tree LSMs, people have the right to use such LSM.

While I consider that some of out-of-tree LSMs being unable to become in-tree
is inevitable, the requirement that any LSM has to be built-in is a barrier
for LSMs which cannot be built-in. The "static call" changes in this pull
request is saying something like "any kernel code has to be built into vmlinux,
for CONFIG_MODULES=y is harmful", similar to "any software which is not included
in this distribution must not be run, for software which is not included in
this distribution is harmful".

People have the right to install whatever userspace software / kernel modules
they need. Making it difficult to use userspace software / kernel modules
which the in-tree and built-in kernel code cannot provide is an abuse of
dominant position, as well as removing CONFIG_MODULES=y support from the kernel.

> My focus is on the upstream Linux kernel and ensuring that the upstream,
> in-tree LSMs have the best framework possible to ensure their proper
> operation and ease of development/maintenance.  While I have no
> intention to negatively impact out-of-tree LSMs, I will not harm the
> upstream code base solely to support out-of-tree LSMs.  Further, if
> improvements to the upstream LSM framework are determined to harm
> out-of-tree LSMs, that shall be no reason to reject the upstream
> improvements.

I have been asking you for a solution for "in-tree but not built-in" LSM
(namely TOMOYO). You are refusing to provide a solution for the sake of
"in-tree and built-in" LSMs. The "static call" changes fails to ensure that
the upstream, in-tree TOMOYO to have the best framework. The "static call"
changes makes the upstream, in-tree TOMOYO to have a worse framework than
now.

I'm not against "static call" changes itself as long as "in-tree but not
built-in" LSMs can remain as easily usable as now.
https://lkml.kernel.org/r/caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp
is a recovery for avoid having worse framework than now.

> We've discussed this many times before, obtaining stable magic numbers
> (e.g. syscall numbers, LSM IDs, etc.) isn't possible until the
> associated code appears in a tagged released from Linus' tree. 

Think about a hardware device. A stable device ID (e.g. PCI device ID) is
assigned as soon as a new hardware device is developed; whether a device
driver for Windows, Linux, MacOS are provided by upstream OS manufactures
is irrelevant.

Stable LSM ID has to be a property of any LSM. Not allowing out-of-tree LSMs
to have stable LSM ID makes it difficult to use userspace software which
depends on LSM ID. Again, this is an abuse of dominant position.

> I believe this policy is not only consistent with that
> of previous LSM maintainers, but of the general Linux kernel as well.

The Linux kernel is a servant for users and userspace programs.
Your policy is based on "benefits for in-tree and built-in Linux kernel
code". Your policy lacks "benefits for users and userspace programs".

