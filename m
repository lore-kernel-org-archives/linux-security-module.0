Return-Path: <SRS0=wiIN=6U=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A5CC28CBC
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 16:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9A120708
	for <linux-security-module@archiver.kernel.org>; Wed,  6 May 2020 16:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Klq/9OrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgEFQ3M (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 May 2020 12:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729405AbgEFQ3L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 May 2020 12:29:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F55C061A0F;
        Wed,  6 May 2020 09:29:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id q124so1001514pgq.13;
        Wed, 06 May 2020 09:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOAVLQFd9uwTUOjjWjJTN3XrRveqGQu3fGi5NAseTcA=;
        b=Klq/9OrGleBSilnEJzHaHxo6U6+5KYzpoXw8NfQ0ckYmNzeagyt8Cn+Lh0qUUfgXBw
         gdvmeS543Wp/CARVnMG9p7/k+GBN5NTpMOifujnKdLL+dHUqI1KVxmjG1t5rimrNsuJB
         UUyRsQwnFVFhKVLfZ+SBwuV+9CUgIwYSvnrDjA1L4B9bDGWyJPCNmCSOukNRj+sQUbTI
         0dTcCUJAq8yEvRbhzucPBynu5+SS2MlgdKU1ULI+6y1V+fotxyJhGjhlvyfy3RBIGaf9
         6gF9oVwB1edJcyr0nf3SEqTssg8NJhmbfeGgD4ot+6k9Y+2yZ+jJk0NKLHFWWGMWCPz5
         59wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOAVLQFd9uwTUOjjWjJTN3XrRveqGQu3fGi5NAseTcA=;
        b=WY52QWK9CMWd465CsiOrBjCXZkE7yYSkk+q1RiApxOpyaTqXYMFoh+vzBQ3mQHC0MP
         9EmjwBjCyOTMH3wYsodBA9gbSHrHO4AAT2ddOh7k0H8Gv0dc9kdKIsny4wzAOkAW7kpK
         9LANSPDk9l9hTF+8W1SFY/R4QCN48V6oEim55+X4ZiIntds0hGpf0ioRlFMU+warsVgz
         kw1cq91W2KWJYGOCFVaO9kJQdI+PjhoBaJbhaEhEpImfvpjKofNy8ZUVLSKxsstxtnP5
         4utTuC8agLO0NV3wlrIwaVVZpXAb3ubLJ0X5QhG2uNzq6rdMrN4Uf6HQVeKm2avScdVW
         K14g==
X-Gm-Message-State: AGi0PuadPPMiDr3ScZGa60jr6NFqfND4OhwYN3aP4JzE+s37YRk+S9MQ
        cLatqo6IW/1lXH8JU0+czkeytJaHEPwy9vW31K4=
X-Google-Smtp-Source: APiQypKA7jRCy7Uiazzhg99FLx7nwfM2zcrheQOmKlB0byYCTusr+2zaTAK9A5/lKACS+VAPCWfIWcPIyhI9/7/Ej64=
X-Received: by 2002:aa7:8f26:: with SMTP id y6mr9165928pfr.36.1588782551194;
 Wed, 06 May 2020 09:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
In-Reply-To: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 May 2020 19:29:04 +0300
Message-ID: <CAHp75VdD_3CxtwT_07R8Cc=SE6Uw+FDpom5YxTX4Adq4DPjKkQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI chip
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 6, 2020 at 6:55 PM Richard Hughes <hughsient@gmail.com> wrote:
>
> Export standard LPC configuration values from various LPC/eSPI
> controllers. This allows userspace components such as fwupd to
> verify the most basic SPI protections are set correctly.
> For instance, checking BIOSWE is disabled and BLE is enabled.
>
> More cutting-edge checks (e.g. PRx and BootGuard) can be added
> once the basics are in place. Exporting these values from the
> kernel allows us to report the security level of the platform
> without rebooting and running an unsigned EFI binary like
> chipsec.
>

Isn't it covered by Intel SPI NOR driver?

-- 
With Best Regards,
Andy Shevchenko
