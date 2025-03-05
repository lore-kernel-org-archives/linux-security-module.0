Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A112206F16;
	Wed,  5 Mar 2025 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217243; cv=none; b=swZRrJS3ZedZ6RZv6g1G6uLpfxASymT4Ofet5ht/BwOASrVhiXmOiJGri02SU8Hx15AMXwg7Wnt1/uuMKPhtMAS6gBnoRFFSPjY3BaO8Vf6PKorMYAs/vbhv6sl2LoQmVHHKaNFxPxMRYdLa1EvB+1WSMGYRI1ykJt1DXmHHwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217243; c=relaxed/simple;
	bh=LVimIvaPkCQKyKxhf6x1Ku48FALMBoCR9Ht7Pgy4iX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEM5v/9hbAY0Fm0XM0C4ZmtTravISd/1ePuFqj2BhzZqHoR4Cn2sfl5xCaQBNs6BSu8ppC5tWv93uhQkGR0Jo7edPMysbbNYw4ZVaF67QMOxDdfYB8r3wT5yKrZ+hE5g1uHCqgSaMiu6aY1xZopQS4nvpLOBXbvhZMaxTNFG5G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DP8APJ7+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DP8APJ7+"
Received: from [100.70.32.19] (unknown [172.172.34.12])
	by linux.microsoft.com (Postfix) with ESMTPSA id C9BEC210EAEE;
	Wed,  5 Mar 2025 15:27:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9BEC210EAEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741217240;
	bh=h5YbDWL37Mcy3fsEY9/gr4j3EE225BmLQERD+NDAK64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DP8APJ7+R1mHuydSGoyXOezzRVdUjGyxKtWA2JvDyLCUKNsG5L6TFK3qd0IJSfnqe
	 I9UF1K0W4QCytG3xk9lb+zn8sr3UobCMtI7i6Ndm4sXUzhSMVlG4cFoHa2cI/uCbZC
	 deKMz7cfAK8vIDd0W1r9WyllmuaWwf/FHtWIiTCw=
Message-ID: <5a9793e1-e31c-4dfd-ab36-48f00f66ac7e@linux.microsoft.com>
Date: Wed, 5 Mar 2025 15:27:17 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ipe: add errno field to IPE policy load auditing
To: Fan Wu <wufan@kernel.org>
Cc: audit@vger.kernel.org, corbet@lwn.net, eparis@redhat.com,
 jmorris@namei.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, paul@paul-moore.com
References: <CAKtyLkFyqFCcqUi7TPn9niUwYcHwv8nVq-joKc8kd8tFg58p-Q@mail.gmail.com>
 <1740784265-19829-1-git-send-email-jasjivsingh@linux.microsoft.com>
 <CAKtyLkGV4cGJzbvVUAeLBp=evc_QAWPD8FsskHNVvx-1UZJB-A@mail.gmail.com>
 <0a5e586a-9b55-4905-8663-6ef0112aa32d@linux.microsoft.com>
 <CAKtyLkEveJbJ9HAufC1_x8J287qqDFYZOhK2Y0MEaPo+dkJm2Q@mail.gmail.com>
