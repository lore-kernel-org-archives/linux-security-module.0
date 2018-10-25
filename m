Return-Path: <SRS0=wXFO=NF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A716BC46475
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 20:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF972054F
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 20:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CYVfvVJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF972054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbeJZE7L (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:59:11 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:37661 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeJZE7K (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Oct 2018 00:59:10 -0400
Received: by mail-lf1-f49.google.com with SMTP id a82-v6so7829005lfa.4
        for <linux-security-module@vger.kernel.org>; Thu, 25 Oct 2018 13:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fX5oxsXfvnoDXOpfE1vrfgQeNDjptwR6xgo4hnsCak=;
        b=CYVfvVJKQsWZJ9FSoyKFFWfGG4SsgJqf0ZG20xJxgIKlR6W11BXqLPceO8JJSOcdNJ
         OUgcCREuD9KsDyxRIj0FTPkJ4UTeGpJ7FayBKZ1hClbS6QEDCFnymm6lsyOsVneKHW40
         1Q2e2XX+uwcN0lLQZYWChvBSPOibnqnKuTyFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fX5oxsXfvnoDXOpfE1vrfgQeNDjptwR6xgo4hnsCak=;
        b=EmmnHU4bH+vhXlBogO+Bve422Ye5cbQoKq5cMjuu7QDp5DKcDaTB4mY9CWJxLT1/ux
         8ZnYcrp92LU0hfWrQssgZCUqQHXXxy/2R1Iq5xhO/xwzO9R0iwD0E/dYe1pQG8OqicnN
         wcNc9F7enqMkN08byKpqWWrBkaDzrknhwd0YavIzb7ekElU9xjFAdFiERvVAwW9RKIG5
         neHRDa7PgxitGxv42lhW0U0oOuxzv4I89Ek/uBK9hBecMJ5rPg7nMqrFCJcGhM3ymKq4
         fD9HWzHnhMvIdt+NU1nzzTzucXVQNFU/OrDzVlauHUZXJPWsnJMtNqsTPYXkX8xtPWl6
         1aag==
X-Gm-Message-State: AGRZ1gJW9MTxmh/WBXLY5AAhz7r5fdsS+4G/gJLM4ACGf33w8SnsDqgL
        9xAYzfhooqznHm9vkW6pwl/kcQszaMa5Lw==
X-Google-Smtp-Source: AJdET5dZaGjhI3koCWFLtMSpVx+ON+SOC3pmE4ovdJQoGIGMT87E5WeStqyfPxgu+2TT1LvWiuG21A==
X-Received: by 2002:a19:7306:: with SMTP id o6mr406038lfc.136.1540499097333;
        Thu, 25 Oct 2018 13:24:57 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id h87-v6sm1299010lji.9.2018.10.25.13.24.56
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 13:24:56 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id h192so2871305lfg.3
        for <linux-security-module@vger.kernel.org>; Thu, 25 Oct 2018 13:24:56 -0700 (PDT)
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr457113lfo.124.1540499095902;
 Thu, 25 Oct 2018 13:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1810252029570.30470@namei.org>
In-Reply-To: <alpine.LRH.2.21.1810252029570.30470@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 13:24:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wif2p+P2HWUdyak7i3tgMgtG-dT_hh1uwt7=HgVyUSBcQ@mail.gmail.com>
Message-ID: <CAHk-=wif2p+P2HWUdyak7i3tgMgtG-dT_hh1uwt7=HgVyUSBcQ@mail.gmail.com>
Subject: Re: [GIT PULL] security: integrity subsystem updates for 4.20
To:     jmorris@namei.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 25, 2018 at 2:32 AM James Morris <jmorris@namei.org> wrote:
>
> From Mimi: "This pull request contains a couple of bug fixes, including
> one for a recent problem with calculating file hashes on overlayfs, and
> some code cleanup."

Pulled,

                  Linus
