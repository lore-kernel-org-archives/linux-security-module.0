Return-Path: <SRS0=nw36=QY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2914EC43381
	for <linux-security-module@archiver.kernel.org>; Sun, 17 Feb 2019 01:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19B621A4A
	for <linux-security-module@archiver.kernel.org>; Sun, 17 Feb 2019 01:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J2EPDnet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBQBqx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 16 Feb 2019 20:46:53 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:46563 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfBQBqx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 16 Feb 2019 20:46:53 -0500
Received: by mail-lj1-f179.google.com with SMTP id v16so11417262ljg.13
        for <linux-security-module@vger.kernel.org>; Sat, 16 Feb 2019 17:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYURC02zndMJuPlQmj9dX+oEss1DwhQmZF2JgN/xq2k=;
        b=J2EPDnetfcR7ewv9DCz3GAGSRHDetrxzyr42yiAcT9gHMxPbtXJNOJb5bf4CCzS2Z3
         w863R81koXkUyKTbI8aHRlrjbj/hVDtxcGDUvIF9VMO/i6gcl4WudhCMGmAyLlT9k6Lm
         bMcikRM+13s7eKIdP/o4LwlDZvPYyB+DNtEDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYURC02zndMJuPlQmj9dX+oEss1DwhQmZF2JgN/xq2k=;
        b=Z+oqsqxGPki5/H0pC6gP7f2nLLCRdyGotlQB/lmTstqB2uYNoPPe2c38/4kWx9i4WA
         GtF4mwBsD5XzjxasIbdUlJINvG/6bum4bFiwJMEho32Zbq+yX7Rb7kDWmRD1L6ijcJ87
         IIkg4qAadDb/bFlRjJgvQpm/K2/uj1PtqfOA8OaQZUFldXyl3eao+Yn8GCR0PzVgzpt7
         LqBt2Q9jUhULC7wxjdgA4sG9+XgEdfMxXZYAfa5VDSTAS/DEV2Y4x2VlVA1pmVwaHSes
         hgGnVJ0Mnzj/r6tshytByR+PZZKsGUw6vH37nQ2BHqKRVyhAvxFs/Rkp12L6sNcgtTkk
         LNVg==
X-Gm-Message-State: AHQUAuYNPFMV4ZsHYJ59G4dcijfo7l0t1S+i1mQTcxtBIH+rWtoqPT+B
        olB50ENwNMRgGXrzoK/7pFfDDQT+8yk=
X-Google-Smtp-Source: AHgI3IaDsZ/RzVfXRNESrk00cOYtPfjE6BWQxPU/KwnviNlxJFPZvick9Xsr/9lHNKn4z1BqFme0gQ==
X-Received: by 2002:a2e:2f15:: with SMTP id v21-v6mr9931091ljv.56.1550368011143;
        Sat, 16 Feb 2019 17:46:51 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id d5sm2464621lfi.65.2019.02.16.17.46.49
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 17:46:50 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id z25so3623897ljk.8
        for <linux-security-module@vger.kernel.org>; Sat, 16 Feb 2019 17:46:49 -0800 (PST)
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr10033841ljc.22.1550368009113;
 Sat, 16 Feb 2019 17:46:49 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1902160914180.4453@namei.org>
In-Reply-To: <alpine.LRH.2.21.1902160914180.4453@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Feb 2019 17:46:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=whd_ZMx8bPMQ3vskz8+BHj_rZ38kX62d5=n9J4K3hM4-g@mail.gmail.com>
Message-ID: <CAHk-=whd_ZMx8bPMQ3vskz8+BHj_rZ38kX62d5=n9J4K3hM4-g@mail.gmail.com>
Subject: Re: [GIT PULL] KEYS: fixes for v5.1
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 15, 2019 at 2:16 PM James Morris <jmorris@namei.org> wrote:
>
> Please pull these fixes for the Keys subsystem.

For 5.0 or early pull request for 5.1? The subject says 5.1..

             Linus
