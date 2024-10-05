Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31768200CB
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 03:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099907; cv=none; b=VSdmoH6snqiq9GLzovFU29HjSbJ444GqzY2IYSYhic/62+PSVKmfb9JCLxVIDH4v8i0unL/jlTZ53toAVb7MA0k90OvSIo9TAk5xtAnAWXWQ8U4HC/UerV5eJ7eNNrZDXF5InA6dWXQdKqO0Obx4Vo8wTAHUTqEnqnSj8xQ/o3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099907; c=relaxed/simple;
	bh=5Qqc8SMoCcxwjjhJwa5OXSHXOcyt1VAc3XScoTF394M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iql1E2ne73njJMllIXO6aFwfl+8hYxC8gGVYRNLmq+Gz/O09F0dQK+AA8zKUr7yegjT54cbdBs7I4iOXR4fNld7o+osl5jrsfHpWmRlJn48yZaunAjYr7L7svOvYP+vlA7+/HHb5bYjIeJ+8EMyESpqDkCHhxJcsXOE05mLClgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TRFksHUL; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TRFksHUL"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B80963F6D8;
	Sat,  5 Oct 2024 03:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728099541;
	bh=BmyPOnKET4E0SGjrGt9Fo1ZkBq59WOKlGz2/WIxzrhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=TRFksHULMpYqIiKd7yUPCRk/Fdx+NaPFfuBOcBubN7f1YzjL5rnR5kbVmNYsc6zB1
	 Iz6jVThwcLrqqLUZoUE2O1es/8qxGY9v37knJj3fE9qpuMrrnvi/DcT2kGOgCb92hf
	 Pmt/8k1/UmupAYz8s6o8mSnLtwD8qOdGY3XcJEomHlO68BDBHNK+vCm0tU3OLrewnn
	 a0oiR5J7O0+JRTJbAMSij5GbG80kTqKKjcGQfGBKRVfti2zDgpjKvxAklsd4FlIw2B
	 zBQA6SUNZMM13T69+3m+Ag8DkbTMRTTGLcGcLCSaITFKu9BlOmRlGiiCs7iRrGV9py
	 TEBrqtNwNeq/g==
Message-ID: <2596b240-63a0-4daa-b048-a33fadd4f74f@canonical.com>
Date: Fri, 4 Oct 2024 20:38:56 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: Kees Cook <kees@kernel.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Paul Moore <paul@paul-moore.com>, Fan Wu <wufan@linux.microsoft.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
 <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <202410041645.27A48DA@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 17:17, Kees Cook wrote:
> On Sat, Oct 05, 2024 at 08:41:06AM +0900, Tetsuo Handa wrote:
>> On 2024/10/05 5:54, Kees Cook wrote:
>>> - tomoyo_register_hooks() becomes an exploitation gadget that could be
>>>    used to bypass the LSM as a whole.
>>
>> tomoyo_register_hooks() is enabled only if "CONFIG_SECURITY_TOMOYO_LKM is
>> included while building the kernel" && "security=tomoyo is specified or
>> tomoyo is included in the lsm= kernel command line options".
>>
>> Therefore, those who are building kernels with CONFIG_SECURITY_TOMOYO_LKM=n are
>> not affected.
> 
> Sure, but my point is that convincing RedHat that this is acceptable is
> likely to be an uphill battle considering their effort to gain full
> ro_after_init coverage for SELinux.
> 

I concur. From a disto pov modules can be worse than builtin. The size difference
here really isn't worth the hassle of building tomoyo as a module.

>> Even if kernels are built with CONFIG_SECURITY_TOMOYO_LKM=y, callbacks
>> registered by tomoyo_register_hooks() won't be called unless "security=tomoyo
>> is specified or tomoyo is included in the lsm= kernel command line options", for
>> the proxy callbacks that use static call tables are not registered.
> 
> This part I overlooked. I forgot that Tomoyo is still not fully stackable,
> so it isn't getting included in CONFIG_LSM= for the distros that do
> build it.
> 
>> Even if kernels are built with CONFIG_SECURITY_TOMOYO_LKM=y, and "security=tomoyo
>> is specified or tomoyo is included in the lsm= kernel command line options",
>> tomoyo_register_hooks() can be called only once.
> 
> An attacker with a read/write primitive would be able to locate and
> write to "registered" (since it is not read-only), allowing them to call
> tomoyo_register_hooks() multiple times.
> 
>> And tomoyo.ko is loaded by the
>> time /sbin/init (nowadays /usr/lib/systemd/systemd) starts. That is, by the time
>> an attacker can login from console or can start attacking via network,
>> tomoyo_register_hooks() is no longer callable.
> 
> See above -- calling tomoyo_register_hooks() after boot is entirely
> feasible given a read/write attack primitive.
> 
>> Therefore, the only problem with tomoyo.ko approach is that the static call tables
>> for tomoyo_register_hooks() are currently not marked as __ro_after_init. But it will
>> be possible to make the static call tables read-only if the static call tables
> 
> The tables actually don't matter as much -- an attacker could construct
> their own table anywhere in kernel memory and pass that as an argument
> for their call to tomoyo_register_hooks().
> 
> (This is actually one of the reasons I have pushed to have sensitive
> functions like that be able to check that their passed-in argument is
> contained in a read-only area, but that didn't get much traction[1].)
> 
yep, its a real shame

>> are aligned in a page boundary and an architecture-dependent kernel API that changes
>> given page's attribute to read-only is called. (This is why __ro_after_init can work,
>> isn't it?)
> 
> The __ro_after_init section is immediately neighboring the .rodata
> section, so when .rodata is marked read-only (after __init has
> finished), the kernel marks both sections read-only. (Except for, I
> think, s390, which does two passes: .rodata is read-only before __init,
> and then __ro_after_init is marked read-only after __init.)
> 
>> As a whole, I don't think tomoyo.ko approach is unacceptably dangerous.
> 
> I agree, this implementation is safer than I initial assessed (due to the
> LSM's view of the hooks being skipped due to lsm= not including tomoyo).
> I still think how this patch ended up in Linus's tree was a big mistake,
> though.
> 
> Regardless, my opinion is unchanged: I think it will be harder to convince
> RedHat to build in _this_ version of tomoyo compared to the stock version.
> 
> (Out of curiosity, does RedHat build in AppArmor?)
> 

No they don't

