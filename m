Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D04C6FD1B
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Mar 2023 18:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjCFSt1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Mar 2023 13:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjCFStZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Mar 2023 13:49:25 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32811A658
        for <linux-security-module@vger.kernel.org>; Mon,  6 Mar 2023 10:49:23 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id ce7so6472367pfb.9
        for <linux-security-module@vger.kernel.org>; Mon, 06 Mar 2023 10:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678128563;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/dAOgGOb62V2zK33/81eVK4BPQmGGtO54/EVqtNnL8=;
        b=cnQWTgpAjPCUocNlZLqXEIJBBsS84oCi683vzHQyGg2JH6hkkUuPu1Sn8otDPVsXMf
         vqXVrvuwUDR/Q72TPQMKrxMJfm+y1LBTdfvDv7gtEBUYp9NcD0B1VXhKDOLssVxEaqtz
         G7rj4+Yr+xA55rRjXQYngOFBYx6Lnrx/xYorSKaVrGFH0Mq6YBykH0ZuCkPjj9KTJtjv
         1qIF14ehwpOiyf/JHdBmeewCGgyLaRDojn0/AfJAVTrOxiQW+2kqk0xU7hqUWJkXL8l4
         PO+gsvpZ+VFEqkZ4tkfOaivvVWvbt3Q7TIAPrlAFw9BSzUI2ZqnShBFYchEARZVlFaae
         ThUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678128563;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/dAOgGOb62V2zK33/81eVK4BPQmGGtO54/EVqtNnL8=;
        b=N4dfsDaHeRpyo1yNfa9gMenvVrrJL0IVLcNfeERC8iHN0AFYFQ/CegdK/juYH8i7Yl
         037H6JfuAQRSGJKzs8kdZoBByg4upD6yvVYia4ih9Wm2H56+d24uVVzldMcROKTpJ0it
         NVSaYuPLFkVFdLq6Y6SVJTCPYEGhADjOpzPRVzTzjWX6IQ0wYfbuxOkfdqTUKIEoOpJH
         TZhz8xXUME6oD2mjKBkn2q0Sgk3LfqyIRlPNs2jdvP+dn7RoQOfx2Hr+EKudCQYoUCa8
         TQQ42pFJKCR5eLZ/7+wHzx6BWFr66YCtRciG9MVghXuN++LejrFUCvcb2JFd5CkRJg/Z
         tmuQ==
X-Gm-Message-State: AO0yUKXrfFJCey7ZZOnvVLCVOQumbA7WbDy/xs0DGY7Xpwqj6qE55IVT
        9MKYFMaPvlnRtwayseq2jFIVi3D0EUbvQUxZbCqyIkx9YzahMGw=
X-Google-Smtp-Source: AK7set8LEM5ZX5HiwnKTkfyvG2DmWZOrzjQVvz/WzYzvwLIb0pNdXfUjgqzeVxFTy33HlGhrpOqKS5hrwJRb9SIxi7M=
X-Received: by 2002:a65:6a85:0:b0:503:25af:f50d with SMTP id
 q5-20020a656a85000000b0050325aff50dmr4135924pgu.4.1678128562622; Mon, 06 Mar
 2023 10:49:22 -0800 (PST)
MIME-Version: 1.0
References: <20230217032625.678457-1-paul@paul-moore.com>
In-Reply-To: <20230217032625.678457-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 6 Mar 2023 13:49:11 -0500
Message-ID: <CAHC9VhQnjmX9n2KJhj97SnQfuO50kaJxX3p8p4gHBC5mBkLfxg@mail.gmail.com>
Subject: Re: [PATCH 00/22] Move LSM hook comments into security/security.c
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 16, 2023 at 10:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Hello all,
>
> The LSM hook comment blocks are a in a rather sad state; separated from
> the hook definitions they are often out of mind, and as a result
> most of them are in varying levels of bit-rot, some severely.  This
> patchset moves all of the comment blocks out of lsm_hooks.c and onto
> the top of the function definitions as one would normally expect.
> In the process of moving the comment blocks, they have been massaged
> into the standard kernel-doc format for the sake of consistency and
> easier reading.  Unfortunately, correcting all of the errors in the
> comments would have made an extremely long and painful task even worse,
> so a number of errors remain, but the worst offenders were corrected in
> the move.  Now that the comments are in the proper location, and in the
> proper format, my hope is that future patch submissions correcting the
> actual comment contents will be much easier and the comments as a whole
> will be easier to maintain.
>
> There are no code changes in this patchset, although since I was
> already adding a lot of churn to security.c, the last patch in this
> patchset (22/22) does take the liberty of fixing some rather ugly
> style problems.
>
>  include/linux/lsm_hooks.h | 1624 +++++++++++++++++++++
>  security/security.c       | 2702 +--------------------------------------=
-
>  2 files changed, 1710 insertions(+), 2616 deletions(-)

Seeing no objections, and the ACK from Casey, I've gone ahead and
merged this patchset into the lsm/next branch.  There was some minor
merge fuzz due to the mount idmap work and some IMA changes, but the
vast majority of the patchset is exactly as posted.

--=20
paul-moore.com
