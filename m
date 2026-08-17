Received: from mail-yx2-f5.google.com (mail-yx2-f5.google.com [74.125.224.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A443ED10F
	for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2026 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006411; cv=none; b=hwEGAXhoa7Un1XpCuJ9IDNytUpUrPeQoA2qrjtuYnQo5g6OroKV5JCaoCYVJwkMLr8OiB5mw4CTE6yjE2ivsc4zpYNi6DenuSYz591PFXFKELCzF2RbUAuGn5mCBwSSzCUxumUbfxbPVymdnxyPe7bWmeBg2vXeI2AEgrCDl8pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006411; c=relaxed/simple;
	bh=5pK2wFAPykXYbWKw9j+9CU+Sf7TV/OAwc60EQIbTSLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPI446vG3SYqE/RgnDSeDlh9n1DJ6ThpncyRAcmvrFzwfdvsIyBXKwD+WJoujLrCLYAve7N6mEsb0WRMLH10i+dwdPGSlI8CF60l81wxJQAJzbvhqf1VGuZbe7LHyrrc1DkFZWy3L5tfWKeKSoIT4Xw1AauZE1gcj7inFqAQ5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e2Q7BH8I; arc=none smtp.client-ip=74.125.224.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e2Q7BH8I"
Received: by mail-yx2-f5.google.com with SMTP id 956f58d0204a3-66c70d38356so2872231d50.0
        for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2026 15:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787006408; x=1787611208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=97BG6VtICGPgHi+9DUaQeQ2mZyM1OOusq8xn45jRUgo=;
        b=e2Q7BH8IVMaa7RPRFWTUM6wzLHffkALCx2eCbs7NQ8EDyB8QbrvTrCNxX2TXsxyOXU
         ke8t+PxxxZ2V8LvWCrEDIic83vL/EQvgjBNR85bzi9GWOW/zdFPdKf7v+pEt3pH0+W+3
         SQdFGDZWAMwx56Ez9enhwesft0CuiwBFcKbEhv29obGiTFTCRst9lRDIBmNaJE5lmgZu
         mMk/Q2rft08JBuFMekpcCA7nrjipyNYqQ6sdMl33LW1jEyVwmj33S9Sxyn3DFNqV7lS3
         gcppLHvzjPKVZWB7chQMGrsrx93XA1j7C3LxwUPokz4AmSqlqApKjNmWDTm9Vpro3kes
         9fUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787006408; x=1787611208;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=97BG6VtICGPgHi+9DUaQeQ2mZyM1OOusq8xn45jRUgo=;
        b=RQMy2rs9fJijvk/nXcFNnaBFkpTvdtfSh7l7ZJlURJhzQXkTur2upSRsQldg7JndwZ
         Pa8EMu+wT7cK6jsgG6o8jLwwwY9WZGqk24O7Ui8H/V6Q7jkzK3bXvoS/u2PHCnn/nDFi
         Hs9zeZo+Khv0hFj1jwITC/LpzGpUKX7NweGP6uajra/1O0nVd+zfY5cAXc3PNwEWp0t7
         bXJYbXR650+jLH4IikfJKf5BYwH2XDtQXuwEf+g64Q3rX4n6G9o5tK/Kvq5d+yw2vu1X
         LL2qxjga4k4qjj46ul47XUZE8iceH+pBr+dYazMayGTiuWHlWoXwOypbidTaMpJ0yTrd
         xbVg==
X-Forwarded-Encrypted: i=1; AHgh+RoOXvhPxgbboQpjkbkQRjB56vuM0pAgxKdpLU+Scs0yPfUQoqoMX/zgpZ5pdS/i1zuKmERnnn7pWijctTB2EuL8GS6nis8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx37kI30+HziPxHQtXbqWYE9Nsfzl/MGqsLdI3BgL0Qed9GAxf
	TerHX4Qzl4oul9Wcs/9NHqJbHRvNTqDK9mBE+fM41EyFr65cWsCD8ua20FdokYRJ/Gk=
X-Gm-Gg: AR+sD12cw3Vx7YQf+Ye6WSOhSo7AD8KxDvxNkGlOSlWTjDz8IPC21QVWqTPcF6oVfOF
	vBMSHXSOPGZz6jo7s9VU8Exn2rg485nKQR16I5VFFonWGz/JVzMeAIQ0LIP7ZtGf12gbCju1dyO
	CeGNtAU247ERYpoah0qpE3YuDNJsrQ+Ts6DKU+8PkCFd7zn6uwTIETsHN3zJzW6I4pzBH+FjC6M
	7F0XlwYKFw/YFlrqLXrvB/tpWe5zBaHZDalLcU6BqAl30HVWM9jieCVK416gA70R3zZqpk/9jdj
	rQEQfxDonsLG042Nxd6y4G4ZhtIiZK21BdBWonlW4QTKvpBytQ5kQ0qfJ+GRaqaQ+TxUhvZAkCf
	oEOTrd+6k8DQ5Nh2BSVTQgE7zPyQEOzTKXxX+biRPtLTPY3XWZM3ONKG0zSFnd6m3hfs2elAq71
	PE8KlpGgp/IwEeBI9uJ0C30INzj/i7YpIaXPAsHBM=
X-Received: by 2002:a05:690e:43c7:b0:668:db:8c35 with SMTP id 956f58d0204a3-66cb9d15d3cmr1260532d50.20.1787006408368;
        Mon, 17 Aug 2026 15:40:08 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cb57903d5sm1391547d50.14.2026.08.17.15.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 15:40:07 -0700 (PDT)
Date: Mon, 17 Aug 2026 17:40:05 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: syzbot <syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com>, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, roberto.sassu@huawei.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [integrity?] possible deadlock in
 ima_file_truncate
Message-ID: <cevxz5bpcfdm5uvjmu3a6qql2qar4477oczd4knffn4wkgojds@ubo47iitdo6k>
References: <6a77c7cd.b50370da.49fe0.0031.GAE@google.com>
 <cc5bsuwzvdoqrhgggqqb6qgkgh2cxymbupt4ghsi2msnudh4rf@slzwriyjykze>
 <6045f93f2e2c2ad4f6227509d363e75bf2340510.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6045f93f2e2c2ad4f6227509d363e75bf2340510.camel@linux.ibm.com>

On Mon, Aug 17, 2026 at 06:21:57PM -0400, Mimi Zohar wrote:
> On Mon, 2026-08-17 at 15:43 -0500, Frederick Lawler wrote:
> > On Sat, Aug 08, 2026 at 05:20:29PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.org..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=113c53b9580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=448c2e24b1ceff13ed2a
> > > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/dde4460fa7fd/disk-c21bb419.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/e1fe13568a84/vmlinux-c21bb419.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/283184100427/bzImage-c21bb419.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
> > > 
> > > ======================================================
> > > WARNING: possible circular locking dependency detected
> > > syzkaller #0 Not tainted
> > > ------------------------------------------------------
> > > syz.3.857/8643 is trying to acquire lock:
> > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_reset_action_flags security/integrity/ima/ima_main.c:708 [inline]
> > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_reset_action_flags security/integrity/ima/ima_main.c:697 [inline]
> > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_file_truncate+0xe6/0x190 security/integrity/ima/ima_main.c:723
> > > 
> > > but task is already holding lock:
> > > ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: do_open fs/namei.c:4693 [inline]
> > > ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: path_openat+0x2929/0x4280 fs/namei.c:4863
> > > 
> > 
> > I had AI whip up a reproducer for this, but it's not mutually exclusive to the
> > added patch. Tested by running reproducer, then unapplied patch, still
> > reproduced on v7.2-rc4.
> > 
> > I'll need to simplify it before I post it.
> > 
> > #syz dup: [syzbot] [integrity?] [lsm?] possible deadlock in process_measurement (6)
> > 
> > See below for un-applied repro result.
> 
> Hi Fred,
> 
> In response to this syzbot, I responded:

Sorry, I must've missed that.

> Like other pseudo filesystems, configfs files should not be measured by IMA.  To
> addresss this particular bug, please add a rule to the builtin
> dont_measure_rules[] and default_appraise_rule[] policies.
> 
> Without the configfs filesystem being in policy, can you reproduce the deadlock?

I was not able to.

Best,
Fred
