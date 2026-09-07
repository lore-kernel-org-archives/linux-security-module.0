Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0862D3EC812
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796064; cv=none; b=X7vBnW3dWG5eLQgIDWXRbCUc80tlRXUnd+sHaazKU53t2BBKKPOoGeiBx7nUd2QOoW43VxgConFuMwt5mwqs9zGtKtGVmK2CBFnhHza9uSGzocR52OmLQRbNECqTeXXohnRCcqBHQTgHjqwp2Oa69peQVQtCIHG8Fjc2gekeCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796064; c=relaxed/simple;
	bh=LsBLn8cXF33M9xsQ1sh1/dOCqLgHSvdMJu+9kf2eJnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6AnPtRjUyO4N3Lq8A0kyrSRdUAJm4OJ36Jjh6g7Cn8YmSK5aINKmQQigzdwahfDqAPbWiZ3z1hdtw1PP33Ig/UHVtzuBQJZMXxLT43GBOGdOHVUFYaZ/MnLKI5CZ2ovl07ZoNtjxbiP++vIhqtW8vuwnLk0JbRN3kWeUwR3roE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ONo3Yd5P; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ONo3Yd5P"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9399d52b1efso77699985a.0
        for <linux-security-module@vger.kernel.org>; Mon, 07 Sep 2026 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788796061; x=1789400861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RQkY42FeJcZwapgA9K9xQ52KS/Gzc6p9wbLWVF1hJqQ=;
        b=ONo3Yd5P+HJX1YqS2nHyAEMJ1JMkcrWWoM2FENgofjJsR5kyZpov4qS72In0zlssNx
         zayU6UQOXtCuKzy6OdIYZim7DjCMy822QTHak/KCv+VZO1yRHeDgSDA5R8T9r7VMtytU
         qz62qF4vRzegoCuPeanLp3ROZOgExbqYdHzlDWwssduiSQBOK0O94wyxx7oX6TbiXaby
         xfN5Uw1yOCov7qnTLzLTJA+6NZVqiVc6NWuFhbpFAQfZmvkLAgMwuOQmqsXWosGLcBSS
         WAJypDzNAOzfL9yo4piRWhZjJYnaoUbm/7++1wr23dp6w0H5cGz4EtcRdLnIBtUEG9oO
         9rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796061; x=1789400861;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQkY42FeJcZwapgA9K9xQ52KS/Gzc6p9wbLWVF1hJqQ=;
        b=iwgKRELPj50d/nAsrfsVXJCU8YpI58nyG/zvlRDKH/eI7Zhriubj58Kigy3WY1lQkL
         zC1s7VRtcMz55adXbsOZXOPmJtqT1UczKtMFuUa3eS7RzSfUBfgnmu6hXEM5BnIndVlH
         2K/AtVFGms42MyU5nQS3ngGCLj/QOtaodGGjNBw1SSL3vSxBxlVVkRZNcT1hlWjQaQUQ
         xkb6SzFj4N+/FjqE2U6TKy5y9vdQh/g1vPzQVESCWNc5CsP+NxSzJy0rkV0EC+28t1ag
         Xa+J7tFh6w/93jFIBJjmtJhd1wogIb5Ch5FfMFL/ObonF23whsOGVun3EVmfNtAVQDLD
         chFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhKxKoOLlVJfG2r3k7oyijyJT21ESbvnp/fC4aVKj16zg1a+fELM94gFD1QYeGeeFOmQfGwCx8Bx9lsz6m8Bri+Ltvxi8=@vger.kernel.org
X-Gm-Message-State: AFuF++l6L5iXk0F8sMPYUkC6aQIcyGNTKaH4kwPQ1FQE6okNPKCNDiBg
	PQBple/WrY154vYFpTrRopCf1D5y6e4XJyv1xaUf9M0U2+wx4MhqgFJ3scBdNNNU6LM=
X-Gm-Gg: AYBFou1AQgJp2z2l3w42Z58jpQfwi0ysGSPzWc53BB3IJz3rPi9m9VVGhLZkybo1cfU
	CbC5tqNPyn+N9Is9mjw6281V0lreyH8zrStdkkazTAojB7ruREdWzQz8P3n3fYVuE9axqTiXEYy
	cSnPJtK58+V5o8lyP8bu4451mv3ombntgmOB0Co1OveVmdFtHFnay/SgSIeeH2U3BkBi8H5g95i
	M2A/DXGTEtu31Q/hSLPDELCKH1VuDiO9+CnxPglQghnL/ZZs5ivyRIu9szdY3yNxZA+/k93K53p
	MrOzuMFklqe+ff90UUTDJMNG0s280LdcMpBXIgQDGM/0M+VyNLxtB1hxyC0SVRIFlT+i7k0NFUZ
	egfl00t+GDa9TOhP29A9gIhNodbSRQM17T7GDPE5hkHNK6LqLudlARAijkzuKzWmSlRUVFuPx3Y
	V+yS4VEIz/wPULgdY7WOfQDXT2xtAnLtmZ4dkBlqjczmtik6bNG5rIgUox7WHerXwsB/+Mgy2tB
	nbJkdy5V5eUos3YQB+X4jaJ2xGy7wY9yKeRwJNuBfPs
X-Received: by 2002:a05:620a:6cc7:b0:939:6de7:8768 with SMTP id af79cd13be357-939805729bbmr2426484585a.47.1788796060831;
        Mon, 07 Sep 2026 08:47:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbb70f1sm928876585a.40.2026.09.07.08.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:47:40 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:47:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>, 
	Michal Hocko <mhocko@suse.com>, peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, 
	rostedt@goodmis.org, jpoimboe@kernel.org, mic@digikod.net, oleg@redhat.com, 
	tglx@kernel.org, david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, 
	rafael@kernel.org, gnoack3000@gmail.com, ljs@kernel.org, sj@kernel.org, 
	rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, tony.luck@intel.com, 
	reinette.chatre@intel.com, x86@kernel.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, pavel@kernel.org, lance.yang@linux.dev, mhiramat@kernel.org, 
	pmladek@suse.com, longman@redhat.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, dietmar.eggemann@arm.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 7/8] lib: convert process iterator to
 for_each_process_rculock
Message-ID: <ap7ckXealr0JMfeN@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-8-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-8-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:33PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process() loop in lib/ with for_each_process_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

