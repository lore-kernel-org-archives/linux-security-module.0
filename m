Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B06B67E
	for <linux-security-module@vger.kernel.org>; Sat, 28 Sep 2024 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727486746; cv=none; b=rzFOl/W/ihtxSvnKa+Yv4Kp86tt0TcepCwMDhTuRHcJJyICqWiwVQpvHVEB8v7P7+DzRpiJW76qFx4o8c/1BLmU9EJjnYNH5e1VENWsq6LRLoPi4/nUCIMWtMpsVFq+ObxfCNapvgkdosM2jdROdwetriwBvpygnegzWfHRnKpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727486746; c=relaxed/simple;
	bh=jPUSEh9FCNIvrNqStehrhErh5ihqIT1DZ9rsVyEazeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn/1JcajqEUz24MOxCd/pUBKoPnwXiOVK31A+Q1o3N0BzXOe0j/wBs2pGhIyLHJaFZOYVTgsr6VL1a7wAHK6F+F36IGW2uRWt08nTQwLtTaxiVA15xXEFIdRIoTa7hGSBwvXXeV8h8C6UT3HGMozFDVzvPD2al30pGVtyLxA8YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CVhlO0jX; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CVhlO0jX"
Date: Fri, 27 Sep 2024 21:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727486741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ff6ohtx94F3pZDLlRAIikfKqB72ebwv0OgN33Zat0K0=;
	b=CVhlO0jX7j56+Go8Hw0rWq2kfvkB4Dm0/VSUsCDktamGOK2teTcZAIR79+8Rq/NPEwZcOW
	F8kCOIwav5f1rcPnuaLSktzS28v/gSWl/0inzPUqv00jyJHQqHqWv/ebPgM732qCDiAQuP
	iULHgGIEJq6hK9vTTKtAUNwtGJEP5QE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	syzbot <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly lsm report (Sep 2024)
Message-ID: <owdoubzm3jqf4cuhawaavver5mzko32ijuh2nrm5vhzegmjbmf@az3mweawrni6>
References: <66f12e9e.050a0220.3eed3.0009.GAE@google.com>
 <CAHC9VhTxCzWvM+j8=J08JVs=1cwk9rtBSS7qFBkdm-_neAwkJQ@mail.gmail.com>
 <03c3a47ca225050d37dca6a9249c1f978f1fc56b.camel@huaweicloud.com>
 <734977390eeecba39789df939a00904e87367e5e.camel@huaweicloud.com>
 <nqxo5tqcwbwksibg45spssrnhxw7tabfithgnqnmpl2egmbfb7@gyczfn7hivvu>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nqxo5tqcwbwksibg45spssrnhxw7tabfithgnqnmpl2egmbfb7@gyczfn7hivvu>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 27, 2024 at 08:08:48PM GMT, Kent Overstreet wrote:
