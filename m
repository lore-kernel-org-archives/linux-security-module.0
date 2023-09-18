Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8517CD13D2
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Sep 2023 15:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjIRPSu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjIRPSt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Sep 2023 11:18:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FB6E73
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 08:17:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-404c023ef5eso28595215e9.2
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 08:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695050238; x=1695655038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3lFpWEQNX0RgOS+vwuIIC94hCwP0MrQhLUc3uHKyySs=;
        b=eiEci7qCy6lw3Eas2Sc0yeiGZiE2eCnRW0KuIIUmBA114vUTcBgIMlt/rEkdkrvSXU
         C6ArRKpz4/eO5oYjJ7jYw01DeQth5IOWjzYGyXgx7wWaT2Lm1sSWRXk4PeafB5Wf5xRh
         v4tF4cpBFyhSFVxeeBGPYXtRswEUnhqO+pqgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050238; x=1695655038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lFpWEQNX0RgOS+vwuIIC94hCwP0MrQhLUc3uHKyySs=;
        b=oYa1j+s7+59BR1FUPaolyL+8g1e8Pl+l7wHAs2CJgUtTX9elWBbTLbtLsY4qTnD1mx
         oOHlvWMMlFM2O7mRb5NvonJOnRW4rKY4S6ifqiHSQ/IyAaZMudcM2vugB/n2hovnKj7C
         ih8PBNkhUUgP6RB9EuVl89UARSsS2NWfktZEIALHln7qRkjaGPe9uVOcXX53rGrjl2zp
         EN+SiKmU5MAEDo2nPtlgrxEYuJfTKnfdub0aE/bsOVYLvcE6j+wPGyrucmJMkGP7ZGDF
         9YDxUtktfJDzdQk/5FphBLJEoyOcglBjWVFq0RFWwmes7UhjozNA2zf8oJz0ufOvip9C
         iM+A==
X-Gm-Message-State: AOJu0YwS+/Zaq6bWq8qMmo2TTQow9aWoyKHxH2ujKMoFHpO4SMdB5KbV
        LDSvthT4xXVzafCVLSHoBW4X3uStTFkZlJBpWrBSFtKs5tCetsWt
X-Google-Smtp-Source: AGHT+IFnzEkphfcA1k56lMmjABKC+h4WWJYwladyvHeyaRQV3hNEF1Dw61zv3yr9gv0EEochrOGS5dXCs2GS30BWGs0=
X-Received: by 2002:adf:a3c4:0:b0:31f:f664:d87 with SMTP id
 m4-20020adfa3c4000000b0031ff6640d87mr7329776wrb.20.1695048675110; Mon, 18 Sep
 2023 07:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner> <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner>
In-Reply-To: <20230918-stuhl-spannend-9904d4addc93@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Sep 2023 16:51:03 +0200
Message-ID: <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 18 Sept 2023 at 16:40, Christian Brauner <brauner@kernel.org> wrote:

> What we're talking about here is a nicely typed struct which returns two
> paths @mnt_root and @mnt_point which can both be represented as u64
> pointers with length parameters like we do in other binary structs such
> as bpf and clone3 and a few others. That is a compromise I can live
> with. I'm really trying to find as much common ground here as we can.

So to be clear about your proposal: .mnt_root and .mountpoint are
initialized by the caller to buffers that the kernel can copy paths
into?

If there's an overflow (one of the buffers was too small) the syscall
returns -EOVERFLOW?

Thanks,
Miklos
