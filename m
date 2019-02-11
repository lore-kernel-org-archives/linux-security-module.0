Return-Path: <SRS0=hX+A=QS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C60BC282CE
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Feb 2019 23:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36AF217FA
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Feb 2019 23:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jIB9jrQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfBKX6v (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:58:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35215 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfBKX6t (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Feb 2019 18:58:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id j13-v6so634810ljc.2
        for <linux-security-module@vger.kernel.org>; Mon, 11 Feb 2019 15:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQ9txClnOPvA0+cE2XnrMxnAEC+EkIsS3jsP+3nl88s=;
        b=jIB9jrQDIwkxZZ+wUU0WeTmD5cLa4ytsZ1MIz7n7oCqoEeNFfLIdKDWrKApMmOW+Ln
         xocjIC4KVOr7KS6PChBNyR1ylaI4te6sFtZNg8ln08rU2uOySGUlBXifjVRlangVqXza
         j602TKJISQ04y9+ggEAq7YihPq62Kp36/Kqt7Jo6R32Qb/S2Leya0aT3PWSRRiCWrZ/C
         cX63BQHYgPVuEQk3OsPz5JVvBCIVjEEP8XJXUACyWHVFsRsBpKQCHImF+x14pJuztRqM
         6FUmBMCkh0j8febJ82HL8ZnwwCzpX6E2YDpM5AV7/JVreOeyGHiAe7x/weJdOOrrfVxh
         UZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQ9txClnOPvA0+cE2XnrMxnAEC+EkIsS3jsP+3nl88s=;
        b=eyrEltZ99Q5jyt91aFOTNt31Sp58SVKwg40PVwdH3qcMSVLWa9XsmZuLIXDwMaV0my
         Q4qiScMRIzsTfdp2G8Wxp1n2gUGdXB9xzQHDWKSX8ezmVULo2/uAzCNVHAHhXqXK5I5y
         UR8r+DHHNKtwE6x8p6S1+Vx/kTTyAA7a4ftbyAl7EtxvHrp7tretZeTLonPc7w3cpWPE
         pMaYET1dgVqo4B4Q7g6sF4AhLmef89ZyFsckMpYm6Rds/dDm009rt/xAZEoMENM7HITV
         uK2IO0tPfK2dqjZ1nVaIdmBtA3ex4otcbRhfP/t/+g7judTdNNJPbXyajUTa95Jx0Mas
         hO2A==
X-Gm-Message-State: AHQUAuaKPFRGweIm0slXf5HRVWcydpsH/wL/2SCr0JXSM9KonvTcSycu
        VQccwLseHZwnbpie3BmsCVsl+YXTfN2cDJsa4hQK
X-Google-Smtp-Source: AHgI3Ia+fugU3WxSw0hRef3spzflVqQuPnFKiuGYMeYyfQpiMVTqCCjEFp92JiD38oGM3QRzPO1AsguFoBBYj54UINI=
X-Received: by 2002:a2e:3308:: with SMTP id d8-v6mr468911ljc.38.1549929527195;
 Mon, 11 Feb 2019 15:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20190205110638.30782-1-omosnace@redhat.com> <CAFqZXNuW-ZAQ5Be2b+R4WRr33JCpJXK8OZ0Qv8uD8Pxcwk7Biw@mail.gmail.com>
In-Reply-To: <CAFqZXNuW-ZAQ5Be2b+R4WRr33JCpJXK8OZ0Qv8uD8Pxcwk7Biw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Feb 2019 18:58:36 -0500
Message-ID: <CAHC9VhRNS1+zqTcc5rYiCrT7LGEX08BPpZLeOAe1YMUUzV3cKg@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Allow initializing the kernfs node's secctx based
 on its parent
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 11, 2019 at 7:08 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Are there any further comments/objections to this patchset (other than
> the duplicate include in patch #1)? I'd like to accumulate changes (if
> any are needed) before posting v6.

You might as well just go ahead and post the v6 version.  Since we are
at -rc6 now it is a little late to merge this into selinux/next for
the upcoming merge window so we've got another dev cycle to sort out
any issues.

--
paul moore
www.paul-moore.com