> On Fri, Sep 27, 2024 at 02:18:10PM GMT, Roberto Sassu wrote:
> > On Tue, 2024-09-24 at 13:53 +0200, Roberto Sassu wrote:
> > > On Mon, 2024-09-23 at 08:06 -0400, Paul Moore wrote:
> > > > On Mon, Sep 23, 2024 at 5:02 AM syzbot
> > > > <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com> wrote:
> > > > > 
> > > > > Hello lsm maintainers/developers,
> > > > > 
> > > > > This is a 31-day syzbot report for the lsm subsystem.
> > > > > All related reports/information can be found at:
> > > > > https://syzkaller.appspot.com/upstream/s/lsm
> > > > > 
> > > > > During the period, 0 new issues were detected and 0 were fixed.
> > > > > In total, 4 issues are still open and 27 have been fixed so far.
> > > > > 
> > > > > Some of the still happening issues:
> > > > > 
> > > > > Ref Crashes Repro Title
> > > > > <1> 306     No    INFO: task hung in process_measurement (2)
> > > > >                   https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
> > > > 
> > > > Mimi, Roberto,
> > > > 
> > > > Any chance this is this related in any way to this report:
> > > > 
> > > > https://lore.kernel.org/linux-security-module/CALAgD-4hkHVcCq2ycdwnA2hYDBMqijLUOfZgvf1WfFpU-8+42w@mail.gmail.com/
> > > 
> > > I reproduced the last, but I got a different result (the kernel crashed
> > > in a different place).
> > > 
> > > It seems a corruption case, while the former looks more a lock
> > > inversion issue. Will check more.
> > 
> > + Kent Overstreet
> > 
> > https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
> > 
> > It happens few times per day, since commit 4a39ac5b7d62 (which is
> > followed by a lot of merges). The bug has been likely introduced there.
> > 
> > In all recent reports, I noticed that there is always the following
> > lock sequence:
> > 
> > [  291.584319][   T30] 5 locks held by syz.0.75/5970:
> > [  291.594487][   T30]  #0: ffff888064066420 (sb_writers#25){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90
> > [  291.603984][   T30]  #1: ffff88805d8b0148 (&sb->s_type->i_mutex_key#30){++++}-{3:3}, at: do_truncate+0x20c/0x310
> > [  291.614497][   T30]  #2: ffff888054700a38 (&c->snapshot_create_lock){.+.+}-{3:3}, at: bch2_truncate+0x16d/0x2c0
> > [  291.624871][   T30]  #3: ffff888054704398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bch2_trans_get+0x7de/0xd20
> > [  291.635446][   T30]  #4: ffff8880547266d0 (&c->gc_lock){.+.+}-{3:3}, at: bch2_btree_update_start+0x682/0x14e0
> > 
> > IMA is stuck too, since it is waiting for the inode lock to be released:
> > 
> > [  291.645689][   T30] 1 lock held by syz.0.75/6010:
> > [  291.650622][   T30]  #0: ffff88805d8b0148 (&sb->s_type->i_mutex_key#30){++++}-{3:3}, at: process_measurement+0x439/0x1fb0
> > 
> > It seems that the super block is locked by someone else, which is not
> > able to unlock. Maybe, it is related to bch2_journal_reclaim_thread(),
> > but I don't know for sure.
> > 
> > Kent, do you have time to look at this report?
> 
> If you scroll back in the console log, you see this:
> 
> [  230.372988][ T6772] Allocator stuck? Waited for 30 seconds
> [  230.373025][ T6772] Allocator debug:
> [  230.373039][ T6772]   capacity1536
> [  230.373051][ T6772]   reserved             31232
> [  230.373064][ T6772]   hidden               0
> [  230.373077][ T6772]   btree                0
> [  230.373090][ T6772]   data                 0
> [  230.373102][ T6772]   cached               0
> [  230.373114][ T6772]   reserved             0
> [  230.373127][ T6772]   online_reserved      768
> [  230.373140][ T6772]   nr_inodes            0
> [  230.373152][ T6772]   
> [  230.373164][ T6772]   freelist_wait        waiting
> [  230.373176][ T6772]   open buckets allocated1
> [  230.373189][ T6772]   open buckets total   1024
> [  230.373202][ T6772]   open_buckets_wait    empty
> [  230.373214][ T6772]   open_buckets_btree   0
> [  230.373227][ T6772]   open_buckets_user    0
> [  230.373239][ T6772]   btree reserve cache  0
> [  230.373251][ T6772] 
> [  230.373262][ T6772] Dev 0:
> [  230.373274][ T6772]                      buckets         sectors      fragmented
> [  230.373288][ T6772]   free                     0               0               0
> [  230.373303][ T6772]   sb                       0               0               0
> [  230.373318][ T6772]   journal                  0               0               0
> [  230.373332][ T6772]   btree                    0               0               0
> [  230.373347][ T6772]   user                     0               0               0
> [  230.373361][ T6772]   cached                   0               0               0
> [  230.373375][ T6772]   parity                   0               0               0
> [  230.373390][ T6772]   stripe                   0               0               0
> [  230.373404][ T6772]   need_gc_gens             0               0               0
> [  230.373418][ T6772]   need_discard             0               0               0
> [  230.373432][ T6772]   unstriped                0               0               0
> [  230.373446][ T6772]   capacity               128
> [  230.373459][ T6772]   
> [  230.373470][ T6772]   reserves:
> [  230.373481][ T6772]   stripe                  60
> [  230.373494][ T6772]   normal                  58
> [  230.373506][ T6772]   copygc                  56
> [  230.373519][ T6772]   btree                   28
> [  230.373531][ T6772]   btree_copygc             0
> [  230.373543][ T6772]   reclaim                  0
> [  230.373556][ T6772]   interior_updates         0
> [  230.373569][ T6772]   
> [  230.373580][ T6772]   open buckets             0
> [  230.373592][ T6772]   buckets to invalidate    0
> [  230.373605][ T6772] 
> [  230.373616][ T6772] Copygc debug:
> [  230.373627][ T6772]   running: 1
> [  230.373656][ T6772]   copygc_wait:0
> [  230.373675][ T6772]   copygc_wait_at:0
> [  230.373694][ T6772]   Currently waiting for:0 B
> [  230.373708][ T6772]   Currently waiting since:644 KiB
> [  230.373722][ T6772]   Currently calculated wait:0 B
> [  230.373735][ T6772]
> 
> this looks like a bug in bcachefs where alloc counters didn't get
> initialized correctly, which makes sense given that 6.11 landed the disk
> accounting rewrite. Will dig more as I have time.

And looking further, I don't see anyhting in the console log from when
bcachefs actually mounted (???), which means I don't think I have enough
to go on. It's clearly an upgrade path issue - we didn't run
check_allocations as is required when upgrading to 1.11 - but it's not
reproducing for me when I run tests with old tools.

Can we get some more information about the syzbot reproducer? Exact
tools version, format command and mount command.
