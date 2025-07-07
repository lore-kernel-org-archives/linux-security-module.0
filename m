Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260C21CFF7
	for <linux-security-module@vger.kernel.org>; Mon,  7 Jul 2025 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920691; cv=none; b=EhAIjifxDtWhevTLhkEXVk/IxUveyWRaThRJ30+rQHEXpuiSIYAblgTdFyigYi5p6o1JuLMBNFNevFDNsxx7IUzYLB+9PWGB+QBzWlZULricJxoJL+bNddtIKrga9Zfdh16ML1c/OH0yRSBskck3ttV4xWbYCLvxkIM9XvNse2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920691; c=relaxed/simple;
	bh=yRVqyPat7GN9F8zNJwC3S9yF+wNlVd/chrVQuraG1+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMwx992gC7yW0ad8S9N6ZVAmr9cwN00hLAmTx2CEgEFKqrG3lcD2+H0l4ZcPL0KCAhyMfhWOylsgm4D4joMeDrzoWYoGBEJOKQSethItqDscVPonSVLicDRlJIn9Q/Zu1Hsbv058JN4mNPMUf5Ohxen5Qo7mcux4yB/Iv2T8OYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=W3iwJDl8; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="W3iwJDl8"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d9e2f85ab4so34127885a.3
        for <linux-security-module@vger.kernel.org>; Mon, 07 Jul 2025 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1751920687; x=1752525487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BTlWpVgqOV5ugp/e3CPL0JyQGmCCQPxWeyY4pt9b7I=;
        b=W3iwJDl8wwMUn9NpmfyDfAYRi7F1mpA7raB8MGwfygO8B5lQMtB0dMaYldyPg+v8kV
         MEWoDYIWwbFa2I+U3DomiLAQfI12Od1KMKwdOdX2Jc1PFgY7IASyAur67CBPqP5jzaZ5
         CuxIbBMriQvnfGYOvtQ59vQJsC4VLKVlsN/EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751920687; x=1752525487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BTlWpVgqOV5ugp/e3CPL0JyQGmCCQPxWeyY4pt9b7I=;
        b=tJcy7VOBdZ/uXxO/GY3/c3NOM9HsYVmGD0yHWpMdsJoGxLDWFddUvDiHYfjwm0YWOM
         0DtOrws1V9SaubV/fgjXOgKnBZR3EWdE1q+LDxKdRCml6iTlyACm07e0jmqfEmUAVn0S
         N652b7u3+jwNSsXAF9rJW+SO3ku8/qAL0LvRSiTavd/lWR83U2Sh3/DjFwa7vFnIOFOD
         xxLiosQSbJLHAI1G6UtxysWJVhKf9e4QpU6yK8LbaTfd3I68zCuirHsHC/mnwP2Hk0pG
         UXU+vt9yBZqlqmS/2JWjeM9owFf6j0F3XNjv+i2VnziHeInxtV90B34fvYk1UHWccUxc
         HqjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUeHzim5bgBj4ZwYwHopveNKfakPvU41aCdZfuPPXSI+S0o6o2NnzHS8k65ZmkShtSTs8pY3zpepqorK9lP82whJHKQK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8zxxGSi7kPA2gqU41/1Q/2TgWpLDVa4Dko7dV93bVGKLG7s5+
	pjpGEcA/Rl1XwojiRbG+x6Vj/Px9UDYY7cSRIKOZOorm0Z3w6bgaAzM7706TFze1rw==
X-Gm-Gg: ASbGnctiV5/5zjeSK0jN0de7kSmte9pSUvr8YqXP0ZbLvihVNw64vrp4hX8S+ALINO6
	TbQ3edGWPIjZdIWkp0xply/9o8lZHBG8twjlyHNII1Qd8CAuOh3G14DbDQXvgVuhysI/u5X74Ev
	WybG4LsPEHqRXwnmTG2/KHr2c5T1CoHHugUXAg8VBBI3CkdmqehV2NOZNeNHhm4fXnYqeIboL72
	ehlpGbVI0Xu4psx2793mK199hB8NhpmQzPDyoE1PFGMhfMgZobo60YesLizrJME/5GdW2wRvtYl
	bzVMvU/3TzAoPG+lqsi3ao44AI4peTuqgbW1D4ntwXCHApReuwzcEtjCRuP5TFckKYxeMoq0m/C
	fttIM3jr2ZZ4EyeJ6Z/e7ziileEbR8CzH+DwDiEKAuLrgaYk=
X-Google-Smtp-Source: AGHT+IEaHKHQ7/gC3ce/2SRKioHppqzpcheDCakLklCvAnjqt9HnqlAKfKYaZRVlYc4h5UFY3+OS2w==
X-Received: by 2002:a05:620a:2916:b0:7d5:d240:ba4d with SMTP id af79cd13be357-7da01d74aaamr74728885a.22.1751920687191;
        Mon, 07 Jul 2025 13:38:07 -0700 (PDT)
