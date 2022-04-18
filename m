Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F211C433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Apr 2022 05:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiDRFxB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Apr 2022 01:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbiDRFxB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Apr 2022 01:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 992625F45
        for <linux-security-module@vger.kernel.org>; Sun, 17 Apr 2022 22:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650261022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQi37t5ImtJGz8dpkcjwi4DmC/UUnyTxDNTmEnfJgZE=;
        b=g3FytvuRgP0x5EjQ/NNRo0nX/cjduQmyl5o134J6k0jvlzVssm7c1DFW9ffGjcyn7lUbqH
        T4wiCIvxE1IRUQ+YJFZy6Y5/arodLtocigdWn02+f8GTGW7Rp+483s3mRavO91ZyhYinGJ
        G34EYUD9+VTkYSjWV+y60FhrWKCrFLY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-J_iVMLxeNb-iNVaLqVg6Bg-1; Mon, 18 Apr 2022 01:50:14 -0400
X-MC-Unique: J_iVMLxeNb-iNVaLqVg6Bg-1
Received: by mail-pg1-f200.google.com with SMTP id u3-20020a632343000000b0039cac94652aso8257422pgm.11
        for <linux-security-module@vger.kernel.org>; Sun, 17 Apr 2022 22:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BQi37t5ImtJGz8dpkcjwi4DmC/UUnyTxDNTmEnfJgZE=;
        b=lZlmYYOly/UHwZsPIgdvj9by9CiRZYxD5++lZFadB8Z2nDOf5riPO7ibTDha2lxWuy
         kISqrSQbiFCKaI3zW+xF1EHEbbKzIxGab7J3uVekBW4fiHKEyjP1aJD8IiSqLgBPJjsQ
         Y820Q1dEoZRQGi7qT7ZHqd4VbTisrNWVtZdIP2bcVFM9uTgKMAbJFm7WRcI+dwuyhlvT
         2ZVF/fsYI+JV3ahSZGQHmPIhFnRfLq9+/9Tx5BprV1m5l5mt7sCCRJTqzMX+ucitaeqv
         wyREDBVdZhPJrfaoJlcWmLAE4PFfoXjNrswoFzldJSgHl5vOveYUVhHp9m7KGZXQS8yS
         0yow==
X-Gm-Message-State: AOAM531RlQC0pkyYF+zh44uAKAP33vqy/KvO6LR92pVzG3kvetQC++yS
        GNmqO21HaxyKCEnYyCeLYCcnUjGlrKTcL5ugyvdBvc3gcjzSLKXOId97MyRWT02BglZUFkxoSqW
        RVS1//PZLcfAwophxx6FBJ5g2VKqlNwgdSDut
X-Received: by 2002:a17:902:6b4b:b0:158:d86f:b232 with SMTP id g11-20020a1709026b4b00b00158d86fb232mr9562154plt.106.1650261012669;
        Sun, 17 Apr 2022 22:50:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoSw0iKfS7lUTSONvN9gfujuFvECmwh9pZuI5ewINby/kFfzo9o5ZOvaHPQ7r4DFG4n6wQNg==
X-Received: by 2002:a17:902:6b4b:b0:158:d86f:b232 with SMTP id g11-20020a1709026b4b00b00158d86fb232mr9562133plt.106.1650261012447;
        Sun, 17 Apr 2022 22:50:12 -0700 (PDT)
Received: from localhost ([240e:3a1:2e1:fc30:496c:36d3:5798:d144])
        by smtp.gmail.com with ESMTPSA id y16-20020a637d10000000b00381268f2c6fsm11661092pgc.4.2022.04.17.22.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 22:50:11 -0700 (PDT)
Date:   Mon, 18 Apr 2022 13:46:12 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] arm64: kexec_file: use more system keyrings to
 verify kernel image signature
Message-ID: <20220418054612.54knzv4gqoxbq57a@Rk>
References: <20220414014344.228523-1-coxu@redhat.com>
 <20220414014344.228523-4-coxu@redhat.com>
 <YlzJh8SE8pV1Et+O@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <YlzJh8SE8pV1Et+O@MiWiFi-R3L-srv>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 18, 2022 at 10:14:31AM +0800, Baoquan He wrote:
>On 04/14/22 at 09:43am, Coiby Xu wrote:
>> Currently, a problem faced by arm64 is if a kernel image is signed by a
>> MOK key, loading it via the kexec_file_load() system call would be
>> rejected with the error "Lockdown: kexec: kexec of unsigned images is
>> restricted; see man kernel_lockdown.7".
>>
>> This happens because image_verify_sig uses only the primary keyring that
>> contains only kernel built-in keys to verify the kexec image.
>>
>> This patch allows to verify arm64 kernel image signature using not only
>> .builtin_trusted_keys but also .platform and .secondary_trusted_keys
>> keyring.
>>
>> Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")
>
>Cc stable?

Thanks for the reminder! I've added "Cc stable@kernel.org". But it seems
I should Cc stable@vger.kernel.org instead.

>
>Otherwise, LGTM,
>
>Acked-by: Baoquan He <bhe@redhat.com>
>
>> Cc: kexec@lists.infradead.org
>> Cc: keyrings@vger.kernel.org
>> Cc: linux-security-module@vger.kernel.org
>> Cc: stable@kernel.org
>> Co-developed-by: Michal Suchanek <msuchanek@suse.de>
>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>> Acked-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/arm64/kernel/kexec_image.c | 11 +----------
>>  1 file changed, 1 insertion(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
>> index 9ec34690e255..5ed6a585f21f 100644
>> --- a/arch/arm64/kernel/kexec_image.c
>> +++ b/arch/arm64/kernel/kexec_image.c
>> @@ -14,7 +14,6 @@
>>  #include <linux/kexec.h>
>>  #include <linux/pe.h>
>>  #include <linux/string.h>
>> -#include <linux/verification.h>
>>  #include <asm/byteorder.h>
>>  #include <asm/cpufeature.h>
>>  #include <asm/image.h>
>> @@ -130,18 +129,10 @@ static void *image_load(struct kimage *image,
>>  	return NULL;
>>  }
>>
>> -#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
>> -static int image_verify_sig(const char *kernel, unsigned long kernel_len)
>> -{
>> -	return verify_pefile_signature(kernel, kernel_len, NULL,
>> -				       VERIFYING_KEXEC_PE_SIGNATURE);
>> -}
>> -#endif
>> -
>>  const struct kexec_file_ops kexec_image_ops = {
>>  	.probe = image_probe,
>>  	.load = image_load,
>>  #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
>> -	.verify_sig = image_verify_sig,
>> +	.verify_sig = kexec_kernel_verify_pe_sig,
>>  #endif
>>  };
>> --
>> 2.34.1
>>
>>
>

-- 
Best regards,
Coiby

