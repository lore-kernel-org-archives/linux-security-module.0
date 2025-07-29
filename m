Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2D26658F
	for <linux-security-module@vger.kernel.org>; Tue, 29 Jul 2025 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775215; cv=none; b=TQMMHW0siNOJ1YmeSh9nvc1J7CxrqUC0Da0dqMex9U3TPP3LKJ3zs1qGirG4yL+jN908cEy9EhachzQfPw+0rc/qkkYeSX5H5aOytc7Pg7A71RFUmYr97OgM0PfN19YGSzrv1HS0ZroZmsv5qCcUdHG5KoxTBkcs1H+jge+SVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775215; c=relaxed/simple;
	bh=Oww8ViXRQ636yvHdcqFWK/5H+wDq2ImqznhVbDNXEXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTlQCQAbv5u2qHTqAban6HMiPm+oEm2SdfXkevYLTuHyFWC1CcE0f7kvgqHV0g/LlR0b6vH89QkhZdm3sl7lOXuMIevjX7kSaJl27nsU8E514KPj7elsGtVT6qGoAwNhBRdACGZkQLdQoNRr4K7FKHALwYw+mCltbu+ybS/BQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XmVnedWM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XmVnedWM"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0dad3a179so873435266b.1
        for <linux-security-module@vger.kernel.org>; Tue, 29 Jul 2025 00:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753775211; x=1754380011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+fS6oEzgF13BnkxuzsJYDS2RLzpOsZm7wAMzXRWyMbw=;
        b=XmVnedWMmT7cnan/myNcOoBPw69XFC1pt2JNBAsoRLBZG4QPraHdxBir1/5JP8xmI/
         JyXOCs7NJ6WlNWkQJ05F7As8E72CcQ8JBwWQE47iSsAGKwO4QOZVjhsgPfQZZYDoSvcE
         u18VRz4fhYjtK/Kb9xTUeWFUxpX11tDF0EZTAueQ5Ibqko61sJvQ894qPrSiKvfzO7/7
         nRGbxaRcEgX/7W+NRmp0tlDHHEKdjsStEfgE822qx3pr08u9j3sE/fcDLhiIIdF3RfUi
         TyF8jHogXIR1tYYyKdwDRZjD0l3mnCc3foxFHnUK1705OErlgBSUJuOHPlMbmVtszTAb
         tmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753775211; x=1754380011;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fS6oEzgF13BnkxuzsJYDS2RLzpOsZm7wAMzXRWyMbw=;
        b=M8ysWaw3cNSgdJWqerBBBkIw0Lo/Rt6EkVcat8YK62nw+ZYoOLavVHROw7bysbwA3s
         a9W/Mmo3fRPhMV+/7Gjq+r48cmZ73F2dl9e5kP9lcUjQgI0cwigccPd2gdS96ctq5roW
         +r/ZzgzSe3MaLhBVymEv4MbcvNket8V1F0XavLGOg/W9VuZZC4Q8bFw0vWkycJLP1w8l
         TT3DHVLKkkmWeolccgjLjA/eDHTqjRktsSiS5zktrTrNOg30uT3hquHqpjvn8Nfqe62B
         KuBst6bkz4kcNshKNSbIDpIrz+PWX4rYWX0akEjFgwFYmENmlRRIdYk/xvN2u+Y86oo2
         xDZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU24zXIUYJ12KQg8NEj5yykRDpTUW5NMdoN4Ld4jcPB+ZS9wzeOK0st4pNiHseQG0SQCJRHIDn8Ho4aVWGnOrU9wd2sMxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5iEBG9/zfou88x3ezy7Q4SRKWZqrB3j8pG2qcPYLsyBsem3k
	06AIrMYErJx33aFRYS+ffPro/VoSq6q8Jjn3YZSV/j/Atm64LPLXSY8TaMTLTGTfkZY=
