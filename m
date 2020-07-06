Return-Path: <SRS0=KC/c=AR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4754C433E1
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Jul 2020 18:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BAB206B6
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Jul 2020 18:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bN7YWShs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgGFS7Z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbgGFS7Z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Jul 2020 14:59:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20668C08C5DF
        for <linux-security-module@vger.kernel.org>; Mon,  6 Jul 2020 11:59:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so40384701wmh.4
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jul 2020 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bt4u4JPMznhkNHKuGAbh472Qnx6WWkHIy3F9uekLf+M=;
        b=bN7YWShsuTBQnAjnEvGtGV989roN3XzZ/8UZTlJpfS2ieB4DV66lNQpKQlLzLCE8Oz
         BN4Tqqrs6qlg0q1KkFjIpmPfP5rfnWU29ZMDyMbftJ86Dv25JtPBLCbNd1DSu4w+MWcL
         kpTleCHfPrmNBtMaLpXqNKlUPauo3CJ8ewEa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bt4u4JPMznhkNHKuGAbh472Qnx6WWkHIy3F9uekLf+M=;
        b=Dp8BgLe8J6VgvA20l06C309U3cWuIDOop4UtCViIE8B1GzxKNt3sOPB4eOX9I4KjZ9
         MeNkoS/E3pdocgCNH9LUQ7zKF2FRPl+zUXGociZptgMHohBv1ga7joJQSLma0l4fnv0j
         9/NqEo/uu7ZD0zIGJYhptQc4CYUj6QkFV4atWvz8WNj0fN5cgpR7LN1PctfWx0g1Ptme
         h72IkyBaVbLFjspbk2P6VX1+2OsaYxL5SEvSl68K1L+M/3pUVG/LLkenvNJ81IP6j/Eu
         Wv+97F4VNDfy4ahsMyx/AF70LypVwPW5A41JxtcPVwf9QG0LAmrPj+kWE6vEx78BGW2p
         o6FQ==
X-Gm-Message-State: AOAM533iwma5KSFUFAjhlAaRuAvtjpJVZElEV1ezR4PmBZu/GvfDVNX+
        OpRjgO1iJ9QhSmno2xHr6kDYgdHB8phhLBwA06H9Mw==
X-Google-Smtp-Source: ABdhPJx/T88NRzDryjebsL1qpMHu22FFGmE2YItlZrMwdnQZXDcqA5JLarOoawNn6U1/M3a712v484b54U5lQm70yek=
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr566989wml.170.1594061963644;
 Mon, 06 Jul 2020 11:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200706165710.GA208695@gallifrey> <9268bd47-93db-1591-e224-8d3da333636e@iogearbox.net>
In-Reply-To: <9268bd47-93db-1591-e224-8d3da333636e@iogearbox.net>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 6 Jul 2020 20:59:13 +0200
Message-ID: <CACYkzJ78HOP8SZ3jU0DnH0b4f8580AuP4fdG5K3xgaHa8VYaZw@mail.gmail.com>
Subject: Re: [PATCH] bpf: lsm: Disable or enable BPF LSM at boot time
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Lorenzo Fontana <fontanalorenz@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 6, 2020 at 8:51 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 7/6/20 6:57 PM, Lorenzo Fontana wrote:
> > This option adds a kernel parameter 'bpf_lsm',
> > which allows the BPF LSM to be disabled at boot.
> > The purpose of this option is to allow a single kernel
> > image to be distributed with the BPF LSM built in,
> > but not necessarily enabled.
> >
> > Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
>
> Well, this explains what the patch is doing but not *why* you need it exactly.
> Please explain your concrete use-case for this patch.

Also, this patch is not really needed as it can already be done with the current
kernel parameters.

LSMs can be enabled on the command line
with the lsm= parameter. So you can just pass lsm="selinux,capabilities" etc
and not pass "bpf" and it will disable the BPF_LSM.

- KP

>
> Thanks,
> Daniel
