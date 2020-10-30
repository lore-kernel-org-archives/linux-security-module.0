Return-Path: <SRS0=b0TY=EF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACBFC56201
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Oct 2020 15:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267D72071A
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Oct 2020 15:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FDk8YZ+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgJ3PHN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Oct 2020 11:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgJ3PHN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Oct 2020 11:07:13 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9ECC0613CF
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2020 08:07:12 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id s144so1526450vkb.1
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2020 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qezUIHlvY9fFOmo2+xA2K+Ux6IJAtG5C7ju4HZIADck=;
        b=FDk8YZ+1U0Xp/Ygw40EpV0XeoQqT33eCNWvzOPeOzuhtVGoPz8+inv5IWSqFU5QEQb
         fbZH8kjd/7GZgBHweJS80LprkSJvRuThB5A2PYwcRJ19ifGSQ+mXOsFOxCp0TrHprMN8
         Ow0nVKYl2sgjqAIi19jAw5kAX//XFX1+xWk6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qezUIHlvY9fFOmo2+xA2K+Ux6IJAtG5C7ju4HZIADck=;
        b=bQ6a53HNX/Udu6w/bU4bj8Dcbm1TEb8tWV20JBCoa3JxgA/v1ULPK1w8CUfa7axZTa
         TnmY+lPKwv0ucg0EIse45BXRWNYpolW3c2R0Gt9m86dEj7l44LcGPdDPG3TR8GXIXCsG
         7Y7u6esGgDuyHo/JZS/8E+uACI3cKCov9b2/aVFbFuHCq39dL596UFlAHtvbRtIyOg1b
         rqxjxCK0EtwI9GTSjrvnSAJRQI11NCNRIgkfqKx5PSPzWbmbr6K8urJHQOnd97wauSbx
         jarMMRF3R0TzhW9IL4P+mLMsf65BSYGYQkNdef/XwvT2plsciEIXRuLm2UCFgs9x2Gr1
         gMGw==
X-Gm-Message-State: AOAM533YmMX+V3O9vj7qGnZI4cfPMddafsZl6ZhMfNn7hDxFBC+XoDF+
        HRp5XCHEQnG16Cci5Aix8UVaJD2l2GaUrg7mgLqtyAW7S5o=
X-Google-Smtp-Source: ABdhPJw6zBNZsPXoxIh2VrRKYWDLkA+cMVV5G3SLLuH30LfxgNrHG7rsMDRqvHz08mcMwgVJkAuegVhMmIf8qGqUmJE=
X-Received: by 2002:ac5:c80e:: with SMTP id y14mr7299032vkl.3.1604070430985;
 Fri, 30 Oct 2020 08:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201021151903.652827-1-salyzyn@android.com> <20201021151903.652827-3-salyzyn@android.com>
In-Reply-To: <20201021151903.652827-3-salyzyn@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Oct 2020 16:07:00 +0100
Message-ID: <CAJfpegtMoD85j5namV592sJD23QeUMD=+tq4SvFDqjVxsAszYQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 2/4] overlayfs: handle XATTR_NOSECURITY flag
 for get xattr method
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>, linux-doc@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 21, 2020 at 5:19 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> Because of the overlayfs getxattr recursion, the incoming inode fails
> to update the selinux sid resulting in avc denials being reported
> against a target context of u:object_r:unlabeled:s0.
>
> Solution is to respond to the XATTR_NOSECURITY flag in get xattr
> method that calls the __vfs_getxattr handler instead so that the
> context can be read in, rather than being denied with an -EACCES
> when vfs_getxattr handler is called.
>
> For the use case where access is to be blocked by the security layer.
>
> The path then would be security(dentry) ->
> __vfs_getxattr({dentry...XATTR_NOSECURITY}) ->
> handler->get({dentry...XATTR_NOSECURITY}) ->
> __vfs_getxattr({realdentry...XATTR_NOSECURITY}) ->
> lower_handler->get({realdentry...XATTR_NOSECURITY}) which
> would report back through the chain data and success as expected,
> the logging security layer at the top would have the data to
> determine the access permissions and report back to the logs and
> the caller that the target context was blocked.
>
> For selinux this would solve the cosmetic issue of the selinux log
> and allow audit2allow to correctly report the rule needed to address
> the access problem.
>
> Check impure, opaque, origin & meta xattr with no sepolicy audit
> (using __vfs_getxattr) since these operations are internal to
> overlayfs operations and do not disclose any data.  This became
> an issue for credential override off since sys_admin would have
> been required by the caller; whereas would have been inherently
> present for the creator since it performed the mount.
>
> This is a change in operations since we do not check in the new
> ovl_do_getxattr function if the credential override is off or not.
> Reasoning is that the sepolicy check is unnecessary overhead,
> especially since the check can be expensive.
>
> Because for override credentials off, this affects _everyone_ that
> underneath performs private xattr calls without the appropriate
> sepolicy permissions and sys_admin capability.  Providing blanket
> support for sys_admin would be bad for all possible callers.
>
> For the override credentials on, this will affect only the mounter,
> should it lack sepolicy permissions. Not considered a security
> problem since mounting by definition has sys_admin capabilities,
> but sepolicy contexts would still need to be crafted.

This would be a problem when unprivileged mounting of overlay is
introduced.  I'd really like to avoid weakening the current security
model.

The big API churn in the 1/4 patch also seems excessive considering
that this seems to be mostly a cosmetic issue for android.  Am I
missing something?

Thanks,
Miklos
