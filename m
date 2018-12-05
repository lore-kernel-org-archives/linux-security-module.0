Return-Path: <SRS0=Kshx=OO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905D1C04EB9
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 18:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A958208E7
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Dec 2018 18:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="zkst2v3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A958208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeLESLV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:11:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38004 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbeLESLV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Dec 2018 13:11:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so9373097pgc.5
        for <linux-security-module@vger.kernel.org>; Wed, 05 Dec 2018 10:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dHs1/wnA5kau1BlwTTV1S70YNYRjbtdHe8UbXC6cJCU=;
        b=zkst2v3+yeUXRx7Yb6hmBe0wWE3VnD63dnMHQJaacJd4lxmiNO1VA4W+0LUCt0Wey4
         CVBvlOfr6xgQ3DaThmYTIzNT8A0RfFzYoLfzSNlgYeRiePptUVcCI7Jqs0LRK2iSZ0hG
         458JqAAJ2b/AURSueAv5JOOMRBaIT0ix+17mlj0fjoqOQVlYiWjBtX8MqyXm8lfj+SGx
         f4uLEhzFrSnaTFFU28bBurTBoGwptlh35PQc9KFLzGjsO63b1lal24yGGDSYvzMuiJk+
         r+l8VHFmhoAVmIgjmUmpZOBLqVpkcBy6UswR+wqzvRelxOqTwEfQTtKaF906FHLJlC5e
         R0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dHs1/wnA5kau1BlwTTV1S70YNYRjbtdHe8UbXC6cJCU=;
        b=KIObYz9nxER5E3vvZ1YeRgnv7rd1JxIHUUJyQEbXFt3zitwYEWp1EVS0BRWXqaMKDn
         8Tz1mQvrJhcT8A+wcYDdeKuXWQtVJE6D1TMx8LK7aGOiffeNDKSioXZeqR25K37zWNRn
         rnInOnYRR+v3wpfu6g9BypgvW6wI3tWvVnMvnUdyFj39la6Q0FXrdSIC9tzhZjrJ3GIY
         vLS+lAmr9GRcU33i7Jbjs2yWtxMinprMcQJIbxNwH1jNXkczy2Unn+jMblW/kB0X++Dp
         ILzCRJ11ctR6Xfj5hy+3FFVm4Id0atheDfIKwrg56/DfQVWOLIstB7gvKgKkb80yBC6z
         RAhg==
X-Gm-Message-State: AA+aEWZXK1cglTak6/HwPLhhDwQaF1k4IEteoQcMsL4+JYagblN7u/kY
        fL4Am5N9L1kssXEcZe9uv6UgQQ==
X-Google-Smtp-Source: AFSGD/U3lDF64fSVoaHoqppLHVKRLgdHSJLIF2o36/YUvTheibXICzmh8htZ5ur0tkradGUyRr+PKg==
X-Received: by 2002:a63:7219:: with SMTP id n25mr21567382pgc.324.1544033480412;
        Wed, 05 Dec 2018 10:11:20 -0800 (PST)
Received: from ?IPv6:2600:1010:b02e:9276:6d8e:d9d7:f284:ee8e? ([2600:1010:b02e:9276:6d8e:d9d7:f284:ee8e])
        by smtp.gmail.com with ESMTPSA id x26sm26348265pfn.50.2018.12.05.10.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:11:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v2 01/13] x86/mktme: Document the MKTME APIs
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <c2276bbbb19f3a28bd37c3dd6b1021e2d9a10916.1543903910.git.alison.schofield@intel.com>
Date:   Wed, 5 Dec 2018 10:11:18 -0800
Cc:     dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org,
        mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4ED70A75-9A88-41B4-B595-87FB748772F9@amacapital.net>
References: <cover.1543903910.git.alison.schofield@intel.com> <c2276bbbb19f3a28bd37c3dd6b1021e2d9a10916.1543903910.git.alison.schofield@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



> On Dec 3, 2018, at 11:39 PM, Alison Schofield <alison.schofield@intel.com>=
 wrote:

I realize you=E2=80=99re writing code to expose hardware behavior, but I=E2=80=
=99m not sure this
really makes sense in this context.

> .
> +
> +Usage
> +-----
> +    When using the Kernel Key Service to request an *mktme* key,
> +    specify the *payload* as follows:
> +
> +    type=3D
> +        *user*    User will supply the encryption key data. Use this
> +                type to directly program a hardware encryption key.
> +

I think that =E2=80=9Cuser=E2=80=9D probably sense as a =E2=80=9Ckey service=
=E2=80=9D key, but I don=E2=80=99t think it is at all useful for non-persist=
ent memory.  Even if we take for granted that MKTME for anonymous memory is u=
seful at all, =E2=80=9Ccpu=E2=80=9D seems to be better in all respects.


Perhaps support for =E2=80=9Cuser=E2=80=9D should be tabled until there=E2=80=
=99s a design for how to use this for pmem?  I imagine it would look quite a=
 bit like dm-crypt.  Advanced pmem filesystems could plausibly use different=
 keys for different files, I suppose.

If =E2=80=9Cuser=E2=80=9D is dropped, I think a lot of the complexity goes a=
way. Hotplug becomes automatic, right?

> +        *cpu*    User requests a CPU generated encryption key.

Okay, maybe, but it=E2=80=99s still unclear to me exactly what the intended b=
enefit is, though.

> +                The CPU generates and assigns an ephemeral key.
> +
> +        *clear* User requests that a hardware encryption key be
> +                cleared. This will clear the encryption key from
> +                the hardware. On execution this hardware key gets
> +                TME behavior.
> +

Why is this a key type?  Shouldn=E2=80=99t the API to select a key just have=
 an option to ask for no key to be used?

> +        *no-encrypt*
> +                 User requests that hardware does not encrypt
> +                 memory when this key is in use.

Same as above.  If there=E2=80=99s a performance benefit, then there could b=
e a way to ask for cleartext memory.  Similarly, some pmem users may want a w=
ay to keep their pmem unencrypted.

=E2=80=94Andy=
