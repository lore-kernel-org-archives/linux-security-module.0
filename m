Return-Path: <SRS0=lUlZ=7R=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691C8C433DF
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Jun 2020 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C7C208B8
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Jun 2020 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591292108;
	bh=r7M5q0iHyfHGyBRKj6jAheCd58vLXxbeaRkdNijLQxw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Lk5JpMdXdB/IARIBcujaP24Vxr+WR68kfmcLzzBHdAkG6H96B96UzCLXFc++p9NT7
	 YxSLqIDSHnifMCdnUh/EiemOhaQIH2ehD9ZlpZvT2u8+xYFQ/Fa0uTGBHhTnYoUJQ+
	 DznuSxkEbe4pabFRs2s6Krojqq9uPpphHH2CJtT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgFDRfH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730083AbgFDRfH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Jun 2020 13:35:07 -0400
Subject: Re: [GIT PULL] keys: Changes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591292107;
        bh=r7M5q0iHyfHGyBRKj6jAheCd58vLXxbeaRkdNijLQxw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iq5GnctdVbfiV74Ky9wwKSBkE0lGnZshu35uJ+t44i9t3k3vNvmPIrmDhrHJetTTt
         brpyuloVMBJkCAjSMSdLww/z1SS2lHipxdd5rnRTHCCPMU4CqriDKP1VxzR/mlthjy
         OfbV7+oXUhuEYnzw4NEm2S1s5V5395sfU+zQSNo0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1509351.1591115280@warthog.procyon.org.uk>
References: <1509351.1591115280@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1509351.1591115280@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/keys-next-20200602
X-PR-Tracked-Commit-Id: b6f61c31464940513ef4eccb3a030a405b4256d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a484a497c98a0447aca2d70de19d11b1d66e6ef7
Message-Id: <159129210706.22790.7029741775337917188.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 17:35:07 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, mathstuf@gmail.com,
        gustavoars@kernel.org, Jason@zx2c4.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Tue, 02 Jun 2020 17:28:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/keys-next-20200602

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a484a497c98a0447aca2d70de19d11b1d66e6ef7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
