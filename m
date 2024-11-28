Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D014A4EB
	for <linux-security-module@vger.kernel.org>; Thu, 28 Nov 2024 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732779594; cv=none; b=axyTgzjENIDbjjD2w/qNrPU3+G1ky8rD9tsNhVp5C0hlm10deZ03kwFhjN9fuW7s46EU5ABaly82CCvbAbJHvwIO8arlIj6ikqIkq/1+kqKmFtRJRQzS0rGnW6hUap4HaQyiSI7qVDzp41Ix8GCZrQInXpvy78Nh6E4+w9GzxDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732779594; c=relaxed/simple;
	bh=ICYEO3JNczUhVC9alnJmPCUhwkDUucrvPD7zkciKRwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBeIHel2JLns+NHy0WWjpRkMj2MJpBd4lmyeM/4kHgYpjDXwnKAPRMdZiIQhz0+JMWwale/0g9nX2c0YnYyE/ynPhBLTCLHn0gmdXk9eJF5YjxbFEALq9Zky5wxgEr5DZdDNIj8Y1DY/6tJ+sL85IwAhIdJYYXicBxKBnuUGNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PchnehUh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PchnehUh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732779592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+uhfZe6W1m5ISyn1DShF0ivc69FPD+Nahb2/s2sCS+8=;
	b=PchnehUhBY32clvXBxYI5HUfAInlqX3NhOAL3MIW+GmMxSD+JASlPmhmdcACU4+aPob6m+
	KlwGUMf39dF8cdAplGPFLGZCkf9/s4jtnF89J/WMfKuorGpnikWkjXlb3cd5tNO9vsAFXo
	fzBv3pMrRHIbihXZho0Ubm61eg9elVk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-H8mPa4bbNNStGSYUw_PuZg-1; Thu,
 28 Nov 2024 02:39:43 -0500
X-MC-Unique: H8mPa4bbNNStGSYUw_PuZg-1
X-Mimecast-MFC-AGG-ID: H8mPa4bbNNStGSYUw_PuZg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F34B1956095;
	Thu, 28 Nov 2024 07:39:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.112])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C339D195605A;
	Thu, 28 Nov 2024 07:39:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 28 Nov 2024 08:39:16 +0100 (CET)
Date: Thu, 28 Nov 2024 08:39:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhen Ni <zhen.ni@easystack.cn>, viro@zeniv.linux.org.uk,
	catalin.marinas@arm.com, brauner@kernel.org, zev@bewilderbeest.net,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] kernel/sys: Optimize do_prlimit lock scope to reduce
 contention
Message-ID: <20241128073911.GB10998@redhat.com>
References: <20241120132156.207250-1-zhen.ni@easystack.cn>
 <20241127174536.752def18058e84487ab9ad65@linux-foundation.org>
 <20241128071351.GA10998@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128071351.GA10998@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 11/28, Oleg Nesterov wrote:
>
> The problem is that task_lock(tsk->group_leader) doesn't look right with or
> without this patch. I'll try to make a fix on weekend.
>
> If the caller is sys_prlimit64() and tsk != current, then ->group_leader is
> not stable, do_prlimit() can race with mt exec and take the wrong lock.

... and task_unlock(tsk->group_leader) is simply unsafe.

perhaps something like below, but it doesn't look nice, I'll try to think
more. And grep, may be there are more lockless users of tsk->group_leader
when tsk != current.

Oleg.

--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1464,6 +1464,7 @@ SYSCALL_DEFINE2(setdomainname, char __user *, name, int, len)
 static int do_prlimit(struct task_struct *tsk, unsigned int resource,
 		      struct rlimit *new_rlim, struct rlimit *old_rlim)
 {
+	struct task_struct *leader;
 	struct rlimit *rlim;
 	int retval = 0;
 
@@ -1481,7 +1482,14 @@ static int do_prlimit(struct task_struct *tsk, unsigned int resource,
 
 	/* Holding a refcount on tsk protects tsk->signal from disappearing. */
 	rlim = tsk->signal->rlim + resource;
-	task_lock(tsk->group_leader);
+
+	if (tsk != current)
+		read_lock(&tasklist_lock);
+	leader = READ_ONCE(tsk->group_leader);
+	task_lock(leader);
+	if (tsk != current)
+		read_unlock(&tasklist_lock);
+
 	if (new_rlim) {
 		/*
 		 * Keep the capable check against init_user_ns until cgroups can
@@ -1499,7 +1507,7 @@ static int do_prlimit(struct task_struct *tsk, unsigned int resource,
 		if (new_rlim)
 			*rlim = *new_rlim;
 	}
-	task_unlock(tsk->group_leader);
+	task_unlock(leader);
 
 	/*
 	 * RLIMIT_CPU handling. Arm the posix CPU timer if the limit is not

