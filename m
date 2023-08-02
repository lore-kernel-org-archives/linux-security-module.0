Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85687C04A94
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Aug 2023 19:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjHBTk0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Aug 2023 15:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjHBTkZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Aug 2023 15:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7CB1A5
        for <linux-security-module@vger.kernel.org>; Wed,  2 Aug 2023 12:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEF3361AF5
        for <linux-security-module@vger.kernel.org>; Wed,  2 Aug 2023 19:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43FBFC433CA;
        Wed,  2 Aug 2023 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691005223;
        bh=UgfOVAd3N0LE9A421tDJHpcTHgt1AdghlOG6PzQ8gqc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=u7Mq+vdIZrRtFdVMFkh+sIo3KQOXMGTUnGrYEp97lJACLFEWw1GFT6yw9We1VMLco
         RYgxWjfuKfIgyGdG8hmvru/KZgVvBGZcTpf5SoThlDZOOMAXewshBeapP7efDQsSqZ
         m2QmmwAFvbfz53IkoKKJQ9iYHAdk9Z0WNExzliVaMel6IT3TgZqzfL+u476chWgMrj
         rgjcQ1CdseuRlirnL5NFgQIU79H6ZDhtAOfHLGnMo6U944ba/gVtTeNED9RdHUk/Ap
         EiQY0ZYoNt0A9l982d22WNkY+V9qWQPW4+lx88SR6T9f30YRnFnKVmLrm9Bst5uPjq
         GamRThn1Jh5fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B51EE270D7;
        Wed,  2 Aug 2023 19:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlabel: Remove unused declaration
 netlbl_cipsov4_doi_free()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169100522317.7181.17650055028866907046.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 19:40:23 +0000
References: <20230801143453.24452-1-yuehaibing@huawei.com>
In-Reply-To: <20230801143453.24452-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     paul@paul-moore.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Aug 2023 22:34:53 +0800 you wrote:
> Since commit b1edeb102397 ("netlabel: Replace protocol/NetLabel linking with refrerence counts")
> this declaration is unused and can be removed.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/netlabel/netlabel_cipso_v4.h | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] netlabel: Remove unused declaration netlbl_cipsov4_doi_free()
    https://git.kernel.org/netdev/net-next/c/e12f2a6d1b9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


