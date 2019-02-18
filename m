Return-Path: <SRS0=s2IT=QZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415A2C10F06
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Feb 2019 02:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11712218C3
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Feb 2019 02:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sfIDCqcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfBRCqL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:46:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41610 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbfBRCqL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 17 Feb 2019 21:46:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id z25so5157348ljk.8
        for <linux-security-module@vger.kernel.org>; Sun, 17 Feb 2019 18:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/DFwKuZhp2tGU3us6NJa0n5ClRLptAu1w9i5MbORi1M=;
        b=sfIDCqcdOgxM6O9aAAqtZFjFWOJI+8fFxB3Ka8z80V1UdQ5bGCGBHkv9UTNkNe0Mzt
         eFIzlvt8RtfWMyaRAEQNkTiOHRNTPMHKzyqVFoJgVA0ye3IphqmE8Xsfk0oW9NL1rVaH
         wdNU4u8WJ2evLyJyCwIttFzdNk3IkHqh/QhoT/cvlBVAn9Whii+J+O2eAPrOGskSOUwj
         xypDlv6Zwb9An+ZX3vYRWt+Na6JEQISntD/qhKddagBhWpXUX7NDt//1u33B6/nDYto7
         Ws8+XC14CCTqaAL4e4K5fUv5R6Uq6+WqcSqTWAk+d0UTZanFIoabr7QmNT/bophUiMnV
         RpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DFwKuZhp2tGU3us6NJa0n5ClRLptAu1w9i5MbORi1M=;
        b=EhiyjF3ZCuw0IUaxdEOeyqMCCTA4OI3ci+Y0mhPPH/1EPvgje5lTIbIpkCkqwYmJh9
         8t4kez9jnN+qycoiFFj21/DsMiVxfHWt5+BzK1y9bb03fVM/9RvBEG3yWvnxF75Cx0o9
         8B91OAH9OPEM50CfhARSoVE+5YV0vBQuS1xtk1kzvQbe+rTmbuY44nKZg2o1mT/iHLP+
         HN/25uLsGO8i6y+flwh/jPkCH1/YGtyASYmpnpcWP2lvTRJXJk8tbw866Ai/aWq8prhP
         rsRxSE1sY0IDRpfmIan9/1NL0vfB2nqWbYcrqsayarHt683g6s3iagEI7aclsofCw+IB
         hqQw==
X-Gm-Message-State: AHQUAualoLZ45pM8F0hb1Cz1UR4qeXxT9M2gHWSV28kONuTxqEwfhcMt
        ea9YiH4gXFxwleokpldGz5vRAKVrFbVBl5IO3uXE
X-Google-Smtp-Source: AHgI3IYLzrhZQodvsXcPvyhPGwNyP3HL+2e5zzLCWSy5/pcGAcvohlbqnDcpE0X+wSIBYk8Tz2XUeDvnKfJivuGH/uQ=
X-Received: by 2002:a2e:968c:: with SMTP id q12mr2450505lji.95.1550457968559;
 Sun, 17 Feb 2019 18:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20190212182318.GA16669@beast> <5260689d-9016-bdf4-6070-13d2c88ac8a8@schaufler-ca.com>
 <4ed50852-abfb-773b-01e4-b4ac83e32ed3@I-love.SAKURA.ne.jp>
In-Reply-To: <4ed50852-abfb-773b-01e4-b4ac83e32ed3@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 17 Feb 2019 21:45:57 -0500
Message-ID: <CAHC9VhSy8iVUtN1Wt+cy-2RmJQhy34=0zKrUj+RQNEvNuD7y0w@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: Ignore "security=" when "lsm=" is specified
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     SELinux <selinux@vger.kernel.org>, kernel-team@lists.ubuntu.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Feb 17, 2019 at 12:17 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2019/02/14 1:05, Casey Schaufler wrote:
> > On 2/12/2019 10:23 AM, Kees Cook wrote:
> >> To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
> >> used on the command line, and report that it is happening.
> >>
> >> Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>
> The manual for TOMOYO was updated to follow this change.
> SELinux folks and AppArmor folks, can we apply this change?

My main concern is that "selinux={0|1}" continues to work as it has
for years.  It doesn't look like this affects that, but I can't say
I've dug into these changes very far.

-- 
paul moore
www.paul-moore.com
