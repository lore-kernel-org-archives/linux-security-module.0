Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C38C433EF
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jun 2022 23:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245496AbiFJXu2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Jun 2022 19:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbiFJXu1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Jun 2022 19:50:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECA81FD9E0
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jun 2022 16:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85674B837EF
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jun 2022 23:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52425C3411E
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jun 2022 23:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654905024;
        bh=KYBNepAhHucXR/PExiSlnZsz5w016fhUepMKAXCkf2Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TEJ+0qTrjUTppwQq46B8P08Up24ch5A0UAT1t0XIETLHr1thlvg9N9QRc5zjkDlHi
         5MSaZVhJPWISt+jwj90W6C5LpI5N8Pq1hssR7jFhfggaAn1i4FWqBgkGQN44+e1rW/
         gdrj7FAOK0Ctx7OHe5TXzUgcHSXDmx1PBdW7UzoBDwCF+f57vyvXRdQaL9FpJSxUTt
         84bW2NF6l2Pm7ZUjMKdagb8Q6RnT32yhLAuOEMjA3hQVU2mJNrd1Yz2hmEYISa3WqK
         8xLhEDxAh5FdR9svLsna3Wfk0jjl6Dq1Ob92do512k8aevjrR49wuCUHSHJbVas744
         PcjYyXT25/qmg==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-30ce6492a60so6096877b3.8
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jun 2022 16:50:24 -0700 (PDT)
X-Gm-Message-State: AOAM533RhcN9qm3TkLKn3FvaG6w7T/SgAUXCYieP+obj7GYavZ9eeAXS
        TCEFHcj5yafAnqfmJ3p87UXvbzjgPwtJEeczIb7YSQ==
X-Google-Smtp-Source: ABdhPJyMFUotmHwmu0OOQQuMr1PEE/e2CbP//1sfjX+Bie3qrJLHMs2/mlVzmMKQhswPv4i983EVi2fnRvzKOHD9lkI=
X-Received: by 2002:a0d:dd54:0:b0:30d:1079:4569 with SMTP id
 g81-20020a0ddd54000000b0030d10794569mr51097936ywe.340.1654905023434; Fri, 10
 Jun 2022 16:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220609234601.2026362-1-kpsingh@kernel.org> <bc4fe45a-b730-1832-7476-8ecb10ae5f90@schaufler-ca.com>
 <07babe1c-5ae9-a619-b159-f1bb7f3108ca@schaufler-ca.com>
In-Reply-To: <07babe1c-5ae9-a619-b159-f1bb7f3108ca@schaufler-ca.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sat, 11 Jun 2022 01:50:12 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5FcvY-UviCoynkNsxaSfv_mr61n0xgYpteCGMxTGPioA@mail.gmail.com>
Message-ID: <CACYkzJ5FcvY-UviCoynkNsxaSfv_mr61n0xgYpteCGMxTGPioA@mail.gmail.com>
Subject: Re: [PATCH linux-next] security: Fix side effects of default BPF LSM hooks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 10, 2022 at 9:00 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 6/10/2022 11:50 AM, Casey Schaufler wrote:
> > On 6/9/2022 4:46 PM, KP Singh wrote:
> >> BPF LSM currently has a default implementation for each LSM hooks which
> >> return a default value defined in include/linux/lsm_hook_defs.h. These
> >> hooks should have no functional effect when there is no BPF program
> >> loaded to implement the hook logic.
>
> What I failed to point out earlier is that you really want general
> LSM stacking for BPF to work the way you want it to. Reviewed-bys,

Happy to take a look, but we should fix this bug independently though.

> Acked-bys and other participation in that effort would be most
> appreciated.
>
