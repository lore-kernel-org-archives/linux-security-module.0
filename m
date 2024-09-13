Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08A1D9320;
	Fri, 13 Sep 2024 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230548; cv=none; b=mmr/bMoJjFBHxKKxyNEBhQn7k18EgIbF45pXEDu9f1psEA2myjFhskQLaZtmLwJeJWYUf91tZacHdVfK3YjUiiiLhMXLmZV7ysc5pUOkSelMgrSDUZA7y+gpeToPevpamz4qKR4xtOVgLMla/6oU4AK6UjX4R8L2xBdfqvm8f3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230548; c=relaxed/simple;
	bh=SuMS0HN4hN/bb7ejrfP/Qmcc5OXXLqzUH0TNsWsjoEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llDQ67VoKSdA94O7ToqpnDmORfhOxvhCcXypUHkETxw7AUa8bGt+NygbIhGwm3md9DFXHuUbA5ah9lkOQeKxI7zuA9kl0eJMAkcSbpR/7fmPECxiqgH5B9xleseFwNg9EH3ftFPTyw4HTk1Egq70m6iGsykeYk6SsHiaDyuDoVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 48DCSsRv023334;
	Fri, 13 Sep 2024 21:28:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Fri, 13 Sep 2024 21:28:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 48DCSsQM023327
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 21:28:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp>
Date: Fri, 13 Sep 2024 21:28:52 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] lsm/lsm-pr-20240911
To: Paul Moore <paul@paul-moore.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/13 10:29, Paul Moore wrote:
> Linus,
> 
> We've got a reasonably large pull request for the LSM framework this
> time (at least it's large for us), here are the highlights:
> 
> * Move the LSM framework to static calls
> 
> Based on some of our exchanges over the summer, it sounds like you
> are already familiar with the effort to convert the LSM callbacks
> from function pointers to static calls.  This pull request includes
> that work and transitions the vast majority of the LSM callbacks into
> static calls.  Those callbacks which haven't been converted were
> left as-is due to the general ugliness of the changes required to
> support the static call conversion; we can revisit those callbacks
> at a future date.
> 
> It is worth mentioning that Tetsuo Handa is opposed to the static call
> patches, some even carry his NACK, as they make it more difficult to
> dynamically load out-of-tree LSMs, or unsupported LSMs on distro kernels.
> Many of us have tried to explain that out-of-tree LSMs are not a
> concern for the upstream LSM framework, or the Linux kernel in general,
> and that decisions around what LSMs are enabled in distro kernels is
> a distro issue, not an upstream issue, but unfortunately Tetsuo
> continues to disregard these arguments.

No, this is not only a distro issue but also an upstream issue!
Because the upstream cannot afford accepting whatever proposed LSMs
( https://lkml.kernel.org/r/8ac2731c-a1db-df7b-3690-dac2b371e431@I-love.SAKURA.ne.jp ).
That is, out-of-tree LSMs cannot become in-tree and obtain stable LSM ID is
partially due to upstream (e.g. out of resources for review, or failure to
pass patent examination because upstream does not think it adds a new value).
Making out-of-tree (or in-tree but not built-in) LSMs harder to use is a
penalty imposed by "Permanent members are exercising veto".
At least, assigning stable LSM ID to whatever proposed LSM has absolutely
zero cost. Current policy is a clear intention to lock out out-of-tree LSMs.
If you say "I don't have intention to lock out out-of-tree LSMs", please
don't go with just NACK added.

