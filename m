Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD46C3F6B0
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Aug 2022 20:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351746AbiHSUMv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351747AbiHSUMu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Aug 2022 16:12:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7211810650D
        for <linux-security-module@vger.kernel.org>; Fri, 19 Aug 2022 13:12:48 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z72so4111383iof.12
        for <linux-security-module@vger.kernel.org>; Fri, 19 Aug 2022 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TWnGx0tsPzDsYWN5IvwyG0/F4n3/lHDuvrydVsnCdTg=;
        b=FamF99POPr6PtKGcfiAFaDyK/px9/QEUZ9jAWq0VuRMjBQuH/SIEycINUXdEisf8wJ
         GB5Fp0sV/9jsr8SHRoKkycJAodjombPVpppk1giNuh7jurYysChORzMPgyHKQdBRx6Yi
         bMQ8CZykRl92tAcPu+aCfb2R1BHuyiGBmYyICNbj6NOdCbqR0y056zBRI5sucULdSXWP
         iBSs6go4YjTUccStqlOuQrHTd0ys3ntGBcGxqR0SgI4W+Fz4sL7vOXN4324d30h8iu/T
         k8P9H+ggVIlKLOTUU3V6HrleaFRS/uGb9Vw8lQ57cl7kluTFPaNsmbjckIsP6sE3O2xR
         GObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TWnGx0tsPzDsYWN5IvwyG0/F4n3/lHDuvrydVsnCdTg=;
        b=l+ngTicScXDm2+34O+Wq8GsMEvxbEZbYWwwTGj3ShkD6WcIyCDlsviKfWYQO876hpQ
         8LVWxYZIToZnIqVy8d1ZA91UA/eaS+XwPM2vWVqmfXZMhzU7zZz9zzRqfDrmqaib3fRx
         RI7LP9U23UcLXd/n/PZ0YCbyNj2vQ8P1gu5UUihbd7qzRqKRCwFdAlLyrmQcdYVfqyd+
         SRWOrz3rwa1cvw0zOtgiupOEJlQ7Ip7v2EJcfKFyHO7Idr2RM2B2Z1Gu+NnfL/C1RhFY
         8BWV2546mRNWP2eSZQrcX+02O6FViyxTUsXxeeNRh+yblA0hmyKhY3JKFOxQAGpjN87n
         qTnw==
X-Gm-Message-State: ACgBeo2ulW/vX3pDWNptWesZmH7hUA6uEMMPg/vcKbaPnnOCXbq0/+Vj
        skYEjqkYdcC0M3X410d2Gxla9PEcD9CaeiSUl5vubw==
X-Google-Smtp-Source: AA6agR7vH6bU/CcMRlqauAdte2pei9jmt+xQRqGJlV8ch8ekID2WY8/GjnEURxqW3LnsWWhfJJAGPXkSfSDz0FeaHIw=
X-Received: by 2002:a05:6638:34a8:b0:343:4d0a:5984 with SMTP id
 t40-20020a05663834a800b003434d0a5984mr4292780jal.167.1660939967732; Fri, 19
 Aug 2022 13:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220817214728.489904-1-axelrasmussen@google.com>
 <20220817214728.489904-3-axelrasmussen@google.com> <Yv3bnouKb7242Ama@kroah.com>
In-Reply-To: <Yv3bnouKb7242Ama@kroah.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 19 Aug 2022 13:12:10 -0700
Message-ID: <CAJHvVcjd3GtjJ2yr0gNDGHCqc8RZUYXCYaj8eEgo1TTLBjNYSQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-security-module@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 17, 2022 at 11:26 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 17, 2022 at 02:47:25PM -0700, Axel Rasmussen wrote:
> > +static int userfaultfd_dev_open(struct inode *inode, struct file *file)
> > +{
> > +     return 0;
>
> If your open does nothing, no need to list it here at all, right?
>
> > +}
> > +
> > +static long userfaultfd_dev_ioctl(struct file *file, unsigned int cmd, unsigned long flags)
> > +{
> > +     if (cmd != USERFAULTFD_IOC_NEW)
> > +             return -EINVAL;
> > +
> > +     return new_userfaultfd(flags);
> > +}
> > +
> > +static const struct file_operations userfaultfd_dev_fops = {
> > +     .open = userfaultfd_dev_open,
> > +     .unlocked_ioctl = userfaultfd_dev_ioctl,
> > +     .compat_ioctl = userfaultfd_dev_ioctl,
>
> Why do you need to set compat_ioctl?  Shouldn't it just default to the
> existing one?

I took some more time looking at this today, and I think it actually
has to be the way it is.

I didn't find anywhere we noticed compat_ioctl unset, and default to
the "normal" one (e.g. see the compat ioctl syscall definition in
fs/ioctl.c). It looks to me like it really does need some value. It's
common to use compat_ptr_ioctl for this, but since we're interpreting
the arg as a scalar not as a pointer, doing that here would be
incorrect.

It looks like there are other existing examples that do it the same
way, e.g. seccomp_notify_ops in linux/seccomp.c.

>
> And why is this a device node at all?  Shouldn't the syscall handle all
> of this (to be honest, I didn't read anything but the misc code, sorry.)
>
> thanks,
>
> greg k-h
