Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEB2C25B6E
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Oct 2023 13:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjJXN6T (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Oct 2023 09:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjJXN6K (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Oct 2023 09:58:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954022711
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 06:57:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9becde9ea7bso1173663366b.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698155877; x=1698760677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CFq2Fg3zVAnOrmEfLn53FQxN7jmqeIO+YSPDEZIOjqc=;
        b=dBGQjqFyfkxCERh0ht6T4zHtOMCIAEEElWD0aSCE56alg9Tf21JyvwveX0xPtdPfJM
         2lNl7cJUacZQZfQsx6uluR+8JzJ/pMrkSihbCje0m4cS3jM8oLrrlfpDYCiy6VeP+X72
         nsEYRXs8dvXwPwr3u5i/31goOMOKzmLc8zBag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155877; x=1698760677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFq2Fg3zVAnOrmEfLn53FQxN7jmqeIO+YSPDEZIOjqc=;
        b=BugkDuayjckFxLizFZLjNqOTBfwSUt+kkPzPBYwtjw6tGUiSvU6osfZTtJxLJDlRbM
         c3IVaAz+G4Cvvo7QjpK3fpqi2NlpPJls66FyFPODPUh9+8KYczlDzMLDxmSXzJTNWXjO
         fyCha6ySmzwYTzhI4TtmVd8ZkBckJUyRK6FUi1g6CR2RiuSvlR9Vb0/G26Aa8hm1GTJg
         JCsBm2CpIMqDbyB3erzAEIGH/IOZ/9NUfCXinMspRV7cZIateK7umQ9ofVGRWrsRcESJ
         rNXXcXOsUagWlvYNJHBNVzaK2RYbP4+2LRqUaWqY0cmztlFHU2tfvRpc6Ri2x7gYIAUS
         XJlA==
X-Gm-Message-State: AOJu0Yze2AWkhWhbDhf5HZuViTca9yEpiE853IoXiJpJsKX5zTPyZdsv
        LynN/ftuDvi1B+7jaiG6G9k80Di9Ue8q7yokk2V8uQ==
X-Google-Smtp-Source: AGHT+IEV11aVuDatR+GsbiTzkdam4eLmDzs7DndyyWqozB2d9zhCaHb3NdyEF13kC/pQx/zoObUqvAUWAIwVd1XT2cQ=
X-Received: by 2002:a17:907:94cd:b0:9ae:614e:4560 with SMTP id
 dn13-20020a17090794cd00b009ae614e4560mr9998911ejc.29.1698155877064; Tue, 24
 Oct 2023 06:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-5-mszeredi@redhat.com>
 <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
 <CAJfpegsPbDgaz46x4Rr9ZgCpF9rohVHsvuWtQ5LNAdiYU_D4Ww@mail.gmail.com>
 <a25f2736-1837-f4ca-b401-85db24f46452@themaw.net> <CAJfpegv78njkWdaShTskKXoGOpKAndvYYJwq7CLibiu+xmLCvg@mail.gmail.com>
 <7fe3c01f-c225-394c-fac5-cabfc70f3606@themaw.net> <c45fc3e5-05ca-14ab-0536-4f670973b927@themaw.net>
In-Reply-To: <c45fc3e5-05ca-14ab-0536-4f670973b927@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 24 Oct 2023 15:57:45 +0200
Message-ID: <CAJfpegvTFFzCN9nssL0B6g97qW5xbm6KsrFPRqtSp5B1jaYbLg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
To:     Ian Kent <raven@themaw.net>
Cc:     Paul Moore <paul@paul-moore.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 13 Oct 2023 at 04:40, Ian Kent <raven@themaw.net> wrote:

> But because we needed to enumerate mounts in the same way as the proc file
>
> system mount tables a flag FSINFO_ATTR_MOUNT_ALL was added that essentially
>
> used the mount namespace mounts list in a similar way to the proc file
>
> system so that a list of mounts for a mount namespace could be retrieved.

Makes sense.

Added a LISTMOUNT_RECURSIVE flag.

Thanks,
Miklos
