Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAADAC25B0C
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Aug 2022 19:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbiHHTQm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Aug 2022 15:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244331AbiHHTQa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Aug 2022 15:16:30 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F22617068
        for <linux-security-module@vger.kernel.org>; Mon,  8 Aug 2022 12:16:28 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10e6bdbe218so11578805fac.10
        for <linux-security-module@vger.kernel.org>; Mon, 08 Aug 2022 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tTjklP3N0xHZTapO1AHhc2qFb7IfKSUYUkpCWo6nNBY=;
        b=ZSOKztoCgboaGeteudYq4N3KYqQ8UIgYnji3gooMEzV5IRLYEh+XF1ZRfuD0EGQrGF
         /E5OcSx0xKOH11XrTJPWF+sWMQaMqK/KIw2Gn/HV+UkLhhIPbxsCiCVYwrHYOygGXOwp
         ysmzW9/YW9ZTCzsJ5xmf0IynMV0hA+2Wlu3q79QKSXFYtbzcxOixwKNLFB0KJirPHRAL
         NLod93cpmJ39y5iOiEmfdQlJoAQMc9YkzV6IaGtgO7QtNR6QLA8ZVCKk3n3rzMOb0QFT
         gp0dVQ7ArUGhq7F2E/q+wXMZN5JYN2YUZY594kavlTlFPRiqBWRKPPywn8ogyCZaDdmL
         JOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tTjklP3N0xHZTapO1AHhc2qFb7IfKSUYUkpCWo6nNBY=;
        b=R/+lZp58YN5d+3L2W30Aum6AjXoie5pGM7B0B2gZAkKYJcPolu6yRQEaezYOMpWjMx
         ogNj95m0GmLdclBTORWn48TaPMmTcZmv7P5VF7blvfHdkAm94UU7nJ0O7NbGi0knm44M
         vcHDe9tAA/RG/r2VO222roBu8bqsnivnq/rZmk2Aj7CPunATogvebEAQsAB/frb5+27g
         a/n5gMB1QicrGIncBV63N3Yu8IGgTWBa1N+z8fUNvZ8dr8GLlKmDHYj6M5NRk0s6eBLS
         +pJab3NMntHYFZpsPU06CQy1Y2VvqTljl3HWzyU+kajutua3qVHttg+Kc6oVKamo0t46
         ZtXg==
X-Gm-Message-State: ACgBeo0Y1KwOf3qh3jJQEBQg7mUXtuF2YFsVC07qErEcpjygwR7miKp8
        i+hUO3rYZlMVdM5pdp+TvxmImfDA4XuZEDbaPQXv
X-Google-Smtp-Source: AA6agR7Aw2cmXn+MTX3OJNveQNvS7hRoJuqGGAJUvFdZ+o5Hkr7Sb0J1aD17Nf+ppmZUi+oakuDbzPdW9LVLREpdZNw=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr12980423oao.41.1659986187604; Mon, 08
 Aug 2022 12:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220801180146.1157914-1-fred@cloudflare.com> <87les7cq03.fsf@email.froward.int.ebiederm.org>
 <CAHC9VhRpUxyxkPaTz1scGeRm+i4KviQQA7WismOX2q5agzC+DQ@mail.gmail.com> <87wnbia7jh.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87wnbia7jh.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Aug 2022 15:16:16 -0400
Message-ID: <CAHC9VhS3udhEecVYVvHm=tuqiPGh034-xPqXYtFjBk23+p-Szg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Introduce security_create_user_ns()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Frederick Lawler <fred@cloudflare.com>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 8, 2022 at 2:56 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Mon, Aug 1, 2022 at 10:56 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> Frederick Lawler <fred@cloudflare.com> writes:
> >>
> >> > While creating a LSM BPF MAC policy to block user namespace creation, we
> >> > used the LSM cred_prepare hook because that is the closest hook to prevent
> >> > a call to create_user_ns().
> >>
> >> Re-nack for all of the same reasons.
> >> AKA This can only break the users of the user namespace.
> >>
> >> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >>
> >> You aren't fixing what your problem you are papering over it by denying
> >> access to the user namespace.
> >>
> >> Nack Nack Nack.
> >>
> >> Stop.
> >>
> >> Go back to the drawing board.
> >>
> >> Do not pass go.
> >>
> >> Do not collect $200.
> >
> > If you want us to take your comments seriously Eric, you need to
> > provide the list with some constructive feedback that would allow
> > Frederick to move forward with a solution to the use case that has
> > been proposed.  You response above may be many things, but it is
> > certainly not that.
>
> I did provide constructive feedback.  My feedback to his problem
> was to address the real problem of bugs in the kernel.

We've heard from several people who have use cases which require
adding LSM-level access controls and observability to user namespace
creation.  This is the problem we are trying to solve here; if you do
not like the approach proposed in this patchset please suggest another
implementation that allows LSMs visibility into user namespace
creation.

-- 
paul-moore.com
