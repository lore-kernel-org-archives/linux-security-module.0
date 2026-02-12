Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B34252292
	for <linux-security-module@vger.kernel.org>; Thu, 12 Feb 2026 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770926484; cv=none; b=m9KrN52whcvXi4qqXZLIiLQvflDNAvdogEAWtJSprPp+lepc2FCy2XT8kcWFfFAh8eO+eokIjhuW0s5fsvAiFh+qn8vH1oHWssmHlHybhCjv0j90OkHgeEUUn3dBNju7dyHL7+UUKR3cxkg1XU8q9KIhXE/3+E3P6FZ/+Ty6Av4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770926484; c=relaxed/simple;
	bh=KyMi9VG4Ea4n33jAxwvbWNQx0iHZw2OYLCV0XSEC4FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbYWvKkXKRLn9l+3xfY+uHE7Nx6dLEdLXAoF6aAbr4LtQOuc8wHdPNGaoPFp9DVgs2ZTNlNmup1phsTzIViIBGK86oNJoMGw3C775ubNrDYAIG0tJG6+DrwZEzbIAj7wvk9JoGlXa4gAPeLosB07mJZsfGou6ZGQyF8s508PLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=X5WPloUu; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="X5WPloUu"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7cfd95f77a3so137299a34.0
        for <linux-security-module@vger.kernel.org>; Thu, 12 Feb 2026 12:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770926482; x=1771531282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8AN6dwiMo6SD76XNciFuL1KsDP8STQGsSUlvCle818=;
        b=X5WPloUuuY3xKJvlFmJnwD6JdZnbeXRxPcqz1Kty/wajIjhvRjh8UMKYe9Ri/6PFwq
         IAtaLf1OIp9/Ia57a/y9ppkzifXQyNs8gkqx6GgBiecx2YZSQKDBuwDfygXoHEWmGI6W
         YMpJcjue607sz+dyky5zqNdJo4cE9mCM6NbQ3yuuVN0NgnABcHMtrogOFCu5h99s+mM3
         7jx5+STyjO+ohWrkg2qBy3UQyyUXk8BRYLsBQRziOH6jhSaGmccxqPIlz+VVdk22UAWc
         nkpum/KNN/8/dTy7W9rg5hXxENtQBC5N2wKxml+VQQlEmJUwBXFRi+fQITWNbP44p4Gz
         giKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770926482; x=1771531282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8AN6dwiMo6SD76XNciFuL1KsDP8STQGsSUlvCle818=;
        b=iVWDp5Z62KSV/7MMcUFvJq86IYbJznpPqD4RgifQWUa7CkrqAuwZAbqexbl/VJKhRm
         zQmqGOAmSkMs1XQQyk8U+8NACr+EwEOGUdqV5uv/rnsteBcI/FVqCfHkW9KVO1dFU26Y
         fEg51KomB0yYWz/ser1yYPGXAghB/L6LfKh8OFM0sA+IZVQc2me+KmiCCXVQotJ7Ye0T
         OBN/aZdxsxZEPKKRnmNkrk5im21BbcM2YSe5W62QNRqVr6OT3eSfc9uBGhqCzKJLBWeK
         DKo7KGM20CHIzkMoH7hlrZ+NxnHB1R88F8DABGMnPTkN2tG1WEWqNSmYu3FnhotFs2Ha
         yxrw==
X-Forwarded-Encrypted: i=1; AJvYcCVCcHp9uLMFq3srhmgssJLUv5gHJ4tN6S1D35gtMLMvB0/ZOKf9DpomUOVJDte1ch3SOJblAI5GesY9YQgxWwLuCVXAGSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL5E5edaMXt9SjuUeoRP+5EerLMu3lKiDrEUVC6GPGJTNVPlad
	78jPo/EGDwdDT19RGi0FY4Ph7c4NsZ6BpP3HjMZBgExNgckZ/qvwHz205AykmAEbXmI=
X-Gm-Gg: AZuq6aLnB+khV0ThnHsEWm04D33L8FG0YwnsnOazp967G8GUcARBsvqJQSjGGf+5h54
	ybEUKHrM2MO6Pw1vORnewMAcyQLaQi0K2mr7uGmANnZdLMymtIaRp4U1c1lLc9QKclgN9M6BG6D
	2uwjNSvg/1ORg1MTJ1o+DTn82Luf44cWCTFolUBVTP8dZ5pgpl3ghyG3di0hECu2HR7BHsY0eos
	zmYWiW9proTf1x9uJj3oKxWRTbM/42SZGzHqqvpkE/lw+2G4TFF7cZj5Yl2gPOnSP4n4xURrZQA
	ndSWs7IncX2I28H/OWUVwyoOt8Gk4ifCEIzTAk0TPqTb1M4Z5OMiImzCZMwU5JZF3i7E3q3g5tR
	ozjI6GG8aAELDWNeyNy8bBcqR7YLBeL7PaMyfxLNUYBWFwskZK/zIza+o/X2Bac0k+Mxa0yVQZt
	4I3kh3
X-Received: by 2002:a05:6830:6a97:b0:7c7:18e:913a with SMTP id 46e09a7af769-7d4c31b3c88mr57247a34.19.1770926481731;
        Thu, 12 Feb 2026 12:01:21 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:17])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a76f98cesm4342584a34.22.2026.02.12.12.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 12:01:21 -0800 (PST)
Date: Thu, 12 Feb 2026 14:01:18 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v6 0/3] ima: Detect changes to files via kstat changes
 rather than i_version
Message-ID: <aY4xjh5YmZH8ujIX@CMGLRV3>
References: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
 <50c5e00a8c336e8ab393457af009c26902114688.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c5e00a8c336e8ab393457af009c26902114688.camel@linux.ibm.com>

On Thu, Feb 12, 2026 at 02:45:58PM -0500, Mimi Zohar wrote:
> On Mon, 2026-02-09 at 15:21 -0600, Frederick Lawler wrote:
> > We uncovered a case in kernels >= 6.13 where XFS is no longer updating
> > struct kstat.change_cookie on i_op getattr() access calls. Instead, XFS is
> > using multigrain ctime (as well as other file systems) for
> > change detection in commit 1cf7e834a6fb ("xfs: switch to
> > multigrain timestamps").
> > 
> > Because file systems may implement i_version as they see fit, IMA
> > unnecessarily measures files.
> 
> Statements like this are wrong and certainly unnecessary. Refer to commit
> db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version").  Directly
> accessing the i_version still worked on local filesystems.

Sorry, that's the intention I was trying to get across.

> 
> I'll be posting a patch shortly that falls back to directly reading the
> i_version, when STATX_CHANGE_COOKIE is not supported.  It cleans up the file
> change detection code, making it more readable and should simplify adding the
> ctime file change detection.
> 
> > We're proposing to compare against the kstat.change_cookie
> > directly to the cached version, and fall back to a ctime comparison,
> > if STATX_CHANGE_COOKIE is not supplied by vfs_getattr_nosec()'s result
> > mask.
> 
> Please rebase your proposed change on this patch.
>

Sounds good. I'll keep an eye out for it.

