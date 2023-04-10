Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102D7C77B61
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Apr 2023 20:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjDJUXG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Apr 2023 16:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDJUXE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Apr 2023 16:23:04 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984CB1735
        for <linux-security-module@vger.kernel.org>; Mon, 10 Apr 2023 13:23:01 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 72so5981030ybe.6
        for <linux-security-module@vger.kernel.org>; Mon, 10 Apr 2023 13:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681158181; x=1683750181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAVGK4zLATAbON0x5S9sRQuF5rq3pdECXmgnbPbK+Pw=;
        b=JAk7Tl/V9jWHlc2X+hYl24wZuVsC8VtT2M8uKx2Tgv/qGPuwQxVt0aCWQ1ZrlT/qZt
         6xvKSQItTomHGzoxE+IBzqVhw2Haqr51XvdFS0Ud6MfWDz1a/tMURVHWv+buKRuPCwCT
         mIzg+WOL/NZXa+aumrlTFUC9FqIzGcMU3CKecm/0rfjtgUG+c373Thhu8SMnpb4qYis9
         hvF0FG5Twm5ey5X/sSPZxI26I8g88bB/+io+ky8U6IQfsw/gS+vTsHs4J2rjDpz1uJXR
         0ed1J0F8ngSiQz/UJKD0HJTtdcoiHY9zvQ1vR4BcoxAjpN44mCqrwIfAVdAjYclTBiKe
         MkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681158181; x=1683750181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAVGK4zLATAbON0x5S9sRQuF5rq3pdECXmgnbPbK+Pw=;
        b=ps1yljJMXrD6zVWuXZQcCuFfYFP2lZV6xKFAeD80izP1vK+OAYSTqIYI5+cW96nZbj
         ElTV7y60jZJP/IcdnFHAYtS86iIdbfY8PUybJcxI6rn9PT2qPN5lAcKs7ztKOjy7hwx7
         55/winmZHzPWRiUDxS0nwiSYPOSUGF+rVYeA3LJfWitAxjSKBkjho3jRQ8h2E9SL3MTN
         D7n0RQEX9UOHLtU4flLxw+GOYHA7bSRtyiztBDLW9VOBaPF8Z39MHN7tXouyi7v2gg21
         YQKuyaGb5F1jgmoJXE3PT4NeixCV/QYcQPZLFqzcuOiQcGIu5OOO4IyUWMdIXEgusmTi
         sE+A==
X-Gm-Message-State: AAQBX9eAOXtmnY5ezZ4X20dKfSGEXpJQF+GVp3g1Cqq83K67l9XgACip
        7Zh3kNSgRkwHmApWgLvyVeIrQwWEeix/JXL8WzIU1WSObWi5Zk8=
X-Google-Smtp-Source: AKy350ZwBNrdQDhKMZmwkxEtn9RG0XryxRZfQti7t42yXIefFK2WYj77IPRz57nRzCkwtbfFNrem2mUi73Brosn4tU8=
X-Received: by 2002:a25:738e:0:b0:b8e:df36:fea1 with SMTP id
 o136-20020a25738e000000b00b8edf36fea1mr2986264ybc.3.1681158180753; Mon, 10
 Apr 2023 13:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <ZC8Dbux56HbJjpTy@char.us.oracle.com> <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
 <ZC8eZ/RTX//0urV/@char.us.oracle.com> <CAHC9VhR06pa2mDwW26XFqiry11Ubz2_3YKj+ayftu0JdYx9m9w@mail.gmail.com>
 <93ef5db7-fb4d-bf3f-9456-3fb6e7d5ca29@oracle.com>
In-Reply-To: <93ef5db7-fb4d-bf3f-9456-3fb6e7d5ca29@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Apr 2023 16:22:49 -0400
Message-ID: <CAHC9VhRKzv4+fbSK8+fV7v+N5Eaevtag7YvSW1YwJrxs5gAyHQ@mail.gmail.com>
Subject: Re: Semantics of blktrace with lockdown (integrity) enabled kernel.
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, nathanl@linux.ibm.com, joe.jin@oracle.com,
        Eric <eric.snowberg@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 10, 2023 at 3:20=E2=80=AFPM Junxiao Bi <junxiao.bi@oracle.com> =
wrote:
> On 4/6/23 2:43 PM, Paul Moore wrote:
> > On Thu, Apr 6, 2023 at 3:33=E2=80=AFPM Konrad Rzeszutek Wilk
> > <konrad.wilk@oracle.com> wrote:
> >> On Thu, Apr 06, 2023 at 02:39:57PM -0400, Paul Moore wrote:
> > ...
> >
> >>> Before we go any further, can you please verify that your issue is
> >>> reproducible on a supported, upstream tree (preferably Linus')?
> >> Yes. Very much so.
> > Okay, in that case I suspect the issue is due to the somewhat limited
> > granularity in the lockdown LSM.  While there are a number of
> > different lockdown "levels", the reality is that the admin has to
> > choose from either NONE, INTEGRITY, or CONFIDENTIALITY.  Without
> > digging to deep into the code path that you would be hitting, we can
> > see that TRACEFS is blocked by the CONFIDENTIALITY (and therefore
> > INTEGRITY too) setting and DEBUGFS is blocked by the INTEGRITY
> > setting.  With DEBUGFS blocked by INTEGRITY, the only lockdown option
> > that would allow DEBUGFS is NONE.
> >
> > Without knowing too much about blktrace beyond the manpage, it looks
> > like it has the ability to trace/snoop on the block device operations
> > so I don't think this is something we would want to allow in a
> > "locked" system.
>
> blktrace depends on tracepoint in block layer to trace io events of
> block devices,
>
> through the test with mainline, those tracepoints were not blocked by
> lockdown.
>
> If snoop block devices operations is a security concern in lock down, the=
se
>
> tracepoints should be disabled?

Possibly, however, as I said earlier I'm not very familiar with
blktrace and the associated tracepoints.  If it is possible to snoop
on kernel/user data using blktrace then it probably should be
protected by a lockdown control point.

Is this something you could verify and potentially submit a patch to resolv=
e?

--=20
paul-moore.com
