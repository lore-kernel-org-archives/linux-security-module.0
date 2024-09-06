Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28B714D71E;
	Fri,  6 Sep 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608611; cv=none; b=tfhh+4b/xa2cDpM8b2mm2ebM35v6SV9VTJRUVioDeK/U02zEtNF+j5Wsfwkbkh6NnH8ZCm6CZ2Btchd4TFzVsFUONVrnh8z13/J3RGTbURxgopb2+f19rB2ZOqgio8GJY+kJhiCWGaCjod+XDWJijZiVBRKNB1BxYltCkJxVn00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608611; c=relaxed/simple;
	bh=WBVJTznZlKDb3xF3dJ3M+mo4ckM/wsQeUaHfzaeierQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euS+mrBp86ZWRnR1IQAVXPDthniNAmLS7K9XPqB8+8c32WwcW4y67xEhNso4Z3DmEum5J/8GBCZfN245UC15yfoW+MI/23pc2CPiuGemH8kaRlE/U2aREOC/NpVY+eDMOgEiEN03ZlExApBMjALGT9XjBgpG37yK20YQYtRclac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4867hGwF087759;
	Fri, 6 Sep 2024 16:43:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Fri, 06 Sep 2024 16:43:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4867hFgV087756
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 6 Sep 2024 16:43:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d16cd3d1-4b32-487e-b116-419c19941472@I-love.SAKURA.ne.jp>
Date: Fri, 6 Sep 2024 16:43:15 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LSM: allow loadable kernel module based LSM modules
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, tomoyo-dev-en@lists.osdn.me,
        tomoyo-users-en@lists.osdn.me,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp>
 <CAHC9VhT_eBGJq5viU8R_HVWT=BTcxesWAi3nLcMgG8NfswKesA@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhT_eBGJq5viU8R_HVWT=BTcxesWAi3nLcMgG8NfswKesA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/09/04 23:23, Paul Moore wrote:
> On Wed, Sep 4, 2024 at 3:10 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Until 2.6.23, it was officially possible to register/unregister LSM modules
>> that are implemented as loadable kernel modules.
> 
> ...
> 
>> Paul Moore has commented
>>
>>   I do not intentionally plan to make life difficult for the out-of-tree
>>   LSMs, but if that happens as a result of design decisions intended to
>>   benefit in-tree LSMs that is acceptable as far as I am concerned.
> 
> Patches that add complexity to the LSM framework without any benefit
> to the upstream, in-tree LSMs, or the upstream kernel in general, are
> not good candidates for inclusion in the upstream kernel.
> 

The idea and implementation for using LSM from loadable kernel modules is what
I demonstrated you in a lightening talk session in LinuxCon North America 2010.
It is 14 years since we learned my concern, and you had been ignoring my concern
until now.

The first solution is "do not use static calls". But you won't agree it. Also,
I'm not against use of static calls as long as LKM-based LSM is supported.

The second solution is "export static calls" (and leave how it is used by
LKM-based LSMs). But some of LSM people do not like solutions that can allow
LKMs to disable built-in LSMs.

The third solution is "continue using linked list for LKM-based LSMs" which was
suggested by KP Singh [1]. I'm OK with this solution, though it is unlucky that
LKM-based LSMs can't be benefited from "static calls".

If you ignore my concern, I have to NACK the static call changes you are
going to send in the upcoming merge window.



Link: https://lkml.kernel.org/r/CACYkzJ7ght66802wQFKzokfJKMKDOobYgeaCpu5Gx=iX0EuJVg@mail.gmail.com [1]

