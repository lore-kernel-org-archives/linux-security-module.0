Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2371C4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Nov 2023 19:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346197AbjKJTyW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Nov 2023 14:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbjKJTyJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Nov 2023 14:54:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AA615E07;
        Fri, 10 Nov 2023 11:29:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E66FC433C7;
        Fri, 10 Nov 2023 19:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699644540;
        bh=9Mo74Jdwx7VtQfNYARRBHk1CGMoO66Kzfcj96miMqss=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tlFu8vBjitaykNC4MXzPfGbCrBxNZvrLfLwPW9teSq+LySaeeuJjnzq/+L4eZthN9
         n7S+5CW8lBhnaqO2zW98gykGu3CAZOz2QGdFgxMkcrSoFpgl/o5bvQHPj/BZ8MQUL2
         pFbmdy2iBJ4Gl/CgB616ZweV9TNEy+GqlGqJLcJgb/zr9Ot8OpPYztMYQQBZQ5EQgW
         05wQwQLkSRvOlEwr78mTPUzMmp2PMTDn9nELm/+GrNoxIdqXKrPmB2iqWrLb5RXKYh
         xvLgudzDoxGnclXVYfcwZlI2TuJGvn+566melhEOc3/YDCXVWhXk3C3ekk9vD7hKnT
         nKgyMyM1pNOxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03E41EAB08C;
        Fri, 10 Nov 2023 19:29:00 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20231109
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9672faa215f6b6f1c17ccc622a633611.paul@paul-moore.com>
References: <9672faa215f6b6f1c17ccc622a633611.paul@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9672faa215f6b6f1c17ccc622a633611.paul@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20231109
X-PR-Tracked-Commit-Id: b36995b8609a5a8fe5cf259a1ee768fcaed919f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ead3b62a34d829d2df38187b93a18c22b289bd9c
Message-Id: <169964454000.4685.8575136377510438549.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Nov 2023 19:29:00 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The pull request you sent on Thu, 09 Nov 2023 18:59:45 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20231109

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ead3b62a34d829d2df38187b93a18c22b289bd9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
