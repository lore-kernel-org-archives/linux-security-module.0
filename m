Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142CC189F54
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613565; cv=none; b=R9zLC45a+iZ3fgcukQuRZ97SqliO6n4ccC5oXmgXtd6AzeTl54o+Ljpw7KESEhN9j5X1fdo5d2NWohwmQRQfZn3IiV2PGB4JNffEp1Rm/UjZUraFTuVitbDogjySTdD/LNhIHjq2iPAXvozu81VNDZ+T2fKXl38fiR8uHmedDqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613565; c=relaxed/simple;
	bh=prPqIFoeHifGmIDAGG5AkrjOv/4NpwrrQhih1i4cx98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHZXDGuYru+9oEsE6p2zAXNv2lIg8MhUreDwUyYRcCcnKTJJh2NrSOMgDJjBuhPibkiNiknDzwv2mxX1ClhobHJWYJtZEtsLnXtDIqEG88DQVw9V6qO/owrFQ5dLIqdf6q6Peyg77xMGanAjrGt4cz7oq21TUE5PTFeN2yL+6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YXLq3Tyd; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YXLq3Tyd"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WJxLp57d7zYX8;
	Wed, 10 Jul 2024 14:02:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720612962;
	bh=XlGM+a2UaJA3eWRsE3TByCQA2bW65y0bSQC9fgghkfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXLq3Tyd8QcRd056jhy0PbKzaGVxvtNQoso0cYoYV1riKjHsM6R/QVRzq3OGEqlso
	 45BVkeTHBrAQc8m0szlKlMNalqPxhs2UOeGHIbP6Y2bk2odkB7jAOlTQmCnvwQ9K0U
	 AHyHS6rhdjm843Q5DWYVJ9IpdeD+1B21Wq5INaYs=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WJxLp1P6NzsHy;
	Wed, 10 Jul 2024 14:02:42 +0200 (CEST)
Date: Wed, 10 Jul 2024 14:02:38 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
Message-ID: <20240710.Thoo5haishei@digikod.net>
References: <20240710024029.669314-2-paul@paul-moore.com>
 <CAHC9VhRAHg3pjHLh8714Wwb-KYReEijfE_C3i48r72VztUmdJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRAHg3pjHLh8714Wwb-KYReEijfE_C3i48r72VztUmdJQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Jul 09, 2024 at 10:47:45PM -0400, Paul Moore wrote:
> On Tue, Jul 9, 2024 at 10:40 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > The LSM framework has an existing inode_free_security() hook which
> > is used by LSMs that manage state associated with an inode, but
> > due to the use of RCU to protect the inode, special care must be
> > taken to ensure that the LSMs do not fully release the inode state
> > until it is safe from a RCU perspective.
> >
> > This patch implements a new inode_free_security_rcu() implementation
> > hook which is called when it is safe to free the LSM's internal inode
> > state.  Unfortunately, this new hook does not have access to the inode
> > itself as it may already be released, so the existing
> > inode_free_security() hook is retained for those LSMs which require
> > access to the inode.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  include/linux/lsm_hook_defs.h     |  1 +
> >  security/integrity/ima/ima.h      |  2 +-
> >  security/integrity/ima/ima_iint.c | 20 ++++++++------------
> >  security/integrity/ima/ima_main.c |  2 +-
> >  security/landlock/fs.c            |  9 ++++++---
> >  security/security.c               | 26 +++++++++++++-------------
> >  6 files changed, 30 insertions(+), 30 deletions(-)
> 
> FYI, this has only received "light" testing, and even that is fairly
> generous.  I booted up a system with IMA set to measure the TCB and
> ran through the audit and SELinux test suites; IMA seemed to be
> working just fine but I didn't poke at it too hard.  I didn't have an
> explicit Landlock test handy, but I'm hoping that the Landlock
> enablement on a modern Rawhide system hit it a little :)

If you want to test Landlock, you can do so like this:

cd tools/testing/selftests/landlock
make -C ../../../.. headers_install
make
for f in *_test; ./$f; done

...or you can build and run everything (on UML) with
`./check-linux build kselftest' provided here:
https://github.com/landlock-lsm/landlock-test-tools

...or, even simpler, you can run all checks by running
`./docker-run.sh debian/sid` for instance.

I need to update the kernel doc with these commands.

> 
> -- 
> paul-moore.com
> 
