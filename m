Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26CA501F28
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795750; cv=none; b=bjIqkRB1SMlit4xFLpmcvOMMlO61tmqeS7e/dV80d9bPnUd+Bn9gCrvXy3GX3JfNz/ynhmDD5xDMrsPssO3tQ+U1MjbWqohREm0vGwszelksR1No5bfKSlvbJnyVSQobVpgmpjrK3axYy+alspvZzGX2/KMAN8M4wIh8ufDkvWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795750; c=relaxed/simple;
	bh=+OOqmbaWCc+bj0drcgwfudfjBi7gFVexonNebA007r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS/FqncWUZu2EpnmrE66RyeQlAkhwn+x1uZc02mKCOh/5kvOa0y9IecMe++S4gr5qKaeszPoXcikhkjR7Dlgu5k4Oo4QB2HYtoZ2pqclGkRjO0kmUGNIMXumrY+jFs6q3F2vWT2saTt6YBetcM1AR0V2Iys+BmQfQsdgwPQYqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FdRMqgpf; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FdRMqgpf"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e85499ffbso281846785a.0
        for <linux-security-module@vger.kernel.org>; Mon, 07 Sep 2026 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788795746; x=1789400546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UsM2t2muwC2t6tub3Lkt0Nmc2lGDELjoRCFL/zUluw0=;
        b=FdRMqgpfx1J0zFlqgT+7WgNaj4cSat5/uXgUrOcggIxlg16d1IM6j5fzpoJdfxjB2P
         /9rUsuFGSVHMph0igjnLvLn8ySpk+gqUvrbN2vFaavz5LgUAygmQgsPjMBRC7VanS43W
         JATad4DlLfdmil2YdGkAk7tfgNrN3SfEqLlxTPx+BvyXWvyr/1Ny4qAc9W2iZ6xpxYhN
         3K0/WZ5iPJtbKqRjbXrV42h3dY+YXtAJuM2JWde/5KyxEbZBHxotsnD3mqBpV8K/mpt0
         eO0NVTl1ECtQ1D0rNaVQ1r0m1zbGZZIhGn0fLez/Vrp9QfQSJWdVs2a/JZrDUaX1hpvF
         3YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795746; x=1789400546;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UsM2t2muwC2t6tub3Lkt0Nmc2lGDELjoRCFL/zUluw0=;
        b=HeZ07OZxcbjz5YhvD7U01k2elACgFLnighcnk3Fx6qExwLtloJJpgj85ew4A8NjBgY
         yojEmQOo6ILLhbmW6tpRXRLDDZST6dXw76o8R8xNJeWeu4FZ6kiy+YW443kYsBfSlxX3
         2/lJ0Vu/hwoCv59PjVDbKK9TWVEfJOJHbQ3XY0cAGss0PQ+pJ/V1i7EodmRHm3Ofxltk
         17ES+00ienylTmMUfqxOuAQebKje6k5lHu2pv6KbM9wYXUSVy0pqGjZI0T/IZJNqwPyw
         BLzU1XlpJA6ScbiSFwq8MjLIznf9CHyWXvvCvT4Yh/jGIdhPH3+ejAU/EZakhxp3SzKn
         fMAA==
X-Forwarded-Encrypted: i=1; AKwUvByni7GXlRzmVVSh58FXSzsAOtrb8pIgIzQ51/8uzXPA5z7SHVe+YpoYAtirRaJmK3TILTG3lTSefJcRJBKFbOf0JnLEY6c=@vger.kernel.org
X-Gm-Message-State: AFuF++mX01e3KLPWYznDdOXhJRRvlMkb9fzOs3zGyAUwsZhWuiYvmAPu
	3J2IiQwlM0TScUNRzU7aKhyeKqSk2pZONPbu2zFfyvUFojYzWP1EuaG3c7HLiXWEwdA=
X-Gm-Gg: AYBFou28pfPp899a/Bc53X3jVby6seGemF5G2e1p/3i9ILEr4vMMkn5CxtWhaPKT3eP
	UmOaf66I27FkY625wgBovtl20P7n4T7NOPSOizDYmjafDJzQLSnpZLsiV+M9C1JBsmFcuJEkH7O
	d5mHmAMMRkAbglBOb7aR+JiBXXDfwlkkNT4LX12V/504tzy4iDD3yeZ8feRkxwWydUoWLzXtvsq
	iZduQBO2tGSFDdwx9ptfPpqzwcY09UrkYY2CMR2ikZOgGBhElhtaVkrRY5GJpRNzWh5P9aoj6R+
	QidXvA9lfNDrkUM/KYyzDdZjAuCRVh7RgZiKHn8qfFwxHU3juaarw8ziO02Uul9Wp8aNnm4oHRO
	3rFJYTtZ0iG19oqQW3qpS4m7yiYr3mt38Z1Zw854szYNkPCD/JFi2Zbe0SU2OXPgUTdz+zV8DCc
	aaxT8ImODEmEFBSme/2CLEbZGXxLYdv3AUj5xEGsuc9l9wXYlVbSAEO3QZfjWW3+gQX8UrOxp4l
	6vc4CzHcHMvHRxIvmxgP+5HVGoJa1q0vunTY3eCD1s9
X-Received: by 2002:a05:620a:aa14:b0:939:6c2a:24fd with SMTP id af79cd13be357-9398031b73emr2041569285a.9.1788795745703;
        Mon, 07 Sep 2026 08:42:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040646d64sm95118286d6.14.2026.09.07.08.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:42:25 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:42:22 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Ye Liu <liuye@kylinos.cn>, 
	Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Yi Tao <escape@linux.alibaba.com>, 
	Michal Hocko <mhocko@suse.com>, paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org, 
	jpoimboe@kernel.org, mic@digikod.net, tglx@kernel.org, akpm@linux-foundation.org, 
	david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, 
	gnoack3000@gmail.com, ljs@kernel.org, sj@kernel.org, rientjes@google.com, 
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, 
	boqun@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/8] sched: introduce for_each_process_rculock and
 for_each_thread_rculock
Message-ID: <ap7bPSbO7UvFSwPf@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-2-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-2-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:27PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Introduce for_each_process_rculock(), for_each_thread_rculock() and
> for_each_process_thread_rculock() macros that acquire the RCU read
> lock before the iteration starts and release it when the loop is left,
> so that the RCU read-side critical section is scoped to the loop body
> instead of an externally managed rcu_read_lock()/rcu_read_unlock()
> pair.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Lorenzo already picked up the nits, this is really nice otherwise.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

