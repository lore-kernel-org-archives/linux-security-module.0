Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FB514659B;
	Sat, 14 Sep 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321235; cv=none; b=ZmwricMWeel6pTnV/YviZlcFqdg6t03Q0ywJHBUsUYm1GU+uYGhyRc9qkBg2lLxLY7YoSaBGXdTNhDQGH9PMwk7N+XX1cHlGD4CuWOSMQbEhPqCe9NeQfLcyxVB55rMGQ+HQSsHYQnJEq7vf2sqtr+P8FjFP+UErH/f2FH5UFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321235; c=relaxed/simple;
	bh=mn3vPt1oww2MgjPGA+PJ5Bp/OXpKqUfotXZnSaDnPkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wz1/i/Os4V858zjfJKLk1ylv3gDO8JM81l8Bb49pOtcEqDJtqiEM1pgf5XzsJWcaDKvG/Pmb1NkLCrUPdGusXR7TeMI43kTKdx7/UIwtq8HFohlLKEM5u3VBcTq1oxc2ay3XCQoCNBbYUPZ+QdlRBmNlXwL3Pkq08eCnmlfZPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 48EDeAQw041686;
	Sat, 14 Sep 2024 22:40:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Sat, 14 Sep 2024 22:40:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 48EDe9ZA041683
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 14 Sep 2024 22:40:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <72759961-1f11-4bad-ad0e-b665b5a86aaa@I-love.SAKURA.ne.jp>
Date: Sat, 14 Sep 2024 22:40:07 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] LSM: Add the lsm_prop data structure.
To: Konstantin Andreev <andreev@swemel.ru>,
        Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20240910184125.224651-1-casey@schaufler-ca.com>
 <20240910184125.224651-2-casey@schaufler-ca.com>
 <2e1da617-c437-4ff9-93e0-e0e212aabfaa@swemel.ru>
 <d6de966e-ff67-41a4-8a37-1709119be9fd@schaufler-ca.com>
 <8515a57b-4369-4bd9-a43f-b5543295a472@swemel.ru>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <8515a57b-4369-4bd9-a43f-b5543295a472@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/09/14 19:30, Konstantin Andreev wrote:
> Casey Schaufler, 14 Sep 2024:
>> On 9/13/2024 1:49 PM, Konstantin Andreev wrote:
>>> Casey Schaufler, 10 Sep 2024:
>>>> ...
>>>> The lsm_prop structure definition is intended to keep the LSM
>>>> specific information private to the individual security modules.
>>>> ...
>>>> index 1390f1efb4f0..1027c802cc8c 100644
>>>> --- a/include/linux/security.h
>>>> +++ b/include/linux/security.h
>>>> @@ -140,6 +144,22 @@ enum lockdown_reason {
>>>> +
>>>> +/*
>>>> + * Data exported by the security modules
>>>> + */
>>>> +struct lsm_prop {
>>>> +    struct lsm_prop_selinux selinux;
>>>> +    struct lsm_prop_smack smack;
>>>> +    struct lsm_prop_apparmor apparmor;
>>>> +    struct lsm_prop_bpf bpf;
>>>> +    struct lsm_prop_scaffold scaffold;
>>>> +};
>>>
>>> This design prevents compiling and loading out-of-tree 3rd party LSM,
>>> am I right?
>>
>> No more so than the existing implementation. An upstream acceptable
>> scheme for loading out-of-tree LSMs has much bigger issues to address
>> than adding an element to struct lsm_prop.

What I imagine with "loadable LSMs" is "trivial LSMs which do not depend
on blobs managed by infrastructure but do depend on hooks being called
by infrastructure". Some of such LSMs could be implemented using BPF, but
BPF is too limited to re-implement TOMOYO (or TOMOYO-like LSMs).

TOMOYO is one of trivial LSMs which can easily opt out from "infrastructure
managed blobs". Also, I don't have a plan to allow "loadable LSMs" to use
"infrastructure managed blobs" including "struct lsm_prop".

>>
>>> Out-of-tree LSM's were discussed recently at
>>>
>>> https://lore.kernel.org/linux-security-module/efb8f264-f80e-43b2-8ea3-fcc9789520ec@I-love.SAKURA.ne.jp/T/
>>> https://lore.kernel.org/linux-security-module/960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp/T/
>>>
>>> but it looks like a final decision to ban them is not taken yet.
>>
>> There has never been (to my knowledge) an effort to "ban" out-of-tree
>> LSMs. There has also not been interest in actively supporting them since
>> the "L" in LSM changed from "Loadable" to "Linux", with the exception of
>> Tetsuo Handa, who has been invited to suggest a viable mechanism. There
>> is currently support for BPF based security implementations, which can
>> be maintained out-of-tree. We are currently battling with the notion that
>> the LSM infrastructure is an attack surface. We really don't want to do
>> anything to increase that exposure.
> 
> Thank you for explaining this. Although the “ban” is a side effect of the
> other activity, I think the “ban” should be explicitly recognized as ban,
> rather than evasive “we don’t care”.

The "we don't care" response is really irritating. But if loadable LSMs were
banned, LSM will be dead and an alternative to LSM will be crazily pushed.
No one can enforce "military level security" to averaged Linux users.
That attempt is a reoccurrence of "Only my version is correct" crap.

Only those who needs "military level security" in LSM will use LSM.
Those who don't need "military level security" will use a different framework.

> 
> The reason I think so is that this decision significantly (at times)
> increases the cost of user (here: system owner) <-> 3rd party LSM developer
> interaction, and decreases openness of Linux in this particular aspect.

If loadable LSMs were banned, the value of distribution kernel will be
significantly lost. The point of loadable kernel module is to share the
workload.

