Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510CEC4167B
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Dec 2022 21:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLIVGO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Dec 2022 16:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLIVGN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Dec 2022 16:06:13 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED71CB07AE
        for <linux-security-module@vger.kernel.org>; Fri,  9 Dec 2022 13:06:12 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id h33so4340505pgm.9
        for <linux-security-module@vger.kernel.org>; Fri, 09 Dec 2022 13:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=swlXbvUgIyCpVtfuw5akFewwVTfd7I7Js2pYf2XP82w=;
        b=TaiHuCeZAV1yQQlAJSulkw9JtGnuWlgOsNlnVxYlOPkd0TzlBzHTGSi2lZ4fgCeKFZ
         Ausv62PjanNcqNtCrd/i6ZfyH796UnYOgf/m6TiOAx5RJtP0uFbrWu6zzf41tx94j06a
         u9pkVHUD/V3Wf73BeEHsFd9LeOHHQ+U5XgsFP0I76W58lcFFs2DKySW0Z7D9oSR31/7m
         O2RVoCDmYR+J4eaHcKAgalL8XGd/oxA2u0+kxVW741y+Vnpx+VMq/GEogIiQdWUkVb3r
         Q5JdMYsWOiZWjCeTJa+WNQIX18SmKc4yPkrta45kgLWaBMdFzzqRJa2nMx8QYFDWuF6Y
         HbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swlXbvUgIyCpVtfuw5akFewwVTfd7I7Js2pYf2XP82w=;
        b=qVSdHKZkrvOvVwUyE0kQNktOsd0HWkKPVTetH0/BSfli66aHo00HD4jigBHRZwCJsM
         knHhyyBemWKbjMtnKwy0kX9Ho4TAw0x7Dk7TOWEB90GtjPgLl/PJ/XPsmVj62DvAwI1f
         zVqt/qW2roE7pAt343fLnzDW09IqM/P1W81oRHJEgJibRoG8AnspAquswpeSEKIb7z4d
         gE9Zk+kqMyWxoEcDqGCj/jT3iQOd8kQn9a4jazifqKk0y+zxPL5jn0M0vvhV6+ZYGOAz
         Mg2C1NpAg7X+wyTajFvZ6s53jKego9o4wdJbEj6noz1o7k9EVw/eF8e8+GxwUYCadzar
         x0RQ==
X-Gm-Message-State: ANoB5pnhSJSI37mX8CBWsKIJ43jJBCLVg2Xzlc1wkmuX7CgLBUzrBYb/
        xoll78ZTMQf5TqfUq1SdAemCMxJy/d4dyLysPPYA
X-Google-Smtp-Source: AA0mqf5UWEv2FphOoofYNiFjCOBLSmWLY2xIp+weIrCQVhgvg4KV4FG8JEHmcR0rn7ZdcCbz3LrXj/ZTlsVPzBiCzv0=
X-Received: by 2002:a63:64c5:0:b0:479:2109:506 with SMTP id
 y188-20020a6364c5000000b0047921090506mr145405pgb.92.1670619972378; Fri, 09
 Dec 2022 13:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20221114111844.3461403-1-konstantin.meskhidze@huawei.com>
 <CAHC9VhQZ0i1GF2a9P9v05awKCb_j2X0Tv_xVfhQm4NnMJFs5Lw@mail.gmail.com>
 <CAHC9VhSrbZeP2Lmd-dVXyUqM2=b7z-HMWh1ZPQ30eWchwrQJvA@mail.gmail.com>
 <ef77d0d1-5003-9147-6ba7-ef08a5109ce0@huawei-partners.com> <ed961349-0996-1e71-a624-cf55d893b2e2@huawei-partners.com>
In-Reply-To: <ed961349-0996-1e71-a624-cf55d893b2e2@huawei-partners.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Dec 2022 16:06:01 -0500
Message-ID: <CAHC9VhSogM2_WrOWTEJAeWz3Pw39fU5L3ioR8425Kxq-W7LiNw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] SELINUX: Remove obsolete deferred inode security
 init list.
To:     alexander.kozhevnikov@huawei-partners.com
Cc:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-security-module@vger.kernel.org,
        jamorris@linux.microsoft.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, artem.kuzin@huawei.com,
        hw.likun@huawei.com, xiujianfeng@huawei.com, yusongping@huawei.com,
        hukeping@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 8, 2022 at 7:29 AM Alexander Kozhevnikov
<alexander.kozhevnikov@huawei-partners.com> wrote:
>      Hi, Paul,
>
> Finally, I hope that I've got answers on all questions which were found
> open on previous attempt:
> 1) RCU accesses. There was a bug in printout code (isec pointers were
> messed up with inode pointers), unfortunately. Now the picture is clear.
> All inodes which were accessed on RCU-walk mode got another access in
> Ref-walk mode right after and got successfully initialized. This is
> exactly as VFS manual suggested.
> 2) Inodes which are left without initialization are coupled with
> directories which are mount points for some other filesystems and
> according to VFS path lookup logic this dentries are substituted by
> root dentries from underlying filesystems by handling mount points
> during link_path_walk(). So this inodes do not have a chance to be
> accessed until this mount points exist. As those generally are special
> filesystems like /sys/fs/cgroup (very good example) there is almost no
> chance for unmount of them.
> The chain of events is quite simple: upper directory created, inode
> added to deferred list, another filesystem mounted to this directory,
> inode is not accessible anymore.
> So, hope that this time I have quite good explanation of the story.

Thanks for the update Alexander.  It sounds like the VFS RCU fallback
is working properly, which should address my worry about revalidating
inodes while in a critical section.

I would suggest updating your patchset based on the previous feedback
and reposting.

-- 
paul-moore.com
