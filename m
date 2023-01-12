Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB6CC54EBE
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Jan 2023 17:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbjALR4W (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 Jan 2023 12:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjALR4Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 Jan 2023 12:56:16 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C8555676
        for <linux-security-module@vger.kernel.org>; Thu, 12 Jan 2023 09:16:03 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 141so13251561pgc.0
        for <linux-security-module@vger.kernel.org>; Thu, 12 Jan 2023 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nzSuljwXCaXyiAVCXAx1oRKKeIjSI3nJRRGJJx1quUQ=;
        b=MFOcCfEZ7Cjmr3WB5GH4eeEn0165eiypBPdejoqXwokek49v/AySoZEAZw9j2oDcmq
         y4J6DEeYf3KOdxex0i3awGU/lJNKOesgPify/ePlg8mxB+jk23/SKGnDkwfjKWs723G+
         5fTI4dD97IJHbv3KYFmaYeEhLvdEO5RWppT7C9xSdlKh60iFFNFBADUu4kCkp7oLBgpM
         RQWj59jEMMtexCUU92taNzVkPyGJ6EsQ4nGL8WFfh1sHrh7w0DJkEzpsadnRGZ+k5KlX
         9RKXsLyYhkqNOIn6C//zs9Slur/qUqHuCKIuWKiASSuuMe2SyhJoPMmQAvRwAOR8UYA5
         lbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzSuljwXCaXyiAVCXAx1oRKKeIjSI3nJRRGJJx1quUQ=;
        b=8FNAhTf7f8I/HLPa1eE2pvvtl5H9ZbMCEJ+xelHiYwwMjB5111dWsQgdJWwqi09C76
         EAmZlF6clGoWltzKlnJOlIxq2+z4TPIprscl7x018EYYExHGD/TQ3gfmEkHcDPnxcRko
         jqhI3FRquHer+9U3mwxWpUqETj1AcqFvTVTqiMkfPkrCN7pblVfWOCpKRspqDxRZxqno
         KKWhV3cPGJRvghMs7m8yqFkOsqnIjyEZLLKs6BJZZ7XtTA8MNMI8cRRLqJN1+wpUGy9K
         CWY92FL0/Oumg1uJB1OaIBNb7hejP9wJ859ZMe4ZtOMWARBdEN1i7ee1vgSIsvmWhBnw
         Ak1g==
X-Gm-Message-State: AFqh2kpxxMlM5JxF1ycVMggcom6/Yny0dRVar/k70ogx+30TL0mma/WL
        59fGotIfnc5WMB+5jj1G0QqRjIEsOFIqrj+Ozg4L
X-Google-Smtp-Source: AMrXdXsG96vnEjEW68HlbBwvUb9qhZbhASlzXqBntMWFBx7pNvLRL/YHEGdI0X89G0/fteFLqA6mf93dh22GLZtjV5o=
X-Received: by 2002:a62:158f:0:b0:588:e66e:4f05 with SMTP id
 137-20020a62158f000000b00588e66e4f05mr1300557pfv.23.1673543763211; Thu, 12
 Jan 2023 09:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Jan 2023 12:15:51 -0500
Message-ID: <CAHC9VhS0SnEb46-FBpn2JpC2dJ7OnkeJ2EtLBvVvkOLdfFmcbg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] evm: Do HMAC of multiple per LSM xattrs for new inodes
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 1, 2022 at 5:42 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> One of the major goals of LSM stacking is to run multiple LSMs side by side
> without interfering with each other. The ultimate decision will depend on
> individual LSM decision.
>
> Several changes need to be made to the LSM infrastructure to be able to
> support that. This patch set tackles one of them: gives to each LSM the
> ability to specify one or multiple xattrs to be set at inode creation
> time and, at the same time, gives to EVM the ability to access all those
> xattrs and calculate the HMAC on them.

...

> The patch set has been tested with both the SElinux and Smack test suites.
> Below, there is the summary of the test results:
>
> SELinux Test Suite result (without patches):
> Files=73, Tests=1346, 225 wallclock secs ( 0.43 usr  0.23 sys +  6.11 cusr 58.70 csys = 65.47 CPU)
> Result: FAIL
> Failed 4/73 test programs. 13/1346 subtests failed.
>
> SELinux Test Suite result (with patches):
> Files=73, Tests=1346, 225 wallclock secs ( 0.44 usr  0.22 sys +  6.15 cusr 59.94 csys = 66.75 CPU)
> Result: FAIL
> Failed 4/73 test programs. 13/1346 subtests failed.

Can you provide some more information on which of the
selinux-testsuite tests failed?  That shouldn't be happening and I'm a
little concerned that these test failures, even if unrelated to your
work here, could be masking failures which are related.

-- 
paul-moore.com
