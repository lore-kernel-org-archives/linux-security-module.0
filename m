Return-Path: <SRS0=Z4XS=RB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3399C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Feb 2019 17:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A424321850
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Feb 2019 17:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbx6L9E6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfBZRpu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:45:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52240 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfBZRpu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Feb 2019 12:45:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so3305156wml.2;
        Tue, 26 Feb 2019 09:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SZS9Di1EubFvel1atFrzP1niMUgW1k7k8zj1DUUaGTg=;
        b=Nbx6L9E6sRw4gR323efY73Dv0323EWGB21J4Ud6LhYTPXKmj/RdsOPoiTuTMJ8WZrq
         PDx7PzxhW6oQTS4+cWpD0K1v7sUspyYY4E1Qrqka7QqSfenjfDIDtYcWmvs72sgZno2z
         pZ1U79/NHMHH+oKbFHpEYz1uefIwXBEcCg85mQScSpBIHEngMhh8CZ+E8dJsUYVLoAsM
         nlO4qhWeQsbZY2GIaDh28hV6Zyr38MH70SMMiqQnNtgArvmnjal9nHCWZfCpaA8OUYgA
         m9VlVL1410oYcPP2/fg4Gk89ZwIdBNONWRcdtBPxaejkWvlsEjrdIa+mfGwx0QXWtYGl
         u3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SZS9Di1EubFvel1atFrzP1niMUgW1k7k8zj1DUUaGTg=;
        b=uFjaMss6jux9MBg59w4TTcuhEaTp0x/5A0mBc6uy6X53oyTApO5kZUXiM1nT5NtYDN
         G9lqVwJv5gqN71LQaSpshIxvk1v6Xd7xY4eoPjF2jtDEaRXE28J7JDn/bEnR+U/hr2Fn
         dDp+M/KlCMJtXNOdt/I/i4j2zlwOgX5GEHlCAvgyTaPsOft0z5c1IbhUDQ2G8KeN8+8w
         yWZmdCJXmrqD0Y8c5kS8VNRV9NmscpW3jl1JbLZ8Rcqx8WVFU1ZPuUbnPIBeFDgb8ghc
         pfblrPP43VDyDT6NH2x6pvQUKyNnChJsPkLZRPtS9ldzfAjuj3knTHqM4LQ+KGrqFM19
         xkOQ==
X-Gm-Message-State: AHQUAuZyryQChbkJx82ZWjgjNTcF9uuZkopvv99u6CUq+UP9YvGAEFxi
        4JaEx6zWLtaJ+UEqGPvkGr8AAGRt
X-Google-Smtp-Source: AHgI3IZe90p+bL2KVmdZpBD3+aiOZ5Ah7b1qyc6paEMnbMKB8rI0TwNl2pWnBCjWXP2lpwip4aDMJg==
X-Received: by 2002:a1c:4155:: with SMTP id o82mr3352219wma.122.1551203147077;
        Tue, 26 Feb 2019 09:45:47 -0800 (PST)
Received: from [172.16.8.139] (host-78-151-241-71.as13285.net. [78.151.241.71])
        by smtp.gmail.com with ESMTPSA id m15sm9395769wrx.30.2019.02.26.09.45.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:45:46 -0800 (PST)
Subject: Re: [PATCH 04/43] separate copying and locking mount tree on
 cross-userns copies
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
References: <e967b416-dcef-2ce4-8775-2eb67da7d045@gmail.com>
 <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
 <155059371731.12449.5751025556744658291.stgit@warthog.procyon.org.uk>
 <27060.1551195858@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <c1ad9cda-1e63-e902-4cfd-59058711863f@gmail.com>
Date:   Tue, 26 Feb 2019 17:45:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <27060.1551195858@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 26/02/2019 15:44, David Howells wrote:
> Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:
>
>> I can see that this covers copy_mnt_ns().  It should also cover what will
>> happen in future, if you pass an OPEN_TREE_CLONE fd to a process with a
>> different mnt_ns and mnt_ns->user_ns, and that process mounts the fd using
>> move_mount().  However, I can't work out how this covers mount propagation
>> across namespaces.
>>
>> The comment "Notice when we are propagating across user namespaces" is moved
>> to attach_recursive_mnt().  I can't find any call to attach_recursive_mount()
>> inside the mount propagation code.  Am I overlooking something?
> You've spelt the function name two different ways?
>
> Further, attach_recursive_mnt() calls propagation, not the other way round.
>
> David (& Al)

Thanks!

I have a (positive) comment on the new mount API, that I was holding 
back due to my confusion here.  I will send it now.

Alan
