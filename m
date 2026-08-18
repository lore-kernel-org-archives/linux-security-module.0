Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00236F433
	for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081991; cv=none; b=pT3drbrI9k/oZq0E8RNqIXt6wXTN9oRNNKbFWlnPcNgzX2njBgMEfAG6UPwZh+Zvt5K1tqJ/rtQ53HklsPYcdiLd+ufPQG4kZV3P9SJrnrDE/CNmVnw95fS5JpP8HVZoWf2NfdMoPtRT09QbvsMEkm7JqvpqvtqyvH4uLpMcwo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081991; c=relaxed/simple;
	bh=4+UTR7Z7d5DwpYL503R5TO4vWVuUTpEXPr+HACLyLwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPvJXLSIdgt3xzFEbWK+5F0efRjiNDRehdzpQOaiqYAoSlTd3GGsLVMryAGyMckZYCo822tSL0kklTSV15l1297joEswV2CqC3fQIc/JL/5uymV++QSgCydx/3VW+A24YoB9uPNd0lhjQG1OWRYmuKYsRMZnmcXJ4zeWMy7WIeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IWN95f3c; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IWN95f3c"
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4ab2d8e7e4cso99139b6e.1
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787081989; x=1787686789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8LtuU+tO63aCvSR2Bm+1jaIeVmDj7SPmB1MVl55mOpg=;
        b=IWN95f3cMOxRF+fBlNnOSw+rrp0ZpsiKqQjJ9stXCvtFf7CUTfu2wdGOack2yKuIiB
         VB3N1aVnyZlajTHLCj7RjVNyacvyCIsjJVhngX7pDrChtAHSf/qvBdnXYimvu1NN/wuL
         3PNesodW7M1u02AQtAry1FG4NumJyEQtOeJSqFlYs1YyttW1J34bEHhMZIJ/DRXiEY3k
         SH3HA1TusuGOUYSFC7bEXpj04AbRVyJ4r9/ur46BFJ5kvyWnXtYwqSxAoTqNJUg7YXOJ
         WQ1LcrWL5r6+7rM6BQCcAcj+/0Yqb71EnuNn79yvBBgWCJenpBudRPjW/FDy/tRXCXqH
         v1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787081989; x=1787686789;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8LtuU+tO63aCvSR2Bm+1jaIeVmDj7SPmB1MVl55mOpg=;
        b=RmeAHKc4NzxaXSZExnmdIpXNObd291lDciFoaMqf2dK6ypRoCCxz9waXF/iKdUb/BT
         UQgMENq0uDz+mSX0kT7IIWKaOF99eIwD3V4Kv0Zdx3ZNjQ7gomA2NpQh/o3Oj6TJWZna
         m1lYxuCVG8fAcbTrNPQiu6N5/PfwwRQrvND9KW620PlnNAc76xUSRho1IeP6+kdFfnDU
         8Tt1i7NwkNZss6vVhHNS4DS9J/c06B0oe/IKRjA28K/MYdzob5GuktVmSlR9XlKN1cYk
         Tnbs+zhJNqHDRqsXBybRAMZgXasaQwGvX6fyCenJucBTOzN++A7IXsb69f7RGaYn/rGZ
         fE+g==
X-Forwarded-Encrypted: i=1; AHgh+RpDTgHELqbwfsi/M/gtx6L/D6nOeUbeIN35FyRJKTqKjaTeH3EwIl85PeucxtGC73vzcE1memsn2PyM5HZLbbKerioOGVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW5ZBgTvMydiqr6+lZawlFPZc/TbHVm2pX6l9u4Zv9fP80pfsL
	t5awUSTpF2yeSN3yN99kVSiknMuovuhReAK5lc2MMhw6F6DdyEhIK0GnPWWUkF7NlX8=
X-Gm-Gg: AR+sD12dnT/hV+4d2iT5mG+zpDGFjFRkRjlBW6e4FLorxl14UVyvpq5VgKbC/9sTHNy
	megzhYcZISmXzrg11gnWQtRVuSS8WJeahfhtMpz+hIIxa8n0ibd0ExRAeNRBnjv75Ec29StJeBD
	Fx+K/ejtZbY7C1u3oy1d/+syIioQ8gipTthmoK2O9o0cMFFFDtbMhFW8A+2CKmQutjxe9tM1g7W
	FpYkPbNRjID2L/gHLNdPPl/3s/dZCbDKFlXiPJwF3KY4iHGNW8JYc/xlt1bluBWqXeWUqkLikHu
	h7e3SC7jOqjbPYiaJDW82o0v1E0gvMbUkVhGCpr7isMsVrIRg1JM47VrSWe0B4tPeNePYcSacUz
	pQEnzRagvW06xIK3HLXa8LEFDnnEPfCeWu30Zw/cGkR7H3STcQ0bm6FY7ZU7GTGR7Ptdp0kcxmn
	1eE5VKt3uJ3hjkRA203MC0i0XAzCdYztfKrhb7A4o=
