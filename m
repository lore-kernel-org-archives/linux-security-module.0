Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468F3E0C47
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123511; cv=none; b=ZgcY5lnVxmhOMsUNg86V+Sm0eW4tIoxyHZArKYfw5X7+V+rIbBKhIoca08xlFEsmV5wfDMi/TZ17LluJ7giKHhVuPbvNp9SfE+El5Ou2KFApm7n/ELdA2nsG4UHQ41BvVowc/jS1vHpLZV39+E3u0juTw+JgW02+V4zZCG5qP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123511; c=relaxed/simple;
	bh=Icv2VgJhL3W6ouaYoa/R5Pjlzon0IGg9KffIGQi3ZEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OETuw/qPJ99qQPto7dwYxoYLSRZmIs1D8NEg/qEte+YPWheUjDJ5DOZxeAmhVapV+qffj8VbkZS/HcwH+LjseLupBgUpEfRy1gwc1tj6Wbdmmu8XMsHTqpFyVP8McO5/1iL0/Q01Cas8atRsvkK5e9106gh9n89dBdr+jJ2DT1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i79ASJAA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VBFOhhHX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i79ASJAA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VBFOhhHX"
Date: Thu, 2 Apr 2026 11:51:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775123503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSBzuFiBjwXuxTtp4uVoBK+Fhkp5nSu9LpB56QNO5JU=;
	b=i79ASJAAakdwKfnxgyX5PoZakglWxflYuRDs6KUv8quN/beShOISKl7zpNaDKdQv2luCow
	bs2hAvq7nR0hkaEygTJ/fHNbNZDSLwgwWmr1OSm86d3rrCMblgweQqZ7tgCkfe2I6tA8eV
	RcTfex8ps54/PGOqtbxWlKHBBUVzs4AUt7RdYwb/Qz+RXMwDjshJeWyxnS3KyygSjbuQlJ
	Ma2hNJ7y5djbo6boSjFWVwVOVnyfkn9GTy3Iz9TSA2aki62NQxxmYOF+nKWv/ueuyEf6f3
	Lj+fUV15ts7sMX5wOfyNuNxfijl7uIQStF3eU93/t5PmVPE/yGtx31EboT+e9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775123503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSBzuFiBjwXuxTtp4uVoBK+Fhkp5nSu9LpB56QNO5JU=;
	b=VBFOhhHXGwLe7MnPktYwdVkdrgZn5sNubY4d0raQW7cknhuPZ0JUGVa2o34/iDbZp4XJdS
	l/4ebsVem4Af51CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	John Johansen <john.johansen@canonical.com>,
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Subject: Re: [PATCH v8 04/12] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260402095142.c9sySV-h@linutronix.de>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
 <20260327164838.38231-5-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260327164838.38231-5-gnoack3000@gmail.com>

On 2026-03-27 17:48:29 [+0100], G=C3=BCnther Noack wrote:
> * Add a new access right LANDLOCK_ACCESS_FS_RESOLVE_UNIX, which
>   controls the lookup operations for named UNIX domain sockets.  The
>   resolution happens during connect() and sendmsg() (depending on
>   socket type).
=E2=80=A6
> Cc: Tingmao Wang <m@maowtm.org>
> Cc: Justin Suess <utilityemal77@gmail.com>
> Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Suggested-by: Jann Horn <jannh@google.com>
> Link[1]: https://github.com/landlock-lsm/linux/issues/36
> Link[2]: https://lore.kernel.org/all/20260205.8531e4005118@gnoack.org/
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

The unix bits look okay to me,

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
