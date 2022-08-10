Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32019C3F6B0
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Aug 2022 18:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiHJSkK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Aug 2022 14:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiHJSkJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Aug 2022 14:40:09 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB9C6C119
        for <linux-security-module@vger.kernel.org>; Wed, 10 Aug 2022 11:40:07 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-116c7286aaaso2901911fac.11
        for <linux-security-module@vger.kernel.org>; Wed, 10 Aug 2022 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JF+jvzJ9J7rN+bZsHfjsFFUjwlN+h+ky1MttPYSMiNY=;
        b=CW4o+Cd+JnxBhfMY1lKxIDc2nY2q+nXtdmdaeccqBavPXcwjyi4IkmmEfb2dKhZVk/
         8HIC5+vmay3B833cSqxul6tLEgXlRIGj0inW3RSpVBEOW5syEHxCGVdvVmZD+cQp4DjC
         DYjWXwb8DLnhFq8nlLW8PrzanHvoZL/xfLoKOaQ+XWoKeJqHCZMnPY9ifxMKGCTmJz7b
         aQjKlPAfPIfG4KYmPtrT7Koz9vmi/zpK1L6YejMHb0FukqMNU0ebs0H2oZsk12kXXel7
         GKLHDdd3HnsKTM24KrVDiMP1WnPuAJOGdU72PZ+qskXfKzirp+aOb1toE/D4RdHwi8uR
         WbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JF+jvzJ9J7rN+bZsHfjsFFUjwlN+h+ky1MttPYSMiNY=;
        b=DJbnD8pFDub5R2v+CmS9FW0i/9x57SLbJttJJXpteDkGj2G0OohdAFsLIo07NEJFQD
         dIp0wSsXCJxQiI8tCsOJsnx0uH/iepRkd1E393G2zpxRBZDJC2ypQeQSzW5U/1TzuFsp
         Yux/BzqwmdoPMXbKv6bkmjdvuADtcpB/pKy69GaREDZb0KU/7qFn2owxgW/1HaDT1j0X
         wCJcJqN3HPeLlUCzS0bSDxPZg4SJ+96yKod2HlwmjJ+U8i+zZ5noUDxuLCBqiuFWusXg
         Uo3AlZW3TKjX7yjj/WXUOJeaJiwqAyLZF8IkXdweDe5JWlEMtvq1GLfPV06Md5dL+cHT
         K48w==
X-Gm-Message-State: ACgBeo0n0MUCHrhmLeZK+wmfxguKv5M52UIeKSrF7jllisSd2eZouQSa
        vzrgHk3UFK3xvHMZIz1l8hE6JfD2eHjTjITlbHXS
X-Google-Smtp-Source: AA6agR5nexQyG2ReJ5r0YsSyA4myGB59sSKhWcXiNCmQ8ihtGjorAgqpca5Vp8MQI3H4OAIlFeVnHNxRuDf/8S1bUmg=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr2044914oao.41.1660156805547; Wed, 10 Aug
 2022 11:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220715191622.2310436-1-mcgrof@kernel.org> <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
 <YvP1jK/J4m8TE8BZ@bombadil.infradead.org>
In-Reply-To: <YvP1jK/J4m8TE8BZ@bombadil.infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Aug 2022 14:39:54 -0400
Message-ID: <CAHC9VhQnQqP1ww7fvCzKp_o1n7iMyYb564HSZy1Ed7k1-nD=jQ@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd file op
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        casey@schaufler-ca.com, joshi.k@samsung.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 10, 2022 at 2:14 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Jul 15, 2022 at 01:28:35PM -0600, Jens Axboe wrote:
> > On 7/15/22 1:16 PM, Luis Chamberlain wrote:
> > > io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> > > add infrastructure for uring-cmd"), this extended the struct
> > > file_operations to allow a new command which each subsystem can use
> > > to enable command passthrough. Add an LSM specific for the command
> > > passthrough which enables LSMs to inspect the command details.
> > >
> > > This was discussed long ago without no clear pointer for something
> > > conclusive, so this enables LSMs to at least reject this new file
> > > operation.
> >
> > From an io_uring perspective, this looks fine to me. It may be easier if
> > I take this through my tree due to the moving of the files, or the
> > security side can do it but it'd have to then wait for merge window (and
> > post io_uring branch merge) to do so. Just let me know. If done outside
> > of my tree, feel free to add:
> >
> > Acked-by: Jens Axboe <axboe@kernel.dk>
>
> Paul, Casey, Jens,
>
> should this be picked up now that we're one week into the merge window?

Your timing is spot on!  I wrapped up a SELinux/SCTP issue by posting
the patches yesterday and started on the io_uring/CMD patches this
morning :)

Give me a few days to get this finished, tested, etc. and I'll post a
patchset with your main patch, the Smack patch from Casey, the SELinux
patch, and the /dev/null patch so we can all give it a quick sanity
check before I merge it into the LSM/stable branch and send it to
Linus.  Does that sound okay?

-- 
paul-moore.com
