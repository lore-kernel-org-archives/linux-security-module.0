Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7831CF5EE;
	Sat, 14 Sep 2024 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311610; cv=none; b=phUM5bYpE+/crpsQCHAGFkP8RFvOCc6nnOWhJ8/S09wVigfdo3g33E3hC3bN0XbVOXnhENXAwSHbX5Lmy4VtiIUR+8poQqg5olOxJZFn8odUUqH00jR7N+zHH3pa5iDKJrXClib8BHOYhEWyyrqs4lQcWi6tSoMlUyx7/hR58zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311610; c=relaxed/simple;
	bh=0Np0j/XCjQq8ArTXaBFN3IAI+8xElCsx7Dfm+z8XxUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+UAQlz5TijQWUASByY51uqmc2Z2MO3GYynbHl+VQ0BDsx3fWX2K/GWh4izuUAo5Eq1vjW97TphTSX75taHCbR7o9kWbBW7p4/lryucApbb4attawTaNRQBAAk5V0a7bEpZYfKeJQWV4V/uPmdU1GQCtKmtEfdHYbsBk/Ypaqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=PlOJKhLZ; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="PlOJKhLZ"
Message-ID: <78b7f307-6b24-4e61-8e03-08047b4d4744@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1726311604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNv4qUKOzlKxirBNyaWXKH8sd5c4iia9fhvLfP4jKsQ=;
	b=PlOJKhLZwBfsJ80OX4whNf1cqp/FOwSiYE8Au4bzZrqwv6CxID3nd4wPYUOsvY3NmWHpO7
	f4QASQInaO8tRjxBbaYErBgrS6W0sKuGcvPbZbAxLTK8eb37Sy5WJxPdWhlTtdzYW32Cns
	hma8tyuFo15YSfwwEBqArBuZxqzRLEY=
Date: Sat, 14 Sep 2024 14:00:35 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 01/13] LSM: Add the lsm_prop data structure.
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20240910184125.224651-1-casey@schaufler-ca.com>
 <20240910184125.224651-2-casey@schaufler-ca.com>
 <2e1da617-c437-4ff9-93e0-e0e212aabfaa@swemel.ru>
 <CAHC9VhQfLRfKTjksZ=KxuNPHXXUAV_0Q0ejKEDmFXc82wOZu2g@mail.gmail.com>
From: Konstantin Andreev <andreev@swemel.ru>
In-Reply-To: <CAHC9VhQfLRfKTjksZ=KxuNPHXXUAV_0Q0ejKEDmFXc82wOZu2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Sep 2024 11:00:03.0884 (UTC) FILETIME=[40749EC0:01DB0695]

Paul Moore, 14 Sep 2024:
> On Fri, Sep 13, 2024 at 4:49 PM Konstantin Andreev <andreev@swemel.ru> wrote:
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
>>> +     struct lsm_prop_selinux selinux;
>>> +     struct lsm_prop_smack smack;
>>> +     struct lsm_prop_apparmor apparmor;
>>> +     struct lsm_prop_bpf bpf;
>>> +     struct lsm_prop_scaffold scaffold;
>>> +};
>>
>> This design prevents compiling and loading out-of-tree 3rd party LSM, am I right?
>>
>> Out-of-tree LSM's were discussed recently at
>>
>> https://lore.kernel.org/linux-security-module/efb8f264-f80e-43b2-8ea3-fcc9789520ec@I-love.SAKURA.ne.jp/T/
>> https://lore.kernel.org/linux-security-module/960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp/T/
>>
>> but it looks like a final decision to ban them is not taken yet.
> 
> For those who haven't read my latest comment in the v6.12 merge window
> pull request, I'll copy-n-paste it here:

I have certainly seen your comment,

> "My focus is on the upstream Linux kernel and ensuring that the
> upstream, in-tree LSMs have the best framework possible to ensure
> their proper operation and ease of development/maintenance.  While I
> have no intention to negatively impact out-of-tree LSMs, I will not
> harm the upstream code base solely to support out-of-tree LSMs.
> Further, if improvements to the upstream LSM framework are determined
> to harm out-of-tree LSMs, that shall be no reason to reject the
> upstream improvements.  I believe this policy is not only consistent
> with that of previous LSM maintainers, but of the general Linux kernel
> as well."

but the matter of fact is … your dispute with Tetsuo Handa still continues.
You are sending controversal signals to the public.
--
Konstantin Andreev
