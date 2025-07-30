Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C32192FC;
	Wed, 30 Jul 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867606; cv=none; b=XFV9s8EsAEoznm87ketkVXZUM5JRN4nrsztaCFW06V4NAQu+5DSZsTS0FvlRgsEtz6oyqX2WujIBCwR1yQ/HuKIbgtOPEDirKoe55MkedKIi9BGc2oXMvCqFRv8E74JZlSgmy4c5jOpXKyBwqbPeJvKyGdkg3vT01vhpWgq4r/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867606; c=relaxed/simple;
	bh=ZLwtql3PAv5rT5fZZseO69SnXuOKkCikTwuzUTrOy8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P94w6pHjGar13KEUa55w6oUqCzC0+H0hzLqNY5cQMiHrv+fWGWSCjzYXIFqxoh2l4yVuLBm3C8AQUwysbaJZcJthTkCcDRRLZfQjdXcisOrJRvOL2w7Cr0YPBztWX6YYto5E/gvO4AVHC12vT8y/oMOYJrrYwk1M2EGP3AkgQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=enw/ndHO; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="enw/ndHO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753867593; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ftYGM2w9MWCsVNvyG5RJGXhmw0ACmw9Xueyrdwm3brw=;
	b=enw/ndHOeliff3jRd8awu9wDpqa+OCDrsYqa+aK6vifA3+6W20W3Fs+PVx7o2XBOiAJE1Oiql2KBzL5SDT3JTMHoAUyMWpOleJOlVGXZsSUzvbrW5VTyATJFFatDqCYoEiuPI+jLaWJl0BgtNYdLpdXtmgcg7/6SS8aIwFH1bvM=
Received: from 30.246.163.44(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0WkUQDEK_1753867555 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Jul 2025 17:26:33 +0800
Message-ID: <c946ad53-15c8-497d-863b-a237e6c4466c@linux.alibaba.com>
Date: Wed, 30 Jul 2025 17:25:50 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: simplify security_inode_copy_up_xattr()
To: Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729090933.94942-1-tianjia.zhang@linux.alibaba.com>
 <e81ba8e7-8938-4b76-ae7b-bfee6021aeac@schaufler-ca.com>
 <CAHC9VhQAVvvXUoFu7xnh0uBhmvgYinP=AhiC4y17JJ02M9s5Nw@mail.gmail.com>
Content-Language: en-US
From: "tianjia.zhang" <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <CAHC9VhQAVvvXUoFu7xnh0uBhmvgYinP=AhiC4y17JJ02M9s5Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/29/25 11:09 PM, Paul Moore wrote:
> On Tue, Jul 29, 2025 at 10:43 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 7/29/2025 2:09 AM, Tianjia Zhang wrote:
>>> The implementation of function security_inode_copy_up_xattr can be
>>> simplified to directly call call_int_hook().
>>>
>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>> ---
>>>   security/security.c | 8 +-------
>>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>>
>>> diff --git a/security/security.c b/security/security.c
>>> index 596d41818577..a5c2e5a8009f 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -2774,13 +2774,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
>>>    */
>>>   int security_inode_copy_up_xattr(struct dentry *src, const char *name)
>>>   {
>>> -     int rc;
>>> -
>>> -     rc = call_int_hook(inode_copy_up_xattr, src, name);
>>> -     if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
>>> -             return rc;
>>> -
>>> -     return LSM_RET_DEFAULT(inode_copy_up_xattr);
>>> +     return call_int_hook(inode_copy_up_xattr, src, name);
>>
>> Both the existing code and the proposed change are incorrect.
>> If two LSMs supply the hook, and the first does not recognize
>> the attribute, the second, which might recognize the attribute,
>> will not be called. As SELinux and EVM both supply this hook
>> there may be a real problem here.
> 
> It appears that Smack also supplies a inode_copy_up_xattr() callback
> via smack_inode_copy_up_xattr().
> 
> Someone should double check this logic, but looking at it very
> quickly, it would appear that LSM framework should run the individual
> LSM callbacks in order so long as they return -EOPNOTSUPP, if they do
> not return -EOPNOTSUPP, the return value should be returned to the
> caller without executing any further callbacks.  As a default return
> value, or if all of the LSM callbacks succeed with -EOPNOTSUPP, the
> hook should return -EOPNOTSUPP.
> 
> Tianjia Zhang, would you be able to develop and test a patch for this?
> 

Yes, I will submit a new patch to try to fix this issue. Thanks for your
suggestion.

Cheers,
Tianjia
