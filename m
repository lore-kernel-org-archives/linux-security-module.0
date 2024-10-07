Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF73FBA5
	for <linux-security-module@vger.kernel.org>; Mon,  7 Oct 2024 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298842; cv=none; b=qzazvqihBcEvexHOeXo4cnSebTYw/jXMGBnCEKUXs7NNFcO2YmWvrS7rnprYiAgdL7OskrhxIyc5Ty/ZBycamtVYMdZoSiKi0K8dNjEqAv9NJXzzbBXBjtFE4/uJFKTt9csxbuCJkEV2gJLt3Yv7Mntz8FdkTtzvrqatPgdKAw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298842; c=relaxed/simple;
	bh=Jwk/cwBsHIyELooC1cFNZghHD22ncXEH8OKEGBgAZJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Un0oOv8G9QtO5tMbO3p9t8l4/7TGcoPQFbLIcxa9KcKfpfVCfkNve1mr8Eir+APovWFeIH8iHCmwqatH4cs9Uzk088U/MHvVdeKoV+aE604zmfijgqD7QScWUbcaAbajUfpVRDkRcA88Ant/D7K8qkGlhpTh9gxyO0R/7KkLlXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 497B0WS3014397;
	Mon, 7 Oct 2024 20:00:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 497B0WS4014393
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 7 Oct 2024 20:00:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9230bf37-487e-443a-82de-d399f30704f3@I-love.SAKURA.ne.jp>
Date: Mon, 7 Oct 2024 20:00:31 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: Simon Thoby <git@nightmared.fr>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>, Kees Cook <kees@kernel.org>,
        Fan Wu <wufan@linux.microsoft.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler
 <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        KP Singh <kpsingh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-security-module@vger.kernel.org
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
 <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook>
 <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
 <CAHC9VhQLONjomYjs6pK2tibVfOaPY+TbDA2CYQ1YEGX7ENVkYw@mail.gmail.com>
 <ec8770e0-8f7c-42b7-b66b-7f830be7271a@nightmared.fr>
 <20241006000206.GA901131@mail.hallyn.com>
 <28dd6c35-c201-4367-b853-d637534d9d3f@I-love.SAKURA.ne.jp>
 <3f43ee1c-b297-4a4d-bc3a-bdcaa1613039@nightmared.fr>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <3f43ee1c-b297-4a4d-bc3a-bdcaa1613039@nightmared.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp

On 2024/10/06 20:14, Simon Thoby wrote:
>> It is sad that the LSM community does not like e.g. loadable LSM modules despite
>> writable variables are not a practical attack vector for my customers...
>>
> 
> The difficulty is that the LSM community need to think of what's best for all users,
> and that include users where the writable static calls may be an exploitable path.

I explained how __ro_after_init linked-list can be made writable only while registering
callbacks at https://lkml.kernel.org/r/5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp .
What is the reason this approach can't be applied to __ro_after_init static calls?

I don't think that the LSM framework will forever never allow adding callbacks after
the __init phase. This is a matter of deciding whether the LSM framework allows
"making read-only a bit later the __init phase" (or "making writable only while
registering callbacks"). And if we decide to implement it, then we can write a
proper API.



>> Going back to tomoyo.ko seen from my customers point of view.
>>
>> Advantage of building TOMOYO into vmlinux is that the procedure for
>> communicating with managers/developers/operators becomes simple.
>>
>> Advantage of building TOMOYO as tomoyo.ko is that users can update only
>> tomoyo.ko (thanks to KABI in RHEL kernels) when a bug is found in TOMOYO.
>> Minimizing possible code changes helps minimizing cost for updating packages.
>> But secure boot / module signing (not a topic to consider for current
>> environment, but possibly becomes a topic to consider for future environment)
>> needs to be taken into account.
> 
> Finally, I must admit that I know nearly nothing of both TOMOYO and BPF-LSM.
> Nevertheless, for your tracing needs (this may not work well for enforcing a
> policy, but I kind of inferred from your emails that you were mostly interested
> in tracing/debugging capabilities), may you could reproduce the necessary functionalities
> of TOMOYO via BPF-LSM?

I already considered using BPF-LSM. My conclusion is that BPF-LSM is too
restricted to mimic TOMOYO's tracing capability.

