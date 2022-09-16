Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB95ECAAD8
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Sep 2022 20:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiIPUUU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 16 Sep 2022 16:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiIPUUS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Sep 2022 16:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1438B580A0;
        Fri, 16 Sep 2022 13:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A46B962D91;
        Fri, 16 Sep 2022 20:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0980DC433B5;
        Fri, 16 Sep 2022 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663359616;
        bh=nRLV12Mb0YiipccVdbD4fD+/s41J01u+MTPMkL8uEHw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rNow7IWEtKu45jLz8tknCNlcqG+XDyoqf8ccLCDHisIV2O9YQaVkLiWhlL0oS50ME
         QO1MjiIH7l9axIHErFpRLeKG8g01Gm1oP1rbz4co9sLO1Oqrcm0JF2+wzGKy9B7IjH
         C3X7PBlnTQ7kDlnAATiowhE4CBlYonhmm71CLZpBKyCrVPZiXwhSerqimzVJ+TdIUy
         fPLNJJFjC3TRiIX8n0kFx5QzpYKMAzMXBi6ye4JgN1yHXoeT7Edv4vxjzUCXcxoD5o
         4OL/8IMz35IfYe8nDb7Vu6+Htidzg5AZuna2RHZpiPq8wo1acAY3DlBrr5FamcXvmq
         FiJ15jEtmIDNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D98EAC73FFD;
        Fri, 16 Sep 2022 20:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: use bpf_capable() instead of CAP_SYS_ADMIN for
 blinding decision
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166335961587.27465.6441988777317672518.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Sep 2022 20:20:15 +0000
References: <20220905090149.61221-1-ykaliuta@redhat.com>
In-Reply-To: <20220905090149.61221-1-ykaliuta@redhat.com>
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org,
        alexei.starovoitov@gmail.com, jbenc@redhat.com,
        daniel@iogearbox.net, serge@hallyn.com,
        linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  5 Sep 2022 12:01:49 +0300 you wrote:
> The full CAP_SYS_ADMIN requirement for blining looks too strict
> nowadays. These days given unpriv eBPF is disabled by default, the
> main users for constant blinding coming from unpriv in particular
> via cBPF -> eBPF migration (e.g. old-style socket filters).
> 
> Discussion: https://lore.kernel.org/bpf/20220831090655.156434-1-ykaliuta@redhat.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: use bpf_capable() instead of CAP_SYS_ADMIN for blinding decision
    https://git.kernel.org/bpf/bpf-next/c/bfeb7e399bac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


