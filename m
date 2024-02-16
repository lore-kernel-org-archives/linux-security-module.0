Received: from sonic312-31.consmr.mail.ne1.yahoo.com (sonic312-31.consmr.mail.ne1.yahoo.com [66.163.191.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E9CA21
	for <linux-security-module@vger.kernel.org>; Fri, 16 Feb 2024 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042954; cv=none; b=GOyXJRBr4u0V/EcPi0DQ7LHPoGghpTrLC9G5A/UwiTqmeUfZOfCVHSb3IQQVtJIfGt5WwbMz6QQgGembWFEewtgUqDbENNCxbU3MrmVXkk8tapjiXHNIKxckNW2bfb9OwX6d0KD5HKJsijzo+pNjvb4k+/sXcyNo7cfLZQ6tiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042954; c=relaxed/simple;
	bh=69RYpdVYDTZA8DIigKvYi3SBzDIkw9Xs7dhP6vsUEhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZhnZjebqWzql+1dHYchmENdxocRgREoYjaL+q8vtLJz4waenVFXMsXUI2MvIOU3iSzfPWitEZSEG4JjocZbTiAJUfysBrF5/t2SsvmRor9FHBE2T2QxovB/4CG9D3dZUTf83eGG9jKDuCv1nnUNbITh3EkFXdV0PBWAr222PrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=V51BJ4Bb; arc=none smtp.client-ip=66.163.191.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="V51BJ4Bb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1708042951; bh=bFeP3L3bN3aSXJISbrH6tvM7Jez+tPsE+Pw9OQXBZ1Y=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=V51BJ4BbIa967cJiOrxePrCMSnT0n4rA67+0NJ9FBfj0pB0LMQd3Afq4j24cpXLDp+je5VRY9sNFdAkdPCcOylbSZ95VlEY5WgxOPXNTmVnbNrHGOG0LD6UHxwO9kmHCQGPFNA9Tz5qpSFHwBFMy++pz1gPKzdV8CjYWWmmBVWTaqknTX9D1oeuA71M+pd2BIo66U9i1Aqmn8nU7vvi8M1A0HYzifp6fzEtgD+fQ1mY186pHJqCqRqhc3iRdD68DEEuMlHGrSnpqoAIClnFajuu8LIYcmPLGpWsqZeM3ATa5EWF2evSJVS3W1W1imbhZ81mXI/MlaGxT4CGzL0O2yw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1708042951; bh=zjQvHdqRNKaw3xV/yJehVLkxRMW5Wd7AjW1VELST9m/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ItK+xup1FDbMUkJ60XMcD1hmK9vsCiQaNy7Lv0lCzn6/G7Mu4DtTUNqtOB9JFceMaI6wsqGaipcNuIcOB0CLZBqSaXRlYglARMTJ45xb7hTTmGJuwSP4BkD5rxcujiquzscPG3pdWZCIUf8flq26Fe4DHzi0vGfuC4OUU9qmkWOWvm10nwvophV6rZG2UeGV9N7Iiv7n5NcJ04hmpKj8/M7eew5YyzlwH0RSI20csnuXFOZT/GdpNOpKnpKru64h6o9WKLh06Hnv4ZNVouUy1lTiI4z2qhC6+lGGf5IHGSOM+PXt2sJRIFRkzpN3czCT/0aR4cTq2svMv9xVz0+hcw==
X-YMail-OSG: _ZcCeuEVM1mRsnIRzrZvwFYKLRwXZq9oXipBdGXgl7fh7wfPoMoEdC5DlyrrTts
 khq0x7Yb9JPwA3pSNXEX7KKitxDRKJ.OBCjKPx8uc7QQiYsXBjK_Lpbhylf1.beTo0b4PPqqDdOT
 mHKfNI66QnIpCYu0oezqVwVKlMF5YkIDWYxw9Si0_TFAurLbbjKsnCdhbWHq5D6_5CA1NntJQ7HA
 wET1ShxxjcGZ0AY2x.qjlH.x.zXY5Of0FwiqXM1iDW9jBcG7hckl2OhOHKGHUw1WKHjWihK6RPCM
 qa9YR1GKgcuweD4fnFkufFrpD3BBupeYMouAgn3UQYPhA3x2O1LC9WnYFbGo.bDddoPfOSxYliab
 O9XpeDrAIWWoxUZvi_5vJZ4GQu1hsLAbvfb.qtQXJsK5G7HUMwRenRXvDYxUOcpK.eaXxwAcGTYE
 gM1n50lILzZ1Up8GIQH18r70ICMjPsG8ZeySktV9Y4wj9U.w8OWE3fg7_sbwQ9385bUYl_Cy6lH.
 1ZbGaY7mf1CwZXIo0xs2W64cA_tquJX51.e.UZPToUPWSod5RR.7hgW8Ey4Oq5DaO35UWga6w6dw
 XP5meG8wFiHn5KBhLZDXkHNRcxb30TjakxzQUJpFlQzPM3L06CuF7Q5bW9WEdd0sIGkKYmQJEac6
 jinai1I.x0WPWReo4L5pf1LO80jgwK5vcWF3eEVBl9JP9ACodRtf4TWMyIdYBAUTQ7KsWjvpel6e
 GaMW2wiQeUtB7XraNGej.xfqfjh97z7lxFc7nen9BUSeQvy3fwuOpMXTXFsPrUklQ.alfA763_Wz
 vJUEMm1nsCmA.hf3XsL9waXTS6xbEO12I9Hz.Q6eyy6QdJU91gh4fgi5n7WpepYGNmaXNp6LMjKK
 9KPx9P1db5JMQPX_3DjqJx1TrHtgx_ZwpWTcmrQ_9o7Zd1ZsW9OjNGDHxM2sih0xA_NZDko2A9Ir
 0O2TfoubbEp6dVOhBgHicCce_7vTc7ihmf6FYBP9.kRF1vKlgPbbT_6mQHMLEOaFzXhVT2dKIQ1m
 fUirpZjBk6vbYIHcR0ZnYvljU6QZvz_ZhwrIaMRxWfAq9ZYeOxn4jSO_pCtl.oIq2qGHlRWVTnL5
 CBlLDI_NdOuicPH52FR9Lcp1_sOyvk3aHJLHfqQCoXhuMEJZwUpk774plFE6b0GqKSinXz_eBv0G
 gFahp6NayQlI0yA_bnNuy.j7XxX9qlXQamXvFOWe8X4cASOQcOMTyLPo5FiWCmupLiOubyA4B1ga
 6mx9bl8jMT1TnFI6K0LIu9aY3pHccMRTwOOVYpglIwvPxFjtMkXnEZsdC7v5uly8g2WZ4T60PVwe
 8bTtSyVfWXYV4pB.pC2jzAzP9uqdVrrM6Ne5mPk0R17CcwvEAkmntXCx5CQL1dIRLPXAvXKbFzMw
 WVaUE8yT64hYiW36b6aziphgJ87Z1hkJBUr07AVWfMlLMbnuy6YDyXJUGYwF9XdLig1oHl7GzsfE
 CLF7m9aiXoVjIaUmthA1Maw28s1K5A_PrLglbBh5yQQCBdwcOwAA8W4bwRlxhU0IGZ6gRirN1EN_
 yGzb2p2dmqbw3daaJANcTYWmjRDOxvlu6N4.Df8Y1my840emr_SVGuRYKfw_LSBU6IZkPIl6PyqC
 I9h9lTnhuu_KA6fDtliclAikrDcXJAfbI6bj6meVhd3s25Qir9KNd6bx2O1xTmvVKHCsBl1B4dM9
 gd0B6Vzh36C4jckT2yhbBQLRjaOg3t95XS3RYenLCKKw5VByw.NXXEqw6lu0UOe9i1JYW4zj_6TV
 4dcE.6AGeBDMKeGkjnhOQ74OScUPylqgImVkGkvAm00vA0tLxgC4eltbWe_7GFeouqYgqVYBMjC1
 0h8MReIMuUqEWouP1KtI7raD9xbuSJPQ0_f7oMrMJ8UYk9ffcQh9FtpFVp_GdGZF7zgrFubgGuLJ
 Hb7ZivCCyYWUJ14RTgKllrke9zJh_gZjb08ycw0TX_FL04p0sSAWqSAR1gYulxP4lbC7GJUbVl_h
 knVObe7Ty1TwlHS8y183oOQSGybmgiH0tyI7cYYw_ehCZk59QK9g_j9t2vEfr3GBd5Vy5DIgW21d
 eh96zuNI3zh_La6qLV38nbKIo7Jt1qxh.N4CGUj_7LhpL7HiNUpbW7GGPoXFP8T9ucrX4ieW2m3G
 TR_u77x5eySkw9alUIBQhU5oDrtu__jxzBo4jKQaIXJHXCLxh0gECkoLj1Xgvd53GjhP7ohasMmX
 7lKFolGevxVkxXi_COSST
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a06b1fd6-d818-4a27-b7bb-d05278f1a6e7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Feb 2024 00:22:31 +0000
Received: by hermes--production-gq1-5c57879fdf-6xjwd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0510ecd4e771c0457035cfacb550bed0;
          Fri, 16 Feb 2024 00:22:29 +0000 (UTC)
Message-ID: <9a816f3b-452e-4d3a-8c45-da49f5461317@schaufler-ca.com>
Date: Thu, 15 Feb 2024 16:22:28 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: smack: Possible NULL pointer deref in cred_free hook.
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <ad9dddfe-0fa1-40f6-9f8c-f2c01c7a0211@I-love.SAKURA.ne.jp>
 <fa719d6f-1960-491e-89c2-ed2c14d184fc@I-love.SAKURA.ne.jp>
 <2fa0a73a-1d03-4937-8599-e4560297af3f@schaufler-ca.com>
 <f15e4a73-02e1-4758-a8e6-0edd27224c0a@I-love.SAKURA.ne.jp>
 <757dc423-f914-44b7-98bb-fde5cd42d33b@schaufler-ca.com>
 <b240a8ad-240a-4bc5-9414-62bd417f0b92@schaufler-ca.com>
 <CAHC9VhRdqjWa0Zhw==U=kLNiSeYHDWnQyP8Yb4JNtTA7ki1gqw@mail.gmail.com>
 <8d093ada-995f-4291-9c31-35d9a62525b7@I-love.SAKURA.ne.jp>
 <6e00373a-a028-4575-b2cf-d4da366c2b6f@schaufler-ca.com>
 <CAHC9VhT730AxsUv=1=dEn22ABeHJPZ1JA-xwZv6DN54+DiiKQg@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhT730AxsUv=1=dEn22ABeHJPZ1JA-xwZv6DN54+DiiKQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22077 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/15/2024 3:38 PM, Paul Moore wrote:
> On Wed, Feb 14, 2024 at 7:13 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 2/14/2024 2:15 PM, Tetsuo Handa wrote:
>>> On 2024/02/15 3:55, Paul Moore wrote:
>>>>> Ah, but it turns out that the only LSM that can fail in _cred_prepare()
>>>>> is Smack. Even if smack_cred_prepare() fails it will have called
>>>>> init_task_smack(), so there isn't *currently* a problem. Should another
>>>>> LSM have the possibility of failing in whatever_cred_prepare() this
>>>>> could be an issue.
>>>> Let's make sure we fix this, even if it isn't a problem with the
>>>> current code, it is very possible it could become a problem at some
>>>> point in the future and I don't want to see us get surprised by this
>>>> then.
>>>>
>>> Anyone can built-in an out-of-tree LSM where whatever_cred_prepare() fails.
>>> An in-tree code that fails if an out-of-tree code (possibly BPF based LSM)
>>> is added should be considered as a problem with the current code.
>> Agreed. By the way, this isn't just a Smack problem.
> I've tried to make this clear on previous issues, but let me say it
> again: I don't care what individual LSMs are affected, a bug is a bug
> and we need to fix it.

Yes, I understand that.

>> You get what looks
>> like the same failure on an SELinux system if security_prepare_creds() fails
>> using the suggested "fault injection". It appears that any failure in
>> security_prepare_creds() has the potential to be fatal.
> Perhaps I didn't look at the original problem closely enough, but I
> believe this should only be an issue with LSMs that register a
> cred_free hook that assumes a valid LSM specific credential
> initialization.  While SELinux registers a cred_prepare hook, it does
> not register a cred_free hook.  Or am I missing something?

Yes, you're missing something. If security_prepare_creds() fails prepare_creds()
will fail, and the system will lurch to a halt because it can't create a new
cred. The cred_free hook is a red herring.

> Looking quickly I suspect this affects Smack and AppArmor.

That was my original thought as well. But any failure of security_prepare_creds()
is going to cause the problem. For in-tree LSMs that can only happen with Smack.
If an out-of-tree LSM fails in a cred_prepare hook, or if a BPF program fails
in cred_prepare, we'll have the problem. *Without Smack or AppArmor*.

My current thinking, which could easily change with new information, is that
the cred_prepare hook should be changed to be a void instead of an int hook,
and an LSM that might have a failure case (Smack's memory allocation, for example)
will have to handle the problem on its own. Smack would have to radically change
how it manages supplemental rule lists and label change lists, moving them out
of the cred.

Also to be considered is that the "fault injection" used causes the system to fail
immediately. A more subtle fault injection, provided on a system that has reached
a running state, ought not to have the spectacular behavior seen here. Again, not
an excuse, just an observation.

>   While
> Landlock registers a cred_free hook, it looks like it should properly
> handle being called without a cred_prepare hook first being executed.
> Of course Mickaël is the one who should confirm this.
>
