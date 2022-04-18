Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39EAC433F5
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Apr 2022 05:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiDRFsB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Apr 2022 01:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiDRFr5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Apr 2022 01:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C214011A10
        for <linux-security-module@vger.kernel.org>; Sun, 17 Apr 2022 22:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650260715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T1o3lDkKjJ1ubV1pkELZ5kYo2o2QIP5NYLC4ArKgbfs=;
        b=D6+XQqCmktxZNdiS1ByskyCGTgEhDXVMnRiSeQhVeudZrf/SH0O2DzTwiG9INtFpuZVjM3
        ffmiNwZoXtGyhxKZRs4s1wpbVYGyhDuGxB8bmRdxOZbkP7G+iw51lCCxSWHZZEPHOuN5Vl
        ZJGuBXiffrVoQuG1M1ewR2yUe3I+7p8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-sdFpgQfnMvGfs6PaDBHe0A-1; Mon, 18 Apr 2022 01:45:14 -0400
X-MC-Unique: sdFpgQfnMvGfs6PaDBHe0A-1
Received: by mail-pg1-f197.google.com with SMTP id p4-20020a631e44000000b00399598a48c5so8258674pgm.1
        for <linux-security-module@vger.kernel.org>; Sun, 17 Apr 2022 22:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T1o3lDkKjJ1ubV1pkELZ5kYo2o2QIP5NYLC4ArKgbfs=;
        b=7m76wB6yndsLInghhbgInCeI0jWTTzvo661jl6AeIoq1RCIpfgeekELenkmhpZAFX/
         6n2Cv8a53QtyUdTNOWMAnBX0VPjjXX/NDfv0I8CR7G0xY9U1R8bfqLPstfF/ltVnM/ME
         XkLqQU0Ka0Vx+KIFFhGQn3PfokAKJvvtEfGCAHob0i4l/NvyWzUrKCJGfPcnpNm1iDz7
         rcDK1z6ofwswm0w4AYDVVYb8WE62/teWjflD0Kqo5K/4ps7VM5RH7DMzWP5Gev2MlPfi
         IwlJCzQmwh2Z7zFZ/pcYDOL4QlITmUFcWvKueKuE5Acj5tV9RYdmfW8q7Pqi8Qb03F1G
         442A==
X-Gm-Message-State: AOAM532MNwTaXBmpdkYdqyyV6YM0pgIKaN0gg4VjVK3+9t5K0wPIlGEk
        dyVwTpQk9HcsXsDjYUcSrC3zrO2av3zKP3GhklWBAhlcm6EViNfAYW1DCyOw+XzcjHWX8+s3TWQ
        InWpWHxyWn7OTljBaqfTmvJ++c8FXbEiot10b
X-Received: by 2002:aa7:9110:0:b0:4fa:e388:af57 with SMTP id 16-20020aa79110000000b004fae388af57mr10410820pfh.1.1650260713599;
        Sun, 17 Apr 2022 22:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymR0oZfWlFYrAEf8qnTbPoW8P8tQF737+NvuBY9kYfxQXTP0JBlH5CEWGh43eAvxmeN/jnaw==
X-Received: by 2002:aa7:9110:0:b0:4fa:e388:af57 with SMTP id 16-20020aa79110000000b004fae388af57mr10410797pfh.1.1650260713196;
        Sun, 17 Apr 2022 22:45:13 -0700 (PDT)
Received: from localhost ([240e:3a1:2e1:fc30:496c:36d3:5798:d144])
        by smtp.gmail.com with ESMTPSA id p17-20020a056a0026d100b00505ff62176asm10524875pfw.180.2022.04.17.22.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 22:45:12 -0700 (PDT)
Date:   Mon, 18 Apr 2022 13:42:37 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Yinghai Lu <yinghai@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/4] kexec, KEYS: make the code in
 bzImage64_verify_sig generic
Message-ID: <20220418054237.2rjt357op5nhttvk@Rk>
References: <20220414014344.228523-1-coxu@redhat.com>
 <20220414014344.228523-3-coxu@redhat.com>
 <YlzChw5kPOlPmK9Z@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <YlzChw5kPOlPmK9Z@MiWiFi-R3L-srv>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 18, 2022 at 09:53:32AM +0800, Baoquan He wrote:
