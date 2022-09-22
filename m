Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB1AC6FA8B
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Sep 2022 19:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiIVTH7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiIVTH6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Sep 2022 15:07:58 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5486EFFA5B
        for <linux-security-module@vger.kernel.org>; Thu, 22 Sep 2022 12:07:56 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1225219ee46so15290724fac.2
        for <linux-security-module@vger.kernel.org>; Thu, 22 Sep 2022 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2E/C7DbYFbgaIr08r5WQJJ8lH65h8Rlpzk3fsg7D9e8=;
        b=Sc2t84MYNifRdpTZz6LHCdTHbGpHtePPoew2qsdF9HHe8gStsU2qKwHjLQmE1+oPPg
         I1EurkRBUsiV216mZSYCjX649kwgi5p9dGPj50oSNxaH8t9N5Lyt/GsKj+zklmLR6qEr
         6R4aHXhiCm/iktm0j/EoGmNd0poPj6lF+d3aisz2dZom3AWJS8ZfcYs8qIfw2l7FOMBe
         HWJ3KinBwLAunUH38CmELQ+uYEnv7YZf9KTUM3+NhHM3aV3rTSVddlmYen3IgFOvDILn
         1pehVy8LfZjvBTsHHkBR3BUiOkMUko7Ppki5o5o9Li47YyyXPlz3/ARUMXM7puPuP26M
         yXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2E/C7DbYFbgaIr08r5WQJJ8lH65h8Rlpzk3fsg7D9e8=;
        b=IPjUvpbmEuo4lO6RbLoJSqjqyyexISdgTbIWKHdXW/W8ZdombTQejxlrWF4xdPq67j
         jr7MyLhsacvv/PKM9vPNZHM/0NqaLSQ9EbDF/FIeWOeqruzpWu++m0/nskEomcizDz8H
         AJB2PQliIQ3saWsjGK57r2kxrSkD/Gq9soMyfLAw8FDCdQgP9Id9yOy9dY6AEQD00SE3
         eWzXqtMlC0XhL0bHZNbmzEgA/HwE4pHc/eBMLoWTJ4tm76819OICZKYMihZ8f5XvuTi7
         MYpRmWGbgGnxndjI9s3jYt7I+VUgVDDtjETQD6JOZIcYQdcqHJHDkJIxiaDmfVojdSma
         LYuA==
X-Gm-Message-State: ACrzQf2KITT2RbPCMqddLqmBjTAN6T4tKop/BoacPlo43SxYWyKfKS8q
        gOGxyx3BRkvzhWGYkkhstU+5oXRJKwsGb4wjAMuu
X-Google-Smtp-Source: AMsMyM6d9RAgQ5lrUQAwZbu3DJT1/UNg9egieC9LHbxthXW7OebfrM1G5JLCjS1iPUbSyY1utPnUyQOKNNFWojmurr0=
X-Received: by 2002:a05:6870:600c:b0:12d:9e19:9860 with SMTP id
 t12-20020a056870600c00b0012d9e199860mr2966449oaa.172.1663873675323; Thu, 22
 Sep 2022 12:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
 <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com> <16ca7e4c-01df-3585-4334-6be533193ba6@schaufler-ca.com>
In-Reply-To: <16ca7e4c-01df-3585-4334-6be533193ba6@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Sep 2022 15:07:44 -0400
Message-ID: <CAHC9VhQRST66pVuNM0WGJsh-W01mDD-bX=GpFxCceUJ1FMWrmg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/29] acl: add vfs posix acl api
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 22, 2022 at 2:54 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/22/2022 10:57 AM, Linus Torvalds wrote:
> > On Thu, Sep 22, 2022 at 9:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Could we please see the entire patch set on the LSM list?
> > While I don't think that's necessarily wrong, I would like to point
> > out that the gitweb interface actually does make it fairly easy to
> > just see the whole patch-set.
> >
> > IOW, that
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/log/?h=fs.acl.rework
> >
> > that Christian pointed to is not a horrible way to see it all. Go to
> > the top-most commit, and it's easy to follow the parent links.
>
> I understand that the web interface is fine for browsing the changes.
> It isn't helpful for making comments on the changes. The discussion
> on specific patches (e.g. selinux) may have impact on other parts of
> the system (e.g. integrity) or be relevant elsewhere (e.g. smack). It
> can be a real problem if the higher level mailing list (the LSM list
> in this case) isn't included.

This is probably one of those few cases where Casey and I are in
perfect agreement.  I'd much rather see the patches hit my inbox than
have to go hunting for them and then awkwardly replying to them (and
yes, I know there are ways to do that, I just personally find it
annoying).  I figure we are all deluged with email on a daily basis
and have developed mechanisms to deal with that in a sane way, what is
29 more patches on the pile?

-- 
paul-moore.com
