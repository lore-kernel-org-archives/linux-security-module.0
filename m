Return-Path: <SRS0=mt4R=CN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D487CC43461
	for <linux-security-module@archiver.kernel.org>; Fri,  4 Sep 2020 21:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C1B208C7
	for <linux-security-module@archiver.kernel.org>; Fri,  4 Sep 2020 21:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DhemKUhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgIDV7X (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 4 Sep 2020 17:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgIDV7W (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Sep 2020 17:59:22 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A080C061245
        for <linux-security-module@vger.kernel.org>; Fri,  4 Sep 2020 14:59:21 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a26so10507366ejc.2
        for <linux-security-module@vger.kernel.org>; Fri, 04 Sep 2020 14:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5sj8Qs8D244b3DypbkVLK9SyzByIH1TSJxbsczlHJv0=;
        b=DhemKUhWJ1l++sfpfTPanfr2H5ctoJjFoQYr2T0m0NMZWUZuuixxnUF3vFHS6Vuc9M
         B2aFtIvz2x98v6Aei58a0BVXpOj4o5KpCmbs41waO1Uu7BTlHU0n39LzeKSYWuG07zUN
         rRTZvntMJbTDhWwI/fQOvTr5LruA9Ao8BvpWGsHETFYVauFbIc08/LUN6Pb9cJoN38FF
         3Rt9sYCffUlLNzUlf3+wA3QC3jz58jiMuQNuoa0x2AFJFmvwrrK2HTVSDGgK/lVTeDFW
         5EiBQn47TSoiw5/uhVuPpZzfpVQbiLRREYHDOBtjN+Px9GqUtBF9PdrY6SQ0ZrmRG9zs
         aoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5sj8Qs8D244b3DypbkVLK9SyzByIH1TSJxbsczlHJv0=;
        b=sG97pr1YWefoBtI3OSN6xCQx4nN3TH1tTYCyqvKiUdh/qLycMHAQKwYHI040bTfBXS
         AJlngi3bIkYGSx1rNG+sn1WQyw+DHKI3tw5fQF9n88nWlBNasm2O0G2OhyIysAew5hGU
         2EmVFp0Q1z6oHjr3RYFvWOzIfm303wcIaTFDB21xomZPhHNi4dhaGx/Mgd1sS4AFJ6X1
         Ki3mcF0CMBdGBzGXKUvYR0HXDl5coIRVsPRqlxN6hQCvucPID9RnNyBTLk+gCEO5KUn6
         1KeRogT3QCwg27AuALb/AeE77z80pxkDISfjDSiy8rS8fwejK/4zUqpB3YQ2zoDXQPKR
         e9zA==
X-Gm-Message-State: AOAM531PgCcLcFlZtsviZ8gPb2vEnYpWOjqKbNBJvwMpHZEecee/00fN
        vQduBo5k3LI+SCTx3PScb0eh38jmCMzNZQtviCQk
X-Google-Smtp-Source: ABdhPJyEo302Bpff3ClIcmQHpPcN7oCXqhq2TQCQ5B9CTFtk+KixYuWcSnC0gp7xea3RivSrzCT9299b9ttsc/6vX2s=
X-Received: by 2002:a17:906:8c8:: with SMTP id o8mr9529534eje.91.1599256760459;
 Fri, 04 Sep 2020 14:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-8-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-8-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 4 Sep 2020 17:59:09 -0400
Message-ID: <CAHC9VhTqec_n-4y+Qd_i_YEOx6hrb5qKTDubWR1Y6mwCf3zgUA@mail.gmail.com>
Subject: Re: [PATCH v20 07/23] LSM: Use lsmblob in security_secid_to_secctx
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 26, 2020 at 11:09 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change security_secid_to_secctx() to take a lsmblob as input
> instead of a u32 secid. It will then call the LSM hooks
> using the lsmblob element allocated for that module. The
> callers have been updated as well. This allows for the
> possibility that more than one module may be called upon
> to translate a secid to a string, as can occur in the
> audit code.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  drivers/android/binder.c                | 12 +++++++++-
>  include/linux/security.h                |  5 +++--
>  include/net/scm.h                       |  8 ++-----
>  kernel/audit.c                          | 20 +++++++++++++++--
>  kernel/auditsc.c                        | 28 +++++++++++++++++++----
>  net/ipv4/ip_sockglue.c                  |  5 +----
>  net/netfilter/nf_conntrack_netlink.c    | 14 ++++++++++--
>  net/netfilter/nf_conntrack_standalone.c |  4 +++-
>  net/netfilter/nfnetlink_queue.c         | 11 +++++++--
>  net/netlabel/netlabel_unlabeled.c       | 30 +++++++++++++++++++++----
>  net/netlabel/netlabel_user.c            |  6 ++---
>  security/security.c                     | 11 +++++----
>  12 files changed, 117 insertions(+), 37 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
