Return-Path: <SRS0=y+58=VG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39487C606B0
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Jul 2019 03:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2F121707
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Jul 2019 03:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562642128;
	bh=qAIXHIQXCwN4ZY9FkQ6TQ4y9mrlyzDm/W9EdCYOL7cc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=en7RQFno3iL4ZAohFL+Pm0A/qbizt97OrUZs4OfoBu4cgV3Z5osT0eur328L1IWyT
	 GQd+r77yqcANrWgvdlhtUO9Oje0tFUDscPLmyT0LNOyITs9Tc2mlnG4NASECCKWWE5
	 kVRW6zZm6FglJEpaLg37VXo/imK5qzvy8P17rRA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfGIDPY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Jul 2019 23:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbfGIDPE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Jul 2019 23:15:04 -0400
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562642103;
        bh=qAIXHIQXCwN4ZY9FkQ6TQ4y9mrlyzDm/W9EdCYOL7cc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PP/R6lKRJcJNwHSUvQRE5AIzAKuEJpH/97s45voVnql/I2NM9VBslcsttUE7/Y0k4
         RsbxT+tSeSUd8i5W2aJl6UCej+Q8Yzb2iFsipT/q10l/NiD22aeI8qoOSYHGZ0McHs
         ANfFs8v8fV5wswTfZBT7r4tLVVni558TSjn2WNH0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2595b4f6ce49cc3d413c75f86a63ad9d26f0f1fd.camel@linux.intel.com>
References: <2595b4f6ce49cc3d413c75f86a63ad9d26f0f1fd.camel@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <2595b4f6ce49cc3d413c75f86a63ad9d26f0f1fd.camel@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20190625
X-PR-Tracked-Commit-Id: 166a2809d65b282272c474835ec22c882a39ca1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 884922591e2b58fd7f1018701f957446d1ffac4d
Message-Id: <156264210349.2709.1195958711800929519.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 03:15:03 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        mjg59@google.com
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Thu, 27 Jun 2019 01:50:47 +0300:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190625

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/884922591e2b58fd7f1018701f957446d1ffac4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
