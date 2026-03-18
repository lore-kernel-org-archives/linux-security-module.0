Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D783E0C74
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846364; cv=none; b=I7oL9Gq3+KGwo4qcU5ZSQOosHXW5kX3BKb5HmywMdarLj+obKG42pFR4zmsaWbmE+CfwOU3zCL5K0nfNYJtepi6CNC07QNu5fMUEb9vB8+Do0RhTF9uCGegZKHrElU2UWkHFauJ9viKDYMQufqEwgm3BX2ULecyTB4Fhbw+RThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846364; c=relaxed/simple;
	bh=pQpl3D6m7BhykfOajlHWZs/pYyUaEstzK3yHqN/9KXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUnew2W+jL6DZQ+FrZRPuiPtnlbawDKyb5TCMQnvzVF6siSZ1Aq1Vsr9bn5WXTjvIORnhKZwrFww/El1xWaCKYCSqkL2YDBdhivd+/FGcUgYh5C1XCLyN6vTkM3MISvrZdTMlN8d03UMgIQJD6zLYKrLAQ0jxki2uWqa0KHH0kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sQCta6YZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vqz27Joc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQCta6YZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vqz27Joc"
Date: Wed, 18 Mar 2026 16:05:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773846360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQpl3D6m7BhykfOajlHWZs/pYyUaEstzK3yHqN/9KXU=;
	b=sQCta6YZewNagt4R1VBwFMcB3bI9qUQ3IjlGsNTQuKaypyJFEj5qQ9q7mtIzMiGt80ajqD
	QhZ89Kr4iP49kVU0Naj9NpJ/3S2/nR6QJioOKn22oAc5aUREGtuFCG+ZSITzFQuP7nHt4u
	nDhfsFzFfrgFlWLuRw0uth9g39kJV0rCfa3vXlKaYL+ZNbaVnVcoogUH0351s8v3q4NUaf
	amo1watRcTNXvinzG2rQEug/N12WX2CZnoXqjaH4Tff6SFw4eTvTWdxWhGBZzQN4NL6Aiy
	nMNQ+8HstTz96RwGA9YOZPoZt/Menrv0b2lpuINahTq3fYSSEzX3x67cZF8B2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773846360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQpl3D6m7BhykfOajlHWZs/pYyUaEstzK3yHqN/9KXU=;
	b=Vqz27Jocl7cWxe2cYtHYBp2NFaKUG420BqBLmIZfEA4e7FjHxV8K5oTJs4HX1QX5ExDTJN
	D+0V7cCijRticACw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	John Johansen <john.johansen@canonical.com>,
	Tingmao Wang <m@maowtm.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v6 3/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260318150559.j04YNDtV@linutronix.de>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-4-gnoack3000@gmail.com>
 <20260318111507.1nr6rAki@linutronix.de>
 <abqzXO3MmMXKqXOy@suesslenovo>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <abqzXO3MmMXKqXOy@suesslenovo>

On 2026-03-18 10:14:52 [-0400], Justin Suess wrote:
> Sebastian,
Justin,

> In short: dom_other is a pointer to a landlock-owned refcounted struct.
=E2=80=A6
>=20
> But we copy the domain pointer, which points to a landlock allocated
> and controlled object.

and this is not going away while we are here and preempted after
dropping the lock? (if the landlock policy is updated/ changed/ =E2=80=A6)

>=20
> Justin

Sebastian
