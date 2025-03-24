Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D6628E7
	for <linux-security-module@vger.kernel.org>; Mon, 24 Mar 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742816762; cv=none; b=VNcra6GyhzB3iK2L99Tfxco76uvAzaYtAvxoGyMZ2FN0XvchRv8zidOw85JcTaGloXKV1LPHxP9AJ4OFxSabuvmgPFUHjqtlPAJ1BZAgUTu+6ZTaKgZ2khNIvTa86qI36PdmyF5ojiZi0zAgYevvPu0QiZxbNvXLmMKs9+aNxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742816762; c=relaxed/simple;
	bh=RuvTY0MXdUWGMtTK1dtLu3HRybmF3ohRXGzY2FReOjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSOVw/fk9A5JayLMcd0Pz7Ed0BeHIwJzKmUmoUNk179hqPUot2qW1otFPX6lRoU+4a2+Eqh4MBMSVRqdf59kFT8SUWftQVjQRn45nUwsQDpwVmBnONU5Kz8rpRxIAthd8DMhVJT+P+fIQz9wXHnXgpl5KVwPAzsGUBq6tdxaezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 52OAhRLr090735;
	Mon, 24 Mar 2025 19:43:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 52OAhQcN090732
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 24 Mar 2025 19:43:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <898462aa-8e5e-47ed-9a76-69e4acfbab07@I-love.SAKURA.ne.jp>
Date: Mon, 24 Mar 2025 19:43:27 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
To: Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <cover.1741047969.git.m@maowtm.org>
 <5d683299-fc53-4763-be49-9a91325a832c@I-love.SAKURA.ne.jp>
 <5cff3b2b-998d-4dbe-897d-7622d07f6791@maowtm.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <5cff3b2b-998d-4dbe-897d-7622d07f6791@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp
X-Virus-Status: clean

Hello.

On 2025/03/24 10:58, Tingmao Wang wrote:
> Hi Tetsuo,
> 
> Thanks for commenting on this RFC and thanks for mentioning TOMOYO - I wasn't
> aware that another LSM has a similar permission prompting mechanism already
> (and in fact, I only recently found out AppArmor / Ubuntu has also built
> something like this [1], although AFAIK it's not upstream'd to mainland Linux,
> and the current implementation may be somewhat coupled with Snap?), and this
> is valuable and interesting for me to know :)

I mentioned TOMOYO as an example of how to implement a supervisor feature, for
there is a pitfall when involving userspace. What is important for implementing
a supervisor feature is how to avoid deadlocks, for userspace might unexpectedly
pause due to page fault events. If the supervisor process is blocked due to a
page fault event, the process which is requesting some access is also blocked.

> 
> I've tried out TOMOYO and it seems quite applicable to the "firejail-like
> dynamic sandbox" use case (i.e. use cases #1 in the cover letter) I initially
> wanted to enable, and so I would like to investigate this further.  If you
> don't mind, I would like to ask, have you built / are you aware of any
> end-user-facing GUI for tomoyo-queryd?  There is one on GitHub by someone
> else [2], but I'm wondering if you have tried to, or thought about building
> a UI that's a bit richer (e.g. like the one in [1]).

Thank you. TOMOYO's tools is implemented as CUI-only for minimizing dependency.
I wasn't aware of [2].

> 
> I've looked into the TOMOYO query protocol and I was thinking that, if I do
> end up building something for this purpose, it could perhaps support TOMOYO
> as a "backend" (and in fact that would be usable with the current feature in
> TOMOYO already, whereas a landlock-based one would depend on this patch).
> But if you have already tried something like this I would of course want to
> know beforehand :)

Since TOMOYO does not use audit subsystem, the format of query is essentially
the format of access logs. Just invoking immediately before rejecting an access
request. Quite simple approach. ;-)

> 
> btw, maybe this is just me not looking hard enough, but is there a git (or
> similar) repository for the user space programs (tomoyo-tools)? I tried to
> search online but so far I only found source tarballs, including the pages
> on sourceforge, and I'm wondering if there is a place with latest development
> branches.

There is no git tree. Only subversion repository
( https://sourceforge.net/p/tomoyo/svn/HEAD/tree/ ) is available.

> 
> I want to perhaps submit some patches to the user-space tools (I assume they
> should go to tomoyo-dev-en?) if that's welcome.

Welcomed.

> 
> -- 
> 
> With that said, I should clarify that I think this supervisor feature is still
> valuable for landlock even knowing the existing TOMOYO query feature.

For landlock, I guess you assume that the supervisor process is not blocked
(because landlock is intended for subset of userspace processes), but what if
the supervisor process tries something that will be blocked by landlock
(e.g. spawning a userspace program in landlock-controlled environment) ?
Is there a guarantee that the supervisor process can never request something
that will be blocked by landlock itself (or other security modules that are
active) ?

Use of GUI tends to introduce multi-threaded or multi-processed program or
invoke unexpected system call that will block the supervisor process itself.
I consider that TOMOYO can't provide proof of deadlock-free in GUI. Therefore,
tomoyo-queryd runs as a single-threaded-single-processed program.

> The intention is not to duplicate what TOMOYO already does, but to offer
> flexibility for landlock users and feature parity (with TOMOYO and things like
> seccomp-unotify), and allows program sandboxing themselves (or other children)
> with landlock more flexibility.  The second use case mentioned in the cover
> letter would benefit from this (and a user-level / system-wide sandbox program
> can also choose to leverage this, potentially running unprivileged etc).  I
> will try and prototype a more interesting example to validate the practicality
> (most importantly UX) and use in the cover letter for the next series.  (Will
> also rename the series title to just "Landlock supervise" to avoid sounding
> like interactive permission requests are a new thing)

I hope that my experience helps your implementation.

> 
> Kind regards,
> Tingmao
> 
> [1]: https://discourse.ubuntu.com/t/ubuntu-desktop-s-24-10-dev-cycle-part-5-introducing-permissions-prompting/47963
> [2]: https://github.com/Intika-Linux-Firewall/Tomoyo-Application-Firewall

