Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17378C6FD1C
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Mar 2023 09:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjCNJTN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Mar 2023 05:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCNJTM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Mar 2023 05:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BA393E30
        for <linux-security-module@vger.kernel.org>; Tue, 14 Mar 2023 02:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678785432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgK8jeijDMxB85rbRrmU9CTvwNcdx5i+gm9+kTFqBrw=;
        b=Nl3HERNxfJCkI9dLvW1oP5cbBpIHsc6uOYJcwd4O9+qYMq2WJ37LrDHjYP291gDphP7Hd/
        m1PQa0wAyR1wr251Jt56jKkfdIw+yhA5DJDYpLObPqRIk0Kd2shOguvZKSlv5984YM5fSm
        vJ5+GXXoCUkU+O3YGynXlsUWc/3IUmc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-4fKK6GIcOqmp2DKmxBq_1Q-1; Tue, 14 Mar 2023 05:17:11 -0400
X-MC-Unique: 4fKK6GIcOqmp2DKmxBq_1Q-1
Received: by mail-pj1-f72.google.com with SMTP id nv2-20020a17090b1b4200b0023d18722af2so812588pjb.8
        for <linux-security-module@vger.kernel.org>; Tue, 14 Mar 2023 02:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678785430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgK8jeijDMxB85rbRrmU9CTvwNcdx5i+gm9+kTFqBrw=;
        b=P4JQZsx3x9l6bfc8fvcnJeLtXHiRL1cbjAplKwKyQ5rUfIcSv1e4z4QxVJ5UNH8ta2
         q8mD4CdVJXpqcF7jZ0hFWjJGf9G1eRo8Y/Y3GkSaXshkoPpwpLPAfIuKpFvZIfCV5pmQ
         xAWUi13f8Zwp4X9+OKX6WnKJ0wELuQmFsF+p5nzF6tAtZ9HGGrvZ1a1Yjni3XN485rMS
         RuIgniCNs8ePNd3uHrQQR4SjqtF7SBQ+Oits8N3bVhiZb3zUg1Bdj9TOicrQjxi4x2w6
         znui+E+Tvdw3lFiN5fzGsOxvFPXUTPFXTXvfvJCr9ujr6K87dxdPlevVSl3aQ1XrK78v
         8sbQ==
X-Gm-Message-State: AO0yUKVINgUqVSkHToaXWN1Y+m5Ft2i19YUq0TpFxmf5C4Y8JkFvMt3d
        ozLkdVvcm1nNy0hl6GTbAfuGguaIn4N/VHN3xJtjr+YSXWbNIs3TEJ7sR0foH9jYLJC2uPiXXKY
        sWKpXyMEFNpln7nyTIPSBvlmhq/QvtNKqVuqMSMF0lWDJlV00HXa3
X-Received: by 2002:a63:385d:0:b0:50a:c011:19f2 with SMTP id h29-20020a63385d000000b0050ac01119f2mr2325457pgn.1.1678785430548;
        Tue, 14 Mar 2023 02:17:10 -0700 (PDT)
X-Google-Smtp-Source: AK7set+rm4R+bBfbjv6VaIdBvRAITSL4G8Fa2r0a8Pf400YlXM6B8mgRI9o1cuiJpmG4Nm6xXjQpR4zL8UaFvdSdbko=
X-Received: by 2002:a63:385d:0:b0:50a:c011:19f2 with SMTP id
 h29-20020a63385d000000b0050ac01119f2mr2325447pgn.1.1678785430233; Tue, 14 Mar
 2023 02:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230217162154.837549-1-omosnace@redhat.com> <20230313112923.340128142a92fe50140974db@linux-foundation.org>
In-Reply-To: <20230313112923.340128142a92fe50140974db@linux-foundation.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Mar 2023 10:16:58 +0100
Message-ID: <CAFqZXNveSFuYDF+upR_6F3ipZe56Xok6FPBwDJn-gBw7n6A26A@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 13, 2023 at 7:29=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 17 Feb 2023 17:21:54 +0100 Ondrej Mosnacek <omosnace@redhat.com> =
wrote:
>
> > Linux Security Modules (LSMs) that implement the "capable" hook will
> > usually emit an access denial message to the audit log whenever they
> > "block" the current task from using the given capability based on their
> > security policy.
> >
> > The occurrence of a denial is used as an indication that the given task
> > has attempted an operation that requires the given access permission, s=
o
> > the callers of functions that perform LSM permission checks must take
> > care to avoid calling them too early (before it is decided if the
> > permission is actually needed to perform the requested operation).
> >
> > The __sys_setres[ug]id() functions violate this convention by first
> > calling ns_capable_setid() and only then checking if the operation
> > requires the capability or not. It means that any caller that has the
> > capability granted by DAC (task's capability set) but not by MAC (LSMs)
> > will generate a "denied" audit record, even if is doing an operation fo=
r
> > which the capability is not required.
> >
> > Fix this by reordering the checks such that ns_capable_setid() is
> > checked last and -EPERM is returned immediately if it returns false.
> >
> > While there, also do two small optimizations:
> > * move the capability check before prepare_creds() and
> > * bail out early in case of a no-op.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> Looks and sounds good to me, so I queued it up for some testing.  I'd
> ask that someone more familiar with this code perform review, please.
>
> I assume that you believe that a -stable backport is desirable?  I'll
> add a cc:stable to the patch for now.

Yes, it's a minor bug, but we hit it while testing on Fedora and it's
better for us to have the fix in stable kernels than adding a
workaround elsewhere.

Thanks,

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

