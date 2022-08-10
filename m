Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B4BC3F6B0
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Aug 2022 08:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiHJIaq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Aug 2022 04:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiHJIaT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Aug 2022 04:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953AE192;
        Wed, 10 Aug 2022 01:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C98B60DD1;
        Wed, 10 Aug 2022 08:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FE2BC433D7;
        Wed, 10 Aug 2022 08:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660120215;
        bh=FF7J0DTrGGZjgpb8MEFPQJvwNg4cYx7QMlN0iNTcGhs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dVqE7f/vQI4+cAclDugsYC0Q5GBBW+cIpVaJxxtLf65csG0bukJqbVe8Q9tfhrqSS
         bzF9PftejAN3UUDLsvLcZf7uV5Ln8RcL1hrdhM2l2wRuJaIuPgUTM/EzBtkW3nA2gq
         SBFf/1LM0V1fPYj3iXNYsPgQroG9L4MiIXmf+8YRZPigmaMFzcfxALwaW/Hah0HQMG
         og9xpQAFrctlwKDAKWyKLe6CAwZRVCpApzU8E/1YiHxtOqeTOnZTWe1d10avBLl7aX
         x4fhA+6/uICd4Bmla68D6f3D6s+cB/mfb0Twf0HyDz92IxTvJhMN1FCKC2gBKLmTBz
         5/2ccur9fePjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C662C43141;
        Wed, 10 Aug 2022 08:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netlabel: fix typo in comment
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166012021543.17355.3583207371635676893.git-patchwork-notify@kernel.org>
Date:   Wed, 10 Aug 2022 08:30:15 +0000
References: <20220806101253.13865-1-toiwoton@gmail.com>
In-Reply-To: <20220806101253.13865-1-toiwoton@gmail.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     paul@paul-moore.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Sat,  6 Aug 2022 13:12:53 +0300 you wrote:
> 'IPv4 and IPv4' should be 'IPv4 and IPv6'.
> 
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  net/netlabel/netlabel_unlabeled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - netlabel: fix typo in comment
    https://git.kernel.org/netdev/net/c/2cd0e8dba7a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


