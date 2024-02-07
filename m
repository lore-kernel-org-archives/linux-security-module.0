Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6F3F9D6
	for <linux-security-module@vger.kernel.org>; Wed,  7 Feb 2024 02:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274491; cv=none; b=ukt6EBuPPBIWD6+lQylWKiRz/vLTNVjWNAzLTq2eKMuSnbszS6VmHv0fnn8RYwZ3zH+uNopH4PWku+zDAuLFH7KuC0luT/e9PUkPfAYG7UNk6aRQrFYR14fK+BvJOtuOTg5gEiqcoaItJOMjoygOwmuP+mMsOlDSSLt1AHu3MU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274491; c=relaxed/simple;
	bh=jN6tUDppvLkWvVyhwWtS8ORAR8zjj7K4rIuZPmYMnF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ez+I/qGIGV+Eo8L258UTR3oZbOqXx92zR2Bs/rGfyjBcnGaOvmaNphdJOgrm6y8IcA0/pMoieynZd8PSorM4s5zJU+9AYr79IUgPx1Ja4pDoY7iMPodzONOxDK+lzvRN62lnPhs7Chl3GUbUt/EMzXve+RzT/6lXXvH1tgpwjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4172shsQ014511;
	Wed, 7 Feb 2024 11:54:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Wed, 07 Feb 2024 11:54:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4172sh5O014506
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 7 Feb 2024 11:54:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f15e4a73-02e1-4758-a8e6-0edd27224c0a@I-love.SAKURA.ne.jp>
Date: Wed, 7 Feb 2024 11:54:43 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: smack: Possible NULL pointer deref in cred_free hook.
Content-Language: en-US
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>
References: <ad9dddfe-0fa1-40f6-9f8c-f2c01c7a0211@I-love.SAKURA.ne.jp>
 <fa719d6f-1960-491e-89c2-ed2c14d184fc@I-love.SAKURA.ne.jp>
 <2fa0a73a-1d03-4937-8599-e4560297af3f@schaufler-ca.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2fa0a73a-1d03-4937-8599-e4560297af3f@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/07 10:39, Casey Schaufler wrote:
> On 2/6/2024 6:31 AM, Tetsuo Handa wrote:
>> Hello, Casey.
>>
>> I confirmed using fault injection shown below that smack_cred_free() is not
>> prepared for being called without successful smack_cred_prepare().
> 
> The failure cases for smack_cred_prepare() result from memory allocation
> failures. Since init_task_smack() is called before either of the potential
> memory allocations the state of the cred will be safe for smack_cred_free().
> The fault you've described here removes the init_task_smack(), which will
> always succeed, and which is sufficient to prevent the smack_cred_free()
> failure below. Are you suggesting that there is a case where a cred will
> be freed without ever having been "prepared"?

Yes. If smack_cred_prepare() is not the first entry of the cred_prepare list
and the first entry of the cred_prepare list failed, smack_cred_prepare()
will not be called (and therefore init_task_smack() will not be called).

