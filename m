Return-Path: <SRS0=PFxj=WK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D37C32753
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Aug 2019 18:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF118208C2
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Aug 2019 18:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1r/DABm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfHNS0h (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:26:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44586 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfHNS0h (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Aug 2019 14:26:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id k22so5128558oiw.11
        for <linux-security-module@vger.kernel.org>; Wed, 14 Aug 2019 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfyRu4ibitmm3pHCIVTqboy1nh122UXrIHXc9FisTzQ=;
        b=s1r/DABm3Lxm1IM+J0548Ug6K/p4j03EpJbZ2LUknFrOOhDYffr4jH/1moRUGsxDQC
         Q3LFdRxY1UFA+QqgFO9mzrh+UxmYXm14v3fEGCJw3GwMt+5agR4GVvoa1VIxXXLqXthH
         UMMTCv1u/rO05ZhO3/qXrew+iAynRB58TBKY8jHFxZJ7wsoFflq5UIp/Zmr6PaKCcBzR
         CeWBbrjPgvNyclh/XYKG2nc6xO6h7G834XQ/e+B0Jc+1gBQRm4x4CLEidJRJ0TUH55Y+
         1DolcnPb+TR08Em8nQa1jHMhXs+Vj0SyEty/MP6V8w9h+Ijp/swpQJUdgB0k9zwlp6NQ
         EMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfyRu4ibitmm3pHCIVTqboy1nh122UXrIHXc9FisTzQ=;
        b=TX/MLnbQr4GKmjFYHErDgU5KAwEBE24g0vbmFtb6lLoV6FT95+jCaUy/ma4tp77aNq
         i1F76yMGTkpVG1dEI6xxmJ71RTz5TtAS2I5erXwTMOcahhJnqrWvjiu9AVmlwve+N8vs
         7AlLZ6WR5DJGAE6Hq1qrDTsaD4VmvVssQ9/lCH79OUN1Zi0p6R2JRDjhaYS0wplZY4jp
         yJEPP+FDBwflcPP8SuiGCBgYP0JoOjqR4uk0CUawthVU991vpAI0x+fcgUO8NXDeM57W
         rhBwj4pvRBINlju3NV240HQL40xByKERqexCzvY6pN9B34taBnexHLIX1nWP47nBMTpS
         q7Ew==
X-Gm-Message-State: APjAAAWLK5QHA3+Zw6/K6aeNOB8relRmqeAN8ZQOBuQp3XP0LqseSBo1
        FMgymaKjTtyInNx1/+bvcWxLobm3fEqJVZ+lX9yAZ37nPYmrOA==
X-Google-Smtp-Source: APXvYqzTnkpONgBon9dZvZD4CoK8FabGP4DBvXcABAcsXQoZKxAHUyWIKJb6tgkeZfc0VgkC6mksocgrV+iXSl2uy40=
X-Received: by 2002:a02:a88e:: with SMTP id l14mr663116jam.105.1565807196021;
 Wed, 14 Aug 2019 11:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190813192126.122370-1-matthewgarrett@google.com>
 <alpine.LRH.2.21.1908141503240.27654@namei.org> <CACdnJuvXpJoai+H7WeM_TNk2cjqr8evAm082aJgBRGvsUyaAVw@mail.gmail.com>
 <alpine.LRH.2.21.1908150423100.31503@namei.org>
In-Reply-To: <alpine.LRH.2.21.1908150423100.31503@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 14 Aug 2019 11:26:24 -0700
Message-ID: <CACdnJusMnDOcWq5LW7w1=F1vFN0qYxTDK7YRyQgLo1uHC+gqhQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] lockdown fixups
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 14, 2019 at 11:24 AM James Morris <jmorris@namei.org> wrote:
>
> On Wed, 14 Aug 2019, Matthew Garrett wrote:
>
> > On Tue, Aug 13, 2019 at 10:06 PM James Morris <jmorris@namei.org> wrote:
> > > Which kernel version are these against?
> >
> > Crap. Sorry, these ended up derived from HEAD. Let me fix that up and
> > resend. Sorry about that!
>
> Do you have an upstream dependency on Mimi's code in -rc?

No, there's no dependency, I just ended up with an additional hunk
when rebasing.
