Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ED8C4332F
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Oct 2022 19:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJRTSJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJRTSI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Oct 2022 15:18:08 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0515A8A3
        for <linux-security-module@vger.kernel.org>; Tue, 18 Oct 2022 12:18:07 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3321c2a8d4cso146817217b3.5
        for <linux-security-module@vger.kernel.org>; Tue, 18 Oct 2022 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fI1gzC8xPWpWaBXSivcFsCeh1hj05+5Sc3zxFpnbpSg=;
        b=M14+eL0EvuPm/IWlMSAwbARSaMRt1HpphND1sfL5szRa/CePSaVcmJVeJYqXJxIok/
         /P6U5+ok0/ICNCJ1KQqqIRivDUrSoXBtsxZhUTXRNTA1zU92bL6MW1gdPuejIhGPi/PV
         4whaXp5Ue8p8SP0VHrOo2HA+mPsyrxeqj3SsmQvnbX2nXOiD/eLIawz8Ap4H7WYrU3y5
         XdDsHt8xz+xyatX8yFoh1zuwr4daVOM3b9WD53+IQp7HI7GewLuFxD2X3IwXJN2YGuhZ
         X9mVXdYP/ALouctzrqtuGVwaqCl1S1ZVmxOgTVqv0niSunkZGZrQ7LW2+Z8rXEvlbiO7
         5B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fI1gzC8xPWpWaBXSivcFsCeh1hj05+5Sc3zxFpnbpSg=;
        b=Wr4f4bYr3+DlXXeSpINER+Q4iOL5fVhJrpvy7/c2oduIT/UprrElp5jV13CT/igDhP
         z/aFYomaqi7TFvLlx48XwQSi1lGhyydMdfespcMg/XLNAPjoWLLGmEq3YDgryvxrC+T9
         URzaBHMxWaLL2+eS7VgX7oZbb5dPrD38g5MM57u51pqf/CNchXc+cf8ZTw4+zgo14tfk
         H1IWD3uTty6HP0dvRmqbNzENWYUjxa2RoVwfvSdsyojBBwd0KPH95rPHTgQPVpdqWcHz
         +0yD1MZzOHysOIcPxCOAQbspY6CXPdUjHZV42EDOq7ZV5CwrrKjr7jMewGfkC6e/oF68
         WNFQ==
X-Gm-Message-State: ACrzQf0LjIyP+Z69dhat1V7AOK2SlXYeFnCAq4jzjgm3FgT1yXXj58EP
        Kc3v/9uiPbWTz6PCgDVIJ9tmPIvONtp7av0m9eMl
X-Google-Smtp-Source: AMsMyM7+dHNsBB3+ydXo/JLHGHk4DuSLixHESZmorA+6Riams5t44qD9LsNjutfi92NNy1hJjJzTUb6uhoSMXlQr41A=
X-Received: by 2002:a81:a141:0:b0:35f:a727:f27 with SMTP id
 y62-20020a81a141000000b0035fa7270f27mr3917543ywg.205.1666120686281; Tue, 18
 Oct 2022 12:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221018115700.166010-1-brauner@kernel.org> <20221018115700.166010-13-brauner@kernel.org>
In-Reply-To: <20221018115700.166010-13-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Oct 2022 15:17:55 -0400
Message-ID: <CAHC9VhSWymFrrV2Zu3isAivuZMvgBxagkoDg3vLGDOww=Y8t_Q@mail.gmail.com>
Subject: Re: [PATCH v5 12/30] integrity: implement get and set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 18, 2022 at 7:59 AM Christian Brauner <brauner@kernel.org> wrote:
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
> vfs is guaranteed to have and has lead to various bugs. Add a proper
> security hook for setting posix acls and pass down the posix acls in
> their appropriate vfs format instead of hacking it through a void
> pointer stored in the uapi format.
>
> I spent considerate time in the security module and integrity
> infrastructure and audited all codepaths. EVM is the only part that
> really has restrictions based on the actual posix acl values passed
> through it (e.g., i_mode). Before this dedicated hook EVM used to translate
> from the uapi posix acl format sent to it in the form of a void pointer
> into the vfs format. This is not a good thing. Instead of hacking around in
> the uapi struct give EVM the posix acls in the appropriate vfs format and
> perform sane permissions checks that mirror what it used to to in the
> generic xattr hook.
>
> IMA doesn't have any restrictions on posix acls. When posix acls are
> changed it just wants to update its appraisal status to trigger an EVM
> revalidation.
>
> The removal of posix acls is equivalent to passing NULL to the posix set
> acl hooks. This is the same as before through the generic xattr api.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>     /* v3 */
>     Paul Moore <paul@paul-moore.com>:
>     - Add get, and remove acl hook
>
>     /* v4 */
>     unchanged
>
>     /* v5 */
>     Paul Moore <paul@paul-moore.com>:
>     - Move ifdef out of function body.
>
>     Mimi Zohar <zohar@linux.ibm.com>:
>     - Fix details in commit message.
>     - Add more details to kernel-doc for evm_inode_set_acl().
>
>  include/linux/evm.h                   | 23 ++++++++
>  include/linux/ima.h                   | 24 ++++++++
>  security/integrity/evm/evm_main.c     | 83 ++++++++++++++++++++++++++-
>  security/integrity/ima/ima_appraise.c |  9 +++
>  security/security.c                   | 21 ++++++-
>  5 files changed, 157 insertions(+), 3 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

-- 
paul-moore.com