X-Gm-Gg: ASbGncuh/fOTW0bNWWTWnwIOg2lZurJh7BZHeWGhm4EIAS535Ag/F6V4symWbAUAhpR
	E+85YgcY7jR5oQTRSDuN37+wbNnP7yVman5EyZ06XNoiajNhirjBzx/Uqwp1KzNRf9qUA8ufPcl
	OGglXGjz2YP6zJLqsb37vyiCyWxkTn1DQtz56NMuYLb7ozvBU1H0X38DJGFKy2FLevBEeuzGvxt
	SEeObJUPaGICUddzm9N/ylZdG6DxNy0r+mJDJNGBU+dL8h6GPl80Tq0jRqLTKTzc2lzLcHIKfji
	jYgZbu0pYLx8kMJunItXv4q6Ppy9UWiPMiSyrm+XakIPcGEBIB1BLnNEY3mP9wmtaKk2QSUyljz
	T6vd7K2Dl2Nvt5tY2leQMpMwOHQ==
X-Google-Smtp-Source: AGHT+IH6jfjNc8UNw32/lozuCfWnAMkVoj//1p/pBWOd6QeQxm4eBhWeUohg5sRFiRJWz3K/TFNAHA==
X-Received: by 2002:a17:907:2da3:b0:ae9:c47f:1bda with SMTP id a640c23a62f3a-af619c0ca6cmr1436573566b.59.1753775211380;
        Tue, 29 Jul 2025 00:46:51 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.209.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61558c0779fsm1398957a12.27.2025.07.29.00.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 00:46:51 -0700 (PDT)
Message-ID: <c2754ac3-28d0-4c6c-bd2d-0dcc9ca66b77@suse.com>
Date: Tue, 29 Jul 2025 10:46:48 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] lockdown/kunit: Introduce kunit tests
To: kernel test robot <lkp@intel.com>, linux-security-module@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com,
 jmorris@namei.org, dan.j.williams@intel.com
References: <20250728111517.134116-3-nik.borisov@suse.com>
 <202507290540.9IANrMED-lkp@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <202507290540.9IANrMED-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29.07.25 г. 1:04 ч., kernel test robot wrote:
> Hi Nikolay,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.16 next-20250728]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Nikolay-Borisov/lockdown-Switch-implementation-to-using-bitmap/20250728-191807
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20250728111517.134116-3-nik.borisov%40suse.com
> patch subject: [PATCH v2 2/3] lockdown/kunit: Introduce kunit tests
> config: arm-randconfig-004-20250729 (https://download.01.org/0day-ci/archive/20250729/202507290540.9IANrMED-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 1b4db78d2eaa070b3f364a2d2b2b826a5439b892)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507290540.9IANrMED-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507290540.9IANrMED-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> security/lockdown/lockdown.c:31:5: warning: no previous prototype for function 'lock_kernel_down' [-Wmissing-prototypes]
>        31 | int lock_kernel_down(const char *where, enum lockdown_reason level)
>           |     ^
>     security/lockdown/lockdown.c:31:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>        31 | int lock_kernel_down(const char *where, enum lockdown_reason level)
>           | ^
>           | static
>     1 warning generated.


That's a false positive, since the function is exported only for KUNIT 
case, what's the correct way to make testbot ignore it ?
> 
> 
> vim +/lock_kernel_down +31 security/lockdown/lockdown.c
> 
>      20	
>      21	static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
>      22							 LOCKDOWN_INTEGRITY_MAX,
>      23							 LOCKDOWN_CONFIDENTIALITY_MAX};
>      24	
>      25	/*
>      26	 * Put the kernel into lock-down mode.
>      27	 */
>      28	#if !IS_ENABLED(CONFIG_KUNIT)
>      29	static
>      30	#endif
>    > 31	int lock_kernel_down(const char *where, enum lockdown_reason level)
>      32	{
>      33	
>      34		if (level > LOCKDOWN_CONFIDENTIALITY_MAX)
>      35			return -EINVAL;
>      36	
>      37		if (level == LOCKDOWN_INTEGRITY_MAX || level == LOCKDOWN_CONFIDENTIALITY_MAX)
>      38			bitmap_set(kernel_locked_down, 1, level);
>      39		else
>      40			bitmap_set(kernel_locked_down, level, 1);
>      41	
>      42		pr_notice("Kernel is locked down from %s; see man kernel_lockdown.7\n",
>      43			  where);
>      44		return 0;
>      45	}
>      46	
> 
