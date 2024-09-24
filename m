Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A217BBF;
	Tue, 24 Sep 2024 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178838; cv=none; b=BYvm4An4ehmm1mAXeOcvdE2sQkmWk+whT0ikFkR/IsCRGObBxYjwQfoSKFkZnFS4t5LR3OBZIrAZ7U8Wv0I2fLopClMxRtUwMq1mDimdS2Xzwaa0TpE4JdqSYoLQ4lA4US6Sbtii6ZU/taQ2HNLR1zUHoG97VgUs93tY81S6tTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178838; c=relaxed/simple;
	bh=IhWAF2DxdL1FoJXN5Saft/aN9JCzs0Ol8JkHJhbnmeo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E384lI2FsQzTf1aPDdjCwOhLZizgiE1trNWy53EuxRWOloT1kKVi8ginR9zwZ9DKyAg6NCzwWjFby13YygeHiB0xFmsPgBeZd7rAPYJJvf8JMP6sJQcrkj77+BEtXTsdz0OzNDQe3akPuHqxAHcuXzXnxMB2UDkQd8rqdTN0H1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XCczw5Rvfz9v7JT;
	Tue, 24 Sep 2024 19:28:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B6254140419;
	Tue, 24 Sep 2024 19:53:46 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCHNsc_qPJmnqKOAQ--.26997S2;
	Tue, 24 Sep 2024 12:53:45 +0100 (CET)
Message-ID: <03c3a47ca225050d37dca6a9249c1f978f1fc56b.camel@huaweicloud.com>
Subject: Re: [syzbot] Monthly lsm report (Sep 2024)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, Casey Schaufler
 <casey@schaufler-ca.com>, syzbot
 <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Date: Tue, 24 Sep 2024 13:53:32 +0200
In-Reply-To: <CAHC9VhTxCzWvM+j8=J08JVs=1cwk9rtBSS7qFBkdm-_neAwkJQ@mail.gmail.com>
References: <66f12e9e.050a0220.3eed3.0009.GAE@google.com>
	 <CAHC9VhTxCzWvM+j8=J08JVs=1cwk9rtBSS7qFBkdm-_neAwkJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCHNsc_qPJmnqKOAQ--.26997S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF43WF1ftr4kXr1xtry8AFb_yoW8CFy7pF
	W0krs0krs5KF4xtayvgr1UXw10q3yrCFWUJ34qgr17u3Z3ZFn3JrZ29F45ZFZ0kr1xAF90
	vFnIv3sYv3W8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBGbyIHwF4wAAs4

On Mon, 2024-09-23 at 08:06 -0400, Paul Moore wrote:
> On Mon, Sep 23, 2024 at 5:02=E2=80=AFAM syzbot
> <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com> wrote:
> >=20
> > Hello lsm maintainers/developers,
> >=20
> > This is a 31-day syzbot report for the lsm subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/lsm
> >=20
> > During the period, 0 new issues were detected and 0 were fixed.
> > In total, 4 issues are still open and 27 have been fixed so far.
> >=20
> > Some of the still happening issues:
> >=20
> > Ref Crashes Repro Title
> > <1> 306     No    INFO: task hung in process_measurement (2)
> >                   https://syzkaller.appspot.com/bug?extid=3D1de5a37cb85=
a2d536330
>=20
> Mimi, Roberto,
>=20
> Any chance this is this related in any way to this report:
>=20
> https://lore.kernel.org/linux-security-module/CALAgD-4hkHVcCq2ycdwnA2hYDB=
MqijLUOfZgvf1WfFpU-8+42w@mail.gmail.com/

I reproduced the last, but I got a different result (the kernel crashed
in a different place).

It seems a corruption case, while the former looks more a lock
inversion issue. Will check more.

Roberto

> Looking at the syzkaller dashboard for this issue, it looks like it
> may have been present for some time, just difficult to reproduce
> reliably (although it does appear to be occurring more often
> recently).  Any ideas about a root cause?
>=20
> > <2> 9       No    general protection fault in smack_inode_permission
> >                   https://syzkaller.appspot.com/bug?extid=3D4ac565a7081=
cc43bb185
>=20
> Casey?
>=20
> > <3> 3       Yes   WARNING in current_check_refer_path
> >                   https://syzkaller.appspot.com/bug?extid=3D34b68f85039=
1452207df
>=20
> Based on the discussion over the summer I believe the consensus was
> that this is a bcachefs/VFS bug, reassigning to bcachefs (or trying to
> anyway).
>=20
> https://lore.kernel.org/all/000000000000a65b35061cffca61@google.com/
>=20

