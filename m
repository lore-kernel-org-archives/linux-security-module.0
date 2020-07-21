Return-Path: <SRS0=/BYZ=BA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAB5C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Jul 2020 00:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A94D22CAE
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Jul 2020 00:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595291913;
	bh=zn97BBCV9wx9Bl4hJt31tQNVSYEFVcKnoAZiJ8T9vTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VJryGr0KaBiDmXLVpD2mY1XNHnl6/VT3klYh+XOfOiqx33XJpjDQPVI0ntSSCFqVr
	 ZHeqjF8vYSOS3E7Zilmjxl4dKft7u3tu1gy8UWAENOqdP6zCZXk0+2jeLPH8/fTjLs
	 LeLrdhP6xgXjfabiFuj/9QgMPz8ubQReMix3BrXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgGUAic (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgGUAic (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 20:38:32 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE54208E4;
        Tue, 21 Jul 2020 00:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595291911;
        bh=zn97BBCV9wx9Bl4hJt31tQNVSYEFVcKnoAZiJ8T9vTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBnM4rxbH77JMpzUSJ9gLUVH/pY8umGnO6vJB3TgtG0lc5NW1bKxZeSlPbFndFPqE
         DCOaord2OirGTGgtWeCg9pIgjM3mgx3xj9xCEGMYkvf6KXBLhu9ZdGzt3lzlp7giF2
         ELQ1JjYDNwufy6O10uEXUiIDfM5YfEE1EOabOqoE=
Date:   Mon, 20 Jul 2020 17:38:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        syzbot+e6416dabb497a650da40@syzkaller.appspotmail.com
Subject: Re: [PATCH] Smack: fix use-after-free in smk_write_relabel_self()
Message-ID: <20200721003830.GC7464@sol.localdomain>
References: <0000000000000279c705a799ae31@google.com>
 <20200708201520.140376-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708201520.140376-1-ebiggers@kernel.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 08, 2020 at 01:15:20PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> smk_write_relabel_self() frees memory from the task's credentials with
> no locking, which can easily cause a use-after-free because multiple
> tasks can share the same credentials structure.
> 
> Fix this by using prepare_creds() and commit_creds() to correctly modify
> the task's credentials.
> 
> Reproducer for "BUG: KASAN: use-after-free in smk_write_relabel_self":
> 
> 	#include <fcntl.h>
> 	#include <pthread.h>
> 	#include <unistd.h>
> 
> 	static void *thrproc(void *arg)
> 	{
> 		int fd = open("/sys/fs/smackfs/relabel-self", O_WRONLY);
> 		for (;;) write(fd, "foo", 3);
> 	}
> 
> 	int main()
> 	{
> 		pthread_t t;
> 		pthread_create(&t, NULL, thrproc, NULL);
> 		thrproc(NULL);
> 	}
> 
> Reported-by: syzbot+e6416dabb497a650da40@syzkaller.appspotmail.com
> Fixes: 38416e53936e ("Smack: limited capability for changing process label")
> Cc: <stable@vger.kernel.org> # v4.4+
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Ping.
