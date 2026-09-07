Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9850AC3D
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795814; cv=none; b=shrXGLk4WEjYAtnnZaPJQFh/DDXcDmwQ6tsFVGHBndOL7GD1rTDnjuyOdb+vyVvK99qYK/xnpfAHgV71BSX9EqNm9ouQmTMCQjRf73mKtQkeIZApaa5YVemdpKP2h/yBhNrii4vY+wjuKoThSRZZLWjmgwPrJ5kGOcKI55z4GtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795814; c=relaxed/simple;
	bh=MICC69rDhpY77nwXlWteXYHHthmexIfa62lpP2Cj7Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRcg9sFLfgdyJQGUCxp1DSO/xLmk28bWTFQjGPyAMeWDmcA98LNbnBhjXC1TIzfoOa76eXLJ08eh/KGOnBK2ETSvMozQU4Eqcpu0MnZJxC3J7aIlPfaFARNEH7DUgFMm+R3vf4VZIMz/p3D1Ft8oBu0FX5O1z35dxnJdFDWj1tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Wxwdz4as; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Wxwdz4as"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9391252b5caso242891385a.3
        for <linux-security-module@vger.kernel.org>; Mon, 07 Sep 2026 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788795807; x=1789400607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9N6f/b+RDjU+5LdwC1W3FgNOtZzFd5njRslDhw37g/s=;
        b=Wxwdz4asm/wUkAUNPcS7PK3TKmk03THM0ngCJKv2mGm8eYY0UNUxnic/ApLQ0dSzrd
         bkHz+ZvTFiWmDGZt/+bG/l3m41ZVbFPlSp0fw7bMxMEK/P6/KSpK621zmAwxmMxZVO8Q
         1Kycppc0Kxxv5t5cmDqbAeiJ++wELgckZPjdrbkkyHC1oys5mE4JKSOHKeLYbgqkLi9y
         fpGgYnxKwzc32YOlgsHBFkT6LOEA+hFpKyBeDUzT//Jexpfi83xzaE7ASctcmG81qsoN
         v2ZsrvyH9BXle7aWkjm6sdoPFmkvg44QbgfJbfr/6D4jf18am1wEmmvFBYiFMTVDpqYq
         VTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795807; x=1789400607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9N6f/b+RDjU+5LdwC1W3FgNOtZzFd5njRslDhw37g/s=;
        b=rE/7fLuV2jOwbexqr19i0OhDjxrizQ+xKXWA8FkhVIe4vKiCrak4MaKD+DJMkvSp6U
         Y/bKDcwjSPEwam4pSNjEd36Wsu3iDjunrRbuwfMlVmoTxfgln6PpB+DOcONjavho9v/E
         1h6ulj2dLNgUHfiqI9kyb8ao4SDnBiomDquznRiWwpGDGFblUwsq7hUrzSEA583dWCoU
         w5hkl8jC48nMwWf1G8EPYNoEykpsKzfdzk9vIJKDEOrIWa6rl0SbYk32fLeXMKpeB7fR
         oN5h6TRe+Xybux9wMEvFZX4ukP0fndRwnU46J0meC2ENf8RnnbG/JrTElFCbkJDqeLL2
         x+YQ==
X-Forwarded-Encrypted: i=1; AKwUvBzaUsw+Xk/FNsQ7s5cQNwlrxNzzUfcwDRYRFfZQduKklAAXwGJB4c3HRU46wIoLUGkSUYIXSMua25s6QqEkM880ph3/6MU=@vger.kernel.org
X-Gm-Message-State: AFuF++kfk2RCuLlDbaR04sbr2Ge8A4YgC92EAe1rno6eKPptKpLYKl7B
	r5XPdSzHgB3S9fn7pDslpLoVjso1j+dPxyGdXuHqhDaggok+aKTbCIjY3m3pgAx2gks=
X-Gm-Gg: AYBFou1Uvl6wsWhRvRwixUCeE4JAM3RdmDUFEKOR/NNB5bUikb6goiVIiSwbv86/17L
	mIdcA0FvPQTyB3VlYyV/nT63p6YrXxqGpGlspgF5FelsS5+gGBRYhwwiF5UzS4oOdKY7zyLWq16
	2RLmugvtGnQLSqdMMU4qfU1pobVUycs88SWQAtwdz+n/1ubitxspnYuTiRj7InVPZTbkVn4PzRT
	cq5aNas9qf6zmGTMWcaKGXYWHyI0r1hfg5CuaCiCZZVlgDCX5KFL4EcLYAWdyiDsFL+q2QXcyt2
	HyuuJq5xj9+ZXUrokG2Fn0K4j47IAU4CFM9MIClbnF5qIoGntC2ICenBzC6WxnWGMv4ococMlF7
	swlrgIZZ6FurOyjhrdOMhPVjSKiCgwJ35F+TfXuGom2XDiMApxaw2m1AiKL2CovULU4xxNWOYrQ
	Qhan2+u3HlR8tBLIqGCspCNIJnb20Wyue6m543xnxzurLC49VAHRX0oFHJqrfQBCfdd0fAGOqqk
	YoXGbYW1vL8oouVPTG+TN7nLtOaUGkwRv2m4dgHDqqZ
X-Received: by 2002:a05:620a:1a10:b0:939:93f:3b41 with SMTP id af79cd13be357-93980341197mr2411106785a.16.1788795802336;
        Mon, 07 Sep 2026 08:43:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406bf8c3sm94620766d6.48.2026.09.07.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:43:21 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:43:19 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>, 
	SJ Park <sj@kernel.org>, peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, 
	rostedt@goodmis.org, jpoimboe@kernel.org, mic@digikod.net, oleg@redhat.com, 
	tglx@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, 
	gnoack3000@gmail.com, ljs@kernel.org, rientjes@google.com, shakeel.butt@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/8] mm/ksm: convert process iterator to
 for_each_process_rculock
Message-ID: <ap7biSs63MDeB34i@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-4-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-4-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:29PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process() loop in mm/ksm.c with for_each_process_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: SJ Park <sj@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