Content-Language: en-US
From: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
In-Reply-To: <CAKtyLkEveJbJ9HAufC1_x8J287qqDFYZOhK2Y0MEaPo+dkJm2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/5/2025 1:23 PM, Fan Wu wrote:
> On Tue, Mar 4, 2025 at 4:04 PM Jasjiv Singh
> <jasjivsingh@linux.microsoft.com> wrote:
>>
>>
>>
>> On 3/3/2025 2:11 PM, Fan Wu wrote:
>>> On Fri, Feb 28, 2025 at 3:11 PM Jasjiv Singh
>>> <jasjivsingh@linux.microsoft.com> wrote:
>>>>
>>>> Users of IPE require a way to identify when and why an operation fails,
>>>> allowing them to both respond to violations of policy and be notified
>>>> of potentially malicious actions on their systems with respect to IPE.
>>>>
>>>> This patch introduces a new error field to the AUDIT_IPE_POLICY_LOAD event
>>>> to log policy loading failures. Currently, IPE only logs successful policy
>>>> loads, but not failures. Tracking failures is crucial to detect malicious
>>>> attempts and ensure a complete audit trail for security events.
>>>>
>>>> The new error field will capture the following error codes:
>>>>
>>>> * 0: no error
>>>> * -EPERM: Insufficient permission
>>>> * -EEXIST: Same name policy already deployed
>>>> * -EBADMSG: policy is invalid
>>>> * -ENOMEM: out of memory (OOM)
>>>> * -ERANGE: policy version number overflow
>>>> * -EINVAL: policy version parsing error
>>>>
>>>
>>> These error codes are not exhaustive. We recently introduced the
>>> secondary keyring and platform keyring to sign policy so the policy
>>> loading could return -ENOKEY or -EKEYREJECT. And also the update
>>> policy can return -ESTALE when the policy version is old.
>>> This is my fault that I forgot we should also update the documentation
>>> of the newly introduced error codes. Could you please go through the
>>> whole loading code and find all possible error codes?  Also this is a
>>> good chance to update the current stale function documents.
>>>
>>> ...
>>>
>>
>> So, I looked into error codes when the policy loads. In ipe_new_policy,
>> the verify_pkcs7_signature can return a lot of errno codes (ex: ENOKEY,
>> EKEYREJECTED, EBADMSG, etc.) while parsing the pkcs7 and other functions
>> as well. Also, In ipe_new_policyfs_node used in new_policy(), I see the same
>> issue with securityfs_create_dir and securityfs_create_file as they
>> return the errno directly from API to. So, what should we return?
> 
> I think the key here is we need to document the errors in the ipe's
> context. For example, ENOKEY means the key used to sign the ipe policy
> is not found in the keyring, EKEYREJECTED means ipe signature
> verification failed. If an error does not have specific meaning for
> ipe then probably we don't need to document it.
> 
>>
>> For other functions: I have complied the errno list:
>>
>> * -ENOENT: Policy is not found while updating
> 
> This one means policy was deleted while updating, this only happens
> the update happened just after the policy deletion.
> 
>> * -EEXIST: Same name policy already deployed
>> * -ERANGE: Policy version number overflow
>> * -EINVAL: Policy version parsing error
>> * -EPERM: Insufficient permission
>> * -ESTALE: Policy version is old
> 
> Maybe make this one clearer, how about trying to update an ipe policy
> with an older version policy.
> 
> -Fan

Thanks, I have compiled the list based on your comments.

* -ENOKEY: Key used to sign the IPE policy not found in the keyring
* -ESTALE: Attempting to update an IPE policy with an older version
* -EKEYREJECTED: IPE signature verification failed
* -ENOENT: Policy was deleted while updating
* -EEXIST: Same name policy already deployed
* -ERANGE: Policy version number overflow
* -EINVAL: Policy version parsing error
* -EPERM: Insufficient permission
* -ENOMEM: Out of memory (OOM)
* -EBADMSG: Policy is invalid

How does that that look? I will update the documentation with this list
in the next patch along with suggestions you mentioned.


Moving the memdup failure discussion here:

>>> diff --git a/security/ipe/fs.c b/security/ipe/fs.c
>>> index 5b6d19fb844a..da51264a1d0f 100644
>>> --- a/security/ipe/fs.c
>>> +++ b/security/ipe/fs.c
>>> @@ -141,12 +141,16 @@ static ssize_t new_policy(struct file *f, const char __user *data,
>>>         char *copy = NULL;
>>>         int rc = 0;
>>>
>>> -       if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
>>> -               return -EPERM;
>>> +       if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN)) {
>>> +               rc = -EPERM;
>>> +               goto out;
>>> +       }
>>>
>>>         copy = memdup_user_nul(data, len);
>>> -       if (IS_ERR(copy))
>>> -               return PTR_ERR(copy);
>>> +       if (IS_ERR(copy)) {
>>> +               rc = PTR_ERR(copy);
>>> +               goto out;
>>> +       }
>>>
>>>         p = ipe_new_policy(NULL, 0, copy, len);
>>>         if (IS_ERR(p)) {
>>> @@ -161,8 +165,10 @@ static ssize_t new_policy(struct file *f, const char __user *data,
>>>         ipe_audit_policy_load(p);
>>>
>>>  out:
>>> -       if (rc < 0)
>>> +       if (rc < 0) {
>>>                 ipe_free_policy(p);
>>> +               ipe_audit_policy_load(ERR_PTR(rc));
>>> +       }
>>>         kfree(copy);
>>>         return (rc < 0) ? rc : len;
>>>  }
>>
>> In case of memdup fail, the kfree(copy) will be called with the error
>> pointer. Also how about refactor the code like
>>
>>         ipe_audit_policy_load(p);
>>         kfree(copy);
>>
>>         return len;
>> err:
>>         ipe_audit_policy_load(ERR_PTR(rc));
>>         ipe_free_policy(p);
>>
>>         return rc;

Another issue I was thinking about that is what if memdup works but then 
ipe_new_policy fails, then we still need to call kfree but the above code 
mentioned by you will not do that.

I think we can just use "copy = NULL;" after recording the rc value from it,
instead of the suggested code. For examples, we can look at selinux.

-Jasjiv

