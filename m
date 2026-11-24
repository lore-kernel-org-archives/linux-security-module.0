Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536172;
	b=EMwmrEAsV2YriXSJl6RbOtFydDIaTANNnnROs4vHaRN4RDMwth/YGKWzO+h5Upm/AR9E
	 MzaoGQK0jS7bG8W+KVauvW/kS597Y+H4ffmXwHZVRO0spd3a7i2sOPZEQRzkhd/UtnJqV
	 mHdMkJdudZ/O93P+ry1m2+7HtJNXr7tCCmOXAXseCCu8g5gIciR4q2S/S4Sjc0ANMxpEO
	 l3xknZgVp/dCiLO3We6JWqL9pslZOTDq5WU+YtuH0S2rfCSvd3zvadOQxV7Sxxg2hxRvB
	 BXVD9B+MHb1Zv37ih/2qwXBXCQCOIyyW0wS00xLv+TNGhxBOJ+92JoLJPinRV/SQiHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=VIP6J/fBo0uMkDHJLPjC6lz8Vse963XInWutXlvbkwI=;
	b=kbZINhrcyJ6pPT84ON39KJzC8Qc3fxOj888AeP4CAIYnUOvsi3bFAjJW1w8b59nZcNKr
	 iGq9NDoB6olkR3IZTTe2Is7BRPDUjnUwbxQ72Yl6kbN7ZnAF7HFiQs6Fd7LO7b2ChB3dQ
	 Ecsqr6hVIIxfZDeDaseR8NwTbqEBEd8f6XxRvS3iSUn7EgMJ0McbrIyKJyHr4yOzvgTBt
	 ieiBGeoJnMLr80dG0e6W4jxY4BkiYUtE8JtkQYrCrS25xdI9GYymys+H3Afjch4gpmdt8
	 2xU+wpTEhRrnhCaFaaPuNAuXt4AVsHoNV5OJbzGgogsDCgM7x94V2fvsTortpPoP9tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b7ro8bt8;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79979606A337
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 16:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79979606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b7ro8bt8
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a358881793so2429579f8f.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 08:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795536171; x=1796140971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VIP6J/fBo0uMkDHJLPjC6lz8Vse963XInWutXlvbkwI=;
        b=b7ro8bt8s6WZ6goSKdTR9/b7UJZ+ETxzxEOK0KkeYo2eflpr8rt0OF6cFwV0jnuChQ
         viEH1Te3AgIKQ6/QUdTLdEwn45BzlMSO/KkLMybo1MY4sV3bcqBM7pg4YLoF32KwKm8H
         +lcVjh6X8y92UVgcXyfso+WFDHxbnhGvk/TeyGE0zkXdEfaCDi3p98b1jci2sgSm31fl
         w6EvnZhsiX8/R6QD+XjTHNd9kIQqXTn+eL5AzVDkjKo8hRdiCQHd+U+rWOPGf06yuLs7
         RNL0Mlb4kz0rsO68sTFR1NAJ/TSvmlvW+vAqvMMDbROXjbVQwWAddk9yPnDXxED9W8sD
         MA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536171; x=1796140971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VIP6J/fBo0uMkDHJLPjC6lz8Vse963XInWutXlvbkwI=;
        b=PIs/RdbAu4T1s3fFjpJI9tHbXv1lJo5Zv8xsAjKRyT+Of1fizobyfZ0M9git7iJ/EN
         +txgrv59eGWZGXNI98llTgrvvt0IRkYJBrqV7fVeEB52Ss04yaH33d8ab2+ZTyG+pIW0
         JBlblVM7fR3d6jr3ohVXUv/IfYQTRs/BaSZoMz+RA/ba3Y+yLlQbAheLgax5rfzdnNmn
         WZWFVq5RcRCsNWLioZF0WJnk3Nm9gvd9B1SaQahmKLEmjP1fY0bp2GovukbrDlWdcj76
         3DyT0Q8lSdDHIA4w6EqNlOF7dVariBnDVhKcwhhm0RdYVYzFerR9CQGrltRJjxwOJFk9
         qqBg==
X-Forwarded-Encrypted: i=1; AL+hErHM86s5pqwpmrEOT76zHrhzC4FCAusTNhzKeMgFnRvm6CM2JcQ3Ul02bcFwyvBfWVthEMfglSpSUQaGRrIXueGOkTx26e8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bhJ1qLbY0E/X6iFYm06B0se+dzowU1TZi+SOevmN/pp8GpaGE
	QbuAPue2JoC4DcYRfacWWWW8ercElhFyObdo6JW/itPWGl4b0ltma4PZpdaYHn5JgA==
