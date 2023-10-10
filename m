Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F29CD80D2
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Oct 2023 13:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjJJNfD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Oct 2023 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjJJNfC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Oct 2023 09:35:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F63DE
        for <linux-security-module@vger.kernel.org>; Tue, 10 Oct 2023 06:34:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53447d0241eso10124979a12.3
        for <linux-security-module@vger.kernel.org>; Tue, 10 Oct 2023 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696944897; x=1697549697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YWUC8y8l3yNsmutyYm6vcX2/BBN8tUeuIPKvPzyLwRk=;
        b=oHgX8gFY/7p1cowP3/MkjeksfTpy02cbyXHVaMtjsdS4VWPRRpzZ12ZBt+WIcXPloG
         rlVuU3WLXVYA39JR0tbwEM/dOoQhyagi+1wXhCNeUGNAGJzILElEqgTKsefkD7Wsw4u5
         8FrmM22Rjdwr9NaCJKs4hV5LM1fAHk7hSvFp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696944897; x=1697549697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWUC8y8l3yNsmutyYm6vcX2/BBN8tUeuIPKvPzyLwRk=;
        b=G/GFi0cztcpDODaODfx92zdOticgV5JKdnoYlKB8EA8ID4qsflxoUj8sbrh/wCBEhD
         5GDTCAzOn3eS1v1KUgljJu1YIXnWlT0AOa1O1yfAE6+eQ55y33ruC+P7blcgDz2UmkSd
         OH1lAlECyId0YHGek7iAWU9sjybOqvHjwjt3yqauUdy58Lny391rTvsCbJP449RbrFQC
         e9iqymWcqEwH0AHeSNfiQrzJ0IHJP2W/tcGemoxAB4+5xmrRZyClakEv26aMjeLa7Bp7
         M9EVCmS7aHk4GfRwN3s/SdD9LOC1ScMs6aYq3GasBUbA4CZ//5iYrG0/ad64qFqobmSf
         XMfA==
X-Gm-Message-State: AOJu0Yzl5NdjFrXGvTkaYQAXzC8I66bnKxyBFePNwvQNfX2pJCLEFVmq
        njG6NHv+zD9CA9ZC6aK3snwoKaMm3Q9J2JPRx4Pdyw==
X-Google-Smtp-Source: AGHT+IGwMUdcL/W56HSslwNCKmz+C7aJVFJrM4duK0etXFNSbx8bpp8Q7QWmQJHZRD0TzXnKmcbSoWRwvRSilSrZm0Q=
X-Received: by 2002:a17:906:3004:b0:9ad:8aac:362b with SMTP id
 4-20020a170906300400b009ad8aac362bmr13751511ejz.23.1696944896972; Tue, 10 Oct
 2023 06:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153712.1566422-1-amir73il@gmail.com> <20231009153712.1566422-4-amir73il@gmail.com>
 <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
 <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com> <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com>
In-Reply-To: <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Oct 2023 15:34:45 +0200
Message-ID: <CAJfpeguEf71ZknP5rGU9YNtJTp1wBGBKyv6M0JZ=5ETuaipDxQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 10 Oct 2023 at 15:17, Amir Goldstein <amir73il@gmail.com> wrote:

> Sorry, you asked about ovl mount.
> To me it makes sense that if users observe ovl paths in writable mapped
> memory, that ovl should not be remounted RO.
> Anyway, I don't see a good reason to allow remount RO for ovl in that case.
> Is there?

Agreed.

But is preventing remount RO important enough to warrant special
casing of backing file in generic code?  I'm not convinced either
way...

Thanks,
Miklos
