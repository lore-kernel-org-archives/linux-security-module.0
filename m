Return-Path: <SRS0=iK7v=36=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB7CC352A5
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Feb 2020 18:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6419A2085B
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Feb 2020 18:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581359460;
	bh=omPLg79kMPvUSKiyNNvd0/ylILD31wzwomGJPrNGyQg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KkHK6P/p/tDwNLEArowwkv3Yi/IhdVkgiMMTrWUmX8li0yB7asNSgza4obL0P1hlp
	 RMy3d1o2zKbe85M+lfc0JXPgQ/B1UMfLz+6ROETaDMSc05pEJJKj/41UrWil98rKVB
	 NJ1iGGCOIuX5rukxyVsTF46TdpEEsdF8V+C0GMiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBJSa7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:30:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgBJSa7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Feb 2020 13:30:59 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3094820873
        for <linux-security-module@vger.kernel.org>; Mon, 10 Feb 2020 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581359458;
        bh=omPLg79kMPvUSKiyNNvd0/ylILD31wzwomGJPrNGyQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dZmJEdXyo7TiCuP494908+DDQqiXuByAFM/5ZYZdUBh1RBbsjG4Nj8BtvNderACDu
         buUtqSZaMUtzDuCNulwdaDkgV5kqZL7lno4QgAbQ/lGQBv705tgeTFjmzJtXJCSjQ1
         BFRJCZcEs4eVwRoiOiwkJ6JclPVFDKSbcrF3PIR0=
Received: by mail-wr1-f51.google.com with SMTP id r11so5811559wrq.10
        for <linux-security-module@vger.kernel.org>; Mon, 10 Feb 2020 10:30:58 -0800 (PST)
X-Gm-Message-State: APjAAAXtgrqme/OEZ95TFtKiaJ+zbqk37jK6U7BvczvSGGhzMk1MzACA
        foTR5y/Tr5klXu2zYVvyZU6OuttF6Ht3iRznBGTjeg==
X-Google-Smtp-Source: APXvYqzr7b50VDslir7PKIqAsDCapDo139eIqmv/8TM15nWdMYYpgSAHPnXtkGdcaP89mSWD9lXJHS+xhiOGpQ18who=
X-Received: by 2002:adf:ea85:: with SMTP id s5mr3242839wrm.75.1581359456683;
 Mon, 10 Feb 2020 10:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com> <20200210150519.538333-6-gladkov.alexey@gmail.com>
In-Reply-To: <20200210150519.538333-6-gladkov.alexey@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Feb 2020 10:30:45 -0800
X-Gmail-Original-Message-ID: <CALCETrVjv04OOdzGNf7sRmRR-KUgY7xdMXA236nHZ1arn0KwVQ@mail.gmail.com>
Message-ID: <CALCETrVjv04OOdzGNf7sRmRR-KUgY7xdMXA236nHZ1arn0KwVQ@mail.gmail.com>
Subject: Re: [PATCH v8 05/11] proc: add helpers to set and get proc hidepid
 and gid mount options
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 10, 2020 at 7:06 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> This is a cleaning patch to add helpers to set and get proc mount
> options instead of directly using them. This make it easy to track
> what's happening and easy to update in future.

On a cursory inspection, this looks like it obfuscates the code, and I
don't see where it does something useful later in the series.  What is
this abstraction for?

--Andy
