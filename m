Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AB7C77B72
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Apr 2023 21:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDQV5H (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Apr 2023 17:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjDQV5F (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Apr 2023 17:57:05 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782643AA9
        for <linux-security-module@vger.kernel.org>; Mon, 17 Apr 2023 14:56:54 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54fbee98814so186046667b3.8
        for <linux-security-module@vger.kernel.org>; Mon, 17 Apr 2023 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681768613; x=1684360613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQQxoxnDlO79aAcPDshmupzvZRwHB19vPO2rZiGwcJk=;
        b=DTgNvNbhdjpyHxKadnk1WKqzC8oWcbXEDZMpG5ipntlwByNQl/nHFOj+ZbO6VNSJNP
         N0LZ/vbh+gQuqjg1WyKdRnvLqdwYs8F5J5cIp04+agUSqaj6jVoHqd1J1fcOgTtiVddd
         Kl2M3dMuAtZ2Xg+C25uPJMaPLt6dJOGBakz1FFSR5NLfbH7eKzr7SWS0tUo2/eX67S0b
         vm91xdMIzFOBjv2tsoQJYMrDxzO9aIe32clVYoPFwrXbQHd/dtVlMF2V1KJUETdtEUn3
         hW0k9XKt/gJnSC6AUFcrEACfy4Q1aznBHs7MaEi+sE+oLfAWbRebVd30FwNNCw3MyOxq
         ud8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681768613; x=1684360613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQQxoxnDlO79aAcPDshmupzvZRwHB19vPO2rZiGwcJk=;
        b=WWufe6YDVlYwAcjniPtpPb7JhINBy1DEld78YS/teJdCAIq5xb72KMKzvnTxYokX8f
         4kH7yuwmnAtliow3696Q956tzrz2WwAG/xsXKjJ1rul/1PhpCrQYUwywShAktyhDspSh
         72inSNY89ArFCLemmjBwhnKRZALNb0imV0aYwAYtbwKptAHQuGDDSPz00yNH8wbQw7t2
         4cKTAYCQCbFQtAqXG0Uo8TvLGu1Jm8SUyHDqx/VpEJj3GV8B2QZ8OskWNXmZjxN9Bvg0
         g0wxd116eVQgR4M7XASHWGzaKpg4JgZ4Wk2i4aIigAP8KALF9/JW76g5an3t2qCczL9z
         XcKA==
X-Gm-Message-State: AAQBX9e3Q50dR4a7fimKj1Xro4OLvd1qTuAvLuOE3BpMcoTxvP50i2fc
        Ws9kMMD31GtLiXtOm8aQqNUUcRINGLYjJFavLf30
X-Google-Smtp-Source: AKy350b/9VSgQDkcO3dfWMA8H7V+Tq9BIMgJP3E2JG5C4kAEJXd40vYSYLfGaD38SdySX4eX++Q8ewkTP/6Z5qkvI/Y=
X-Received: by 2002:a81:ac49:0:b0:54f:8824:8836 with SMTP id
 z9-20020a81ac49000000b0054f88248836mr10491315ywj.8.1681768613668; Mon, 17 Apr
 2023 14:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230412205316.7114-1-junxiao.bi@oracle.com> <878reqs0xg.fsf@linux.ibm.com>
In-Reply-To: <878reqs0xg.fsf@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Apr 2023 17:56:42 -0400
Message-ID: <CAHC9VhS3LpJ_x7ZfdV83KY3U49XFGMLejz7rsiEH19rzyUfD-w@mail.gmail.com>
Subject: Re: [PATCH V2] debugfs: allow access relay files in lockdown mode
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        joe.jin@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 17, 2023 at 4:39=E2=80=AFPM Nathan Lynch <nathanl@linux.ibm.com=
> wrote:
> Junxiao Bi <junxiao.bi@oracle.com> writes:
> > Relay files are used by kernel to transfer information to userspace, th=
ese
> > files have permission 0400, but mmap is supported, so they are blocked =
by
> > lockdown. But since kernel just generates the contents of those files w=
hile
> > not reading it, it is saft to access relay files in lockdown mode.
> >
> > With this, blktrace can work well in lockdown mode.
>
> Assuming that all relay users do not expose the kinds of information
> that confidentiality mode tries to restrict, this change seems OK to
> me. I think that assumption applies to blktrace; apart from that, there
> is a handful of drivers that use relay files (I searched for
> relay_open() call sites, maybe there is a better way).

At the very least I see an Intel graphics driver and some network
drivers, but like you, that was a quick search and I'm probably
missing something.  At the very least someone needs to go audit those
users/drivers to ensure this is safe to merge.

However, regardless of what that code audit may turn up, I'm a little
concerned that it would be all too easy to add a new relay interface
user which isn't safe.  The check in debugfs_locked_down() is far too
removed from the code which is using the relay interface for it to be
likely noticed in a future case where an unsafe user is added.  This
looks like a vulnerability waiting to happen.

--=20
paul-moore.com
