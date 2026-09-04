Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA64CB8C1
	for <linux-security-module@vger.kernel.org>; Fri,  4 Sep 2026 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533615; cv=none; b=UhqvNKH1l6XfauVo/rorYO6h//mClAV+ZFb0PSzIpaj8GdcoGOwABWU9h5i9QnxjvbVj6HwjQLN5GpYsoWviYvi1pbPcIJPcKyYBfQJRfh7z48xmgSR75aDbFd8UZ1TejUKplFQ93K55uIaLESHKLpdnmPG4ArwbR2KaHReaBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533615; c=relaxed/simple;
	bh=TBJnaG19xsDF+x4w6zx7YtaC12GwukzzbDomstsRk1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f4XsPxscxuNauTCKkouw4Lfvjq5mErkQ2I4cQGTepIbKjQJHVRtt126SoGNCkWRSSt+ga3Z9uMYPhiI1xrwUOwf/1+C9FqI8a88VJFO1Ja52qnkYClV20sezSWezsYzqMv/x5DL1y6INM/0tyZJyPtpw2jmPVe9bC4lDLLb1zj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWlm+4fI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWlm+4fI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788533612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lpOLr06SKT9VWUbfIdRTrVaGCYppzQHTCSBPigs1Iqw=;
	b=eWlm+4fITrya8sZMzsUIZZ+Gkfh6wrwIkfCVZXuveZZOPG5wMnTEla/TtLgecP3fraLuxY
	DPiP7yFM1TDhW1O1d/Sl45rfck22TnctZ+ufXNed78IblwoLMp4dBP2Mqaf2kyEP5X2U6/
	KbAQ9PBGMPRQhaEktF3U5AA9zzg/ucA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-SGgM8J6hPr6FYVMWtzv7og-1; Fri,
 04 Sep 2026 10:53:26 -0400
X-MC-Unique: SGgM8J6hPr6FYVMWtzv7og-1
X-Mimecast-MFC-AGG-ID: SGgM8J6hPr6FYVMWtzv7og_1788533602
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F41CD18CD2AB;
	Fri,  4 Sep 2026 14:53:19 +0000 (UTC)
Received: from fweimer-thinkpadp1gen4i.stuttmso.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2752A1955F10;
	Fri,  4 Sep 2026 14:53:09 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@kernel.org>,
  Lorenzo Stoakes <ljs@kernel.org>,  "Liam R. Howlett"
 <liam@infradead.org>,  Vlastimil Babka <vbabka@kernel.org>,  Mike Rapoport
 <rppt@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@suse.com>,  Ingo Molnar <mingo@redhat.com>,  Peter Zijlstra
 <peterz@infradead.org>,  Juri Lelli <juri.lelli@redhat.com>,  Vincent
 Guittot <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Ben
 Segall <bsegall@google.com>,  Mel Gorman <mgorman@suse.de>,  Valentin
 Schneider <vschneid@redhat.com>,  K Prateek Nayak
 <kprateek.nayak@amd.com>,  Kees Cook <kees@kernel.org>,  John Johansen
 <john.johansen@canonical.com>,  Georgia Garcia
 <georgia.garcia@canonical.com>,  Paul Moore <paul@paul-moore.com>,  James
 Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
  me@black-desk.cn,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  apparmor@lists.ubuntu.com,  linux-security-module@vger.kernel.org,
  linux-api@vger.kernel.org
Subject: Re: [PATCH v2 0/3] pidfd: add task path ioctls
In-Reply-To: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn> (Chen
	Linxuan via's message of "Mon, 31 Aug 2026 10:59:05 +0800")
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn>
Date: Fri, 04 Sep 2026 16:53:07 +0200
Message-ID: <lhuecf9cbl8.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: zBUIWWiO0e3TzWtJdVTmFMVmu9Qy72EzAzqyUXWiwA0_1788533602
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

* Chen Linxuan via:

> This series adds PIDFD_GET_EXE, PIDFD_GET_CWD, and PIDFD_GET_ROOT. Each
> ioctl takes no argument and returns a close-on-exec O_PATH file
> descriptor referencing the corresponding task path.  The new ioctls use
> the same ptrace permission check and nonzero-argument rejection as the
> existing pidfd namespace ioctls.

How would one upgrade the O_PATH descriptor to a full descriptor without
a mounted /proc?

Thanks,
Florian

