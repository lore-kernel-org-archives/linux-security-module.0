Return-Path: <SRS0=Re8g=SL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D681C10F0E
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 20:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0573D2084F
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 20:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ci3YXYPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDIUzu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:55:50 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39630 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDIUzu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Apr 2019 16:55:50 -0400
Received: by mail-vs1-f68.google.com with SMTP id g127so52473vsd.6
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2019 13:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZSrBQKpQd+adpCbhGYkyPOgmdo9uCPs8DR7ZiCGabo=;
        b=ci3YXYPxT6IWOfTme6bKOV/WcqJ1xHLV+6vYN329Lht7HzSfZ7oeN40siOZdIAuLfo
         T0EkSo4YAdsaw1Vw29vU46gHvr3HJITv/qkxqUkowaHgM/iRoK2vvvctzbqGLJ8sT8fi
         kwYf8rX43hUhe+vq8BCA0zSCSj33jxxMAyYEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZSrBQKpQd+adpCbhGYkyPOgmdo9uCPs8DR7ZiCGabo=;
        b=jfyw3TkpTyyWNChL2hZ8t0Hmkx5cC6LbDRHJ2sFq0MBV8MSgPEXFJ1uxPAOpQV8+YV
         Vi7K2kyEjvRI/paaG1R95Ra9wSRaLJmcr56KWkiOfbtO4fFLmHMIz8vxfSe6oedl5sjL
         xJlVK58eaOatj8SRjHB8rlFqyvgnkTU0ob4/hHx99EHY60IPnABvlyssTeZBnvLBA65G
         cRs0lJMcWS9P6tLHO2u7Iq5g3qrhHu1ufjQWmD1tstKSeof5JKwzO4Q2HzIzGyim1ej7
         F1uQWOKo33s20MbUM+5jM1IiPjNnTjxo/DnnuBAsSF0Zhb4iG0QdyV1+H3uKdiKOQ0kH
         e/wA==
X-Gm-Message-State: APjAAAUJloRbLeIaI+fa4XfXe+7h0HINJT9QeZW9wZBBAM/ek8BdZuVh
        qGMBbcO/PJb/2OTkdvEa+BNRQWeNRvA=
X-Google-Smtp-Source: APXvYqxS90mU21IhNV/U6wS7CGD3qcQS5A5Ik91UHe4xBsbrR0uDN1gLrDEdZw3JvNpPU+Z7Xzwzfw==
X-Received: by 2002:a67:fa52:: with SMTP id j18mr20877380vsq.118.1554843349173;
        Tue, 09 Apr 2019 13:55:49 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id n202sm9378474vke.5.2019.04.09.13.55.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 13:55:48 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id d15so61412vka.8
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2019 13:55:48 -0700 (PDT)
X-Received: by 2002:a1f:2443:: with SMTP id k64mr14154520vkk.47.1554843343804;
 Tue, 09 Apr 2019 13:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190408160706.GA18786@beast> <CADyDSO4NkEY-SPT-abnyRXT9kGWhF8LbU3XQGNp-5k_15debDg@mail.gmail.com>
 <CAGXu5j+g8tPrDAYVKv26ci6zvGuvC1TMXto7weVP2QBymMRjhw@mail.gmail.com> <alpine.LRH.2.21.1904100611310.7633@namei.org>
In-Reply-To: <alpine.LRH.2.21.1904100611310.7633@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 9 Apr 2019 13:55:31 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJjaW3yayq+R9xk30h5s+u8vGptKi73o5fGK5nA4W=soA@mail.gmail.com>
Message-ID: <CAGXu5jJjaW3yayq+R9xk30h5s+u8vGptKi73o5fGK5nA4W=soA@mail.gmail.com>
Subject: Re: [PATCH] apparmor: Restore Y/N in /sys for apparmor's "enabled"
To:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>
Cc:     David Rheinsberg <david.rheinsberg@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 9, 2019 at 1:12 PM James Morris <jmorris@namei.org> wrote:
> Actually, JJ usually submits directly to Linus.

Ah! Right; I forgot. John, can you take and send this?

-- 
Kees Cook
