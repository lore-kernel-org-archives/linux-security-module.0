Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799ED396B66
	for <linux-security-module@vger.kernel.org>; Sat, 18 Apr 2026 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776553719; cv=none; b=GNu5t3jTgVwcNXJciZFGCGd2hH+ZknzsXBZPTrPwd9jIWHhr+V7bFg7RFHLHMejLOybpigzW4T2y9VWKXcOxve9u3mHQQhmJB86dCTDjwIn4RFgCMXbtXvwwljzXABIWwx6eeKyzksSmjGkP+08IMfvF2JwdMqWZ8hnq5PrUHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776553719; c=relaxed/simple;
	bh=Xar4WmIgCE2sEueWRogWtI/LcIsN6hYef9Fkw6uWnIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt1YMR6rbemkDVQCn2p+//4kpUAJ+1aKzFUPXeaXOJi4iGoCFfTH2Kg20a5hM4eD3nG6gpOowWiN46y26GI9xt7iS6okAD/sUhTHP4Vka0uucLCQiMv0A3v0H6iqksu7hg6IyrJdUD1w6Yt/hA4Li+sg8/TUvVVqRt57Ejoub24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nc8x+fkL; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc8x+fkL"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79827d28fc4so16903267b3.1
        for <linux-security-module@vger.kernel.org>; Sat, 18 Apr 2026 16:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776553716; x=1777158516; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QDLBwLu2Osjs067OAPxTWdOsEiACtCr2ZJS7OWNSDmU=;
        b=Nc8x+fkL9qtiX9YPOgvJ7Z+Bb36HJhLdTNZe7s5v5bpawRLtP+8JQ9G0CluZ1eYzCz
         G3k4VD5z3g97Ceiz9imYe3gJ2XVrsGRvbHL4p8M0RNRgiRph6DM5Cokg5qkmBDNcLCBc
         06IAIDvXrIT4J3CNjIUXIVrDnLJ78Wm83PSwwjf4KOVGG4VPSauquGiW5gFX1u+vIe+4
         Lj3TXNgT/ABfbMQi4/dRYv+PAv8DLZG8yLdwax6vHXfsmURhva2MeMqMbwfTh1a9yK/+
         6teqOhn7fdqUz34CGqsDqPpQXMBzGZWwCOXTo/uzrYy2CeXQnd0S2reo3YNZ1HcBZKN8
         2WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776553716; x=1777158516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDLBwLu2Osjs067OAPxTWdOsEiACtCr2ZJS7OWNSDmU=;
        b=QDF+Jn3lUh87ma1Y7V0zT8G2ldFOgGJClEVSLfGUpgLubM5qTUrp8dIOgYCOfCmP+X
         9ODLR/QswT8Yqm+SKqoKbsK1cwnLRHDVKXMXiKiNgfkzjOhaWEupl9SWMsftrcHQH7mu
         4VgE0AHX3aUaVDdoZYKS+fvIm/TkQwwbV9sAlQmsKlwTnwVvPz/vaBYEKk9X2Q6HMr3y
         PWPmEc1QL72HdTWUiQZ5NnXaDyUM62aipdoMtqBUQj7qF5fwRlN+PdtDGJleDqJyliLm
         gN7jYe7Q3iydbuK5KV0HNCS0/UhgZUlRK+eWHhRJwvPPWTBYsTWXKRZjurRhJD6TQgCi
         NPSw==
X-Gm-Message-State: AOJu0YwDcXlePJbSXK1W0pdWe0e31lrpA43rJfXJaGOPKYp5m2VXtEVe
	ahMQZfAqjAQUYhKsqA3+MPLWv8IXNWF+2GtSiO2DfzD2iPQBIZj6lAri
