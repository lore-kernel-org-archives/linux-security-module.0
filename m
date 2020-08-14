Return-Path: <SRS0=hu4j=BY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C28C433DF
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Aug 2020 02:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1474C2078B
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Aug 2020 02:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ZHYjLnTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHNCEC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgHNCEC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Aug 2020 22:04:02 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF738C061757
        for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2020 19:04:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id t23so5995364qto.3
        for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2020 19:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=hUU0prCBVTiAdFjEmzNOw5Gb6e+uyebOVxh5mfohMZ4=;
        b=ZHYjLnTA8pn7mZs8tBrjI/YXvWUT0nqxrTQ9+gkgrHhbOTWncTagbOBc3Jtbv1gtr1
         AhaIRVAbyglnnfhSOsD1y4i0fibwAYT2oqvw2nlfEHkUXRo0tWlvyV5bL6hrS3NR3xQ2
         vFUHgnnsFpbMzSBpJnt0Mv4sq6+nmqFMZqrH5jjXvtF+OT4Xd4tN0/6aXIWkGcSUTekw
         hbQ/g6Q1uJjltVPVRCrGbNKOprdMsEN+a3n6MDrlADAUXJn8ytAaJlEKIzslp4p25Y6S
         2P1E72w77aWbRYymjpAzhRmvgvPkOuGstPUWD1OhQAXqvB9EyhJU++mcNXd0Q0MefRxW
         uuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=hUU0prCBVTiAdFjEmzNOw5Gb6e+uyebOVxh5mfohMZ4=;
        b=okaWoIiMKEdsLqjwlXW35cWgqJ2Y+0cR6qgplm3yIq6eD+K18GYVivKlHtgfwCPyCU
         X1oXHQW/Y+gcL51/ZTPqyyUT/zyg0s6GrvwweELKu1UpLd0net9N+69YEmQhCNIB3wG9
         YYtX4K1JIsY75E6Dq+BBmAxbmBDmyek4KFnHFMeNTUfE6s6yMiGu3lRt+THUN5Jiq63+
         aUM+G/2b4YX4suhCzsr9LSt3i/JLT2a6MZ8g+m2w8GaE5EojvAqgM9uHW7QB66uJeUKr
         J9BGihDtqAK5zIE30uNuFGmcR68hWYLAprB71KJL3t+jAOcMZ58czelakSwy+EpPnHJc
         0gpA==
X-Gm-Message-State: AOAM530a+Sq0DZBegg2z+exikuuhizJF8h0Kf4WBanurce0U4f0SSJfW
        5ulKweehuyILa17d4bKz2sNbaf2vQii0
X-Google-Smtp-Source: ABdhPJyKsBUL/dUY5nnzG1uSx/dbhMyxDw5DHJOloHjCd8PWnKRPo+BJRmskDLdSX1s/+gFkEowHOw==
X-Received: by 2002:ac8:5254:: with SMTP id y20mr194609qtn.170.1597370640911;
        Thu, 13 Aug 2020 19:04:00 -0700 (PDT)
Received: from [10.0.0.46] (c-24-91-201-67.hsd1.ma.comcast.net. [24.91.201.67])
        by smtp.gmail.com with ESMTPSA id u39sm9322823qtc.54.2020.08.13.19.03.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Aug 2020 19:03:59 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
CC:     <SMACK-discuss@lists.01.org>,
        <linux-security-module@vger.kernel.org>
Date:   Thu, 13 Aug 2020 22:03:58 -0400
Message-ID: <173eab59eb0.27df.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <b1fcf225-83f4-dbed-8d70-f2e0194e70db@schaufler-ca.com>
References: <20200812003943.3036-1-casey.ref@schaufler-ca.com>
 <20200812003943.3036-1-casey@schaufler-ca.com>
 <CAHC9VhTq66h1LsNBuhXG6WFiKn7hCBApciG6sVawW=jDwqDDWg@mail.gmail.com>
 <fba5a257-599f-b2e5-d4bf-57269fc7734b@schaufler-ca.com>
 <b1fcf225-83f4-dbed-8d70-f2e0194e70db@schaufler-ca.com>
User-Agent: AquaMail/1.25.2-1672 (build: 102500008)
Subject: Re: [PATCH 0/3] Smack: Use the netlbl incoming cache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On August 13, 2020 8:32:16 PM Casey Schaufler <casey@schaufler-ca.com> wrot=
e:
> On 8/13/2020 9:36 AM, Casey Schaufler wrote:
>> On 8/11/2020 7:10 PM, Paul Moore wrote:
>>> On Tue, Aug 11, 2020 at 8:39 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>>>> Update the Smack security module to use the Netlabel cache
>>>> mechanism to speed the processing of incoming labeled packets.
>>>> There is some refactoring of the existing code that makes it
>>>> simpler, and reduces duplication. The outbound packet labeling
>>>> is also optimized to track the labeling state of the socket.
>>>> Prior to this the socket label was redundantly set on each
>>>> packet send.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> ---
>>>> security/smack/smack.h        |  19 ++--
>>>> security/smack/smack_access.c |  55 ++++++----
>>>> security/smack/smack_lsm.c    | 245 ++++++++++++++++++++++++----------=
--------
>>>> security/smack/smackfs.c      |  23 ++--
>>>> 4 files changed, 193 insertions(+), 149 deletions(-)
>>> FWIW, I gave this a cursory look just now and the NetLabel usage
>>> seemed reasonable.  Out of curiosity, have you done any before/after
>>> performance tests?
>> It's early in the benchmark process, but TCP looks to be about 6% better=
.
>> UDP numbers should be better. I'm not expecting the level of improvement
>> SELinux saw because the label mapping from CIPSO isn't as sophisticated
>> for Smack as it is for SELinux.
>
> UDP looks like a 12% improvement, which I had expected.
> On the whole, worth the effort.

Great, thanks for the follow-up.

--
paul moore
www.paul-moore.com