>On 04/14/22 at 09:43am, Coiby Xu wrote:
>> commit 278311e417be ("kexec, KEYS: Make use of platform keyring for
>> signature verify") adds platform keyring support on x86 kexec but not
>> arm64.
>>
>> The code in bzImage64_verify_sig makes use of system keyrings including
>> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to
>> verify signed kernel image as PE file. Make it generic so both x86_64
>> and arm64 can use it.
>>
>> Fixes: 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
>
>Will the code in bzImage64_verify_sig generic not being genric cause any
>issue? Asking this because I don't get why making code generic need add
>'Fixes' tag.

Thanks for raising this question! This Fixes tag is for the problem
as described in the 1st paragraph of the commit message and making the
code generic is the solution. But if I misuse the Fixes tag, I can drop
it.

>
>> Cc: kexec@lists.infradead.org
>> Cc: keyrings@vger.kernel.org
>> Cc: linux-security-module@vger.kernel.org
>> Cc: stable@kernel.org
>> Reviewed-by: Michal Suchanek <msuchanek@suse.de>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/x86/kernel/kexec-bzimage64.c | 20 +-------------------
>>  include/linux/kexec.h             |  7 +++++++
>>  kernel/kexec_file.c               | 17 +++++++++++++++++
>>  3 files changed, 25 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>> index 170d0fd68b1f..f299b48f9c9f 100644
>> --- a/arch/x86/kernel/kexec-bzimage64.c
>> +++ b/arch/x86/kernel/kexec-bzimage64.c
>> @@ -17,7 +17,6 @@
>>  #include <linux/kernel.h>
>>  #include <linux/mm.h>
>>  #include <linux/efi.h>
>> -#include <linux/verification.h>
>>
>>  #include <asm/bootparam.h>
>>  #include <asm/setup.h>
>> @@ -528,28 +527,11 @@ static int bzImage64_cleanup(void *loader_data)
>>  	return 0;
>>  }
>>
>> -#ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>> -static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>> -{
>> -	int ret;
>> -
>> -	ret = verify_pefile_signature(kernel, kernel_len,
>> -				      VERIFY_USE_SECONDARY_KEYRING,
>> -				      VERIFYING_KEXEC_PE_SIGNATURE);
>> -	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
>> -		ret = verify_pefile_signature(kernel, kernel_len,
>> -					      VERIFY_USE_PLATFORM_KEYRING,
>> -					      VERIFYING_KEXEC_PE_SIGNATURE);
>> -	}
>> -	return ret;
>> -}
>> -#endif
>> -
>>  const struct kexec_file_ops kexec_bzImage64_ops = {
>>  	.probe = bzImage64_probe,
>>  	.load = bzImage64_load,
>>  	.cleanup = bzImage64_cleanup,
>>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>> -	.verify_sig = bzImage64_verify_sig,
>> +	.verify_sig = kexec_kernel_verify_pe_sig,
>>  #endif
>>  };
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 413235c6c797..da83abfc628b 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -19,6 +19,7 @@
>>  #include <asm/io.h>
>>
>>  #include <uapi/linux/kexec.h>
>> +#include <linux/verification.h>
>>
>>  /* Location of a reserved region to hold the crash kernel.
>>   */
>> @@ -202,6 +203,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
>>  				 const Elf_Shdr *relsec,
>>  				 const Elf_Shdr *symtab);
>>  int arch_kimage_file_post_load_cleanup(struct kimage *image);
>> +#ifdef CONFIG_KEXEC_SIG
>> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
>> +int kexec_kernel_verify_pe_sig(const char *kernel,
>> +				    unsigned long kernel_len);
>> +#endif
>> +#endif
>>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>>
>>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 3720435807eb..754885b96aab 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -165,6 +165,23 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>>  }
>>
>>  #ifdef CONFIG_KEXEC_SIG
>> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
>> +int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
>> +{
>> +	int ret;
>> +
>> +	ret = verify_pefile_signature(kernel, kernel_len,
>> +				      VERIFY_USE_SECONDARY_KEYRING,
>> +				      VERIFYING_KEXEC_PE_SIGNATURE);
>> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
>> +		ret = verify_pefile_signature(kernel, kernel_len,
>> +					      VERIFY_USE_PLATFORM_KEYRING,
>> +					      VERIFYING_KEXEC_PE_SIGNATURE);
>> +	}
>> +	return ret;
>> +}
>> +#endif
>> +
>>  static int kexec_image_verify_sig(struct kimage *image, void *buf,
>>  		unsigned long buf_len)
>>  {
>> --
>> 2.34.1
>>
>

-- 
Best regards,
Coiby

