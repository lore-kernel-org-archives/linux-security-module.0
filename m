Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFF3C433F5
	for <linux-security-module@archiver.kernel.org>; Thu,  5 May 2022 14:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379253AbiEEODp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 May 2022 10:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiEEODo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 May 2022 10:03:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD423617E
        for <linux-security-module@vger.kernel.org>; Thu,  5 May 2022 06:59:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a21so5335130edb.1
        for <linux-security-module@vger.kernel.org>; Thu, 05 May 2022 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cdP+QQ3RkXNjtwvBi4VN1FsvGgtTlKBfCuL8UUAtAI=;
        b=E8qBemq4oTx4YPbWRWMJzV2qIbcvYOdveNbfeZemz+4dZQ+I0m7fLXmsY75j+/wiX5
         XaE1LThAuxmxZgvbTboIF71ZZ5XDfPUtgSQz8ZVQ2PL1AE4CxYt/PmItFNePGMLFoNgb
         A8tRUVmKiVc6KZIJU/kk/0DlACH0+77UO+Qz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cdP+QQ3RkXNjtwvBi4VN1FsvGgtTlKBfCuL8UUAtAI=;
        b=RioeaS6kB8XfK7H/MEIcOQWIIT7jkD5+QT+GHCAFmVj/QGUbm3iK9I1z2RoylpEGE9
         OAlG2ZXLg+EYfOatrxS0R4HwEa7RdR5kZKooYRtqwHEMbsyCgCmEkkmZ+6s9xieh+I2v
         3lnmRgD5eVoLKLD+HUb6jOvcF4O/i+Q/qNY4+8Eqyi/6JYdgbdfsuSR1S05I8H0gvUaw
         XxIRSMVD0+Ha+P3FRsI/M9JWTnYnCIUTfa178BlD9GjoCZmF++Pk7N7SxjaMqCXmE+Iz
         kHKJ3fDwy2290aYtQpUrEDeEFdaFK+rEVQkhaciWyCAk2P/aZ3m3uINK0D57BbGPyOWt
         EF5w==
X-Gm-Message-State: AOAM530EBLsU8PsTkxI6McRxsvGyvn8Ld6ivaa0bCwS5jkF1eXPO5WGc
        F3p5CUA0+0We69zeKhoqtANCYOKIGkLAJTlBOC2tcw==
X-Google-Smtp-Source: ABdhPJzTe+CDKCcscUgOgvXLSyK5NVYs7EmJWj3tio4m59arkqFAPKBq+XxNeijdGRs92739wL1GOOxDMjNo+9z+bh8=
X-Received: by 2002:a05:6402:5ca:b0:423:f330:f574 with SMTP id
 n10-20020a05640205ca00b00423f330f574mr30384732edx.116.1651759197275; Thu, 05
 May 2022 06:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220505123033.sgcyx7kfl4kcfcds@ws.net.home>
In-Reply-To: <20220505123033.sgcyx7kfl4kcfcds@ws.net.home>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 5 May 2022 15:59:45 +0200
Message-ID: <CAJfpegv2asQoevG992+1yruSrmMus57CoQ+=Cssf7O50FhyJyQ@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 5 May 2022 at 14:30, Karel Zak <kzak@redhat.com> wrote:

> Is there a way how to get mountinfo-like entry by mount ID for some
> sub-tree? Something like:
>
>  getfattr -etext -n ":mnt:info:21" /

Yes:

getfattr -etext -n ":mntns:21:info" /

>
> The interface has to be consistent with some notification system (I
> see your question about fsnotify/fanotify at linux-fsdevel) and mount
> ID seems better than paths due to over-mounts, etc.

Right.

If the mount notification doesn't fit into fsnotify well, the original
patch from David could be used.  I think that part was
uncontroversial.

Thanks,
Miklos
