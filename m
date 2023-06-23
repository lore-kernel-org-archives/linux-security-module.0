Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C278EB64D7
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Jun 2023 23:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjFWXII (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Jun 2023 19:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjFWXIH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Jun 2023 19:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C538A1BF7
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687561640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IndmHJW7I2iYVHC+s6xLbT86+daeIKxbgRYOnFOMqQk=;
        b=FYYqO20sx+ZdL4Ol8D9HyY6KZh2StFC68mOb3PFHCE3a59M9gmNdEefJMelriv62jxqwH8
        UvZhZPGwYueUsTMqAO5reBMemEbnx/Q+9wZGZHy9aggkqnV9mUtXAqBI/EY1b/Ws6qWRMO
        smyEm6DFu6Zpa8THGXKh5Z1g5W/Frj0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-g77DKYflPUmWRcNZTbTAXA-1; Fri, 23 Jun 2023 19:07:18 -0400
X-MC-Unique: g77DKYflPUmWRcNZTbTAXA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-98890dda439so68299566b.1
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 16:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687561637; x=1690153637;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IndmHJW7I2iYVHC+s6xLbT86+daeIKxbgRYOnFOMqQk=;
        b=Y/oyxUek1KKEXovXMOCGKCOTDWdeKn51kWgKhRv6A1Rr+ZOwRacOZ6uzF4C43MOml4
         djSb/cZSEPb6O8VUBHRe2xsrOiFeX0Kf2qw4iWIulo3viyFp66nfQLwiDY7ldN/6YD7h
         UCJDr5dRl2RSg74/z/8pJ+P9gsHSiIwjJxlZkkZaPLttmnIbIxqE3IcUf4/CW4Zixh8D
         CmdSU9iet8sgNrzbfcHuf6LblselqMAERqjl1ZNbo2/gBimXcpJKSQXrbgHnUKhKHCXU
         iakM2cQLbYq7lXHe9Y1m6BrS/LzMpMdws1NiBtw50vr2Ll2APcCQjKOa7yGu584/lBQU
         puEA==
X-Gm-Message-State: AC+VfDxqFtzvacR9ajr1RnmM90G43bZSgapu1bUC5oYCYMgCoKzcujFG
        gDLnxbCRN+jf4/jjz8jeh2x6UK8F8RxkxqfUWmeKFZPJl+c48q1dCQbVS6m8z5POWrWNkM5sT8m
        E8t5CZtABV73yW/HrX9JpWHX584JdruMk/by3
X-Received: by 2002:a17:907:7294:b0:988:c97b:8973 with SMTP id dt20-20020a170907729400b00988c97b8973mr11952534ejc.6.1687561637367;
        Fri, 23 Jun 2023 16:07:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4jXVCMLg8/cuBN07+tlH0Tc4fw+5Tajcbq0k2+pijlLqwz/GNKlFoaHWf/LcljX+tmgPb5ZQ==
X-Received: by 2002:a17:907:7294:b0:988:c97b:8973 with SMTP id dt20-20020a170907729400b00988c97b8973mr11952518ejc.6.1687561636713;
        Fri, 23 Jun 2023 16:07:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q9-20020aa7da89000000b0051d7e2648d8sm39880eds.33.2023.06.23.16.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 16:07:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7D87BBBF798; Sat, 24 Jun 2023 01:07:15 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>, lennart@poettering.net,
        cyphar@cyphar.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
In-Reply-To: <CAEf4BzY2dKvMk_Mg2oLnD5a8aOhXCmU-0QD6sWGNZqkjbMrhBA@mail.gmail.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
 <CAEf4BzY2dKvMk_Mg2oLnD5a8aOhXCmU-0QD6sWGNZqkjbMrhBA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 24 Jun 2023 01:07:15 +0200
Message-ID: <87wmztixr0.fsf@toke.dk>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

>> applications meets the needs of these PODs that need to do
>> privileged/bpf things without any tokens. Ultimately you are trusting
>> these apps in the same way as if you were granting a token.
>
> Yes, absolutely. As I mentioned very explicitly, it's the question of
> trusting application. Service vs token is implementation details, but
> the one that has huge implications in how applications are built,
> tested, versioned, deployed, etc.

So one thing that I don't really get is why such a "trusted application"
needs to be run in a user namespace in the first place? If it's trusted,
why not simply run it as a privileged container (without the user
namespace) and grant it the right system-level capabilities, instead of
going to all this trouble just to punch a hole in the user namespace
isolation?

-Toke