Received: from ?IPV6:2601:145:c283:58e0:5dee:da73:58da:ff15? ([2601:145:c283:58e0:5dee:da73:58da:ff15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4ccd60csm64345516d6.35.2025.07.07.13.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 13:38:06 -0700 (PDT)
Message-ID: <48916a70-2a89-4d24-8e36-d15ccc112519@ieee.org>
Date: Mon, 7 Jul 2025 16:38:00 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs: generalize anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Paul Moore <paul@paul-moore.com>, Shivank Garg <shivankg@amd.com>
Cc: david@redhat.com, akpm@linux-foundation.org, brauner@kernel.org,
 rppt@kernel.org, viro@zeniv.linux.org.uk, seanjc@google.com, vbabka@suse.cz,
 willy@infradead.org, pbonzini@redhat.com, tabba@google.com,
 afranji@google.com, ackerleytng@google.com, jack@suse.cz, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
References: <20250626191425.9645-5-shivankg@amd.com>
 <a888364d0562815ca7e848b4d4f5b629@paul-moore.com>
 <67c40ef1-8d90-44c5-b071-b130a960ecc4@amd.com>
 <CAHC9VhTXheV6vxEFMUw4M=fN3mKsT0Ygv2oRFU7Sq_gEcx2iyg@mail.gmail.com>
Content-Language: en-US
From: Chris PeBenito <pebenito@ieee.org>
In-Reply-To: <CAHC9VhTXheV6vxEFMUw4M=fN3mKsT0Ygv2oRFU7Sq_gEcx2iyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/7/2025 4:01 PM, Paul Moore wrote:
> On Fri, Jul 4, 2025 at 6:41 AM Shivank Garg <shivankg@amd.com> wrote:
>> On 7/3/2025 7:43 AM, Paul Moore wrote:
>>> On Jun 26, 2025 Shivank Garg <shivankg@amd.com> wrote:
>>
>> ...
>>
>>> Thanks again for your continued work on this!  I think the patch looks
>>> pretty reasonable, but it would be good to hear a bit about how you've
>>> tested this before ACK'ing the patch.  For example, have you tested this
>>> against any of the LSMs which provide anonymous inode support?
>>>
>>> At the very least, the selinux-testsuite has a basic secretmem test, it
>>> would be good to know if the test passes with this patch or if any
>>> additional work is needed to ensure compatibility.
>>>
>>> https://github.com/SELinuxProject/selinux-testsuite
>>
>> Hi Paul,
>>
>> Thank you for pointing me to the selinux-testsuite. I wasn't sure how to properly
>> test this patch, so your guidance was very helpful.
>>
>> With the current test policy (test_secretmem.te), I initially encountered the following failures:
>>
>> ~/selinux-testsuite/tests/secretmem# ./test
>> memfd_secret() failed:  Permission denied
>> 1..6
>> memfd_secret() failed:  Permission denied
>> ok 1
>> ftruncate failed:  Permission denied
>> unable to mmap secret memory:  Permission denied
>> not ok 2
> 
> ...
> 
>> To resolve this, I updated test_secretmem.te to add additional required
>> permissions {create, read, write, map}
>> With this change, all tests now pass successfully:
>>
>> diff --git a/policy/test_secretmem.te b/policy/test_secretmem.te
>> index 357f41d..4cce076 100644
>> --- a/policy/test_secretmem.te
>> +++ b/policy/test_secretmem.te
>> @@ -13,12 +13,12 @@ testsuite_domain_type_minimal(test_nocreate_secretmem_t)
>>   # Domain allowed to create secret memory with the own domain type
>>   type test_create_secretmem_t;
>>   testsuite_domain_type_minimal(test_create_secretmem_t)
>> -allow test_create_secretmem_t self:anon_inode create;
>> +allow test_create_secretmem_t self:anon_inode { create read write map };
>>
>>   # Domain allowed to create secret memory with the own domain type and allowed to map WX
>>   type test_create_wx_secretmem_t;
>>   testsuite_domain_type_minimal(test_create_wx_secretmem_t)
>> -allow test_create_wx_secretmem_t self:anon_inode create;
>> +allow test_create_wx_secretmem_t self:anon_inode { create read write map };
> 
> I believe this domain also needs the anon_inode/execute permission.
> 
>>   allow test_create_wx_secretmem_t self:process execmem;
>>
>>   # Domain not allowed to create secret memory via a type transition to a private type
>> @@ -30,4 +30,4 @@ type_transition test_nocreate_transition_secretmem_t test_nocreate_transition_se
>>   type test_create_transition_secretmem_t;
>>   testsuite_domain_type_minimal(test_create_transition_secretmem_t)
>>   type_transition test_create_transition_secretmem_t test_create_transition_secretmem_t:anon_inode test_secretmem_inode_t "[secretmem]";
>> -allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_inode create;
>> +allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_inode { create read write map };
>>
>> Does this approach look correct to you? Please let me know if my understanding
>> makes sense and what should be my next step for patch.
> 
> [NOTE: added selinux@vger and selinux-refpolicy@vger to the To/CC line]
> 
> Hi Shivank,
> 
> My apologies for not responding earlier, Friday was a holiday and I
> was away over the weekend.  Getting back at it this morning I ran into
> the same failures as you described, and had to make similar changes to
> the selinux-testsuite policy (see the anon_inode/execute comment
> above, I also added the capability/ipc_lock permission as needed).
> 
> Strictly speaking this is a regression in the kernel, even if the new
> behavior is correct.  I'm CC'ing the SELinux and Reference Policy
> lists so that the policy devs can take a look and see what impacts
> there might be to the various public SELinux policies.  If this looks
> like it may be a significant issue, we'll need to work around this
> with a SELinux "policy capability" or some other compatibility
> solution.

In refpolicy, there are 34 rules for anon_inode and they all have { 
create read write map } -- none of them have the execute permission.  Of 
these, only 4 are explict and could potentially be broken.  The 
remaining get it due to being unconfined, thus can be immediately fixed, 
since it's unconfined.

IMO, this is very low impact.

-- 
Chris PeBenito
