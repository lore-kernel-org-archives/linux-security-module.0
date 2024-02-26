Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E511F94C
	for <linux-security-module@vger.kernel.org>; Mon, 26 Feb 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708978884; cv=none; b=b0cXBwVDc82V8BiBLnwJrK/+zZm5YwMCf2sgYst6TRF2nSwHguRZJxNe0jt6PqQHl4jzIBcQ6rRxcGinCAu/R+mqmle8sAwrXp0LGuttxw4q9Ux/oJV7NeNiKpf7Ee/A+m8/ntYoUiQoZ/T4v/12K4WeY68F7UXh3iceA53oZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708978884; c=relaxed/simple;
	bh=V+U8mYk2PqPb7oIAg3nmSJcwO6wdq7wethQJpUrnYu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imoghdMlJSk1315avi/7976GDiLragLOH76PItKSn5NMZMcQd42yQd4ObG5VlWRgVMI7g3SBCA4tdH+g2AnnlVB/Pw5dwzC6DhpX0C51WOV+fM6WYzq7QXktL2lFsjWYCBpCVRsxBC4/3HUfebYz0XzU1YQJoCJYDFkt3GWOCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=KJUhhXGf; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="KJUhhXGf"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TkBpN1hWzz1BN;
	Mon, 26 Feb 2024 21:21:16 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TkBpM2YKfzNmm;
	Mon, 26 Feb 2024 21:21:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708978876;
	bh=V+U8mYk2PqPb7oIAg3nmSJcwO6wdq7wethQJpUrnYu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJUhhXGffQjx/Gy/vSu3BvRt5p6/m8qt0oVPUu0MiyipgKJ0hAYnuWpdQEYzPRq8z
	 cz+Ds0eGefPzBwWXJyxxXfR+RvvLwgUbsLCKZtgDF8xd23cUIkqM/e3CtssPnYFbLs
	 RORbAwEpx2+UG/bVEZIZStVfNGkJkOLwb1hZIzok=
Date: Mon, 26 Feb 2024 21:21:06 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <keescook@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	davem@davemloft.net, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Will Drewry <wad@chromium.org>, edumazet@google.com, jakub@cloudflare.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/harness: Merge TEST_F_FORK() into TEST_F()
Message-ID: <20240226.NooJ5ahBip8A@digikod.net>
References: <20240223160259.22c61d1e@kernel.org>
 <20240226162335.3532920-1-mic@digikod.net>
 <20240226162335.3532920-3-mic@digikod.net>
 <202402261102.3BE03F08DF@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202402261102.3BE03F08DF@keescook>
X-Infomaniak-Routing: alpha

On Mon, Feb 26, 2024 at 11:04:12AM -0800, Kees Cook wrote:
> On Mon, Feb 26, 2024 at 05:23:35PM +0100, Mickaël Salaün wrote:
> > Remplace Landlock-specific TEST_F_FORK() with an improved TEST_F() which
> > brings four related changes:
> > 
> > Run TEST_F()'s tests in a grandchild process to make it possible to
> > drop privileges and delegate teardown to the parent.
> > 
> > Compared to TEST_F_FORK(), simplify handling of the test grandchild
> > process thanks to vfork(2), and makes it generic (e.g. no explicit
> > conversion between exit code and _metadata).
> > 
> > Compared to TEST_F_FORK(), run teardown even when tests failed with an
> > assert thanks to commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN
> > for ASSERT failures").
> > 
> > Simplify the test harness code by removing the no_print and step fields
> > which are not used.  I added this feature just after I made
> > kselftest_harness.h more broadly available but this step counter
> > remained even though it wasn't needed after all. See commit 369130b63178
> > ("selftests: Enhance kselftest_harness.h to print which assert failed").
> 
> I'm personally fine dropping the step counter. (I do wonder if that
> removal should be split from the grandchild launching.)

I thought about that but it was not worth it to add more lines to
review.

> 
> > Replace spaces with tabs in one line of __TEST_F_IMPL().
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Will Drewry <wad@chromium.org>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> 
> One typo below, but otherwise seems good to me:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> 
> > [...]
> >  			_metadata->setup_completed = true; \
> > -			fixture_name##_##test_name(_metadata, &self, variant->data); \
> > +			/* Use the same _metadata. */ \
> > +			child = vfork(); \
> > +			if (child == 0) { \
> > +				fixture_name##_##test_name(_metadata, &self, variant->data); \
> > +				_exit(0); \
> > +			} \
> > +			if (child < 0) { \
> > +				ksft_print_msg("ERROR SPAWNING TEST GANDCHILD\n"); \
> 
> typo: GAND -> GRAND

Good catch!

Jakub, please fix this with the next combined+rebased series. Thanks!

> 
> -- 
> Kees Cook
> 
