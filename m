Return-Path: <SRS0=sUyx=4Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41984C3F2D2
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Feb 2020 15:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B06246AE
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Feb 2020 15:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="layGR74o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgB1PkB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:40:01 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:43384 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgB1PkB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Feb 2020 10:40:01 -0500
Received: by mail-ed1-f42.google.com with SMTP id dc19so3799279edb.10
        for <linux-security-module@vger.kernel.org>; Fri, 28 Feb 2020 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxXDJZ7f6H00ez0+mALJX7AbbRdlX/cGNEAILCClU4Q=;
        b=layGR74oZe0zK+z+s/MzdlOErm6fqV8udwcAVkyvlVtJGbU3LQZdbrW7YDDQR3xxX1
         +ArizJjpudd3M0ZYiUbV/lqOWL1wkYnL9d+0zqmlYnRe0kgJ4rraXd0aLjdYQsS8lwvd
         7fpR8mQhuxucuQU93Ddv77XsE50ikrb7M3gn+440lAvDtH/GOvJbL39j3MQdb3kFOFRW
         8EyLoE03svJRwB0yjBBGLw04S7LA+xxKumGZLiYNXTy0XlpkgIn/G1f0TpjaZGdr+5mj
         RZRUePsg7w5VdRvVNikPn6MDhdkowEPfMciZviTHbK4oiOr4dTKidvY65ec0yLuMXCep
         ICJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxXDJZ7f6H00ez0+mALJX7AbbRdlX/cGNEAILCClU4Q=;
        b=IxFVD05CSw0VSn7tgFEoOARuhiLZTh5rxM86LJfTIIK2K2hBxvRO68IjoGDDdR707A
         RhzsNFzOkrYmiZABf41OxVdl2iEiCmM9hBQ0QdtXzMA6pjVk4wyOQjSCrqdSYY+NCWVL
         GTFGAwN1hZ4CooZWIojJK/ajJv9PMxuPY9GH8DVPvfqENC8FL894ZJ9mfbTdfZLQFA7U
         EEBCnIaobTWfshHzsbFyp8AroIfPuuYLuNC3HlNVnB1AdPV/ZTlO2e+WQesuUR3E5l01
         G0vreGNc8yoCHpDkej8lQd92MLyinWnH8X59WajNWiuSaI+9W+Zg7yF4otwmSVhT3daw
         FSbA==
X-Gm-Message-State: APjAAAWZNx/wpayPK1MnYzLoCOWZ+z1cuB/wDxeZLQBsXBUbD9RiTp1L
        DQI2nkZGMmbvCacWeP82PqmKwzSEsSUA9/FKHJeW
X-Google-Smtp-Source: APXvYqzPXJdkmRSSXKy8sLFVHAoz7nCVQDueiBs/U4am/5vjpTX96878W7/2eekHamHsI+GLYOxe/wa3wvRwJueXQDs=
X-Received: by 2002:a17:906:f251:: with SMTP id gy17mr4577220ejb.308.1582904398494;
 Fri, 28 Feb 2020 07:39:58 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhQ=W4R2LGCxaKzVEx4J31m4-F7mDo2BOMTqso2JdScHzw@mail.gmail.com>
 <101039.1582904234@warthog.procyon.org.uk>
In-Reply-To: <101039.1582904234@warthog.procyon.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Feb 2020 10:39:47 -0500
Message-ID: <CAHC9VhQ_ajha6my_9aksXWhiT+nMs7P-P5sxmV_eXTm37b8fgA@mail.gmail.com>
Subject: Re: Please revert SELinux/keys patches from the keys linux-next branch
To:     David Howells <dhowells@redhat.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 28, 2020 at 10:37 AM David Howells <dhowells@redhat.com> wrote:
> Paul Moore <paul@paul-moore.com> wrote:
>
> > For some reason we haven't been able to get your attention on the
> > related SELinux mailing list threads, but we need you to revert commit
> > f981a85690dc ("security/selinux: Add support for new key permissions")
> > from your linux-next branch.  Can you please do that?
>
> Sorry, I had to squeeze out a new version of notifications and fsinfo before
> disappearing off to Vault - and then I disappeared off to Vault.  However, I
> can do that now.
>
> I can drop keyring ACL patches for the moment and pick them back up after the
> next merge window.

Great, thanks.  For future reference, I would *really* prefer if
patches like this one went up to Linus via the SELinux tree as it
changes the SELinux kernel ABI (the keys and selinux next trees
currently conflict because of this).

-- 
paul moore
www.paul-moore.com