X-Gm-Gg: AZFdTZfHmlArKLHMMworG+ypyHkrS4KAffKgQcFJH0q0zBqCQmlQ3EBk9+XnVnbbcNj
	XcuSDPy5BmwO3vpmGwaR8l1GsCwKYAPXe0hqwm3zRWISTbxfV601TcdMhHOQiiMKCVsVV2SUuFz
	B0G/u1qsj4k97WRVm0c8ZBKCvfOX/ztC7mgjLzztWxBaeeFKwTRMNk7O6OEYH13aUvSa0O9LtDx
	x8i7lOtVmvYTskScTwQiDMEZsQFMTN8JrkUNQ+/JJQYLXzpRsubOYBtB5YM94SAykplpRmz6PHd
	afynPPb4xYQE9JiKTlWvlGFvzwk5MNa84lrbBdhOyXHl63sBdm5NqQbgW8+WC5rlZcqq2OyofM+
	RP2kr5JeRpnevaKH0EOt+f0YRBzVftUJIMEPRvNZoSexV1YWuooz6vlGsNrtzUvPEVVro/Q05lv
	M1m+c5IeWbX8xoCgUpGHLST/+nmTOV8DxkJZIKSkEynkgrk4KZXXf/bedW7A+7geDhqkPgSxzhx
	yuFuebM79+l04BlBEsXA1D+6Cf8FydIQeReRsKM1kawcBUMkhuXfiRZDNxpuuLpFLBx1FtGlDCj
	w3Hz55zrFk1CNgzFa+dBpsohc4etkOI/F03VWh3+d97uVecTT9fBTe7AbHwZ
X-Received: by 2002:a05:6000:4541:b0:4aa:d196:f329 with SMTP id ffacd0b85a97d-4abb4c7afc6mr19740332f8f.27.1795536170162;
        Tue, 24 Nov 2026 08:02:50 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:d01b:9df4:1123:37e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm30145984f8f.8.2026.11.24.08.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 08:02:49 -0800 (PST)
Date: Tue, 24 Nov 2026 17:02:44 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>, Cen Zhang <blbllhy@gmail.com>,
	James Morris <jmorris@namei.org>,
	Lee Seong Hyeon <ihopenre@gmail.com>,
	Marco Elver <elver@google.com>, NeilBrown <neil@brown.name>,
	Nickolai Zeldovich <nickolai@csail.mit.edu>,
	Paul Moore <paul@paul-moore.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Yihan Ding <dingyihan@uniontech.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] landlock: Do not hold exec_update_lock across the TSYNC
 wait
Message-ID: <awW1JBtrZUoBcwJq@google.com>
References: <20261120151554.2651743-1-mic@digikod.net>
 <20261121.bd9ab1ba5f9f@gnoack.org>
 <20261123.RailieV3ePah@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261123.RailieV3ePah@digikod.net>

On Mon, Nov 23, 2026 at 10:37:22AM +0100, Mickaël Salaün wrote:
> On Sat, Nov 21, 2026 at 10:46:49PM +0100, Günther Noack wrote:
> > On Fri, Nov 20, 2026 at 04:15:52PM +0100, Mickaël Salaün wrote:
> > > landlock_restrict_sibling_threads() write-locks
> > > current->signal->exec_update_lock to serialize TSYNC callers, and holds
> > > it until every sibling thread has run its task_work.  This wait is
> > > unbounded: TWA_SIGNAL does not wake a TASK_KILLABLE sleeper, so a
> > > sibling blocked as a vfork() parent runs it only once its child execs or
> > > exits.
> > > 
> > > Meanwhile, readers of this lock block, mostly in D state:
> > > /proc/<pid>/stat, mm_access(), pidfd_getfd(), kcmp(), perf_event_open(),
> > > etc.  An unprivileged process can thus stall tools run by other users,
> > > including root, such as ps and top.
> > > 
> > > Only a per-process "TSYNC in progress" marker is needed.  Use an unused
> > > signal_struct.flags bit, protected by sighand->siglock, which is held
> > > only to set or clear the marker.  A second caller still restarts the
> > > syscall, and a cleanup class releases the marker on every return.
> > > 
> > > Like de_thread(), treat a group exit or an ongoing exec as a held
> > > marker: a group exit may overwrite the flags, and both kill the other
> > > threads, which the restart lets the caller handle.
> > > 
> > > Add KUnit tests for taking a free marker and for rejecting a held one.
> > > A concurrent TSYNC caller cannot be started deterministically from user
> > > space, but a KUnit thread has no sibling and can hold the marker itself.
> > > 
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Günther Noack <gnoack@google.com>
> > > Cc: Nickolai Zeldovich <nickolai@csail.mit.edu>
> > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Yihan Ding <dingyihan@uniontech.com>
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Lee Seong Hyeon <ihopenre@gmail.com>
> > > Suggested-by: Lee Seong Hyeon <ihopenre@gmail.com>
> > > Fixes: ff88df67dbf7 ("landlock: Serialize TSYNC thread restriction")
> > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > ---
> > > 
> > > Changes since the initial report from Lee Seong Hyeon:
> > > - Rewrite the fix, storing the marker in an unused signal_struct.flags
> > >   bit protected by sighand->siglock instead of adding a signal_struct
> > >   field.
> > > - Treat group exit and ongoing exec as a held marker, because group exit
> > >   may overwrite the flags.
> > > - Release the marker with a cleanup class.
> > 
> > It's not clear to me why the cleanup class and the fix are bundled in
> > one commit here.  (I do find the cleanup class useful, but shouldn't a
> > bugfix commit be as minimal as possible so that it is easy for people
> > to apply to their downstream kernels?)
> 
> I included the cleanup class because we needed to change the up_write()
> call anyway, so it's a good opportunity to use an automatic cleanup
> mechanism instead of replacing it with an explicit lock + flag change.
> 
> I also moved the initial check before the initialization because it
> makes more sense there and it was a good opportunity to do it now (I
> updated the comment as well).
> 
> This extra cleanup doesn't have any impact on backporting.

Fair enough, sounds good.

Acked-by: Günther Noack <gnoack@google.com>

—Günther
