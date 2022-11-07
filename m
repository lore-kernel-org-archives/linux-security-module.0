Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E2FC433FE
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Nov 2022 19:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiKGTW1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKGTW0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Nov 2022 14:22:26 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50EE29C9D
        for <linux-security-module@vger.kernel.org>; Mon,  7 Nov 2022 11:22:23 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id j6-20020a4ab1c6000000b004809a59818cso1743923ooo.0
        for <linux-security-module@vger.kernel.org>; Mon, 07 Nov 2022 11:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pYT5BMk0k0x5MAqDpewGmqXvzVoBMDNQmeGbwYo7Jvo=;
        b=ND8Lsz89fA2IBOex8n2K76SYTmPdOKvzKt3cZ5RqmZAMGhETiHVcQNzbPE1VmxB3I8
         YOGsCLa++Mtgd3tZWJksNG143x8f9CoNm6PBOBSzYG5173rtT680+Ooi+gkkqaNqRELs
         AhxlT/ALuJAuu/aD6ci7771j6mmKk6H6axJX35A8umTWZFZ56u4qTTB30rmIpMA+fudw
         POxBK1JHo+a2E/QABa7I9SPgKmIDsC4zVym1PkT+xY3/XnBqMdhXR4XpidDZwk+VBPJL
         Cq6DIp3k4D1q6OdBP6kXP/CvMjPEQoaJqjzlHHz3duPXJ8VPwWusmk1qOBhSAPrqpXmX
         0Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYT5BMk0k0x5MAqDpewGmqXvzVoBMDNQmeGbwYo7Jvo=;
        b=xRaW95YzSdVo418oyfZ4/BbNtBdg0LVP28gK+JyYhyhAskVzoKr4vTOizqADRkrGnN
         /MwJcCDsejz1xOEFICA7UgJV8nKD+qqUVNXrS/95MxEcqaqz3HR3bNOzmi1YOwfdDpXo
         kiZkBlfYqw8krNR7eeOeIqZ/TjlpQjkfKUwpVm6BEFiNUhHr6UF4v/zqIaOb+cv17euw
         T6EueyHUBY5AtKKl6sjqKm2xLIvDGlBdNXn+4qf162u7QoWPzjb59NRlUjAUFa20lTLv
         2c6rL/FK0X062+y3/QhTC/ZI9WqJpx+nVJzl9NUO3xFwBzIZRC34I9NvuO2rgGqZpAXb
         zo7w==
X-Gm-Message-State: ANoB5pnLDQ1w3rKtMS/GqdpkWKg9+sVorygdLnV83zdeHC902FHMXWWD
        rTqgFMn2X6A+GMIb9DaX6LUOqAkaZgIXHLQAMmGe
X-Google-Smtp-Source: AA0mqf6068nsvKfmFGtrvKWILCe2YZ6zEynjVCZOktCT/LB06SG4RopaoTX0eNMkK1xBBkotRuRsdhyIHmrq4zp9b08=
X-Received: by 2002:a4a:ca8f:0:b0:49e:f01a:feaf with SMTP id
 x15-20020a4aca8f000000b0049ef01afeafmr2825384ooq.81.1667848943030; Mon, 07
 Nov 2022 11:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
 <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com> <20221105024345.GA15957@mail.hallyn.com>
 <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp>
In-Reply-To: <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Nov 2022 14:22:12 -0500
Message-ID: <CAHC9VhTvC+U8f1eoF8G120uh7OJb5Cu3un5vfjc++EuYOggUeg@mail.gmail.com>
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Nov 5, 2022 at 12:06 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2022/11/05 11:43, Serge E. Hallyn wrote:
> > On Wed, Nov 02, 2022 at 10:57:48AM -0700, Casey Schaufler wrote:
> >> On 11/2/2022 10:10 AM, Tetsuo Handa wrote:
> >>> The main point of this submission is to demonstrate how an LSM module
> >>> which can be loaded using /sbin/insmod can work, and to provide
> >>> consideration points for making changes for LSM stacking in a way that
> >>> will not lock out LSM modules which can be loaded using /sbin/insmod .
> >>
> >> CaitSith could readily be done as an in-tree LSM. The implementation
> >> of loadable module infrastructure is unnecessary.
> >
> > Sorry, I'm getting confused.  But in-tree and loadable are not related,
> > right?
>
> Very much related. My goal is to get CaitSith in-tree as a loadable LSM module
> which can be loaded using /sbin/insmod .

At this point in time I don't want to support dynamically loadable LSM modules.

-- 
paul-moore.com
