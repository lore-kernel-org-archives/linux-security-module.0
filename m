Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB2DC32792
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Aug 2022 21:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbiHVVRx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbiHVVRw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Aug 2022 17:17:52 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E3052830
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 14:17:51 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10cf9f5b500so14495294fac.2
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Frrl9mJt0hK/Oh0mjmqdtsrb5voW8zQOC0fq0VF7OIo=;
        b=cr+o9UeF2H2+P3FSi1vd97hqNOWWjypNc761GnbjNwqrQ3dF9SUB7I7tVtW1ZQSSxr
         xssqEneBTWcdbwzMgKxqshLle8kcyt9Guk8QL5omuUGJdVyj1S7RVQL8TGqF1+HufyvZ
         elJ6cD1sLjz8Ca4gKqMVzZyrNL59CTemxqJSd9yBaz5JAt9J3oRYNwjj4GOV6lYmgSYy
         jwfSvN3nMXLRmabDreifGBA1kLgufCpZiFmPpNKnDE/FtdLCEiPeNdgMT41sbNOKWkqb
         xzQOdU8FH5cf2rZ+ywsNcS8sVTFYF9vG3tRvSl1SQsbiuW8wpM2u7f569943dQ1NVX67
         6x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Frrl9mJt0hK/Oh0mjmqdtsrb5voW8zQOC0fq0VF7OIo=;
        b=pQkC7a7oP4DpdwCItrqvROxdP9yLFZCijkQHIOP6cW4yMks26oScwADNyaz8jBSxF3
         Vp+lwqzr90VrlpCy1JvNoEw+2JUYXsGZjNsolxotPAFKcZH4sA6hp3iVtSNi2y3tgSb4
         vHQCMWcrF3CblJtstZr5bF3cyXmHjONoYWEwEOd1P+P0BeFD7AVWxJfxIdx02HUOTJ0z
         pRV8E9lupgvTrAbZLkv6QnO73SarMlTFWkfgjGEYrLvfCvAKkRRYc5tDgmf36Xp7ucyi
         NI937CsF0/O2iUw5txjdg+imrisLa40aaQUlW2yuw3n7dkgIoLa45i81p4fHNdMwepe5
         NEJg==
X-Gm-Message-State: ACgBeo2tJdyFhaD1PPe61VZXl3Shf3l13JL8LysvjDrJ2aYtVfcE65e2
        2FIrdz7jBqHwAfOBz+PtVusIdvc6h3t1mjThzaQriKEqkw==
X-Google-Smtp-Source: AA6agR5LyvZUJEJMt3S64cdt1sfqUrKvz2C/Df/97gW/l5vrLeTnD4gOlSCGbrjs7JRJRWe/NeaRjwwgrwnPPWTCuSc=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr107716oao.136.1661203070177; Mon, 22
 Aug 2022 14:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <166120234006.357028.9335354304390109167.stgit@olly>
In-Reply-To: <166120234006.357028.9335354304390109167.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Aug 2022 17:17:39 -0400
Message-ID: <CAHC9VhSj_qFaftPzdznxaTdYp_=a_7kqNc8Hbdh0Bp7sSf2z=Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] LSM hooks for IORING_OP_URING_CMD
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 22, 2022 at 5:14 PM Paul Moore <paul@paul-moore.com> wrote:
>
> This patchset includes three patches: one to add a new LSM hook for
> the IORING_OP_URING_CMD operation, one to add the SELinux
> implementation for the new hook, and one to enable
> IORING_OP_URING_CMD for /dev/null.  The last patch, the /dev/null
> support, is obviously not critical but it makes testing so much
> easier and I believe is in keeping with the general motivation behind
> /dev/null.
>
> Luis' patch has already been vetted by Jens and the io_uring folks,
> so the only new bits are the SELinux implementation and the trivial
> /dev/null implementation of IORING_OP_URING_CMD.  Assuming no one
> has any objections over the next few days, I'll plan on sending this
> up to Linus during the v6.0-rcX cycle.
>
> I believe Casey is also currently working on Smack support for the
> IORING_OP_URING_CMD hook, and as soon as he is ready I can add it
> to this patchset (or Casey can send it up himself).
>
> -Paul

Forgive me, I spaced and hit send on this patchset posting a *second*
too soon and didn't cancel it in time so the cover letter leaked out.
A proper patchset posting will be coming in just another minute ...

-- 
paul-moore.com
