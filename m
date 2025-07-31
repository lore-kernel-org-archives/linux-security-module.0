Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A39230BE0;
	Thu, 31 Jul 2025 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753963204; cv=none; b=BSN9f45s5ltUug11gg5D+wnTOmUY4hUxmLire0dOjeH2CnMh473QOqwKuwFJYksGlWyq5/D8s1FK5OH3rSZQbxsxpSct8Vsiq83G8zEwRMI+xpe6vPn7LILfmTATgokOMNgpYayTqaNvgSWqnSCnKM+pf1x/RQx0uow6g6jHg4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753963204; c=relaxed/simple;
	bh=aibPBLNYWIL74po7BMss9c7mqz313WqahZSr+AaxYQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L434XxMHbBbPe4WziBeAi5N4dLmi3zWsB2Bv/L+v1ivKoSXD590mK9Ieurcueb/XZPbqNpEVTyWutAZQPAtGLKHUS5dopoXFyt+Iy7AzKXP1u8uGsejV0c+OeYpF8zxd4mLazp/vGRGn7afk1TlazkK/fcPa0sm086Wr7Efx6ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qiBwFNCr; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qiBwFNCr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753963196; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aZdbPjoxwu8ynLp8BFCHS5jhMrTGpZfUnUf2R/AhC0M=;
	b=qiBwFNCrSEj+/nb4RcMMYJN7uehkKctcK9rutgXWmgM0z8GDIZOROmrYRwfheiI4kCfQH66x0uMOtgf6kABR0UF/y7lQjLGa/u5SOGlUwbgnf6z4d0mL0gS9DLe0+ro8AwhYetDa+M4jytxCNAv3+18gPYGHLoOU0R5f6XNtd0M=
Received: from 30.246.163.44(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0WkY6GDQ_1753963195 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 19:59:55 +0800
Message-ID: <2aa4da27-28fc-46e0-8d1a-d9e63b03d502@linux.alibaba.com>
Date: Thu, 31 Jul 2025 19:59:54 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: simplify security_inode_copy_up_xattr()
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729090933.94942-1-tianjia.zhang@linux.alibaba.com>
 <e81ba8e7-8938-4b76-ae7b-bfee6021aeac@schaufler-ca.com>
 <CAHC9VhQAVvvXUoFu7xnh0uBhmvgYinP=AhiC4y17JJ02M9s5Nw@mail.gmail.com>
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

I carefully checked the logic of security_inode_copy_up_xattr(). I think
there is no problem with the current code. The default return value of
inode_copy_up_xattr LSM is -EOPNOTSUPP. Therefore, when -EOPNOTSUPP is
returned in the LSM callback, the next callback function will be called
in a loop. When an LSM module recognizes the attribute name that needs
to be ignored, it will return -ECANCELED to indicate
security_inode_copy_up_xattr() to jump out of the loop and ignore the
copy of this attribute in overlayfs.

Currently, the SELinux, EVM, and Smack that supply inode_copy_up_xattr
callback all return -ECANCELED after recognizing the extended attribute
name they are concerned about, to indicate overlayfs to discard the
copy_up operation of this attribute. I think this is in line with
expectations.

Tianjia,
Cheers