X-Received: by 2002:a05:6808:c1e3:b0:4b2:98a3:a567 with SMTP id 5614622812f47-4b2b8fd69d1mr746b6e.4.1787081988851;
        Tue, 18 Aug 2026 12:39:48 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:52])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2960e32dasm4070878b6e.15.2026.08.18.12.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:39:48 -0700 (PDT)
Date: Tue, 18 Aug 2026 14:39:44 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: syzbot <syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com>, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, roberto.sassu@huawei.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [lsm?] [integrity?] possible deadlock in
 ima_file_truncate
Message-ID: <5jqpdvvwpkrtsvtujrxm4mnuggsaztmm7etwmus3gwznxh5fch@gs5aducakh4q>
References: <6a77c7cd.b50370da.49fe0.0031.GAE@google.com>
 <cc5bsuwzvdoqrhgggqqb6qgkgh2cxymbupt4ghsi2msnudh4rf@slzwriyjykze>
 <6045f93f2e2c2ad4f6227509d363e75bf2340510.camel@linux.ibm.com>
 <cevxz5bpcfdm5uvjmu3a6qql2qar4477oczd4knffn4wkgojds@ubo47iitdo6k>
 <415f81878ac595830e5b5051a5828311c2434e03.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415f81878ac595830e5b5051a5828311c2434e03.camel@linux.ibm.com>

On Mon, Aug 17, 2026 at 07:32:43PM -0400, Mimi Zohar wrote:
> On Mon, 2026-08-17 at 17:40 -0500, Frederick Lawler wrote:
> > On Mon, Aug 17, 2026 at 06:21:57PM -0400, Mimi Zohar wrote:
> > > On Mon, 2026-08-17 at 15:43 -0500, Frederick Lawler wrote:
> > > > On Sat, Aug 08, 2026 at 05:20:29PM -0700, syzbot wrote:
> > > > > Hello,
> > > > > 
> > > > > syzbot found the following issue on:
> > > > > 
> > > > > HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.org..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=113c53b9580000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=448c2e24b1ceff13ed2a
> > > > > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > > > > 
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > 
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/dde4460fa7fd/disk-c21bb419.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/e1fe13568a84/vmlinux-c21bb419.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/283184100427/bzImage-c21bb419.xz
> > > > > 
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
> > > > > 
> > > > > ======================================================
> > > > > WARNING: possible circular locking dependency detected
> > > > > syzkaller #0 Not tainted
> > > > > ------------------------------------------------------
> > > > > syz.3.857/8643 is trying to acquire lock:
> > > > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_reset_action_flags security/integrity/ima/ima_main.c:708 [inline]
> > > > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_reset_action_flags security/integrity/ima/ima_main.c:697 [inline]
> > > > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_file_truncate+0xe6/0x190 security/integrity/ima/ima_main.c:723
> > > > > 
> > > > > but task is already holding lock:
> > > > > ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: do_open fs/namei.c:4693 [inline]
> > > > > ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: path_openat+0x2929/0x4280 fs/namei.c:4863
> > > > > 
> > > > 
> > > > I had AI whip up a reproducer for this, but it's not mutually exclusive to the
> > > > added patch. Tested by running reproducer, then unapplied patch, still
> > > > reproduced on v7.2-rc4.
> > > > 
> > > > I'll need to simplify it before I post it.
> > > > 
> > > > #syz dup: [syzbot] [integrity?] [lsm?] possible deadlock in process_measurement (6)
> > > > 
> > > > See below for un-applied repro result.
> > > 
> > > Hi Fred,
> > > 
> > > In response to this syzbot, I responded:
> > 
> > Sorry, I must've missed that.
> > 
> > > Like other pseudo filesystems, configfs files should not be measured by IMA.  To
> > > addresss this particular bug, please add a rule to the builtin
> > > dont_measure_rules[] and default_appraise_rule[] policies.
> > > 
> > > Without the configfs filesystem being in policy, can you reproduce the deadlock?
> > 
> > I was not able to.
> 
> Do have time to post 2 patches - one to move the configfs magic number to
> magic.h and the other to update the IMA builtin policies?

Sure thing. Here's the post[1].

I rebased on linux-integrity/next-integrity.
(forgot to include that in cover)

Best,
Fred

[1]: https://lore.kernel.org/all/20260818-configfs-v1-0-a2329043cf86@cloudflare.com/
