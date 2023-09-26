Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37965E7F141
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Sep 2023 22:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjIZWd4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Sep 2023 18:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjIZWb4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Sep 2023 18:31:56 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7AA158AB
        for <linux-security-module@vger.kernel.org>; Tue, 26 Sep 2023 14:32:20 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d862533ea85so9517392276.0
        for <linux-security-module@vger.kernel.org>; Tue, 26 Sep 2023 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695763939; x=1696368739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NY9jveINp5V5rlaBbscxlXmPxYesM9ges3+QHzPHTww=;
        b=JevHIhiYqEti5uTChAjUeDs+BEKCL2g/TRyKpHJ/sKw/h9kJ+4HCHHueL9YgowiXeH
         y+mmV6LB+UES6nnIE0g9mcDow3/ZHPCPRA5pmeJtKaqszxJpl0NT7ay2th4isuwERWRd
         6ifB8qXrbjG6XHh86W6nYjbJ42MprekK2a0jDJyRYz6wdUkKZDcVRoJbS8W75zZJ/ol/
         wjRxHQwuiELIsm0pgootgzP3h4C5nRtHxDOpGShBY4KEdcX1nWkWGPR50zOC0aZH70pv
         bM2ZAeX1I+fDiPw6Kc3dDttcv550is1BDPyTfxuXeB+7xXzhCZYRvFSfU+WatkBxmaVl
         Tq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763939; x=1696368739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NY9jveINp5V5rlaBbscxlXmPxYesM9ges3+QHzPHTww=;
        b=UD0g5QF/hTw1ZjLmOW4fC/q+KRlsR9t67FzpepLSrUPpfeLv9pxpPi4G2sy/jgBHix
         jHM6fkO4SkZJiYGu3ZJjAeLUozUe2f19I1wk01VEP1a1SGboihRAOpmpLhCKVWgxmZ1k
         sBl6joFQFGHaVMsxDWv8YCUw2W73oyTQiFsAoJGlMe+DbB89q1HRLeBK7l2Gbfyl8UNK
         0zyldumncCZKSr8AH4DWag518EG7ALJ4fmiccqySfPrA5+3IxVrBhSMxvRO00eeA8H86
         iKf7SsHL08SxBzQ8EMClzF1BXH5rPiLzH1b8TvYuziVV93868NhLz4qoH1D9PDy4oVjd
         Iy1w==
X-Gm-Message-State: AOJu0Yy0Be9yLOQ72tsXmuE+72mtR5RrmAcBnf/LbkZYW+TNtlKMGnbB
        qXXuNWN83Pf+PJlZCcnTu9E1fJ1w/G614qg6jRq8
X-Google-Smtp-Source: AGHT+IFCtQ0lRQAQtAczfLsb2sztHe5JKNKH8brd6I1PKgoiFWprOSxrLQWdFdj8Jz71vraPlw9N0n534XJeETDCyZI=
X-Received: by 2002:a25:d308:0:b0:d85:e4c4:4778 with SMTP id
 e8-20020a25d308000000b00d85e4c44778mr183132ybf.0.1695763939574; Tue, 26 Sep
 2023 14:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230912212906.3975866-3-andrii@kernel.org> <3808036a0b32a17a7fd9e7d671b5458d.paul@paul-moore.com>
 <CAEf4BzYiKhG3ZL-GGQ4fHzSu6RKx2fh2JHwcL9_XKzQBvx3Bjg@mail.gmail.com>
 <CAHC9VhSOCAb6JQJn96xgwNNMGM0mKXf64ygkj4=Yv0FA8AYR=Q@mail.gmail.com>
 <CAEf4BzZC+9GbCsG56B2Q=woq+RHQS8oMTGJSNiMFKZpOKHhKpg@mail.gmail.com>
 <CAHC9VhTiqhQcfDr-7mThY1kH-Fwa7NUUU8ZWZvLFVudgtO8RAA@mail.gmail.com> <CAEf4BzZ8RvGwzVfm-EN1qdDiTv3Q2eYxBKOdBgGT96XzcvJCpw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ8RvGwzVfm-EN1qdDiTv3Q2eYxBKOdBgGT96XzcvJCpw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Sep 2023 17:32:08 -0400
Message-ID: <CAHC9VhTLnT6HmkvJBXVCApHG4sCFdgXxJykPQ8oYLaVa8vXWkQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/12] bpf: introduce BPF token object
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 22, 2023 at 6:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> No worries, lots of conferences are happening right now, so I expected
> people to be unavailable.

Just a quick note to let you know that my network access is still
limited, but I appreciate the understanding and the detail in your
reply; I'll get you a proper response next week.

--=20
paul-moore.com
