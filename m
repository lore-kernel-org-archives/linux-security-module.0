Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5C4CCA479
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jun 2022 01:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350450AbiFPBuZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Jun 2022 21:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348760AbiFPBuS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Jun 2022 21:50:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3FA1580D4
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jun 2022 18:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655344216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mfnj3kbt/mcFDC8cZyL7mlTMEbSGwlIrcY0mmV2SXko=;
        b=OX4zT2HuN9E+iW/XfQd9sPvcgw2HUPtTcSZk6xjX8vtxt0RHLxRnTlNu3I7wYb/kOk9+Gb
        Do2fwcHgvbLIDREIUGxAvt3Ort+n0MXBfKK7zYTxRD0Rp6tqPKWQsp7tx2qmWnE5RVfE/g
        GJF2yCD39CdAiBSbO8IhwDJt/BIfZw0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-glswz0EuOFuTH9_Y2MYJ7g-1; Wed, 15 Jun 2022 21:50:15 -0400
X-MC-Unique: glswz0EuOFuTH9_Y2MYJ7g-1
Received: by mail-pg1-f199.google.com with SMTP id h7-20020a63e147000000b00408948ba461so4553433pgk.15
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jun 2022 18:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mfnj3kbt/mcFDC8cZyL7mlTMEbSGwlIrcY0mmV2SXko=;
        b=MXNN0fbgKkGuhZT/zKJ3EacWDrNtnq3QKRl2FyhQrhzk7YtXvp8TGhVO00hosliDFj
         mwqpyUJKEM7+KIxdteGUjp3lDgG8a8awCgnceqJlBIdNAZNvMbdWe/FIuN/+TjxPErtu
         EtJLvyZXnogEB8Zr00+OvU088fdCjFOwEnUPb7ZOJAFktOcUHUTS9ca/jPwAn6g/Xfs3
         4DSWjPVKoGw8ccngNtqTyLpDGlvENRaKiIhB4V3a9HNofn1mPvKQ1TewVl79qVvczAKK
         4jcoOm0SuO2GaLe3fs8+/m4niTkYAinnTmEJlY5I1AJ+EcIW/JlqSwI9LUxflx2N4nCK
         +KZw==
X-Gm-Message-State: AJIora82cZu/w764k+64zzi7leVwgZL+g7M0rPj5IP6RBvDVq+spj9IJ
        3pNdjpmJWZqTwTwLsedgEW5MwyyU6HCk8pat68yBdTFB9TNBzwjxAC2oXpURChOny8N6N5vPAV7
        vr/dbvpO+NDrV4AqgdjlDNmGRrVpGRrWQ080h
X-Received: by 2002:a63:1e1d:0:b0:401:a251:767e with SMTP id e29-20020a631e1d000000b00401a251767emr2357335pge.26.1655344214526;
        Wed, 15 Jun 2022 18:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sEarbrrVxjiXB2Z4yglIOjHVgXmEDqqN6H9xo+0t/vhcHtsIxwYcmDDYcM0diomczP0LPViQ==
X-Received: by 2002:a63:1e1d:0:b0:401:a251:767e with SMTP id e29-20020a631e1d000000b00401a251767emr2357317pge.26.1655344214223;
        Wed, 15 Jun 2022 18:50:14 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k16-20020a17090aaa1000b001e3351cb7fbsm2464671pjq.28.2022.06.15.18.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 18:50:13 -0700 (PDT)
Date:   Thu, 16 Jun 2022 09:46:50 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>, akpm@linux-foundation.org,
        kexec@lists.infradead.org, keyrings@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, stable@vger.kernel.org,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v8 4/4] kexec, KEYS, s390: Make use of built-in and
 secondary keyring for signature verification
Message-ID: <20220616014650.wd6saed72breqeyb@Rk>
References: <20220512070123.29486-1-coxu@redhat.com>
 <20220512070123.29486-5-coxu@redhat.com>
 <YoTYm6Fo1vBUuJGu@osiris>
 <20220519003902.GE156677@MiWiFi-R3L-srv>
 <c47299b899da4ad4b6d3ad637022ad82c8ed6ed2.camel@linux.ibm.com>
 <YoZSl84aJYTscgfO@MiWiFi-R3L-srv>
 <20220519171134.GN163591@kunlun.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20220519171134.GN163591@kunlun.suse.cz>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Mimi,

>> >
>> > This patch set could probably go through KEYS/KEYRINGS_INTEGRITY, but
>> > it's kind of late to be asking.  Has it been in linux-next?  Should I
>> > assume this patch set has been fully tested or can we get some "tags"?
>>
[...]
>>
>> IIRC, Coiby has tested it on x86_64/arm64, not sure if he took test on
>> s390. No, this hasn't been in linux-next.

For arm64, recently I did a new round of test and the patches works as
expected,
   1. Build 5.19.0-rc2
   2. generate keys and add them to .secondary_trusted_keys, MOK, UEFI
      db; 
   3. sign different kernel images with different keys including keys
      from .builtin_trusted_key, .secondary_trusted_keys keyring, UEFI db
      key and MOK key 
   4. Without lockdown, all kernel images can be kexec'ed; with lockdown
      enabled, only the kernel image signed by the key from
      .builtin_trusted_key can be kexec'ed

Then I build a new kernel with the patches applied and confirm all
kernel images can be kexec'ed.

>
>I used the s390 code on powerpc and there it did not work because the
>built-in key was needed to verify the kernel.
>
>I did not really run this on s390, only ported the fix I needed on
>powerpc back to s390.

For 390, I commented out the code that skips signature verification
when secure boot is not enabled since I couldn't find a machine that
supports secure boot and confirm before applying the patch, kernel
images signed by keys from .builtin_trusted_key, .secondary_trusted_keys
couldn't be kexec'ed when lockdown is enabled; after applying the
patch, those kernel images could be kexec'ed. 

>
>Thanks
>
>Michal
>

-- 
Best regards,
Coiby

