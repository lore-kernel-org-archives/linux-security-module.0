Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB27C433EF
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Jan 2022 18:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242801AbiAFSal (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Jan 2022 13:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242723AbiAFSal (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Jan 2022 13:30:41 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B34C0611FD
        for <linux-security-module@vger.kernel.org>; Thu,  6 Jan 2022 10:30:41 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id j83so10046373ybg.2
        for <linux-security-module@vger.kernel.org>; Thu, 06 Jan 2022 10:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/xBmitbOHdtVQAn4LWhzl9UDVKn43GVAgVY+5ZmJg0=;
        b=lm4tCA4hSwJFZzf7M1gFEOFx/YaTAqH2uGxpeuV7H+Y+iFmSf3jqiINBDiM8dotE1g
         vh0i54AmsJdL94uLVUBeVn1plrq+pe0i4/s7wbo0u5kxm9Pg854TAdAgPziVoECNfuOh
         HNCVktu2dX/G3rQcE4kat9b/UOwrGrwCN3f609XUrSceea00L2mZ6+E3AoU5paWh7ZGM
         wRsCRhPvJ+24K79euDokqYoF8DBWbx39PWvVKhNGsyL4E8PsVByTd5TespNnQL3WRhOD
         UZVoDaaWi/McJeOCkN5unWvQI1dJcQZRgo8Xgfl0srCXW4S/hXkDHymr1f7YKmlVqfsa
         O9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/xBmitbOHdtVQAn4LWhzl9UDVKn43GVAgVY+5ZmJg0=;
        b=TOCVJZJBMmLOH44JM0KUjd4S1hfoRJNBaVBWCDJrA8NZ7nXZaSfYwDIxKD8qpK+Dce
         Fj08EchXpu4r35KezVRFs/F03Emdn4BtLkvnXMoS3kb9LhTd7mlT3ojBiaI5dIOketI+
         HsBd0B7pp2s1736BN4ZMeE72YkG2J+aDR80Rviar/U6osMRcJEPI03SVkIMRU31XCpSF
         XPomt+QCJT+X06BeHvtRSaMFYiVbVLZzVfh5REnb0D2kQSdiaV5o66ksR53IO0cz4pK8
         mOP2QiOJCq2nE8QLEhdmD/FaIrf7i7hPRZMNAxoNXC/9hHZUVy0DDjmpN1cUend1Gl/R
         9ayw==
X-Gm-Message-State: AOAM530nMZGxk+LC4PB/2UMdz7vzVMl4ap7BfuL39g62NH7chLTLhNjf
        PiuIuJvmJF+e7KLg6Ww0J10OfqM3BfxdO0XOnQ33ag==
X-Google-Smtp-Source: ABdhPJwIzJFCyAw+ArQRHeCJK7ZFP38UP4LYuFJ8oyZ4oXkOfDCeI4LeSPJ2rHk53N7EWrs6fXvjAHblXMh9kMG3QTk=
X-Received: by 2002:a25:d0d1:: with SMTP id h200mr8701861ybg.489.1641493840385;
 Thu, 06 Jan 2022 10:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20211229215330.4134835-1-yaelt@google.com> <db88a381739e08806e2370e8fbe8fdde82731464.camel@kernel.org>
In-Reply-To: <db88a381739e08806e2370e8fbe8fdde82731464.camel@kernel.org>
From:   Yael Tiomkin <yaelt@google.com>
Date:   Thu, 6 Jan 2022 13:30:29 -0500
Message-ID: <CAKoutNvX3S=TmhLFg9UVQaUjFbdp3brN5tUM3_QqBo=9d2Dw+w@mail.gmail.com>
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        Mimi Zohar <zohar@linux.ibm.com>, corbet@lwn.net,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 5, 2022 at 3:12 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, 2021-12-29 at 16:53 -0500, Yael Tiomkin wrote:
> > The encrypted.c class supports instantiation of encrypted keys with
> > either an already-encrypted key material, or by generating new key
> > material based on random numbers. This patch defines a new datablob
> > format: [<format>] <master-key name> <decrypted data length>
> > <decrypted data> that allows to instantiate encrypted keys using
> > user-provided decrypted data, and therefore allows to perform key
> > encryption from userspace. The decrypted key material will be
> > inaccessible from userspace.
>
> The 2nd to last sentence is essentially a tautology but fails to
> be even that, as you can already "perform key encryption" from user
> space, just not with arbitrary key material.
>
> It does not elighten any applications of this feature.
>
> /Jarkko

Sure. Please look at the modification below.

The encrypted.c class supports instantiation of encrypted keys with
either an already-encrypted key material, or by generating new key
material based on random numbers. This patch defines a new datablob
format: [<format>] <master-key name> <decrypted data length>
<decrypted data> that allows to inject (and encrypt) user-provided
decrypted data. The decrypted key material will be inaccessible from
userspace. This feature also acts as a building block for a userspace
envelope encryption capability.

Yael
