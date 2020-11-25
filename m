Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77867C5519F
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Nov 2020 12:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088A9206F7
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Nov 2020 12:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R0rjGOpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgKYMFC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Nov 2020 07:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKYMFC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Nov 2020 07:05:02 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963DBC061A4D
        for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2020 04:05:01 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id j10so2021614lja.5
        for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2020 04:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5FUjWxpOQ9zrCued6q8VeN9WGm6VgBFm9lfLrKQbsk=;
        b=R0rjGOpoCeLCagqI1sJ83TnqIgosI5MW9SQKWqklodjOkP6evlnIvgzzl4Or4JHdIC
         ibygpDOJBwvnUP0hCqyfLx/pBm0AKminSD0QrcXq7U0wHG9ghmO21aNF/pizF0LkDBbc
         biBzU/fnTR4ezxv16GJRfgs/RjTrW+M8lahOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5FUjWxpOQ9zrCued6q8VeN9WGm6VgBFm9lfLrKQbsk=;
        b=oqAxPxAPFbwd2crJxYnwjLMv0sHvpW7g3aZsKQ7+dOT0nLmmbIvJdfpssBl+93WqCh
         Sfyq+mkK/RGTFyX6aMGePHTroKt9Vpy105QjDBG/pn0xd8HccRxsePHsnXIvLJMmUOg6
         WiJlPj9ddkfsg8JvVxecLsFKKv7GE/0sIumcF61Ukyv/x6bXNxemldymKOpi+8M/emYb
         +sTf/0QvlLOQ6V7BgQzOjY3Lz4JqlvDr0uhVqlJGXLsH3NYNLIcVsMCclx0R+RfIaTc9
         5nUSIrHNGEJcSRe9FXPqFqihWNgFSkw0fwyVQyqceM8tZEidvMCuLLZlrsVS4NYSIL0M
         4a/A==
X-Gm-Message-State: AOAM531twUrcQYXewiHApSn2lKaKa9z9QNT7H9OA6eFpp/1RTJbMULo2
        4+Iw4YgmzoZOLskgyeN5yo1pTn+wD8lU55MzHAYDHw==
X-Google-Smtp-Source: ABdhPJzxIAysOZN/U4xhG7czC43qYmFbb4hpHmlQUzaVX4IBNdWDCl1YNNVf4IVxAMSNt3qPOQvxZ6gTKifImFD4b/U=
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr1280770ljo.82.1606305899970;
 Wed, 25 Nov 2020 04:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20201124151210.1081188-1-kpsingh@chromium.org>
 <20201124151210.1081188-2-kpsingh@chromium.org> <3b6f7023-e1fe-b79b-fa06-b8edcce530de@fb.com>
In-Reply-To: <3b6f7023-e1fe-b79b-fa06-b8edcce530de@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 25 Nov 2020 13:04:48 +0100
Message-ID: <CACYkzJ51imU+_iNR3zG2pzqvVoewSE+NCTJo_V5ZGYJOej-B-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] ima: Implement ima_inode_hash
To:     Yonghong Song <yhs@fb.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 24, 2020 at 6:35 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/24/20 7:12 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > This is in preparation to add a helper for BPF LSM programs to use
> > IMA hashes when attached to LSM hooks. There are LSM hooks like
> > inode_unlink which do not have a struct file * argument and cannot
> > use the existing ima_file_hash API.
> >
> > An inode based API is, therefore, useful in LSM based detections like an
> > executable trying to delete itself which rely on the inode_unlink LSM
> > hook.
> >
> > Moreover, the ima_file_hash function does nothing with the struct file
> > pointer apart from calling file_inode on it and converting it to an
> > inode.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
>
> There is no change for this patch compared to previous version,
> so you can carry my Ack.
>
> Acked-by: Yonghong Song <yhs@fb.com>

I am guessing:

*  We need an Ack from Mimi/James.
* As regards to which tree, I guess bpf-next would be better since the
BPF helper and the selftest depends on it
