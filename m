Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80218125B9
	for <linux-security-module@vger.kernel.org>; Sat, 28 Sep 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727513865; cv=none; b=rQ6+NQCr9LznRxSQnw11tVsa+GnP2a1NbKk8iy/9iQHF1ZRY2MX++MKKbR5RcHZA27Prxzcjml76m2I5G/19TN0KW/t2lrEp9DjnUnXOadl3ETcVMuBC0n6Jcjnfenk0nlcADFVdV428VhrYtCAoCFFZPHuJCfKVbukIAk60cb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727513865; c=relaxed/simple;
	bh=8Z9JCi4yhlBV0WO699VWsRmVMtZb78fwfRNgqBbs2MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzipPCjP3RUSUEUap/BPyb5IAsvVmX6g3FXim1O50EuJrDC0glB8BKVoQf3jZKnbdxQ8AV1/Nx1M8B4xiSRDGI4olXe2AHCvLwZVD8uLI9zuwicEtiF8nvOIz3tEszg1BLY4FKBwXODasP+BDTrvxbVoXreZI2n7qJWeWe+1YeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cqx6RdVZ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cqx6RdVZ"
Date: Sat, 28 Sep 2024 04:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727513860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+G/Act2+rDOGPVSEZItb2sOKKvrD8MFc52o7wVlkE5w=;
	b=cqx6RdVZMVJWaEwzKw0oNdvg6g9wv2YV8PE44kFtbduvxrrx8WfvtJdu0NaM72BJhu0IRi
	WFIKgb8MtDg8d5Ff7tg/S5Q7ikzRuRRnoCAku5DOKLVBYwOfxgpWj0YTQ5wk425t48TmYx
	CbBW2SwBuawYiuUcLDaAG571yf/IOk0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	syzbot <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly lsm report (Sep 2024)
Message-ID: <pdghzlvw6ypcju6ldsngka44cjp6g56bjjsmxm3sd7dqev4g6y@x72zm7vurxyz>
References: <66f12e9e.050a0220.3eed3.0009.GAE@google.com>
 <CAHC9VhTxCzWvM+j8=J08JVs=1cwk9rtBSS7qFBkdm-_neAwkJQ@mail.gmail.com>
 <03c3a47ca225050d37dca6a9249c1f978f1fc56b.camel@huaweicloud.com>
 <734977390eeecba39789df939a00904e87367e5e.camel@huaweicloud.com>
 <nqxo5tqcwbwksibg45spssrnhxw7tabfithgnqnmpl2egmbfb7@gyczfn7hivvu>
 <owdoubzm3jqf4cuhawaavver5mzko32ijuh2nrm5vhzegmjbmf@az3mweawrni6>
 <ceb762ee-2518-44d1-b73c-fd165da7fbbb@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb762ee-2518-44d1-b73c-fd165da7fbbb@I-love.SAKURA.ne.jp>
X-Migadu-Flow: FLOW_OUT

On Sat, Sep 28, 2024 at 03:49:27PM GMT, Tetsuo Handa wrote:
> On 2024/09/28 10:25, Kent Overstreet wrote:
> > And looking further, I don't see anyhting in the console log from when
> > bcachefs actually mounted (???), which means I don't think I have enough
> > to go on. It's clearly an upgrade path issue - we didn't run
> > check_allocations as is required when upgrading to 1.11 - but it's not
> > reproducing for me when I run tests with old tools.
> > 
> > Can we get some more information about the syzbot reproducer? Exact
> > tools version, format command and mount command.
> 
> Reproducer for this bug is not yet found. But syzbot does not use userspace
> tools. That is, testing with old (or new) tools will not help. Please note
> that syzbot uses crafted (intentionally corrupted) filesystem images. If the
> kernel side depends on sanity checks / validations done by the userspace
> side, syzbot will find oversights on the kernel side. Please don't make any
> assumptions made by the userspace tools.
> 

You seem to be confused; how do you expect sysbot to test a filesystem
without the format comand?
