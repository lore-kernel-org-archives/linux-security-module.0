Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F3DC54EE9
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Sep 2022 22:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiI0W4C (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiI0W4A (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Sep 2022 18:56:00 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167BB7B7B4
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 15:55:59 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id c13-20020a4ac30d000000b0047663e3e16bso1484163ooq.6
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 15:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hUrOAFbv1WvNS5nfnfXalDada/2jFqZVwG5+2XwNmSc=;
        b=C9djtUXltgc9jbueR7CK87UTwddCNQ5TDMKibMzfv8y8wvYzjiRfBQxtp945GEUV62
         ZRa/jhTjsgBJP1ZQaCjvsQLN7kLyrJWSz6QRW2rj891L6NEYAQOil5ybmr9KsX7kG3aL
         5nOvluzDlavQ2AuTqvHIeI1t7SVz009bYwTWwViFeAq0KeL5G8fVXLSjoVPo2P72O2xE
         SzZ0GqEmoewxinei9P/FWpAGdmpdGfENifXvX4PqnMtgqcWkkWznhXxqaZ9HX2Ujh4CY
         XUE40fVA6lV/0wQYiR0hkbzXXjlUl5dHr16FL50/td0ckiEEJvSNJelGLSY+Es70+G1e
         GlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hUrOAFbv1WvNS5nfnfXalDada/2jFqZVwG5+2XwNmSc=;
        b=gIIIjFYcd7KsgdElLkAbbF5DtXWayVALxHE4ybfVEthAS9CUOgerjAfCmz07DlBuvu
         UIhyTpNnoRTG/oWn5k+LpVRf9LJ55V7EOV9CdnidSLNqm6QrcRzNRO5Nm/rt19SA+7zq
         wugHpAQ9+gpVzNx0SFK6vqv7JrizL5RwSxnDjo2KSphswgPX0vWstgJM8eoGbR/wTDqG
         JlGU/V9/QMsYYrZk7JKlG4UmNw7Vq2czDAOqOsPWkX+ISW45b/9GTW5dTadyioiLd8Sf
         ziwPOcFUYgu2oJpGTJNTgRWK1gAaRvsrmhqQug4U5GZtLYGEqYKL/ZZCHY8Vcp4f4HGr
         lZqQ==
X-Gm-Message-State: ACrzQf2PAG6FVF11fqwt+1va+QZqhePboXZ5Ddtthj2o71LtIreNnQgS
        bQvvBvyW5DwCbWhKP/fCzUpyrAsosHponcQueaf/
X-Google-Smtp-Source: AMsMyM4bDoBsixmmiED5RnENMcZyUPcGAxLyjmWn71+0jIWqgq78v3sUmmq0rWfUf7dNRccqVysH7AGWm1s5lIApbhQ=
X-Received: by 2002:a4a:c10a:0:b0:476:4a59:4e4b with SMTP id
 s10-20020a4ac10a000000b004764a594e4bmr10662488oop.24.1664319358344; Tue, 27
 Sep 2022 15:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140827.142806-1-brauner@kernel.org> <20220926140827.142806-11-brauner@kernel.org>
In-Reply-To: <20220926140827.142806-11-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Sep 2022 18:55:47 -0400
Message-ID: <CAHC9VhR7J=8Odk4ihg9ir6kouJjiVm8Tq2zvRjLGxrkpEwPmXQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/30] security: add set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 26, 2022 at 10:09 AM Christian Brauner <brauner@kernel.org> wrote:
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
> In the next patches we implement the hooks for the few security modules
> that do actually have restrictions on posix acls.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/lsm_hooks.h     |  4 ++++
>  include/linux/security.h      | 11 +++++++++++
>  security/security.c           |  9 +++++++++
>  4 files changed, 26 insertions(+)

The only thing that is really absent from the new hook, compared to
the existing security_inode_setxattr() hook in the ACL case, is the
EVM hook which looks to be addressed in patch 13/30.

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
