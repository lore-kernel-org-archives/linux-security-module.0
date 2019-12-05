Return-Path: <SRS0=JRQQ=Z3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03950C43603
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Dec 2019 10:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C931B2464D
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Dec 2019 10:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXGh6TNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfLEKxI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:53:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56389 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729017AbfLEKxI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Dec 2019 05:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575543187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZ3pcvbIa/5GjW3TrOtnvfQxM6Nrqq/Ve/xoy67596c=;
        b=JXGh6TNhIlehq7VrB2Fbi7z28BZYIn/f/uZZqFumTfilKLunEWyiGJY5WsLjaWd9dXnPYQ
        oYpNnsj/lziFC9/1XyYrP0IZAyOHE9Wn0+pMi1HyEm3pS8QZSPC5FsCkfvn/1XMPbuiNxg
        +V38BCZtQgsj7dSYj9uL/NL1HSLEdiM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-0Awy4F_YNVGr_-Ye2bVpCw-1; Thu, 05 Dec 2019 05:53:05 -0500
Received: by mail-wr1-f71.google.com with SMTP id j13so1349378wrr.20
        for <linux-security-module@vger.kernel.org>; Thu, 05 Dec 2019 02:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZ3pcvbIa/5GjW3TrOtnvfQxM6Nrqq/Ve/xoy67596c=;
        b=U2fG1V7HcGNTyYC5/dVRsBsrzP4CHQmMMHQaZRH8NcbM5gd2bX9u6xok9aKfWqhfwA
         5Lcnbp90iIWgteRLQNq4eoTVa+0eZFe6uHyLV8fAlikegTyQscPINqz6jbW8KpWd856E
         8btTLGutmkp0i3wJ7XzExAKLwrE/kL+9Um0K/mwRdf+HppTJrMbTxKSGXOLPFaU0ChJI
         W0eJuQ4Mvk/KaNogCehYZ+KRV25sFfYsGKWPfuJOR5aThEUhH/mNGlTjodI/GHhEjHae
         4z5XA7QhjfyAAQyYCvkoCZ07Mgw2cpNgosYIzsZ//mLS+V4JiiVb9R5YPAUFRXJBSCJi
         wVrw==
X-Gm-Message-State: APjAAAUnffBe0OLw6uXMcWBVbFAbKBWyz6pIUe0YwL5BPK62FLQWfSCk
        u/zOKlfVi8dWGrVb+1aoxRymCVPXZ/4OpJES8Fx5ameVCfV0zp5i4ROIgPA9vFaLLkWoARzWO6r
        21GHNnbrEorbi4c2VHEtU/mt+z7Q9BvimxAXT
X-Received: by 2002:adf:c446:: with SMTP id a6mr9047808wrg.218.1575543184809;
        Thu, 05 Dec 2019 02:53:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwx9CUNwWlq1RaO/psV1pKv4CxKZxc0hZLR/nlLtAxIYf4QbMkgK8PoODzgoTEjMUq7CbXTeA==
X-Received: by 2002:adf:c446:: with SMTP id a6mr9047792wrg.218.1575543184607;
        Thu, 05 Dec 2019 02:53:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:541f:a977:4b60:6802? ([2001:b07:6468:f312:541f:a977:4b60:6802])
        by smtp.gmail.com with ESMTPSA id f1sm11989134wro.85.2019.12.05.02.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 02:53:04 -0800 (PST)
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI <dri-devel@lists.freedesktop.org>, ghalat@redhat.com,
        Gleb Natapov <gleb@kernel.org>, gwshan@linux.vnet.ibm.com,
        "H. Peter Anvin" <hpa@zytor.com>, James Morris <jmorris@namei.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KVM list <kvm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Russell Currey <ruscur@russell.cc>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, stewart@linux.vnet.ibm.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>
References: <0000000000003e640e0598e7abc3@google.com>
 <41c082f5-5d22-d398-3bdd-3f4bf69d7ea3@redhat.com>
 <CACT4Y+bCHOCLYF+TW062n8+tqfK9vizaRvyjUXNPdneciq0Ahg@mail.gmail.com>
 <f4db22f2-53a3-68ed-0f85-9f4541530f5d@redhat.com>
 <CACT4Y+ZHCmTu4tdfP+iCswU3r6+_NBM9M-pAZEypVSZ9DEq3TQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e03140c6-8ff5-9abb-1af6-17a5f68d1829@redhat.com>
Date:   Thu, 5 Dec 2019 11:53:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZHCmTu4tdfP+iCswU3r6+_NBM9M-pAZEypVSZ9DEq3TQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 0Awy4F_YNVGr_-Ye2bVpCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 05/12/19 11:31, Dmitry Vyukov wrote:
>> Ah, and because the machine is a KVM guest, kvm_wait appears in a lot of
>> backtrace and I get to share syzkaller's joy every time. :)
> I don't see any mention of "kvm" in the crash report.

It's there in the stack trace, not sure if this is what triggered my Cc:

 [<ffffffff810c7c3a>] kvm_wait+0xca/0xe0 arch/x86/kernel/kvm.c:612

Paolo

