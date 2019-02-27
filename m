Return-Path: <SRS0=eR/s=RC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB3AC43381
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 16:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9662184A
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 16:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m9W2RWrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfB0Q1i (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:27:38 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36066 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfB0Q1h (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Feb 2019 11:27:37 -0500
Received: by mail-vk1-f193.google.com with SMTP id v131so3989660vkd.3
        for <linux-security-module@vger.kernel.org>; Wed, 27 Feb 2019 08:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UxgEDS2CX/CMq20ylO8bSwgapXjZEgLgnN1+iXxgyB4=;
        b=m9W2RWrPGFU0kTqTwPbx+GS/q5Mx8/SrZWVqVUu8C80Blg3WUbNfEUbf5tZ6PRLnMC
         O157XHAgGDDe8lGhsXAz+Hq29Jh0lmImXqs6fp3BvDHfZGg+zNIZw6kkCZGkf1ZnirI9
         87XHcUujeiVyLzHMNcf3c+icWB7F6nxC2SD30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxgEDS2CX/CMq20ylO8bSwgapXjZEgLgnN1+iXxgyB4=;
        b=P0d8Utwd0Ff4Ugq4DbbwIO2XfdNbMXtL5FrI01edOpbtXjmyuHu1MD4f/+MA7Pu8PX
         eXDLNzmMxtJO5RyDn3LolCLh0F5O2tueFU58d0qzsxUh+BYXejrmny92W53R142N7l3s
         S/KnNCbpz0grnW2f+9wAxC9jgRT6UHn+XLChzKaLKJ/gDTAAyTPtS/0sp+ZuCMvbypab
         11wE6ZjrD2Ik2L0TWCeqtUhhlL5F5YCw5aUddcuckcRy8l8j4m3eRUmMT5vUtStsFoVu
         Qufcc8VYEWBuae5/0V2pjOWVMLWUaX58lkWPji+0zes5yIla/R98ZTp4xFTfh+t4yJPh
         icUw==
X-Gm-Message-State: AHQUAuagA3nmluQy8Gbj90wjbMvZkukNrWUNxOJh5ivjxKN9nhjRLjQ6
        o3cQ75uBe4naXGvMYJ6pwU5JMZzGQcQ=
X-Google-Smtp-Source: AHgI3Iadf3oikD8vc6K4aMNjK5uTBmINLlGOyoTK7n2vsmZF0cOpNUXEElYyImFl8Px3ImKZ9UdIUg==
X-Received: by 2002:a1f:24d3:: with SMTP id k202mr1073677vkk.45.1551284855621;
        Wed, 27 Feb 2019 08:27:35 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id f188sm4857128vkg.11.2019.02.27.08.27.31
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 08:27:32 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id u1so15162697uae.12
        for <linux-security-module@vger.kernel.org>; Wed, 27 Feb 2019 08:27:31 -0800 (PST)
X-Received: by 2002:ab0:2712:: with SMTP id s18mr2507403uao.114.1551284851047;
 Wed, 27 Feb 2019 08:27:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551213058.git.efremov@ispras.ru> <CAGXu5jKzDi42Hazh7JsPQpzH-xdQQTQ+oD06Bb1N6tbYzB3uuA@mail.gmail.com>
 <35a7a5dd-4478-1dc2-5966-c974196f8c7a@ispras.ru>
In-Reply-To: <35a7a5dd-4478-1dc2-5966-c974196f8c7a@ispras.ru>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Feb 2019 08:27:18 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+s7k=nai-ZaMo_526OBBmzNosZ2Dxmjk5LXNP06XJ4Rg@mail.gmail.com>
Message-ID: <CAGXu5j+s7k=nai-ZaMo_526OBBmzNosZ2Dxmjk5LXNP06XJ4Rg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] LSM documentation update
To:     Denis Efremov <efremov@ispras.ru>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 27, 2019 at 7:10 AM Denis Efremov <efremov@ispras.ru> wrote:
> The rest of the warnings are about undocumented hooks. This patchset
> fixes the existing documentation. I will try to document the hooks from
> warnings in a separate patch. Some of the hooks are trivial enough, but
> others require me digging into the code and mailing lists. Can't promise
> to do it quickly.

No worries! What you've added already helps a lot. :)

-- 
Kees Cook
