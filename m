Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6825291D
	for <linux-security-module@vger.kernel.org>; Wed, 19 Feb 2025 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998886; cv=none; b=OMkcaIdAmmf4S3Jxbpgui9RV25clehqCMi9U3hTQ+f2SJ7+APGRL0o1CrHsDN7EypG8mJJcN8PNUhdFOeV2xs8FaWt79NC6JdlU+JjS5o100WZS5G2C9WI9ZtZHj2fERltfCV9YZa3S6XygN8eDmhENW3ngpNh2jDFIFzL/f+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998886; c=relaxed/simple;
	bh=88XueeWXpqj5kjhuB+Fm6H2p7SzVpzBLwq4pINslf2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt6R4XRG0Wz4GXDqNVgduQWK4+qmIqDjSaStbWDNK5AMicMvGPuG2dk/Z9H6HOhRDQcJ/qfBRkJVr4hvse6cMzmt7hhVEjvLHWPSJuyYJnoH3XXIrzFHKxX1fpEs/9pG0qrr27X1yYSvicjafxjNel01pSp/8FAGMbyY4I6Oz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJtfK+Uu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJtfK+Uu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739998883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYjxlUd4Pezfp7IGcM3InFoEs5RX7Q1Y8T88vEWSPEY=;
	b=ZJtfK+Uu3FX9ZQCa+avph6r6jVw23EpRdTgFqcZipM6KZUY1A/Rrs1RH33APCDX+GoN9Am
	fOQi15WVnd1slbnLjZILQs0G2rZWKxdDmMeUUXbi8mf4jTdf45Soq/8a1JYRmNvtAAVhUp
	MA9fKHdBC/zWKmbzKxfouYrMhBF7eVc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-8ZgrR-_ZNOODZdi42zo02Q-1; Wed,
 19 Feb 2025 16:01:18 -0500
X-MC-Unique: 8ZgrR-_ZNOODZdi42zo02Q-1
X-Mimecast-MFC-AGG-ID: 8ZgrR-_ZNOODZdi42zo02Q_1739998876
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0D811800879;
	Wed, 19 Feb 2025 21:01:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.102])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BF5AF190C54A;
	Wed, 19 Feb 2025 21:01:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Feb 2025 22:00:47 +0100 (CET)
Date: Wed, 19 Feb 2025 22:00:43 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] yama: don't abuse rcu_read_lock/get_task_struct in
 yama_task_prctl()
Message-ID: <20250219210042.GE5948@redhat.com>
References: <20250219161417.GA20851@redhat.com>
 <202502191125.1A6F07E@keescook>
 <20250219201742.GD5948@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219201742.GD5948@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Forgot to say...

with or without this patch the usage of ptrace_relation->tracer/tracee
doesn't look right (safe) to me... but probably I missed something and
this is another story. Currently I am trying to audit the usage of
task->group_leader.

On 02/19, Oleg Nesterov wrote:
>
> On 02/19, Kees Cook wrote:
> >
> > On Wed, Feb 19, 2025 at 05:14:17PM +0100, Oleg Nesterov wrote:
> > > current->group_leader is stable, no need to take rcu_read_lock() and do
> > > get/put_task_struct().
> >
> > Can you explain why this is true? In trying to figure this out again,
> > it seems that the only way current->group_leader can vanish is if
> > the entire process vanishes (fork or thread exec), in which case the
> > "current" in this prctl can't be happening; this appears to be locked
> > behind tsk->sighand->siglock ?
> 
> Well, almost, but this has nothing to do with tsk->sighand->siglock...
> 
> task->group_leader can only be changed by thread exec, when a non leader
> thread does exec, see de_thread(). But de_thread() can't succeed and change
> ->group_leader until all other threads exit, see the "Kill all other threads
> in the thread group" code in de_thread(). The "current" task can't exit, so
> current->group_leader is stable.
> 
> Note also that we already have a lot of current->group_leader users which
> don't use rcu/get_task_struct.
> 
> That said, we have a lot of buggy users of tsk->group_leader when
> same_thread_group(tsk, current) != true ;) For example, sys_prlimit64().
> And note that rcu_read_lock/get_task_struct can't help in this case.
> I am going to send some fixes.
> 
> Oleg.
> 
> > 
> > -Kees
> > 
> > > 
> > > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > > ---
> > >  security/yama/yama_lsm.c | 9 ++-------
> > >  1 file changed, 2 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> > > index 1971710620c1..3d064dd4e03f 100644
> > > --- a/security/yama/yama_lsm.c
> > > +++ b/security/yama/yama_lsm.c
> > > @@ -222,7 +222,7 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> > >  			   unsigned long arg4, unsigned long arg5)
> > >  {
> > >  	int rc = -ENOSYS;
> > > -	struct task_struct *myself = current;
> > > +	struct task_struct *myself;
> > >  
> > >  	switch (option) {
> > >  	case PR_SET_PTRACER:
> > > @@ -232,11 +232,7 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> > >  		 * leader checking is handled later when walking the ancestry
> > >  		 * at the time of PTRACE_ATTACH check.
> > >  		 */
> > > -		rcu_read_lock();
> > > -		if (!thread_group_leader(myself))
> > > -			myself = rcu_dereference(myself->group_leader);
> > > -		get_task_struct(myself);
> > > -		rcu_read_unlock();
> > > +		myself = current->group_leader;
> > >  
> > >  		if (arg2 == 0) {
> > >  			yama_ptracer_del(NULL, myself);
> > > @@ -255,7 +251,6 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> > >  			}
> > >  		}
> > >  
> > > -		put_task_struct(myself);
> > >  		break;
> > >  	}
> > >  
> > > -- 
> > > 2.25.1.362.g51ebf55
> > > 
> > > 
> > 
> > -- 
> > Kees Cook
> > 

