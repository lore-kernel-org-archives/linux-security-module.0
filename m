Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39404139CE9;
	Sat, 14 Sep 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726309789; cv=none; b=svB7m+gc+sMeH+CFrQAbULQi2NjCANfEh6AedqLjXHqYoDGzMA1XsymVWoHuzWJUtmPrpHgpZJxWmu5YO4+j0PE8Fw5eLmrsBQUOfuhbcP55WwE9hEgz6/hCLm3L/yIrTpsmZ+JcianyJ1V4aSwyOCrcs/HnC5AYYq2+x9HSA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726309789; c=relaxed/simple;
	bh=oqxt8qh5CI6tQrJsN0hHnJsXYeDBrlCbLqId3kb3IMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVJSuELHo9EX+dJWqIEtPhgH6jOWAec6edKr6DpfkCU1jd7MKl5PihyNsWOlwJRP+vs4BLAkzoUeTFX3Ao4vLzeEGaLGh4NivRcSgX8vDtQhVcPDFibEuWawpJDctaAqRevwre18eDHQ+Ut4/QpQynF8bfmGVO2B6kyrlfrXKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=a/PVE6cN; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="a/PVE6cN"
Message-ID: <8515a57b-4369-4bd9-a43f-b5543295a472@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1726309779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bnCm56rV4nld5AJ7M6A+mhuRfHAViEPcep8BayClas=;
	b=a/PVE6cN6/W3UECA3p1gpXD5WJuyhijlaKmHWgVaPVHdsbZv8Lo4+f8xympZZukMiWZa9t
	k7VyyN+zyghJDJr1xM7KPVrpuPdVLIamK6fzDRzg3UiNeOm1B4JozCOCKnC3RWFUiFJ+t1
	7qUJeBfNpTs6D+orHgqPj/VtMSa0Q5k=
Date: Sat, 14 Sep 2024 13:30:11 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 01/13] LSM: Add the lsm_prop data structure.
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20240910184125.224651-1-casey@schaufler-ca.com>
 <20240910184125.224651-2-casey@schaufler-ca.com>
 <2e1da617-c437-4ff9-93e0-e0e212aabfaa@swemel.ru>
 <d6de966e-ff67-41a4-8a37-1709119be9fd@schaufler-ca.com>
Content-Language: en-US
From: Konstantin Andreev <andreev@swemel.ru>
In-Reply-To: <d6de966e-ff67-41a4-8a37-1709119be9fd@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Sep 2024 10:29:39.0513 (UTC) FILETIME=[010BB290:01DB0691]

Casey Schaufler, 14 Sep 2024:
> On 9/13/2024 1:49 PM, Konstantin Andreev wrote:
>> Casey Schaufler, 10 Sep 2024:
>>> ...
>>> The lsm_prop structure definition is intended to keep the LSM
>>> specific information private to the individual security modules.
>>> ...
>>> index 1390f1efb4f0..1027c802cc8c 100644
>>> --- a/include/linux/security.h
>>> +++ b/include/linux/security.h
>>> @@ -140,6 +144,22 @@ enum lockdown_reason {
>>> +
>>> +/*
>>> + * Data exported by the security modules
>>> + */
>>> +struct lsm_prop {
>>> +    struct lsm_prop_selinux selinux;
>>> +    struct lsm_prop_smack smack;
>>> +    struct lsm_prop_apparmor apparmor;
>>> +    struct lsm_prop_bpf bpf;
>>> +    struct lsm_prop_scaffold scaffold;
>>> +};
>>
>> This design prevents compiling and loading out-of-tree 3rd party LSM,
>> am I right?
> 
> No more so than the existing implementation. An upstream acceptable
> scheme for loading out-of-tree LSMs has much bigger issues to address
> than adding an element to struct lsm_prop.
> 
>> Out-of-tree LSM's were discussed recently at
>>
>> https://lore.kernel.org/linux-security-module/efb8f264-f80e-43b2-8ea3-fcc9789520ec@I-love.SAKURA.ne.jp/T/
>> https://lore.kernel.org/linux-security-module/960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp/T/
>>
>> but it looks like a final decision to ban them is not taken yet.
> 
> There has never been (to my knowledge) an effort to "ban" out-of-tree
> LSMs. There has also not been interest in actively supporting them since
> the "L" in LSM changed from "Loadable" to "Linux", with the exception of
> Tetsuo Handa, who has been invited to suggest a viable mechanism. There
> is currently support for BPF based security implementations, which can
> be maintained out-of-tree. We are currently battling with the notion that
> the LSM infrastructure is an attack surface. We really don't want to do
> anything to increase that exposure.

Thank you for explaining this. Although the “ban” is a side effect of the
other activity, I think the “ban” should be explicitly recognized as ban,
rather than evasive “we don’t care”.

The reason I think so is that this decision significantly (at times)
increases the cost of user (here: system owner) <-> 3rd party LSM developer
interaction, and decreases openness of Linux in this particular aspect.
--
Konstantin Andreev
