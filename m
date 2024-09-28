Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF10225DA
	for <linux-security-module@vger.kernel.org>; Sat, 28 Sep 2024 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727545250; cv=none; b=sbdO6x0K5RZBHmmQ1jxdmm26F0ZZmafCS6v17dqeiAIe4US2AGbPGlVME+/ZBgg7eGh+LXdkT5+sDkAlTO+q+DBo2tcCNfb8JShihzoGy+8YVsaz/3tMrNrg3tfJrWmZTuGHZhRyrLlHy5Rsa0ziHRgCIINvx37bIpReZyhG4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727545250; c=relaxed/simple;
	bh=7cSxZan5VJJanBjU9FgW+bT2c3OOVf4g9f4UDy02JAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff6445riFnXSAKtwL52pcJbSGhlWmKGQ7OQ3oCDd+EKhnffCMVwW3aorkCK2BdpCzwvl9Lv2NK7iIYl1cZ9OItv/XPFG+2e1bUTSIOUNVWdJod9N7nW65+cGRb9rm12FA0TtdEvBZnaLcSwnfsOGsh3WBh3aqguCrp7rN5Sx2HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tc/fKp5U; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tc/fKp5U"
Date: Sat, 28 Sep 2024 13:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727545245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yHOTQNCADZnKsuE9lSzG+7fMe7LaXb0o/Rvu27/vHKQ=;
	b=tc/fKp5UrPYEpRWoVOTK6KHpaOWVe3O0r9IsHUPrFD61yM46clpeE630s1hUMbcHr81ui3
	CcsWmiRXXesP1AqKybsgg58UUCFwAdlDewip+kyOU3OwcpryG4ZWbowkoPF6u+8elO68hc
	m2tHkVYIWi21W6o+JQK8TcuruwgzffU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	syzbot <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly lsm report (Sep 2024)
Message-ID: <y6vqh3zrzcfsq3ngocrcyjo4tn3y3sgarnbcc25kmur3ucp4va@tt5t5rwblvta>
References: <66f12e9e.050a0220.3eed3.0009.GAE@google.com>
 <CAHC9VhTxCzWvM+j8=J08JVs=1cwk9rtBSS7qFBkdm-_neAwkJQ@mail.gmail.com>
 <03c3a47ca225050d37dca6a9249c1f978f1fc56b.camel@huaweicloud.com>
 <734977390eeecba39789df939a00904e87367e5e.camel@huaweicloud.com>
 <nqxo5tqcwbwksibg45spssrnhxw7tabfithgnqnmpl2egmbfb7@gyczfn7hivvu>
 <owdoubzm3jqf4cuhawaavver5mzko32ijuh2nrm5vhzegmjbmf@az3mweawrni6>
 <ceb762ee-2518-44d1-b73c-fd165da7fbbb@I-love.SAKURA.ne.jp>
 <pdghzlvw6ypcju6ldsngka44cjp6g56bjjsmxm3sd7dqev4g6y@x72zm7vurxyz>
 <deff904e-5c56-42ae-b8b0-7b55580b023a@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deff904e-5c56-42ae-b8b0-7b55580b023a@I-love.SAKURA.ne.jp>
X-Migadu-Flow: FLOW_OUT

On Sat, Sep 28, 2024 at 06:23:53PM GMT, Tetsuo Handa wrote:
> On 2024/09/28 17:57, Kent Overstreet wrote:
> > On Sat, Sep 28, 2024 at 03:49:27PM GMT, Tetsuo Handa wrote:
> >> On 2024/09/28 10:25, Kent Overstreet wrote:
> >>> And looking further, I don't see anyhting in the console log from when
> >>> bcachefs actually mounted (???), which means I don't think I have enough
> >>> to go on. It's clearly an upgrade path issue - we didn't run
> >>> check_allocations as is required when upgrading to 1.11 - but it's not
> >>> reproducing for me when I run tests with old tools.
> >>>
> >>> Can we get some more information about the syzbot reproducer? Exact
> >>> tools version, format command and mount command.
> >>
> >> Reproducer for this bug is not yet found. But syzbot does not use userspace
> >> tools. That is, testing with old (or new) tools will not help. Please note
> >> that syzbot uses crafted (intentionally corrupted) filesystem images. If the
> >> kernel side depends on sanity checks / validations done by the userspace
> >> side, syzbot will find oversights on the kernel side. Please don't make any
> >> assumptions made by the userspace tools.
> >>
> > 
> > You seem to be confused; how do you expect sysbot to test a filesystem
> > without the format comand?
> 
> Please find syz_mount_image$bcachefs from e.g.
> https://syzkaller.appspot.com/text?tag=CrashLog&x=17441e80580000 .
> 
> syzbot creates in-memory filesystem image using memfd and mount it
> using loopback devices. For example,
> https://syzkaller.appspot.com/text?tag=ReproC&x=102e0907980000 is
> a C reproducer for an ext4 bug; check how setup_loop_device() and
> syz_mount_image() are used for mounting filesystems.
> 
> Again, syzbot does not use userspace tools for managing filesystems.

Well, they must have started with /something/, I very much doubt they
wrote their own code for writing a bcachefs superblock.

And if they were using the standard format command I would've gotten the
full contents of the superblock in a nice text format, so I could piece
together what happened.

Since I don't have that, and the part of the dmesg log where bcachefs
mounted doesn't even seem to be there, I don't have anything to go on.
