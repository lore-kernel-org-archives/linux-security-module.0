Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39934158866;
	Fri,  6 Sep 2024 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620140; cv=none; b=GEUiE8fP+WaQNiGyHTJ5WXIDKQh4pKy3FqvM0IgTByCGo9on/htRRRSvftWNDQ+fE0KN7c8iOBXpXtgG8KgBD4lhJt9wdqFgLtudpsNDiZb57Lu2sLLm+CyfWKR3QU1T4+zXrX6kEk7Tw4HaRa/Xv9KruuV2/ff8hZvpSugtjuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620140; c=relaxed/simple;
	bh=f5CVM95HAlNZ0W1E7w+xU0t7ZVGWHVxVJ9L8LEll9Vg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pmyzLeCZ4K6zgU0vqR4UmVxI5yfKy0AZRiYpkCI18kPq+AIDLL6x+XVy8aUvee53rLNpRykQtSaDW5oM6U5ZJUFQizg3ULm5FjDDIj0qjD9ok4aEj8ugCwOZWNlzex2Nn+R0nUPuHSS8IlIKkyJb7Wida9dV8zdu6tQl7MGJXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 486AtUFp073718;
	Fri, 6 Sep 2024 19:55:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Fri, 06 Sep 2024 19:55:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 486AtUf9073715
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 6 Sep 2024 19:55:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <939e984a-8c5d-456d-a986-26e242e45488@I-love.SAKURA.ne.jp>
Date: Fri, 6 Sep 2024 19:55:30 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LSM: allow loadable kernel module based LSM modules
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, tomoyo-dev-en@lists.osdn.me,
        tomoyo-users-en@lists.osdn.me,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp>
 <CAHC9VhT_eBGJq5viU8R_HVWT=BTcxesWAi3nLcMgG8NfswKesA@mail.gmail.com>
 <d16cd3d1-4b32-487e-b116-419c19941472@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <d16cd3d1-4b32-487e-b116-419c19941472@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/06 16:43, Tetsuo Handa wrote:
> On 2024/09/04 23:23, Paul Moore wrote:
>> Patches that add complexity to the LSM framework without any benefit
>> to the upstream, in-tree LSMs, or the upstream kernel in general, are
>> not good candidates for inclusion in the upstream kernel.

This patch adds a clear value for Linux users that people get more chances to
use LSM modules which match their needs.

Quoting from [1]:

  Regarding CONFIG_MODULES=y,
  "Vendor-A enables module-A" == "Vendor-A provides support for module-A" and
  "Vendor-B enables module-B" == "Vendor-B provides support for module-B".

  Regarding CONFIG_SECURITY=y (namely in the RH world),
  "Distributor-A enables LSM-A" == "Distributor-A provides support for LSM-A".
  However, "Distributor-A does not enable LSM-B" == "Some vendor is impossible to
  provide support for LSM-B".

  "Distributor-A does not enable module-B" == "Distributor-A is not responsible for
  providing support for module-B" and "Vendor-B enables LSM-B" == "Vendor-B provides
  support for LSM-B" are what I expect.

  Current LSM interface does not allow LSM-B to exist in Distributor-A's systems.
  The "enable" == "support" model should be allowed for LSM interface as well.
  What a strange asymmetry rule!

Your "any benefit to in-tree LSMs" is completely ignoring Linux users.
LSM is for all Linux users, LSM is not only for LSM developers.



Link: https://lkml.kernel.org/r/c2a3279d-451d-23df-0911-e545d21492e6@I-love.SAKURA.ne.jp [1]

