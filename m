Return-Path: <SRS0=pLHH=QW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67794C43381
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Feb 2019 19:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F327217F5
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Feb 2019 19:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Di3X+31E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfBOTCp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:02:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46232 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfBOTCo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Feb 2019 14:02:44 -0500
Received: by mail-lf1-f66.google.com with SMTP id f5so7937814lfc.13
        for <linux-security-module@vger.kernel.org>; Fri, 15 Feb 2019 11:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2wjZ3rAlh8Xs47pTpzNxCmLt+JJOX01hTpRU1PEbls=;
        b=Di3X+31Ew6n1MBP8dSAvbI1TT6KJRwBh14vPlq+pp/QQJe5AwdloMjXKskjKIfqvv1
         OlT0bT5Xh4s+YQRJ09527H17vxOziMoGsTg5+L8nGQ1610yKxEbG8ZOB8SKLXjIPCOZE
         gcewfRscs8FblXY3/JJL1kfTt4Q+m3GWtnTVF1rSsUNXP2LAC6j2qscSutw56HJsVRlD
         HRZiqV565a3H8V8EHEJWmZHpt3K7XosgeogYTb6D2OyZ/d/SqlUkOWFUfpx2wUnXFvm7
         8U9N24rNa+P3pYO7l8Xo80Zu2BfasFgggSBK6H0AQ2wUnf6m/+P7PKzNWfaNqMFgUxVB
         QNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2wjZ3rAlh8Xs47pTpzNxCmLt+JJOX01hTpRU1PEbls=;
        b=fubf/EV/lVY6BPtkKX/H8WOdCn1bzqQXL3miciTKW6rpooeM0k1Pmp+e/DXmoeumY9
         kw+5hajJkU6q9BFptcVb98Ezk6ei0zvmcgip0TpzlCuP+i7Ymle/T+8F2uzr/9xSPdEE
         BXjN2MX0MPHrUXhwz3U+Ppo8p15aLCrKno9QMLg1hlTmqHE5we9Ug1+ZY8ATzYURoBcZ
         jApk+bb6MOZcUKdSev9dCWk2WTFyLPjXuM6YuN+KcYa8ThgfO64uiwnqRXLZNA9U8XMn
         ZrvYydu9mxf6IWKoLiUyGkN885oTgLuct4Kp8D148mL78G3J+u9gzApHrp/TKhjJEXWj
         bLzg==
X-Gm-Message-State: AHQUAubFJVgxpl3MaQH2h7UgQf16mWXbVwTep4kaT+y3QQDyAzbfXmcM
        UpICM8Nnkt9u1/YyiYrUymGFtAjwZx6OgpkBqg6D
X-Google-Smtp-Source: AHgI3IZnkp4Gj0aBxfnV1EZiQ0uGpxT6l3GTlM4dndocUXg0MufMTXUPqnqKcaZGC24bfimdT/P5AdllyIZIZ1cya3I=
X-Received: by 2002:a19:ee13:: with SMTP id g19mr6315180lfb.72.1550257362535;
 Fri, 15 Feb 2019 11:02:42 -0800 (PST)
MIME-Version: 1.0
References: <34948711549920080@myt1-06117f29c1ea.qloud-c.yandex.net>
 <CAHC9VhSDot+uNDi7ULoT7dry4FW9Jgp=NcqDh6TmA=z--kmqkA@mail.gmail.com>
 <6691891549984203@myt5-a323eb993ef7.qloud-c.yandex.net> <20190214.084343.1138362153341500718.davem@davemloft.net>
In-Reply-To: <20190214.084343.1138362153341500718.davem@davemloft.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Feb 2019 14:02:31 -0500
Message-ID: <CAHC9VhQK6Cmcx5kwYAPipR4YGyBHdkLEe3UH+VmNYGHu4PWqjQ@mail.gmail.com>
Subject: Re: [PATCH] NETWORKING: avoid use IPCB in cipso_v4_error
To:     David Miller <davem@davemloft.net>
Cc:     s-nazarov@yandex.ru, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 14, 2019 at 11:43 AM David Miller <davem@davemloft.net> wrote:
> From: Nazarov Sergey <s-nazarov@yandex.ru>
> Date: Tue, 12 Feb 2019 18:10:03 +0300
>
> > Since cipso_v4_error might be called from different network stack layers, we can't safely use icmp_send there.
> > icmp_send copies IP options with ip_option_echo, which uses IPCB to take access to IP header compiled data.
> > But after commit 971f10ec ("tcp: better TCP_SKB_CB layout to reduce cache line misses"), IPCB can't be used
> > above IP layer.
> > This patch fixes the problem by creating in cipso_v4_error a local copy of compiled IP options and using it with
> > introduced __icmp_send function. This looks some overloaded, but in quite rare error conditions only.
> >
> > The original discussion is here:
> > https://lore.kernel.org/linux-security-module/16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net/
> >
> > Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
>
> This problem is not unique to Cipso, net/atm/clip.c's error handler
> has the same exact issue.
>
> I didn't scan more of the tree, there are probably a couple more
> locations as well.

David, are you happy with Sergey's solution as a fix for this?

If so, would you prefer a respin of this patch to apply the to the
other broken callers (e.g. net/atm/clip.c), or would you rather merge
this patch and deal with the other callers in separate patches?

-- 
paul moore
www.paul-moore.com
