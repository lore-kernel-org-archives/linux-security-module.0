Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F914EE49A6
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Aug 2023 10:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHUKz0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Aug 2023 06:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjHUKzZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Aug 2023 06:55:25 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9142DE1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Aug 2023 03:55:23 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-64f42fcd809so3957986d6.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Aug 2023 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692615322; x=1693220122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiI/WQOuZTfR/t2f6lJi1LF56QHzapL/gSCpBEw2/yI=;
        b=voaF9uP3moLZFKmDpjoVS5/VO/S6kYiSBNTYymR1j73z7PoSrQ1s6VP0BDhTvFbm55
         47+aPF1HBWybY5GORChwQ8XPjPvBxIHJjtb7/+tHXqLwoByMxyoRKpYiSM7V5TMGwBpc
         uaDXdSlNPlg7soenxcXG85MEaQX0KmZStM1bGmAH1+NX3+v26r+0H1NRUKqUFJqb3DkN
         PSxNi5d45d+AgRBY1HrtiDFQH4r7FmnixPJXuGuSlTi5LrqQgRl5QXFAoudUQheE0oTz
         ODeRABiRk4fXvbW8uYFfzprhwMY9FPETVIW3Ok4NmIlsN5liVC5mP6M8D4uu9dXgsvtG
         YzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692615322; x=1693220122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiI/WQOuZTfR/t2f6lJi1LF56QHzapL/gSCpBEw2/yI=;
        b=GOlHK7LwNlp4PNxzyyofv9S2ZPv3cL9EpYgPAkH3UYExu67iro9Gz6UVH27pQifVgc
         2xmoXqtxs4uuxcX73KsFvs8DdbaIK9HXX1XYLAiP2kR9b+sL7E166KSA8zq7jSqQ/NmR
         1lBsaQ0BjgQBTvPXocm2Vf4ZBQ1D+k/2cuN51BY2Lhrh6ScE8Jkkgk6ag7hQ9wNgbX1e
         31Fg5KCTzGYBF9XxrcgbRfyLzCVNiHGQKWlndlabX8qzbcA20j3gQgGq/Fmtid4L/cep
         L4F6G3qwaKUbyVdAzO4hANT4oIqA8GQypG27UMDoX3rnJ3BuJujB0nECplFFd3wc4v15
         mJUg==
X-Gm-Message-State: AOJu0Yw0nrsbaQPad29bNJg0lvblHnT7DfQo8lKS/TqbEMGFXdFPjvKr
        xhF7d2Ggr7uFZKO/hil+GnYw9TTTd0NmDa0Yj6AydQ==
X-Google-Smtp-Source: AGHT+IGhBYQ09T4ZsvRgLhFVbDcJZ6bPFOy6hWqSHBVAWat7aAmK5pCE/wWJSXRBSvLxvq4t8vX4VWqE8CWt7pRFElg=
X-Received: by 2002:a0c:f910:0:b0:647:248b:3614 with SMTP id
 v16-20020a0cf910000000b00647248b3614mr6297972qvn.4.1692615322740; Mon, 21 Aug
 2023 03:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230803123515.4018838-1-jens.wiklander@linaro.org>
 <CAFA6WYMzBJTNUxh6b-y=a_NND8FX65YjEP4i-HPS4tQ-Qfm+0w@mail.gmail.com>
 <CAHUa44ET3Oqc4Yq8E4ouAjn5dF9ygxoXyWh0sjFF_vPoooxrnA@mail.gmail.com>
 <CAHUa44HpkxDPgdh1B_bFOVPSOETk3F_ZicdnhmuVOux+5fd7sA@mail.gmail.com>
 <CAFA6WYMdROqkNbfbOkm22AYR1vnNa83dttf-4rF6pp1dZDym3Q@mail.gmail.com> <CAFA6WYOhSAY68S=pqW5=YU=gCo7LHYELt1A7mAx-0revWH5XpA@mail.gmail.com>
In-Reply-To: <CAFA6WYOhSAY68S=pqW5=YU=gCo7LHYELt1A7mAx-0revWH5XpA@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 21 Aug 2023 12:55:11 +0200
Message-ID: <CAHUa44GjxLxzDSRsufvR35HRYpJ0S9iAXaN8cMz-V1B=HVBzHw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: use tee_shm_register_alloc_buf()
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 21, 2023 at 11:35=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
[snip]
> Actually thinking about it more, let's rework
> tee_shm_register_kernel_buf() to be tee_shm_register_kernel_pages() to
> get aligned as we agreed here [1]. This would then shift the
> responsibility to check for duplicate pages to kernel clients rather
> than the TEE driver (don't need to bother about sub page buffers).
>
> [1] https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedf=
irmware.org/thread/Y224PTCQZPKLH2INVWWPRUZM4MDUPYL7/

Sounds good, I assume this will not affect tee_shm_alloc_kernel_buf().

Thanks,
Jens
