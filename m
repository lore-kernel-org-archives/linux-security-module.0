Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E822FD7DD
	for <linux-security-module@vger.kernel.org>; Wed, 12 Nov 2025 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941167; cv=none; b=A/REnexsX5STSz8dcwggIxQTe2oD5XaKF+5HvK1cJNDoJD2Mg8KBI9L998BvFj16hvopDO9gW8+VjwclAbO2LIVHIFCE35nACTwZtdkArkRyYmMcG2yUmAPf4J46lCUyQIsUlnoztzUKxgZNutbPHG/u4MsuU5R3nmj2kT5gl4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941167; c=relaxed/simple;
	bh=qieoI6be/NucVGDXoIOFCAFq9yqK2SgJwSK5f9zar58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM672U+WrYjyrEL3lAR26Jfd6LQISIdEGezH9N/Cs7SrJ1nTDoNfBUCrNLSosl+Q9e/aKGZiRr/2SXWBRwaOcJ3kRR9+qAMcf2N7TdZ498LVaSMABjPcjBcG0JDMpkaYcqBIzwfV9Qx3cfTJwug4PGHosIt0/9IKva6XhwGso8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHC5P0Qo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHC5P0Qo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762941165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NhHDG/RYOkgjp1iTZiVveFurISFNmM/HJtxHwxRJDf8=;
	b=jHC5P0Qo7BGewtgftBuIwUr08CRZ5+mux0AE1ZdEZUill+MfHitOHsDL6vGeysQMwQCpBs
	6gt9g0XvfbJ+eLzNMtcWM6brn9UnMyH6ELCPNAScGJ2s7U/d/OrJOigOYYPz0Ump6/BrmD
	2VDEZ1t9y2RvwfNGipRdtnf4sEdp6Xc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-thKX29d8MDyDCSuebjYMpA-1; Wed,
 12 Nov 2025 04:52:43 -0500
X-MC-Unique: thKX29d8MDyDCSuebjYMpA-1
X-Mimecast-MFC-AGG-ID: thKX29d8MDyDCSuebjYMpA_1762941158
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FED31800650;
	Wed, 12 Nov 2025 09:52:35 +0000 (UTC)
Received: from fedora (unknown [10.44.34.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8BECE1800451;
	Wed, 12 Nov 2025 09:52:14 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 12 Nov 2025 10:52:35 +0100 (CET)
Date: Wed, 12 Nov 2025 10:52:13 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Serge Hallyn <serge@hallyn.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Adrian Reber <areber@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	tiozhang <tiozhang@didiglobal.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	YueHaibing <yuehaibing@huawei.com>,
	Paul Moore <paul@paul-moore.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Stefan Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>,
	xu xin <xu.xin16@zte.com.cn>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
	Dave Chinner <dchinner@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Elena Reshetova <elena.reshetova@intel.com>,
	David Windsor <dwindsor@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans Liljestrand <ishkamiel@gmail.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v17] exec: Fix dead-lock in de_thread with ptrace_attach
Message-ID: <aRRYzb2FxHzpKhms@redhat.com>
References: <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <20251105143210.GA25535@redhat.com>
 <20251111-ankreiden-augen-eadcf9bbdfaa@brauner>
 <GV2PPF74270EBEEDCF80CEE0F08891ED37BE4CFA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRM2POTDTxEzeF2F@redhat.com>
 <GV2PPF74270EBEE16FE36CF873C5C2309A9E4CFA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PPF74270EBEE16FE36CF873C5C2309A9E4CFA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 11/11, Bernd Edlinger wrote:
>
> On 11/11/25 14:12, Oleg Nesterov wrote:
> > On 11/11, Bernd Edlinger wrote:
> >>
> >> Well when this is absolutely not acceptable then I would have to change
> >> all security engines to be aware of the current and the new credentials.
> >
> > Hmm... even if we find another way to avoid the deadlock? Say, the patches
> > I sent...
> >
>
> Maybe, but it looks almost too simple ;-)
>
>    164          sleep(2);
>    165          /* deadlock may happen here */
>    166          k = ptrace(PTRACE_ATTACH, thread2_tid, 0L, 0L);
>
> what happens if you change the test expectation here, that the
> ptrace may fail instead of succeed?
>
> What signals does the debugger receive after that point?
> Is the debugger notified that the debugged process continues,
> has the same PID, and is no longer ptraced?

Ah, but this is another thing... OK, you dislike 3/3 and I have to agree.

Yes, de_thread() silently untraces/reaps the old leader and after 3/3 debugger
can't rely on PTRACE_EVENT_EXIT, so unless the debugger has already attached to
all sub-threads (at least to execing thread) it looks as if the leader was just
untraced somehow.

OK, this is probably too bad, we need another solution...

Oleg.

