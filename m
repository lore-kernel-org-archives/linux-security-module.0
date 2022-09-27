Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7702FC6FA82
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Sep 2022 22:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiI0W4r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiI0W4f (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Sep 2022 18:56:35 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F76BE32
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 15:56:34 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l5so1272399oif.7
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 15:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=q+xDxX7qmN9tVFy6Qbnf6RhZgrUGdrMIItYPApeCEC0=;
        b=1ZXYUkDnVURiom08uKHLSA5+rtDUISo4yRw96IG01vyClHrAXUQVOf7PjH9MlpEmxL
         KkCH4/K24t6FJtgqqSTpKpRES8SsrA3dfvujUORz9aSJVfWPYF24HXF2Ik8OvBZTRikZ
         robx/1UzSG6mRQAU32zvgZUXHurmKElEGkTC6safkLbLKEGLQ0/6z+QAvLcnGgbal+0B
         I11gYUNiDldQeZxb0hTip20n35Q/fALOSMoqYFiVHZ/GQY1G7SDOcHMt7TXFVS8Ntld+
         OvS+Y+bsYW8EAJ7bk/0SG89Ub91azW8++FuB+W041+8WnmTvVWYsV2ZMOMYgZCYSQlyk
         isrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=q+xDxX7qmN9tVFy6Qbnf6RhZgrUGdrMIItYPApeCEC0=;
        b=hZhTb5TkwjCVFl70BLGI918uSYnZiGZI/ZCNhC4vbWEdkct4ylusvGQ15AuouLKbPO
         PtU/k143qnPJTwJk+h7xOSynIIYLapEzbFCAoOFRE+jqAdaR/m0cHWps+im7shnjnwAr
         PE+oNZhb1pl+ueWj5CCG0SR6q/G7hTlBBbmTj1tsvbNXVfmfsnCf16CdN4NTUGAg0tEg
         VJPtPm4Siv3b0PuBpPekHRxaiscfEzBChbtknvM4JIWW31sgUxMIAebSusj5SC328fcn
         7aiCoLReiEwiVRebvzV1xxFWvOjBxqWeiEAXF1mrgBpZ/NkEhAa89Fj5plTf9zDKlpab
         B/oQ==
X-Gm-Message-State: ACrzQf3ySvI9Ulzk6nioTevMP+fTWk0iXQOlKOboRvtJbF+RkBO9vT/d
        ut0nGTkFeP3e8nKm84jhtCUJkMksKGJ0ds/2PLK6
X-Google-Smtp-Source: AMsMyM4uDEhU679gy+uhjiz0T2Z4eFZWowxJhwyWagjTWMW+wH6FVSlx10lQaS9Psmn2CwpD1PXntGaTSifFnovm6/w=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr2982274oiv.51.1664319393572; Tue, 27
 Sep 2022 15:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140827.142806-1-brauner@kernel.org> <20220926140827.142806-15-brauner@kernel.org>
In-Reply-To: <20220926140827.142806-15-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Sep 2022 18:56:22 -0400
Message-ID: <CAHC9VhSBoUOhKFeqST-f1Hvmii7gZ+ip-8-Loe8guJTTV7hdag@mail.gmail.com>
Subject: Re: [PATCH v2 14/30] acl: use set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 26, 2022 at 11:24 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The current way of setting and getting posix acls through the generic
> xattr interface is error prone and type unsafe. The vfs needs to
> interpret and fixup posix acls before storing or reporting it to
> userspace. Various hacks exist to make this work. The code is hard to
> understand and difficult to maintain in it's current form. Instead of
> making this work by hacking posix acls through xattr handlers we are
> building a dedicated posix acl api around the get and set inode
> operations. This removes a lot of hackiness and makes the codepaths
> easier to maintain. A lot of background can be found in [1].
>
> So far posix acls were passed as a void blob to the security and
> integrity modules. Some of them like evm then proceed to interpret the
> void pointer and convert it into the kernel internal struct posix acl
> representation to perform their integrity checking magic. This is
> obviously pretty problematic as that requires knowledge that only the
> vfs is guaranteed to have and has lead to various bugs.
>
> Now that we have a proper security hook for setting posix acls that
> passes down the posix acls in their appropriate vfs format instead of
> hacking it through a void pointer stored in the uapi format make use of
> it in the new posix acl api.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>  fs/posix_acl.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
