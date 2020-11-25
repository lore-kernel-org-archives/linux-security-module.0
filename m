Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE95C63798
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Nov 2020 02:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B84121534
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Nov 2020 02:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DApjdGFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKYCzn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Nov 2020 21:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgKYCzm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Nov 2020 21:55:42 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78670C061A4D
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2020 18:55:42 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id z21so998195lfe.12
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2020 18:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVLUYjo0mTqXMXhyI9y/4N/cU1rDAW9Wrg6NPzTE/+4=;
        b=DApjdGFFu/IxkXaaimxU/0ewXnDvcxY15TGVMdZyW2tvcNQJz/tHsGpKQ66lGMG5KQ
         mLBYocW3+ik856F/vTfGAw0XLMoUWgYMDbh2Oy9XTUErY5jxdrC25LyeZr2tTaPrtEkk
         H/O6sPC1ETyCRxgOi9MckQ1N7c1ZaLL9q7rOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVLUYjo0mTqXMXhyI9y/4N/cU1rDAW9Wrg6NPzTE/+4=;
        b=TAP0eroHTVcOLncRiNmYxALsFYuBFmDZOWwf8a+M/cOy1tWAbHs72GRhtgYh4xjpJj
         D7TD0o7VwFgdYeyoI7Oiq3ksO/m5juNzSP6bnzqUQkRmplybZEFThP8M13R+z45XxIAz
         5WRBx47ZsfF7b40NWhu+UmlHcHqRqn4Z7CLuLfytcznoARd9b4chm7BWSBKnSbATJD8/
         Fyf0WRwS8TWDIY2dOwLvPpa0p1FjtE3SSt9dQjLsqygfleKv1/T9KFPja0Zzz7Bln5Pb
         7JEc9PgRv0gMxwd3BdnkVJzepwrOPnnmYIec4gtXGqzCEpxjRdB0SxtQzgsMZxP/7HV7
         nFbA==
X-Gm-Message-State: AOAM531yhY4rm51v29JbHw7/oaJfZ5tfi7kVLDGP5Pb0P3s5qBXV0mD6
        8BoZUKLYzPeha1HbJ8fzfs3TDYl/h3X3PvLxL4ywVw==
X-Google-Smtp-Source: ABdhPJy4WEJZIECjxTGx6sO6NWcN5uOcPf9AqGtjf0VPYkT/LLuPywiZqNJEqPKv+SCBwbNBMhRA2WDqPqayrq6KyNU=
X-Received: by 2002:ac2:51a4:: with SMTP id f4mr434422lfk.365.1606272940838;
 Tue, 24 Nov 2020 18:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20201124151210.1081188-1-kpsingh@chromium.org>
 <20201124151210.1081188-4-kpsingh@chromium.org> <adaa989215f4b748eb817d15bd3c2e8db2cbee3c.camel@linux.ibm.com>
In-Reply-To: <adaa989215f4b748eb817d15bd3c2e8db2cbee3c.camel@linux.ibm.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 25 Nov 2020 03:55:29 +0100
Message-ID: <CACYkzJ5ZJ_yu=dXM5-jXEO5p5WzpXDT5EdT0agL1pgdNRqGamw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf: Add a selftest for bpf_ima_inode_hash
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 25, 2020 at 3:20 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2020-11-24 at 15:12 +0000, KP Singh wrote:
> > diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> > new file mode 100644
> > index 000000000000..15490ccc5e55
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/ima_setup.sh
> > @@ -0,0 +1,80 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -e
> > +set -u
> > +
> > +IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
> > +TEST_BINARY="/bin/true"
> > +
> > +usage()
> > +{
> > +        echo "Usage: $0 <setup|cleanup|run> <existing_tmp_dir>"
> > +        exit 1
> > +}
> > +
> > +setup()
> > +{
> > +        local tmp_dir="$1"
> > +        local mount_img="${tmp_dir}/test.img"
> > +        local mount_dir="${tmp_dir}/mnt"
> > +        local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
> > +        mkdir -p ${mount_dir}
> > +
> > +        dd if=/dev/zero of="${mount_img}" bs=1M count=10
> > +
> > +        local loop_device="$(losetup --find --show ${mount_img})"
> > +
> > +        mkfs.ext4 "${loop_device}"
> > +        mount "${loop_device}" "${mount_dir}"
> > +
> > +        cp "${TEST_BINARY}" "${mount_dir}"
> > +        local mount_uuid="$(blkid -s UUID -o value ${loop_device})"
> > +        echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
>
> Anyone using IMA, normally define policy rules requiring the policy
> itself to be signed.   Instead of writing the policy rules, write the

The goal of this self test is to not fully test the IMA functionality but check
if the BPF helper works and returns a hash with the minimal possible IMA
config dependencies. And it seems like we can accomplish this by simply
writing the policy to securityfs directly.

From what I noticed, IMA_APPRAISE_REQUIRE_POLICY_SIGS
requires configuring a lot of other kernel options
(IMA_APPRAISE, ASYMMETRIC_KEYS etc.) that seem
like too much for bpf self tests to depend on.

I guess we can independently add selftests for IMA  which represent
a more real IMA configuration.  Hope this sounds reasonable?

> signed policy file pathname.  Refer to dracut commit 479b5cd9
> ("98integrity: support validating the IMA policy file signature").
>
> Both enabling IMA_APPRAISE_REQUIRE_POLICY_SIGS and the builtin
> "appraise_tcb" policy require loading a signed policy.

Thanks for the pointers.

- KP

>



> Mimi
>
