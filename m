Return-Path: <SRS0=H0F3=27=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F041C3F68F
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jan 2020 08:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B5520721
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jan 2020 08:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdJh/iUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgAJItD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:49:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46076 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbgAJItD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Jan 2020 03:49:03 -0500
Received: by mail-lf1-f67.google.com with SMTP id 203so828393lfa.12;
        Fri, 10 Jan 2020 00:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILZt7jJkOheoPWlACDpARCR+CuAKn7kG8kza3ZrG138=;
        b=ZdJh/iUBgZmey0Ml6eDQCli39cTvPlTWqnsUQ2iGDxbTiQbky+F7fEWGD7LGii84vl
         EI8ivZdzcTSNKaAOWzHnAHhVnF2Ke4KD8J2JWhoqUOoEwaeLqyk6h1sNNQ8SyuAO4vQ7
         KiMSheo04FSIbXARXNjR4564dS8zJwLy1frSCQBy5Hsc6dyxqRxjgp6oRkmf0piVASxa
         gPKOVSpmnxnWwh1NWypRYBwyCs5LBaSqITNB2oshSw8DoTAn+ysY1gU5geXyHUoV5ULn
         bzKuHoB4dZKoHqdDJeyJ1Gr8XykYAd9XcONsxEvK+JmJvSlSGvs4I0RFFxvZUlyDw8x4
         mtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILZt7jJkOheoPWlACDpARCR+CuAKn7kG8kza3ZrG138=;
        b=bC/raeXpRXXg1DmFn+NineP3jretFRJXm+ut6YcUgJTSDedsu/FD2SsobMoUvWCrXZ
         ECHxCWg9oe9gEtwyg+eO+K+SBEa7bpSJmEM/FKkCqmzPE4ZBv0x58woqh/kSasYkGxFe
         eUysGhYa8B+P5BEk/eoESKmltctUTjoQeTp30gP3dZvei140WVHQ5MUWr7Mvy0ke2YcY
         ctv5G2eofraq/MPUm8+BQLVqPn4tNAsxi/deTbrBjjqMEiGl9OSHcwMJICRG4mE/NUl7
         nADMOZU4+76vY5UQ+QH5wbu9VkSfnAGafwmVck+MSTOD6uhuHsKUEG9F70GtvIrlOFq1
         oIlw==
X-Gm-Message-State: APjAAAUQ5GGxd6w910vtAqiOkM192CW/Rfsil+Oc0KkXUtdhphgaR75i
        sk5d1lZroSln4kbC2VrietNrwW27TXMfNkgWNv4kGw==
X-Google-Smtp-Source: APXvYqygJQGZ3RBimeVYjq2hOPJ5DA0A9a/V/pXoNIaHkblmaz9IPKSLcU5ZEk5cDkdou5Kd/J1O34Tc/eJ6ZMAOkZw=
X-Received: by 2002:ac2:5549:: with SMTP id l9mr1483090lfk.53.1578646141193;
 Fri, 10 Jan 2020 00:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
In-Reply-To: <20200108111743.23393-1-janne.karhunen@gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Fri, 10 Jan 2020 10:48:49 +0200
Message-ID: <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
Subject: Re: [PATCH v2] ima: export the measurement list when needed
To:     linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
        monty.wiseman@ge.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 8, 2020 at 1:18 PM Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> Some systems can end up carrying lots of entries in the ima
> measurement list. Since every entry is using a bit of kernel
> memory, allow the sysadmin to export the measurement list to
> the filesystem to free up some memory.

Hopefully this addressed comments from everyone. The flush event can
now be triggered by the admin anytime and unique file names can be
used for each flush (log.1, log.2, ...) etc, so getting to the correct
item should be easy.

While it can now be argued that since this is an admin-driven event,
kernel does not need to write the file. However, the intention is to
bring out a second patch a bit later that adds a variable to define
the max number of entries to be kept in the kernel memory and
workqueue based automatic flushing. In those cases the kernel has to
be able to write the file without any help from the admin..


--
Janne