X-Gm-Gg: AeBDietyOufu482+SQqC/QvOnuL5xaLPCuegCK9IrQYkxSp8DbX4E8+23IYlLvKw2j/
	qW3f+A2JjOqjtjyoFBDOWAo4B+xftrIK7xWmWSt9xTWN+iEsQPkuuTRlb/wIzqmbaUMi0sDHPhS
	bOVvbzyQv/MOeFY+Ir3tJ1fB5ixuUgeZUqvc/uq25KF7+paRGJklyGOJoFcdgdYin5z7HiOvTgK
	xLjWigcIR5jr6MR8xfrRe4ozhbDLgwDOJolINq45CN4f3JKKH581BhXhKpSsw6dbVuHfLji6m2f
	jIdfr2E0DFmsdkr/EeNdOhc2ihVaCq+ltfX1qDiGk7+L6/aChC82YiRHrQAcHXtO5mzmc2VgU0b
	jj5G5D4UHFItQvphBZscaAL7g/dqIfmSb42IeymdlPgjCjl3Py6java6K776qSuVtlwTxRW4INW
	PFPfki/U+3yW5bUBgZPtcZTf9wg6oIz/5TBU7Vau0DYlcxD8LPxz68qWZy3ztq98He1h6MtVoZ5
	fb1h/Ns3fq/gA==
X-Received: by 2002:a05:690c:399:b0:79c:c51c:7f4a with SMTP id 00721157ae682-7b9ed002905mr87916127b3.46.1776553716465;
        Sat, 18 Apr 2026 16:08:36 -0700 (PDT)
Received: from suesslenovo ([2600:1700:18fb:6011:3b24:58f5:5e89:7648])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bc3bsm24805917b3.27.2026.04.18.16.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 16:08:36 -0700 (PDT)
Date: Sat, 18 Apr 2026 19:08:34 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?utf-8?B?546L5b+X?= <23009200614@stu.xidian.edu.cn>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, paul@paul-moore.com
Subject: Re: [BUG] landlock: warning in collect_domain_accesses via renameat2
 path rename
Message-ID: <aeQO8plVsM4dg9jL@suesslenovo>
References: <25536ce2.4391.19d9b3484ff.Coremail.23009200614@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25536ce2.4391.19d9b3484ff.Coremail.23009200614@stu.xidian.edu.cn>

On Fri, Apr 17, 2026 at 07:30:03PM +0800, 王志 wrote:
> Dear Maintainers,
> 
> When using our customized Syzkaller to fuzz the latest Linux kernel, we discovered a crash related to Landlock during a path rename operation.
> 
> HEAD commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449

This is the initial 6.18 release, without the stable backported fixes.

> git tree: upstream
> 
> Reproducer and logs:
> Output: https://github.com/manual0/crash/blob/main/cebd27007e806e16cf15cb1e0214c24054e8998e/report1
> Kernel config: https://github.com/manual0/crash/blob/main/6.18-syzbot.config
> C reproducer: https://github.com/manual0/crash/blob/main/cebd27007e806e16cf15cb1e0214c24054e8998e/repro.c
> 
> ----------------------------------------
> 
> Analysis:
> 
> The crash is triggered through the following path:
> 
> renameat2
>   → security_path_rename
>   → current_check_refer_path
>   → collect_domain_accesses
> 
> This indicates that a path rename operation triggers Landlock's path access control checks. The crash occurs inside collect_domain_accesses(), which is responsible for collecting the current process's domain access rights.
> 
> The bug is caused by collect_domain_accesses() traversing inconsistent or invalid Landlock ruleset data during rename path permission checks, leading to unsafe memory access.
> ----------------------------------------
> 
> If you fix this issue, please add the following tag to the commit:
> 
> Reported-by: Zhi Wang <wangzhi@stu.xidian.edu.cn>
>
This was fixed in 6.18.2 with
cadb28f8b3fd6908e3051e86158c65c3a8e1c907 (landlock: Fix handling of
disconnected directories) [1]

So this has been fixed upstream and backported already.

Please target fuzzing against a supported tag.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.18.y&id=cadb28f8b3fd6908e3051e86158c65c3a8e1c907

Justin
> Thanks,
> Zhi Wang
