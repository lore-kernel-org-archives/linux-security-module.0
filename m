Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6EDC19F2A
	for <linux-security-module@archiver.kernel.org>; Sun,  7 Aug 2022 15:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiHGP4r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 7 Aug 2022 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHGP4p (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 7 Aug 2022 11:56:45 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72295BD
        for <linux-security-module@vger.kernel.org>; Sun,  7 Aug 2022 08:56:44 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso5004784otb.6
        for <linux-security-module@vger.kernel.org>; Sun, 07 Aug 2022 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tnkMy90miiYykpI+4R1JbqPUfm8FqXUj36yuJdO5lZQ=;
        b=04TcRDDnQ/n11tjO3q2a9hJ4jGbfIbJaW7mx0SB6gZ5L4yoY8n3fLm3er880S4x4iX
         vzYte+KixhJeKl+VthtAq3fFD9LJarWfY356ntsGb0STqseQGrOP8MkME58FPFPcj90Y
         +YDXcGXh6AOQ5o819qrFPx/RP3vmykt6X7yuBOwyAod3AxgrwanNJnphHPRRLfNtyv1B
         7aLSl1pfs7CDf+d2xNRPQEzeg1qEsccxszVPUxCxyCOPlVPaKSpJh6cokkwKcaUEhg7R
         6WV868ttwy1j/VZoWibA0kF/REF19gC7jVCOCpRwUG4OrjHIpd5odWIcx6xBFbJ0xuYt
         yvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tnkMy90miiYykpI+4R1JbqPUfm8FqXUj36yuJdO5lZQ=;
        b=Jp1aKR/16Tot/g9eGl9Rt1Ud94WXQJYN83Ec81hGmtQEmqTRxC1wiEQcR2sbe2pxys
         Ck9uYjNByJIzOLdOhxiZpqogv3j3KWHphjCGGNzCyvXv6f9xuca4FYtfwk5Ohot/5d5e
         cQesSZ6DmhMbLPhwnVheMAZl7GsVa7VpVPoCYwgEUb3ro6h68spsBdImpgqQirzkxjgK
         pjCSCEc6IMol2+Atike5Umsg3PHQRYK4I3YPSqyh+10dangQEFXm+W+GlerIrK7Dw7bJ
         vHzA9pyPk3m8fqT7/81vuym4wqqHrwfkxS70j5R6FXWGm8uHSNlIlpnUSZZlZPMtjNCh
         udxQ==
X-Gm-Message-State: ACgBeo2Fdtf5AfrJ8qms/CqV6abknDLs/qTMwPw2XqI+fs2AvSOeoYK5
        h3DVgyxpqDRFsx+mDMgpLJMJW78ic2ZxVwNG2wmb+4YNRQ==
X-Google-Smtp-Source: AA6agR4Jo+rOQva+fvprNdCfYk170dTkQW52EuCCfVrlN5lste6gHm1XEEVirBB3TnHF9GTNsVkrILmixIDOMbPMhIc=
X-Received: by 2002:a9d:4d13:0:b0:636:bdd9:b57b with SMTP id
 n19-20020a9d4d13000000b00636bdd9b57bmr3280310otf.26.1659887803849; Sun, 07
 Aug 2022 08:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220806101253.13865-1-toiwoton@gmail.com>
In-Reply-To: <20220806101253.13865-1-toiwoton@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 7 Aug 2022 11:56:33 -0400
Message-ID: <CAHC9VhQz_gcJHuKEpkJTgOw1PLHNoEY+vniEpW+qs=76w0eLPQ@mail.gmail.com>
Subject: Re: [PATCH] netlabel: fix typo in comment
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Aug 6, 2022 at 6:13 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> 'IPv4 and IPv4' should be 'IPv4 and IPv6'.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  net/netlabel/netlabel_unlabeled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for catching this.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
