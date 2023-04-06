Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5E0C77B6C
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Apr 2023 21:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbjDFVnf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjDFVnf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Apr 2023 17:43:35 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B149EC5
        for <linux-security-module@vger.kernel.org>; Thu,  6 Apr 2023 14:43:31 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p15so47575758ybl.9
        for <linux-security-module@vger.kernel.org>; Thu, 06 Apr 2023 14:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680817410; x=1683409410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1tdf0dP3p75gbUDta1n8AoifAFsngGXYbbJDPtsRkM=;
        b=QzEtFGRK4tVy6vrykACos54k4DrpNuwx0yerPu+L2iq3tj+xVSO3bCsBid9PpH6Re8
         oGXqAG+7GQVUlXhpPE/Y47CoqaTo5yOxEUIFw4JWWYDp96DgxSd8VKiZvqsk7WRwMJ3D
         f6+TQpYHzy74SukPZZTn1+3pH3ups9FUbeJxY2fnZfCG/jO4ftB8zZ1GKjBsHhBm6Uh8
         vfg1BgXEac+Gr5liBZRuPy2xKMTAexZfr2edTqMPG6deGLFpKRWsj29b4jmmGUDXK07+
         e7DjlKS/5A5P4oiJf57xGdhNX4t3NTBFT8NLYYnE4Ox87h7tBHgrwtOx6a8eiI2Oizns
         wLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680817410; x=1683409410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1tdf0dP3p75gbUDta1n8AoifAFsngGXYbbJDPtsRkM=;
        b=qy7Hox0K+N7tCdiAP1YPQRsAQnpgXGmDqEn6sJqnciMc7XLIU6WlpnQO5/lYBt2FeA
         67jPUpA5ZYzp4Fyt74M+jhPnvf8VaRshtsoE3Ls8AEZd0L8REIMfKxPVl1PRLcTiCxyd
         Csav2sbKKhVU/ajeMks5XisX1Ki72ILTFjIPRUidfAbdgQGLojhNUCJwZuWpwFekVzCU
         T0YxB4MABZRGUOLUH8Rdw3YwoEcKjZM/iTHRw8lUcWC11c1JyU64WV+n6Z4XmxnkHF5f
         OojqdMKA9PBDDjdBwp9lJMy8KnMKFYteoLJ4yC8XqK+oJsfBjWLNOoZfNiwjQsDmymIh
         rSMA==
X-Gm-Message-State: AAQBX9dv6AlN77hA6j17BrRhhIe2fzhjYSYGKnUvKAdYtyOdS6EUwWvd
        JeaoPplflvsO8ib56yz/rpMzmjKJ1KEHnmPAlQxz
X-Google-Smtp-Source: AKy350a93oURm884448cScZMr43XclbJEAvMts5UQ3IhyvrDpsCB/FXb/NwAgsAxYWn6SCQyH1ilOk9yRUUHJF7OJdY=
X-Received: by 2002:a25:3007:0:b0:b76:ceb2:661b with SMTP id
 w7-20020a253007000000b00b76ceb2661bmr569159ybw.3.1680817410374; Thu, 06 Apr
 2023 14:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <ZC8Dbux56HbJjpTy@char.us.oracle.com> <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
 <ZC8eZ/RTX//0urV/@char.us.oracle.com>
In-Reply-To: <ZC8eZ/RTX//0urV/@char.us.oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Apr 2023 17:43:19 -0400
Message-ID: <CAHC9VhR06pa2mDwW26XFqiry11Ubz2_3YKj+ayftu0JdYx9m9w@mail.gmail.com>
Subject: Re: Semantics of blktrace with lockdown (integrity) enabled kernel.
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, nathanl@linux.ibm.com, junxiao.bi@oracle.com,
        joe.jin@oracle.com, Eric <eric.snowberg@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 6, 2023 at 3:33=E2=80=AFPM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Thu, Apr 06, 2023 at 02:39:57PM -0400, Paul Moore wrote:

...

> > Before we go any further, can you please verify that your issue is
> > reproducible on a supported, upstream tree (preferably Linus')?
>
> Yes. Very much so.

Okay, in that case I suspect the issue is due to the somewhat limited
granularity in the lockdown LSM.  While there are a number of
different lockdown "levels", the reality is that the admin has to
choose from either NONE, INTEGRITY, or CONFIDENTIALITY.  Without
digging to deep into the code path that you would be hitting, we can
see that TRACEFS is blocked by the CONFIDENTIALITY (and therefore
INTEGRITY too) setting and DEBUGFS is blocked by the INTEGRITY
setting.  With DEBUGFS blocked by INTEGRITY, the only lockdown option
that would allow DEBUGFS is NONE.

Without knowing too much about blktrace beyond the manpage, it looks
like it has the ability to trace/snoop on the block device operations
so I don't think this is something we would want to allow in a
"locked" system.

Sorry.

--=20
paul-moore.com
