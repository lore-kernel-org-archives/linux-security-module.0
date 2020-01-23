Return-Path: <SRS0=QZUe=3M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FC2C3F68F
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jan 2020 08:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2835624125
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jan 2020 08:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrHK1F06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAWIll (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Jan 2020 03:41:41 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34328 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWIll (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Jan 2020 03:41:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so1700600lfc.1;
        Thu, 23 Jan 2020 00:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UyvUctf+qJyIsi+eU7dg970I4xk9OoLbCIf8MD5kDRY=;
        b=MrHK1F061wna3tijOCU4KH6liyiYUCgR+POobFfZe5hQOhOScpnJ6ExdInWZO1jaSM
         nfV9RsLqYojqpoLZ72Urxi0bm4i+e/568/6sMcBqmKmstw9PRz0Al+S498NNMqa0ImRM
         iwzpXAgNJQrvFeylVEBdnN0NhmZWmhS6aOFAgGjeySe2BO1wYuffLRu7DCnaKbIG/gZ3
         UDIwsdRhUC5f/OX6CsHPiKIhxYr6OS5SzBZNTBMvmSiFKAiYsDPGwUcme2syx6RjVGVF
         XT5J1IFk+rTplhMR5sQjAhrQ1xxWlF5ZnR2r2hZxLBVSF41xpYoU6BGju6IVo2fyOMb+
         ZDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UyvUctf+qJyIsi+eU7dg970I4xk9OoLbCIf8MD5kDRY=;
        b=fW9Br2zswysdZN6j4msuyhic52Gq5TF33ojGgiruVbkxGcYm1k85jH2iO/F2xY5+6Y
         TNt72dOwVX25VYBCHo0A1HPpTQTtd9Agg2buWjCtzU9Dm+ht+fzVzh/3InPY6WdeDq0b
         JfiZxxd/5sVYSjFJ49irscTzxMNaOe4NFl0eM/SOAT9FishSB/SW7Fi6bvxXciRoFCja
         ACxRBcW6LemjU6eWNhU2YjWLNdv44nKWUroW7YZpyfpexqikCmTiG/EVa697jTis+Rhs
         FIJyWU+JCpk6jEj0GZTIAAr/kuPc8tbpG8yDoMZK3XAoGfLMjairNM7VX8VCB+ZWhres
         QMFw==
X-Gm-Message-State: APjAAAXMTTrzpAN12WyI1VKu8E1U2S/6P0VF6fGvCxqC4A7P2vDYEPSs
        FgOxXIepVnpRs5cVOYvG3ZXUKL9h44f7T5gGG/C4Ew==
X-Google-Smtp-Source: APXvYqxq1PMY9h9u7/7/tbPcBgMeaIa+vVbpcKz5u/krFu8NV0KvjehPakfPqGeaYoSbwk4CqEMnZV7BqQ9wKAK/pI0=
X-Received: by 2002:a05:6512:78:: with SMTP id i24mr4152255lfo.10.1579768899124;
 Thu, 23 Jan 2020 00:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
 <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com> <1579708579.5182.77.camel@linux.ibm.com>
In-Reply-To: <1579708579.5182.77.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 23 Jan 2020 10:41:27 +0200
Message-ID: <CAE=NcraSfo0fwxCnFQd08Ga59DsvxPTch-n_iN7fxt+3RdmP+A@mail.gmail.com>
Subject: Re: [PATCH v2] ima: export the measurement list when needed
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
        monty.wiseman@ge.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 22, 2020 at 5:56 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> > While it can now be argued that since this is an admin-driven event,
> > kernel does not need to write the file. However, the intention is to
> > bring out a second patch a bit later that adds a variable to define
> > the max number of entries to be kept in the kernel memory and
> > workqueue based automatic flushing. In those cases the kernel has to
> > be able to write the file without any help from the admin..
>
> I don't think it is common, and probably not acceptable, for the
> kernel to open a file for writing.

Ok. It just means that the kernel cannot do its own memory management
and will depend on the user flushing the memory often enough to
prevent something bad from happening. Is this more common in the
kernel than writing out a file?


-- 
Janne
