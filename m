Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011525;
	b=JxczVwEzPovhywU5oSgPvsTIt9P5V1NgJRDHysOaBSN3eqRAuePiMf+L8jRLMddwWEmJ
	 FbKkQEkj9/eV8FNmh2QflWlC+ZsI7lZhAvjSey3VvP2t/x7IyxpgKf2XlKuGIqhSCebyw
	 2cGepYNBdkdEAL9TmzmD/RGdXtLvNEAAGk2YiFLfm/223v77FdcSwUeSzD5IDixzMHG04
	 dQdSy9nnOBCV5kQseVS/wfDtoxWdyRdxY765qXP3CbRAhgxC9aDo/1kjNe1+asV4ELbwL
	 W+Z6oz2D2Wlai0ZjoWEv6yXrnh5LAIHnbE3f0PO1dmHvmSmTuGwNtfPWjFXOLIwYUNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011525;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=omjjlnQ1ZJ0MhBqkhPOBcLqOsv5nWuoArS+/Pbu32u4=;
	b=PmqDT2Ua99HsQuWCakhS+BwL4VwbtAGio7pDV4lWU3zhqUBZDeZGrTwDIa2uy4uja0QU
	 frxuR/Yr6dcTlX1gBSZ8TNE0nUd9DWB2doM4jKkIu6IJ8kZuO1IJAAbKafn+crbg7CgoR
	 yaxbCQwgof7R/5g/sZPKLTNAQ7PgmIGtZegXruuPUx8WbAj83d5NCa/TQSrZzrQqb4trq
	 DG9recN28/kMAlMNvZT3c/JFP27NnJQuMvMPpBg66ifEHVcSJdJ7zaV3Motoi1+XcME4b
	 TIt7SqfQ0EBRqKEl6PIoM1575uPFKKitsZ2tebcgRaMOTUw2AXw0sA/i3YYUeNt+VAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgvCHIek;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 19A0260A261F;
	Wed, 18 Nov 2026 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgvCHIek
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 158801F000C7;
	Wed, 18 Nov 2026 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795011524;
	bh=omjjlnQ1ZJ0MhBqkhPOBcLqOsv5nWuoArS+/Pbu32u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hgvCHIekeWMD5z9HUp1GpczxJH97zCvgETH/xhnJ1ZBZgU54WIlwdNVCZoVIMjwI3
	 b1qW6Yyr0er7e6X/pUrlbQqjyVNyy7gFVq7VyCqot1Lhaw815N8X/dieBgpgZTQM30
	 Qp05hEFjO2SZl+t+4BUKPw2jyBR/TkO+yGVB8dEI2YkP4j11YsGyui/HsrJs5U+W5j
	 C2693zwXc5m1ern5G23a5PK2m6IOOSafzy+UZ9Gp7W1jiSuGuaXGwFLJmcOVxFKdCk
	 7/ojQKABwBn5p1KdHyj1DtsuL6hQ3xlABpn+YsHYSB2Qz9XSI7h4XQ+LmVDkYDN3SV
	 Y7pzf7AQ0dlFg==
Date: Wed, 18 Nov 2026 16:18:40 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>, Kees Cook <kees@kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Manfred Spraul <manfred@colorfullife.com>,
	Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Paul Moore <paul@paul-moore.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Serge Hallyn <sergeh@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [RFC PATCH 03/13] rootns: Track init lifecycle via
 copy_process() and pid_namespace
Message-ID: <av2zwC5IrBXJo6QM@kernel.org>
References: <20261117050841.3289652-1-jarkko@kernel.org>
 <20261117050841.3289652-4-jarkko@kernel.org>
 <sashiko-outbox-220138@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-220138@kernel.org>

On Wed, Nov 18, 2026 at 05:09:42AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issues to consider:
> - [High] rootns: UAF and refcount imbalance in exit_rootns() via
>   unreferenced pid_ns->rootns
> - [High] rootns: unreferenced pid_ns->rootns pointer in exit_rootns()
>   causes UAF
> - [Medium] rootns: copy_rootns() publishes init_pid before
>   attach_pid(PIDTYPE_PID)
> - [Medium] rootns: missing is_child_reaper() and locked state checks in
>   copy_rootns()
> --

I'll address the Sashiko issues, reflecting them to v2.

No need to spend time and effort for review before v3.

Br, Jarko
