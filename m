Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9181EA7F4
	for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859712; cv=none; b=ebM3P/qJAfFoYiDqHk1UXr+/ZDaIqzifJjRAhRcw5DNrYfVyhbQJrZgk4Fy6hAPWdgBhzsREnA8Z6cLljCQktvFMMnS72Wfj5rZGTmnryV2NgRbpOMjt6O90xS6aRUgYQIh/MG5IZP7k/FrXTi1HxJy4wwNISWn9bBfTq0RjV2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859712; c=relaxed/simple;
	bh=WMY0URR/0cLwSJ2L0si/XMkqrw+jMJ3q/61X3vyCG4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTlsEG857trXQclnFEAb9uzKh/eR3CIImKesLQc3ZCmfvWOP/gDAXyH2DCkLlcuPwQsbYhr55NSBuCNpJISEwKV3cwo6Wmwww/p76ziMhadgPtJmDvgJrsOM8HRJsFyx4O0dJme5p3+5cwPKmLVdfMu1ss7nfmrMfdWn3m9f3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=njFxP2pb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njFxP2pb"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4362c635319so3931693f8f.2
        for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 07:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771859709; x=1772464509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qy5P+ToU2+DIsWB9qf7hA9TOn9AP9dn4ErmGsYtInqc=;
        b=njFxP2pbxCNZYvaKiUhTuI+KDW3H6BGWTT8ar5brsXBWO9lvQsANsc/JLNDRyRJvAb
         2dOk/1ftCxXglnJDUdSfaVB+dofqELP6rDnL1zDE6M8mkGrUOxjaQ8493ZTLz45maF+0
         AVu7Nd1ps79Qdvw1uENGDQZHXi9ff9l/5aDwsicGwqjcFczoPu0mYAfWdR7M0uDHTErJ
         IRj+SV0CFgBKz+4DZHcC+ltmGknv7NyrcYJujRaPSnSSeBCN6gkLx0qW2lqBsjnwC32S
         zEGUw+gcg81Aahcw8AYw6iut5Bo+62/QAxmURvp4O6hLm6w2QxHpIXzny6R0B4UKL1gV
         NaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771859709; x=1772464509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qy5P+ToU2+DIsWB9qf7hA9TOn9AP9dn4ErmGsYtInqc=;
        b=hjBO1ZB1lIYGMXt+s4Qh9/V5P5JuUsIYFAJTcRl+tr2SAykgEtzDN3LDGqUsYxg4a6
         bMTTK7u2zxu2X/hink8tP4aXkaKRptAFjbvJN5amTdMgGy7oaRIfNC1cettqrVtGlQhR
         ovIbIcZqeut4IMJ7Hvzd0WlpdEztqxHGKJ6308eN3SQpEtnDLpY6cjQXg3JZr9a2DyAa
         IP666Yp0vDEKPyUeDs//6u2pRszGiJF21zV1DSK89XH/B/N4ptr+D4e5hmgq7MznyzOI
         vgAgni9p+zHHWrcAHw35qD80UIkd9b9XO6QaFeLji6qYfN+v4iGtko2CC/Xxx8X+elSP
         4tKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRApK3ZjdBrPlhC8F227oMhLZZ1lWEGut1ur7f4y4tdmzM86NVOQKBl38WGNReENq9B7fyMAYAUufd/Z0SqXpAMoIBuZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvTtAP9QHzGRg102QZ7WiaHAJVehlKKYF4sO8oi6SQ4B9yJJiR
	TVBXdOPs5EiOyD1FinWsAGUaifEebbOZ8gpbEF+QjwjWrAEj/gbQwfAu0xVHlK9HEQ==
X-Gm-Gg: ATEYQzxWn5dLCSywPdazrIInH+7DZxWec8Pri7Sek/vMGDYMIB55cGSeNe0zUe7RNzE
	sp8i57/z+Ko8IXaiv9MolzYWqVmrYmNSPN8cFzCfQ8H6nhVyMpu6q1H1zBbkoaYg0texzTIEja3
	sMBAjyGjatEIvDfNhn6N5vgXQEIxMSOYsCl0bdstMr0ZLmxK5C5BZ7HA3RKkLAYzLTI8EA6Un+j
	EB/iSJ3CYEZA1ZAG6Rgx8kB7NCRFaSAatwiqYDllVloQvhYSllFNIgrpb0ZyclhiXm5A2Hwsoiu
	LDgjHTSGcZRQrAiIgJA2b9S70wbsMOkFbEhw9JOjHu98xg/yy8sGy8gbdYkpBRLz9DL69Ebl4PA
	PqlRmsJWwHrJfZVPebrCCynKl+qk+KT++Gd6Tz+ThPCPnpEyM9JidaN6JiM0nTlXxOala6/Idtc
	g3quxCybTox7QiQCXsDd+FURPWBXiTX669/FzE62cafG1FSmTGirzP
X-Received: by 2002:a05:6000:4283:b0:435:e451:39d4 with SMTP id ffacd0b85a97d-4396f17b99emr16423501f8f.44.1771859708685;
        Mon, 23 Feb 2026 07:15:08 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:7e7b:5377:4d5f:ed4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f6csm21900005f8f.7.2026.02.23.07.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:15:07 -0800 (PST)
Date: Mon, 23 Feb 2026 16:15:02 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: syzbot <syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, anna-maria@linutronix.de,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tglx@kernel.org
Subject: Re: [syzbot] [kernel?] INFO: task hung in
 restrict_one_thread_callback
Message-ID: <aZxu9knL8UB0DA4u@google.com>
References: <69984159.050a0220.21cd75.01bb.GAE@google.com>
 <aZxYv7MxxExj9fjM@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZxYv7MxxExj9fjM@localhost.localdomain>

On Mon, Feb 23, 2026 at 02:40:15PM +0100, Frederic Weisbecker wrote:
> Le Fri, Feb 20, 2026 at 03:11:21AM -0800, syzbot a écrit :
> > Call Trace:
> >  <TASK>
> >  context_switch kernel/sched/core.c:5295 [inline]
> >  __schedule+0x1585/0x5340 kernel/sched/core.c:6907
> >  __schedule_loop kernel/sched/core.c:6989 [inline]
> >  schedule+0x164/0x360 kernel/sched/core.c:7004
> >  schedule_timeout+0xc3/0x2c0 kernel/time/sleep_timeout.c:75
> >  do_wait_for_common kernel/sched/completion.c:100 [inline]
> >  __wait_for_common kernel/sched/completion.c:121 [inline]
> >  wait_for_common kernel/sched/completion.c:132 [inline]
> >  wait_for_completion+0x2cc/0x5e0 kernel/sched/completion.c:153
> >  restrict_one_thread security/landlock/tsync.c:128 [inline]
> >  restrict_one_thread_callback+0x320/0x570 security/landlock/tsync.c:162
> 
> Seems to be related to landlock security module.
> Cc'ing maintainers for awareness.

Thank you!  That is correct.  We are already discussing it in
https://lore.kernel.org/all/00A9E53EDC82309F+7b1dfc69-95f8-4ffc-a67c-967de0e2dfee@uniontech.com/

—Günther
