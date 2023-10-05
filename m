Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EBCE772A3
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Oct 2023 16:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjJEQKQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbjJEQJk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Oct 2023 12:09:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F9A7E212
        for <linux-security-module@vger.kernel.org>; Thu,  5 Oct 2023 08:52:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5363227cc80so1889817a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 05 Oct 2023 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696521147; x=1697125947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ7R/nvBhjGTebLIH07sXUQkeSq81lBJV2IFuqFT5ks=;
        b=kaAKFbtGGjgq+daw7tAPVKBzxgbEZS9H7gZCMFN6Loa+RDfMDJJPx7OVmEaJtr5nO7
         whXAfc+4mSiqQGPVk8UZrzWIs7N9mg0yc5MiqbSkhy+B0awBpFHbdak6CYFQcvlZTqv6
         9DxxkWBBlTnGtHFJcuQ0qxZx2w3BZ416UgQm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696521147; x=1697125947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQ7R/nvBhjGTebLIH07sXUQkeSq81lBJV2IFuqFT5ks=;
        b=mc5nmNvc9FibsS7e2ORixoFwunxZ+iD89hIMcLWcFab2kbMnuIsZOIeItC3omGjL1S
         4JChMYQ01E1UuPlLz8s9PsefX2iebNZzE29Y/ZFZzEnL7lbbsiTO5yo6w9S31Iq4pV6s
         CyyeXxHvMb4ZcaTItnOkiitVTfvAQRi5yRh62FUrwnk/lRpY6UWA/iFM+SyISwcMsTFN
         rqtnALibJmvuo3o3nAPI8AqbFZ3NKy4u8rIrsRqtasI/hTyaOSbF83/ZwAxUDnzDBwjv
         eqL0NXmfK0wsBGDDnf7A1N0SnWNTzjcfMQEP15W0xK5OgYNPfJHz5fGZQ6jtnaJc5Cxc
         tmQQ==
X-Gm-Message-State: AOJu0Yy/ZNOaMMaqJiT1pxwgCB8LZWvBmiUzPoeQNWUg7XsIsknlOxKi
        wfRiRZgI+d/5IKuJQDPFLqHF+I13stKVllK8boVr4w==
X-Google-Smtp-Source: AGHT+IEjk91u8XSDRTtHtK1m9U1BbYI9ul1sY8PRZffqsVYEFnsO8jHMq77QF4AYuvBhByku9bOaBTvxJTmlGFVmmZk=
X-Received: by 2002:a17:907:724b:b0:9a1:fcd7:b825 with SMTP id
 ds11-20020a170907724b00b009a1fcd7b825mr5098742ejc.71.1696521146721; Thu, 05
 Oct 2023 08:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-2-mszeredi@redhat.com>
In-Reply-To: <20230928130147.564503-2-mszeredi@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 5 Oct 2023 17:52:15 +0200
Message-ID: <CAJfpeguTQvA6cq-3JCEZx6wP+nvZX8E6_77pNRJUU2_S7cyAiA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] add unique mount ID
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 28 Sept 2023 at 15:03, Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> If a mount is released then its mnt_id can immediately be reused.  This is
> bad news for user interfaces that want to uniquely identify a mount.
>
> Implementing a unique mount ID is trivial (use a 64bit counter).
> Unfortunately userspace assumes 32bit size and would overflow after the
> counter reaches 2^32.
>
> Introduce a new 64bit ID alongside the old one.  Initialize the counter to
> 2^32, this guarantees that the old and new IDs are never mixed up.

It occurred to me that it might make sense to make this counter
per-namespace.  That would allow more separation between namespaces,
like preventing the observation of mount creations in other
namespaces.

Does a global number make any sense?

Thanks,
Miklos
