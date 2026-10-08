Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D5396561
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470385; cv=none; b=jNdS7xqMi5lB27UXC4zm7azshOGPBM0Zur630hcP5m2WohWgqzm3SP25daRhZemKUF8XxZtUnfNlGD6teIdsgae2rZ2H5mCfuPdmJjk204nWvEddPT4BMM5NA9RUM8YMdB0bfO+DEIikUnM4YjnovgOnjKnDi5HpMXcZEY4ay/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470385; c=relaxed/simple;
	bh=OgDnk7a4SjHhcIVOIfICL2Uk/HqZDTTLfZD54khkumI=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=erpi21kIkvO7kq605kSCC2sXWFfj39OL4Htxyhjbyx80zjFYNGXKMSOf7AooqmVxljFtQe06jju3V0Jg/0J/6Yj5UHZnHVs2BYwJmy9ISsGeT+YPdHATuYAFzVleuK8nepe1h3oj8mLqDTtlXcG9k275fJdp9XbMb3PKgMZOJuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFE/Cppv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFE/Cppv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28A11F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470383;
	bh=sB9FmqLYylNuV/MMJPFNgAWsgh8j3gA97M+psjV4pp4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KFE/Cppv+i3ko4e7Jf+d/QsLFUQahfqbjRTQYdTG8z9sY4lz2hiMhVU2GvQ5VBANL
	 gwjTGyRNW89Wnf/a9kYS749bm1TkDOfHpd44clu8RJV1Mu0ROeIakMTkTsfiTcvo06
	 ngfmITLviUpnuwZeBdj64Ik5FKdvKewW2YKe/rkxkfjuHh8QauoVOGOAeNmEroIJVj
	 Eg/0DpOg1H8HicTcYfwWgmjhuAEIHdJq2ppC1uqQyaKgz+C9v8d/4xhlaaF+GmUtrs
	 Y6+AXLBXJhY38Y684I5mnR4GHQjeZiMxB5PzEyBMMUQvJExP5NLPfop+D3EN57+7kS
	 wzSYLwapZ7o3w==
Message-ID: <sashiko-outbox-164313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 27/27] selftests/landlock: Use EXPECT for checks that
 later steps do not need
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-29-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-29-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:39:43 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> ASSERT aborts the test, so it should only be used when continuing after
> a failure is pointless.  Use EXPECT for checks whose outcome nothing
> later in the test depends on:
>=20
> * errno values after a failed syscall,
> * test_open() and test_open_rel(), which leave no state behind,
> * WEXITSTATUS() of a child that has exited,
> * matches_log_fs() and matches_log_fs_extra(),
> * the record counts returned by audit_count_records().
>=20
> Keep ASSERT for operations whose side effects later checks depend on,
> such as renames, links and file removals.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D27

