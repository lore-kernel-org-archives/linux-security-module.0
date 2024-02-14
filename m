Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F01420B5
	for <linux-security-module@vger.kernel.org>; Wed, 14 Feb 2024 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952477; cv=none; b=b4rC3WyQh2V7g5aJeiFLoQ/ykvk6FRG/Qv0bX4rYPnIxbxDlxmiyaROsWJ08ZCmRsuHyd3NMEz8ZiuwI5hajuaEo9GWX/GeCYYsrF34YUB02+s/9lt3VS8IpDkav2j26/6+yfRdJ8f0TSbQEJaqgEUGavnI2fFw122ML2s1dEis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952477; c=relaxed/simple;
	bh=XA06MxMtqtsJV0p3ZNbcX1+oHfHTUYDxo/GOTURsyNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLk/8dgkVWRY99YhdpNnCLqp5tpxO1FcnpCUq4Q1zZ+I4wPmwWkM5g905qBJxwhuLAwoQ6qkO2On+mlJOJpjGQR3O4BJE45nsPXnXo/0FhV/B65OpNVHVB2LjvXunz5Pf4ofNlU2X/CAWcNlszdOPXta2dfEPc8o/g1REZYqaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 41EMFwT3007478;
	Thu, 15 Feb 2024 07:15:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Thu, 15 Feb 2024 07:15:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 41EMFwR8007475
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 15 Feb 2024 07:15:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8d093ada-995f-4291-9c31-35d9a62525b7@I-love.SAKURA.ne.jp>
Date: Thu, 15 Feb 2024 07:15:58 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: smack: Possible NULL pointer deref in cred_free hook.
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>
References: <ad9dddfe-0fa1-40f6-9f8c-f2c01c7a0211@I-love.SAKURA.ne.jp>
 <fa719d6f-1960-491e-89c2-ed2c14d184fc@I-love.SAKURA.ne.jp>
 <2fa0a73a-1d03-4937-8599-e4560297af3f@schaufler-ca.com>
 <f15e4a73-02e1-4758-a8e6-0edd27224c0a@I-love.SAKURA.ne.jp>
 <757dc423-f914-44b7-98bb-fde5cd42d33b@schaufler-ca.com>
 <b240a8ad-240a-4bc5-9414-62bd417f0b92@schaufler-ca.com>
 <CAHC9VhRdqjWa0Zhw==U=kLNiSeYHDWnQyP8Yb4JNtTA7ki1gqw@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhRdqjWa0Zhw==U=kLNiSeYHDWnQyP8Yb4JNtTA7ki1gqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/15 3:55, Paul Moore wrote:
>> Ah, but it turns out that the only LSM that can fail in _cred_prepare()
>> is Smack. Even if smack_cred_prepare() fails it will have called
>> init_task_smack(), so there isn't *currently* a problem. Should another
>> LSM have the possibility of failing in whatever_cred_prepare() this
>> could be an issue.
> 
> Let's make sure we fix this, even if it isn't a problem with the
> current code, it is very possible it could become a problem at some
> point in the future and I don't want to see us get surprised by this
> then.
> 

Anyone can built-in an out-of-tree LSM where whatever_cred_prepare() fails.
An in-tree code that fails if an out-of-tree code (possibly BPF based LSM)
is added should be considered as a problem with the current code.

