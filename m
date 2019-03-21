Return-Path: <SRS0=tbeH=RY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB2C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Mar 2019 17:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAEF21902
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Mar 2019 17:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jId7oF8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfCURsG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:48:06 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38426 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbfCURsG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Mar 2019 13:48:06 -0400
Received: by mail-ua1-f68.google.com with SMTP id d4so2206242uap.5
        for <linux-security-module@vger.kernel.org>; Thu, 21 Mar 2019 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zzVMeVxXrLqpS7aSa4juekSEPE0Xh002mmSoBYo4YiQ=;
        b=jId7oF8kAwhY1nl545TSL4SqOZ4eoRxBLmA7XQC0Xq1HJ/xMDrssS0O7fretHJZFA6
         p4v/vIIPw9qSOFwB21ra5bu4D2vgVfebYjdk4tjRFgg9JocJ+7CrXn9IWNu3MI7t5FIB
         knJnaN0y4UalpowWJrIYN2brgdCGvKzf+xFCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzVMeVxXrLqpS7aSa4juekSEPE0Xh002mmSoBYo4YiQ=;
        b=RPNa+djBQsjDjW5fqyuI31aDmOzj740y+qXiIMwLLOtOD8loiGMGeUwHdYE+Ucs6+J
         dm11ISmFsSEaoK0H5lvYBARhK2mRhA48f4vMdvvt2j563/4q0XWkYgdcRbqij+sqvUyD
         3gu3sgYuc1yEdOAdONFYR9u6L26RZ4MEjjWc1RaW2A37EfoYTzoTEpTPT6G4UXywTAXG
         zPibrN6TpHPZZEarfFotTvHPOayR2z5FGpS7WEP58J4566RLVTpzCMTlyeYaR9R4m7Tv
         x4vNLZG6HD0jqNS0U0d2FWn/N3b6CMaUsPGMW3HOErzbKN0cC7LYBEVmobSRQb6W58g1
         cj+g==
X-Gm-Message-State: APjAAAW5wZ+maBVw+3mAkEdWxHeHMgMj3PxJAdy/M6NQL+58oxK73dVS
        O8lobdF0ZaLidz8kbwYR006nfKAkTwzGhw==
X-Google-Smtp-Source: APXvYqwm8vRrMt0eB2Kyygmjb7b6mNaXrWSatnEZ8NH3LD8TLHYqApmo8VjwNbO/sXVk8EXIZts4cw==
X-Received: by 2002:ab0:3145:: with SMTP id e5mr2548266uam.65.1553190485139;
        Thu, 21 Mar 2019 10:48:05 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id z135sm1589558vsc.11.2019.03.21.10.48.03
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 10:48:04 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id e1so4205163vsp.2
        for <linux-security-module@vger.kernel.org>; Thu, 21 Mar 2019 10:48:03 -0700 (PDT)
X-Received: by 2002:a67:e881:: with SMTP id x1mr888484vsn.48.1553190483609;
 Thu, 21 Mar 2019 10:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190308132701.133598-1-glider@google.com> <20190308132701.133598-2-glider@google.com>
 <CAG_fn=U6Rvg9S0AxLun0oHVx9i=JFc0Lzb+rvkiQn1sTHd-caA@mail.gmail.com>
In-Reply-To: <CAG_fn=U6Rvg9S0AxLun0oHVx9i=JFc0Lzb+rvkiQn1sTHd-caA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Mar 2019 10:47:52 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLjkBTTg0k32OPSM9TY9XorU_iYKUDL0L1aYWfhuREy1w@mail.gmail.com>
Message-ID: <CAGXu5jLjkBTTg0k32OPSM9TY9XorU_iYKUDL0L1aYWfhuREy1w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
To:     Alexander Potapenko <glider@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 20, 2019 at 7:44 AM Alexander Potapenko <glider@google.com> wrote:
> A friendly ping.
> Please let me know if I should wait for any upcoming changes to
> CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.

Hi! Sorry for the delay -- between the merge window and travel, I'm
still a couple weeks behind. I should be able to look more closely at
this late next week.

-- 
Kees Cook
