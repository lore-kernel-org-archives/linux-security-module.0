Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ADEC433FE
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Oct 2022 21:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJDVa5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Oct 2022 17:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJDVaz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Oct 2022 17:30:55 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1097B36DF9
        for <linux-security-module@vger.kernel.org>; Tue,  4 Oct 2022 14:30:55 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-127dca21a7dso17892482fac.12
        for <linux-security-module@vger.kernel.org>; Tue, 04 Oct 2022 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SFQu3t4inF2f+xysjgGlZx3Q+02dLvuG3skqtmC7Pio=;
        b=SA+wt+snYtRdSJbpf94VhrexKFOGonjrwKB67DgxIIH3cROJ5H0Xf5DnQd/Zmg0oCQ
         tPKtQqGfOY7cKeLSWYZGbsrWcmghNbzyuVESVUfz8nlzevxY7EbcVnEl7+e7RLUNUw/e
         AOY7a5m8VQy7rfIxuzrsIOM/1t2RtNNy+bwgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SFQu3t4inF2f+xysjgGlZx3Q+02dLvuG3skqtmC7Pio=;
        b=5zdKpb5qeLhOrEDLt4/uhCaGSTMPO8s1Tr3kvLBEOTbFcnGV2llxpuBBRg6t+/kSH0
         VyjZ8lV1F9u85bPssU1DnRmkv1x6A+nsGyw3jFWxcjW9K0Q48fnntgCni2fqdiHna9JU
         oBbRqqS2INdERiVMT1/l9O5OXd0M4zuvxHTVLRpeYD51vi3/Bym8g0+u7Mb85Z9Yg54N
         WBmmPR1FN6ig/oiF7CSVJAth0/A1B4YmupbUkH2fWFbg2aglx3+sTyClBSa60IV61pnT
         0YCYHsIJMTt3jTlukbZBZZ9ePBAH0Mdr+43/NR2wb0TAsYiLClrzbrWGUuPMZKqyYMwy
         smYg==
X-Gm-Message-State: ACrzQf1kd7pCKi5MCTmlLZ9TjHM6uNkud7pX8Ngy+hvLM9E8SDNe8bRm
        PDC1578Cz/GxTvVFp9Aea0bcgIpFOQ+alw==
X-Google-Smtp-Source: AMsMyM7MxOy4jFFs+q7CShXdVQ1dfCGfDHP/ofz4Kp9KmhI4Ejw/HKN8DHFJpuiGpuJYDnCm3DAeXQ==
X-Received: by 2002:a05:6870:601a:b0:132:7b87:1616 with SMTP id t26-20020a056870601a00b001327b871616mr972810oaa.192.1664919053420;
        Tue, 04 Oct 2022 14:30:53 -0700 (PDT)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id r35-20020a056870582300b0011f22e74d5fsm4003683oap.20.2022.10.04.14.30.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 14:30:52 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id z9-20020a4a4909000000b0047651b95fbdso9622801ooa.5
        for <linux-security-module@vger.kernel.org>; Tue, 04 Oct 2022 14:30:52 -0700 (PDT)
X-Received: by 2002:a05:6830:11c6:b0:65f:913:ff93 with SMTP id
 v6-20020a05683011c600b0065f0913ff93mr6285691otq.69.1664919051959; Tue, 04 Oct
 2022 14:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
 <87sfk3mim9.fsf@email.froward.int.ebiederm.org> <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
In-Reply-To: <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Oct 2022 14:30:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjKsSmNVLa1e22Q29-YUEXWtS39d7EDkcN8v_E7SoKGA@mail.gmail.com>
Message-ID: <CAHk-=wjjKsSmNVLa1e22Q29-YUEXWtS39d7EDkcN8v_E7SoKGA@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 4, 2022 at 1:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So this whole "don't do this" approach you have is not acceptable.

Side note: if we have a security hook for "create random file", then
the notion that creating a whole new namespace somehow must not have
any security hooks because it's *so* special is just ridiculous.

I also note that right now USER_NS is both "default n" and "if not
sure, say 'n'" in the Kconfig files, even though obviously that ship
has sailed long ago.

So originally it might have been a reasonable expectation to say "only
enable this if you're doing containers in servers", but that clearly
isn't the case any more. So we basically take USER_NS for granted, but
the fact that people might want chrome to use it for sandboxing does
*not* mean that randomly we want any CLONE_NEWNS to just be ok,
regardless of how trusted (or not) the case is.

                     Linus
