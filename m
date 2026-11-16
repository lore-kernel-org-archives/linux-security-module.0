Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844426;
	b=5CUe+BP3OX73rtnD8kam+6ROF5jPNgq0V95Rcu9vJgECvPAQWz/FVyOE6YPRkyEtuZLg
	 EGfjw7Rh7aGLE0X+XJDI/3kmxI+uE4ZXS8SboPc6c6+r+guX8iNKXAu/5hUq7Wcef/q4q
	 ZS5sV0aYLKQ+2V5oouVkDhZ8xd3Dc3V2ZZ+Y64lN3d9wzGgQ+IsUSvdChbUrUFt3vYcIJ
	 5v4enAD9hFdQRN7q+Iy/etgzh7xOOqrVkbQjefLJgtyVXy+XM8wYW9ts9hOvM1Q65AhRb
	 6heYqBHPy4P34n1/Wkbs4rmHwmr6U7heI51YV8zjly9sIW6dJYAM/E/0klT16nNCDTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844426;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=x2CywPaM2g5NnzDzlfr6I6R7FLOYJMsUt5HyR2scrh4=;
	b=pf69jmPjpvS8JDNvl1dIxPtvRVHB0dehtXHJv4y3WGqrb+Kzf+s+nJN2tuJ3Y43aJPAT
	 XSRwEiRa6i1o7ypzOSI3PHg6y/QeixkWaxxnx9wdWuDi/HTmxxyb9XgARjOD55w+gvfcR
	 qNOoJdmAvEjvLZflifo1a2Fh6RqWDa4Wd07Yd2NcbIrTFS6u5cXhvDJxZyXnQeEVeKElp
	 W0slu8+SlLdByHu5AeqiYRK5eC+qQ1wm8eF+Gug7SBfk21LPtSxKRzRlPJ6LRMFhj48cd
	 4D1CG2nCC/CGEwZ6Bn7UCPYmQTbl4LQx61JfXh6xnD3KPVbUy+CAM7hzMJtDQTzIV9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SzV35JsA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007AE606A331;
	Mon, 16 Nov 2026 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SzV35JsA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A121F000CB;
	Mon, 16 Nov 2026 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794844425;
	bh=x2CywPaM2g5NnzDzlfr6I6R7FLOYJMsUt5HyR2scrh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SzV35JsA+V+Ay/JlfmbHyw8TEEwCyti8oclHTHE0imgrx97/hONEw5501VK69skOH
	 S8XE5M/0vSh2Le4bJxxpU6BliIEOnJvYj9szavM6P2TnHcYhQ4G4zWhfrmKxaxkvoc
	 qRuA3BuhR6lNq1ZaH+PcS/4mJ3EXf4wm3u1xfPJLOqtVrT8EOTs3u2HtEVGYsMqJth
	 TPRPpfh1LBiLdGk1gH5bImnktX7qWe0L3mU1th0caeewo08ajPZ2b1+BQYUXKd88Wt
	 qb7aXa2Nd4bH8fsJ915ni+G+I9OYFjTGkwMxvbAvTtZMaxx4KiKAxuGNUj70cP9Fg+
	 wxhCyQFw7A+XQ==
Date: Mon, 16 Nov 2026 15:53:35 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>, Kees Cook <kees@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>, 
	Suren Baghdasaryan <surenb@google.com>, Ben Segall <bsegall@google.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Ketan Bhardwaj <ketan@armoriq.io>, bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 0/6] security: introduce Kernel Assurance Plane
Message-ID: <avsm6Xg4SFUmF822@gremlin>
References: <20261110202246.274-1-harisudhan@armoriq.io>
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
In-Reply-To: <20261110202246.274-1-harisudhan@armoriq.io>

No comment on the series, but please please please put a diffstat on the cover
letter so people can see at a glance what's changed :)

--
Cheers, Lorenzo
