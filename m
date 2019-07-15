Return-Path: <SRS0=DosV=VM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4BCC7618F
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 16:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489352080A
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 16:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NX4KmUPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfGOQwZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jul 2019 12:52:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40783 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfGOQwZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 12:52:25 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so35168671iom.7
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHoMa0aB575ndxF9MO91+SFVtilbhRQHj9EIOaDf/E0=;
        b=NX4KmUPklIE7SqmWpLBQywave9TEGd/+/k6eJ2icHjCqvWHv5JKuRIusELHKd15mUh
         JprrUpm8paJ93gr/5wR7WbQnPpAioD5mmfknE2yMF666H8cSKKpT4eEze3nRBGW1MuLa
         1CXVjnnWBd6LIcajDmXjrIw5l2Xq5x91Y1nNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHoMa0aB575ndxF9MO91+SFVtilbhRQHj9EIOaDf/E0=;
        b=LEhUJw2MMoED4K3i28+LftS6PF8H1b7mVFEXQr0sJ81Kf7YeFVLw0g9jJNBX/UBPUw
         5s9vsCA/sQ/zZ4GOSkNYUzSMV8n14XT8ONvBbK7Bk1npYCtPdEZz3o/rw5+B78corEhC
         HHjKzSE3ZHCfGWRRgLPG0I8AKNtRYXmrDyHJ5wbTxJ89kuxoiLBDEjfUaYhlsX9T2J1F
         +60+uVvD36+/iRaTF0lLYX/+PA2i7oqUjcLKSnoTusNrDtvBa45UpIcXsjrRCXT9a718
         tJojWpnBzNzTU4LY/bt2EsmzMa/Qak2pG0ymyq18NBNKn56eCK4qvxPASRiQjeNQ772D
         /i3g==
X-Gm-Message-State: APjAAAXSJmO0wbkvCuVaFBDD28+njNeVSBxsQ+HZMROrN0a2XWafBOYz
        6CNO+89wuR8JYnQCeK90pjMr/UJqsTaeGT7MiBOkaaPD
X-Google-Smtp-Source: APXvYqzks/Yh3nT94EU73JeQYfbm5eQCktqaSsKgM0EsmdXp+RQy6lM42+v5gyP0k5DiZS7Tq13K9MLQ7M9+nJVbMAI=
X-Received: by 2002:a5d:9bc6:: with SMTP id d6mr19317271ion.160.1563209544592;
 Mon, 15 Jul 2019 09:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190522172241.192669-1-mortonm@chromium.org> <alpine.LRH.2.21.1905230341520.18826@namei.org>
 <CAJ-EccPo2T6y=7Gw-naPZ4d25em+8TsZMSXp4C=pGeTutbPqZA@mail.gmail.com> <alpine.LRH.2.21.1907130314410.32193@namei.org>
In-Reply-To: <alpine.LRH.2.21.1907130314410.32193@namei.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 15 Jul 2019 09:52:13 -0700
Message-ID: <CAJ-EccPOko4pHKWH2R6b=HO0NnrtbKQWdH6BpO4w5HRsHrTdeg@mail.gmail.com>
Subject: Re: [PATCH] LSM: Update MAINTAINERS file for SafeSetID LSM.
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Sounds good.

On Fri, Jul 12, 2019 at 10:15 AM James Morris <jmorris@namei.org> wrote:
>
> On Fri, 12 Jul 2019, Micah Morton wrote:
>
> > Hi James,
> >
> > Are we still merging this kind of thing through your tree?
> >
> > Or does it make more sense for me to send this through my tree when I
> > get one up and running?
>
> Send it via your tree with my acked-by.
>
> --
> James Morris
> <jmorris@namei.org>
>
