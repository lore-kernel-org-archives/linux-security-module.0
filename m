Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBEEC61DA4
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Mar 2023 22:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjCIW1y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Mar 2023 17:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjCIW1x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Mar 2023 17:27:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A91FA0AE;
        Thu,  9 Mar 2023 14:27:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7080FCE2687;
        Thu,  9 Mar 2023 22:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4FCC433D2;
        Thu,  9 Mar 2023 22:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678400868;
        bh=8ypCYFnJ44r5UZkUrRg3YEA023GJRxYOCkGkfnGE1rI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LrikRTauMWxorofVtFJUp/PBs3uUKJgK6V3mYsnNSRpNYK3BImPEY6YjP0wUhuNLo
         QUcCIZjm8X/yGI8zhtzvFEKQfPm8e6WopsnDGU3LdJNXEddBFgUuPDHeh0wO6LzEMt
         h43MST25WcQmDjkkaZBS2Wsit/I/gAU1diaptB9Q=
Date:   Thu, 9 Mar 2023 14:27:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jeff Xu <jeffxu@google.com>, Eric Biggers <ebiggers@kernel.org>,
        ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, tytso@mit.edu,
        guoren@kernel.org, j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] kernel: pid_namespace: simplify sysctls with
 register_sysctl()
Message-Id: <20230309142746.0bc649a31e76bc46fd929304@linux-foundation.org>
In-Reply-To: <ZApZj9DmMYKuCQ3g@bombadil.infradead.org>
References: <20230302202826.776286-1-mcgrof@kernel.org>
        <20230302202826.776286-9-mcgrof@kernel.org>
        <CALmYWFucv6-9yfS=gamwSsqjgxSKZS0nvVjj_QfBmsLmQD5XOQ@mail.gmail.com>
        <ZApZj9DmMYKuCQ3g@bombadil.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 9 Mar 2023 14:11:27 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:

> Andrew, kernel/pid_sysctl.h is new, not on v6.3-rc1 and so I cannot
> carry this on sysctl-next. Can you carry this patch on your tree?

Sure, no probs.
