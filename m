Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8318BBBA;
	Fri, 27 Sep 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439515; cv=none; b=NE1feotD+2C539JBX1mewHKhxuybQSLfcnwKWB7juaK7uunB2Ib4m+tlCmmaGTYMHdYe4n4MjPh5UGemCYR4n82DZkV9C8BwuN7WqbvuH4tsaYoge45Ajl1Bl4UtU+/26KGWXRlbDpQtJkY0QRFkwk/sN0m/0Y/qB1c/zKcuXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439515; c=relaxed/simple;
	bh=edvQBv5AUfoNTOsFmR3z05KBgHJ+rA2bfOcdUdEwcKY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ODkF3xn4gK94aufZuWWQD/X4PWN2p5MkvTyo/SlJd1S96tu711S/buOzEloQ28mZNDiEKpOCXtUQZhs02ojvt3nT4Gu4M1H/YsAUhhNdkVUta6vjktOeMLanN4eu0JKY1tgamyHVCPui4kalkCx+mGNwNNnZICMejcDnmSOMeeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XFTWf26Hmz9v7J8;
	Fri, 27 Sep 2024 19:58:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id D6740140391;
	Fri, 27 Sep 2024 20:18:24 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnFseFovZmRBTBAQ--.50193S2;
	Fri, 27 Sep 2024 13:18:23 +0100 (CET)
Message-ID: <734977390eeecba39789df939a00904e87367e5e.camel@huaweicloud.com>
Subject: Re: [syzbot] Monthly lsm report (Sep 2024)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, Casey Schaufler
 <casey@schaufler-ca.com>, syzbot
 <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com>, Kent
 Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Date: Fri, 27 Sep 2024 14:18:10 +0200
In-Reply-To: <03c3a47ca225050d37dca6a9249c1f978f1fc56b.camel@huaweicloud.com>
References: <66f12e9e.050a0220.3eed3.0009.GAE@google.com>
	 <CAHC9VhTxCzWvM+j8=J08JVs=1cwk9rtBSS7qFBkdm-_neAwkJQ@mail.gmail.com>
	 <03c3a47ca225050d37dca6a9249c1f978f1fc56b.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBnFseFovZmRBTBAQ--.50193S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW5Zw4fKw1kJw4xCw1ftFb_yoW5Xr4xpF
	WjyF4FyrsYqr1UtayvvF4UGw4rt395GFWUJrWDWr1xA3ZIyryxCryIkF4F9r4DCrn3A34a
	qr1Yv3Z3A34kZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYY7kG6xAYrwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUgZ2-UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGb2FP0JIgAAsH

On Tue, 2024-09-24 at 13:53 +0200, Roberto Sassu wrote:
> On Mon, 2024-09-23 at 08:06 -0400, Paul Moore wrote:
> > On Mon, Sep 23, 2024 at 5:02=E2=80=AFAM syzbot
> > <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com> wrote:
> > >=20
> > > Hello lsm maintainers/developers,
> > >=20
> > > This is a 31-day syzbot report for the lsm subsystem.
> > > All related reports/information can be found at:
> > > https://syzkaller.appspot.com/upstream/s/lsm
> > >=20
> > > During the period, 0 new issues were detected and 0 were fixed.
> > > In total, 4 issues are still open and 27 have been fixed so far.
> > >=20
> > > Some of the still happening issues:
> > >=20
> > > Ref Crashes Repro Title
> > > <1> 306     No    INFO: task hung in process_measurement (2)
> > >                   https://syzkaller.appspot.com/bug?extid=3D1de5a37cb=
85a2d536330
> >=20
> > Mimi, Roberto,
> >=20
> > Any chance this is this related in any way to this report:
> >=20
> > https://lore.kernel.org/linux-security-module/CALAgD-4hkHVcCq2ycdwnA2hY=
DBMqijLUOfZgvf1WfFpU-8+42w@mail.gmail.com/
>=20
> I reproduced the last, but I got a different result (the kernel crashed
> in a different place).
>=20
> It seems a corruption case, while the former looks more a lock
> inversion issue. Will check more.

+ Kent Overstreet

https://syzkaller.appspot.com/bug?extid=3D1de5a37cb85a2d536330

It happens few times per day, since commit 4a39ac5b7d62 (which is
followed by a lot of merges). The bug has been likely introduced there.

In all recent reports, I noticed that there is always the following
lock sequence:

[  291.584319][   T30] 5 locks held by syz.0.75/5970:
[  291.594487][   T30]  #0: ffff888064066420 (sb_writers#25){.+.+}-{0:0}, a=
t: mnt_want_write+0x3f/0x90
[  291.603984][   T30]  #1: ffff88805d8b0148 (&sb->s_type->i_mutex_key#30){=
++++}-{3:3}, at: do_truncate+0x20c/0x310
[  291.614497][   T30]  #2: ffff888054700a38 (&c->snapshot_create_lock){.+.=
+}-{3:3}, at: bch2_truncate+0x16d/0x2c0
[  291.624871][   T30]  #3: ffff888054704398 (&c->btree_trans_barrier){.+.+=
}-{0:0}, at: __bch2_trans_get+0x7de/0xd20
[  291.635446][   T30]  #4: ffff8880547266d0 (&c->gc_lock){.+.+}-{3:3}, at:=
 bch2_btree_update_start+0x682/0x14e0

IMA is stuck too, since it is waiting for the inode lock to be released:

[  291.645689][   T30] 1 lock held by syz.0.75/6010:
[  291.650622][   T30]  #0: ffff88805d8b0148 (&sb->s_type->i_mutex_key#30){=
++++}-{3:3}, at: process_measurement+0x439/0x1fb0

It seems that the super block is locked by someone else, which is not
able to unlock. Maybe, it is related to bch2_journal_reclaim_thread(),
but I don't know for sure.

Kent, do you have time to look at this report?

Thanks!

Roberto

