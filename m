Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A407C46CA1
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Sep 2023 15:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjIRPiN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjIRPiM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Sep 2023 11:38:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D36E69
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 08:34:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso610239566b.3
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 08:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695051063; x=1695655863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RKiCOByDL96hotvveoALRujHhJ+JRMIfwmxKHnT1o6A=;
        b=cbFMjKEczu/Lv6XpGyngZD0PQ4AJfkwfpwPBHVTMK0LHSsFLwB8pgQoNMqxI2coKwX
         h1k8NPkk+NptZdJa4cYpi4+lLLc2tKQVw1awkbZwQYEJm6Fv7KmEOtLveqMJH5C65/vk
         CRoNvSxBupSgNT0qNsY/6rELdHpZLuQKIG75E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051063; x=1695655863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKiCOByDL96hotvveoALRujHhJ+JRMIfwmxKHnT1o6A=;
        b=gbhpd+cAhrRZN/ub8sXW5u9DfDf7G0032rIw/U7tOpYFztdNC2SJWNJNt3dS2iwyFt
         5fYXRRK7LaCegDdpslKanfbcDjHc6fTiFz4zM9pJ79Dd4NynivjjuVs28Iil1dpZBQGX
         MrFe3E8IQBs7nYwDY2RVFxnUqVQChv37b2R3CwpZz3HWpuom20PN71ypu0K2N1TLcy9T
         JlT/L9cWBagrkPBoBiQj1cVtRRo8i5390IsHsOFFW44GG0KpBTI6U4+fpFI9S8+z44wv
         towmEjyQE9QVYqV+cL6hSKlem5wbTm0LbUyTNAGiaInkmR5Zt301HS+4ma1aojA1r2fx
         LqsA==
X-Gm-Message-State: AOJu0YwL0DGwH1u2hR3eOILhFMdkyXjmZ9bQNB7cP5WdqyhUJz1GJVR2
        hvuPG5vzTIwFh9TtJcEe+zgWpDhp4a865kBXfiXcgOqlGhmypMSK
X-Google-Smtp-Source: AGHT+IFIEvXbEUkU+mxN2F/R/tIeFBRSysj5+zBZP+k60Jl/lHiG5m9DX+A4lurODy2hOWFB3ngj7hncFNBhvH4RRiY=
X-Received: by 2002:a17:906:3102:b0:99c:e38d:e484 with SMTP id
 2-20020a170906310200b0099ce38de484mr8115574ejx.6.1695047562459; Mon, 18 Sep
 2023 07:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
In-Reply-To: <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Sep 2023 16:32:30 +0200
Message-ID: <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 18 Sept 2023 at 16:25, Christian Brauner <brauner@kernel.org> wrote:

> The system call should please have a proper struct like you had in your
> first proposal. This is what I'm concerned about:
>
> int statmount(u64 mnt_id,
>               struct statmnt __user *st,
>               size_t size,
>               unsigned int flags)
>
> instead of taking an void pointer.

So you are not concerned about having ascii strings returned by the
syscall?   I thought that was the main complaint.

Thanks,
Miklos
