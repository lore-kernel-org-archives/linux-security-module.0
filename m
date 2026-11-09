Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249997;
	b=S7P9Uxc4Qp2o+Bq64yjXlGh169WMIpt8Pdg5PzQN53qNJdEEha1IiJt6nBMxcY/O+Chs
	 ltkN5wvchH4FCR1H0wscfpQdcRWBJS2FaFLrGKlZNU+ikKQQA6QDapVhNH9b/bN3Nrwdv
	 7CcRSX1rTmQvp4ZmrUW7Q8ITOh4x8isRNX8Ibk3VsQxCLzB8rwzZxnC+6qlsK5ohR3ISu
	 rlXqmranyRHE6Qh4rOp7sWrs6j0bSROwGx8hE1g8x2XM/IhdMB4n3/Ci/DEMPDD/8IAIT
	 j1FhjGs0q3tseI4Qgimpa+FcSIgAZZaxI0jpRqdejb8rm5xT3rdcUCaq/IWAY/s8IrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249997;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ruyz/2K4wlVY4cyIFsxKJQ+uv+8W7GCsg6g5SZEw66U=;
	b=ViM17cQVDaS0UPO0PBh5zvx5qMJXMxj/E0Me1uPSt4/Y9sE5bFcC31lHJZpIQ2EKbRbF
	 DwrND+nIgrIkvJH7//9RhpPftdREbIl6POA0LQoNZ3p1aRFplh8JBTm2ogq0ZdaiaB0kR
	 fASQkeQqRsqWnCQyehfW8vufAwjfEdkjoYbzjQPciD3eifWfOcI5mlAIMfEnNzSy1EcmL
	 mQ7yDj9PMWgxKQ7MDt3MQ5aSkLQSIDep2IdsK64tl5lrHR9/krVhRt0FmxdHwinsYhFcL
	 M4Dr95IBe8EG4raOsuo1ZEpHhrP7+yOa4QbEgpLXZZ1NvCJp7oKZqCIAvKvyuxp/x/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=R9+SjjOM;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C5606A325;
	Mon,  9 Nov 2026 18:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD1C5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=R9+SjjOM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1794249993; bh=6kVwTzI1/KcDLMSc20Gf48sZcIqocBBJVzv0nSohHRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9+SjjOMzRhZ05/CIvcJT2p8lmE7XRQKOFIX21zFe9O5hD12H4H1DPMPqDz6CGn/d
	 +EN7gyBWrcbWHdu58Xgors8T+iHxqYvDpaZLBwZMTV4nKMlOE0JPbIUhUGoav+LpIJ
	 4cWNeeCAhiLPpXPydpgjO9eowbgGlBdMYCxUUO6GJrf0QUOcyCqBPqWWw3U9/FvmCh
	 +VJHBAoRWzpOeVcQzbvtlOA/rXPpFxHBCRh1S/bXcX1SbMjIl1MfaCK+LR8WIOMGO5
	 I5/3Ksz0FyorAPpSh5U4f171zLiOwSWYne3a2fHuMlXz0y1gnhPhbfQErGurC/IGJP
	 AbMtvKAc199jA==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 8DAE69CE; Mon,  9 Nov 2026 12:46:33 -0600 (CST)
Date: Mon, 9 Nov 2026 12:46:33 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: kees@kernel.org, akpm@linux-foundation.org, david@kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, paul@paul-moore.com,
	jmorris@namei.org, shuah@kernel.org, brauner@kernel.org,
	alexjlzheng@tencent.com, jannh@google.com, jaime.saguillo@gmail.com,
	elver@google.com, blbllhy@gmail.com, bvanassche@acm.org,
	pjw@kernel.org, broonie@kernel.org, debug@rivosinc.com,
	tglx@kernel.org, aleksey.oladko@virtuozzo.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, morgan@kernel.org
Subject: Re: [RFC PATCH v2 2/3] security: Add PR_CAPBSET_DROP_MASK for
 process-wide bounding-set drops
Message-ID: <avIVCf1ok6Xyfii0@hallyn.com>
References: <20260929130200.1638343-1-ruanjinjie@huawei.com>
 <20260929130200.1638343-3-ruanjinjie@huawei.com>
 <atjN3JX7sWx9kpQ5@hallyn.com>
 <avHfm5/mVtuN/oPW@hallyn.com>
 <avIKUzCKAkfC-wuk@redhat.com>
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
In-Reply-To: <avIKUzCKAkfC-wuk@redhat.com>

On Mon, Nov 09, 2026 at 07:00:51PM +0100, Oleg Nesterov wrote:
> On 11/09, Serge E. Hallyn wrote:
> >
> > Hi Oleg,
> >
> > please see below.  Do you have any issues with this use of sighand?
> 
> Hi Serge,
> 
> I already tried to look at this patch, but sorry, can't really comment.
> 
> I'll try to take another look, but can't promise much, I don't understand
> the problem space (I could never reallly understand capabilites in details).

Thanks.  I'm mainly wondering about the storing of this pending capability
bounding mask in signal_struct, whether that might have any unexpected
side effects.
