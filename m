Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B002F1FFC
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852239; cv=none; b=IA6l32HBAczavGuGDbrRcOhGCruJiPsYIeT2U5004gQqI8qcm9Qr+lv53iaeN6omQT51b+t5O1YltSkZ6xB2vVpXoFimjLGUTd0ufOxdm9nmdA+qfpdD7v18NRMPgD1XXzowZJA7pEdIoRVzSteu7YByAUL8g11IPwzdyjS0mjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852239; c=relaxed/simple;
	bh=H2btuvgm86SnyuyI4cuOl/bgXhsN1Lmk0Cgyy7/0DpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggXJlRyqRNGXxcbReyXOymzDkqcCjqaBFoqUfEke5pxwUlkzwd/hoCQ/OQi18K8RXmP9PU5KqX0Rxw/D7WeqWCJbXFAK/k34oLfXOUKSpyviME7oeszEXTKLxwoeAIEEc7jyZ+i1ssvplL/rvK6bEKYzvJYtDvlKfvHue+BaYMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gW2EaEmH; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW2EaEmH"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a51edef1fso18356527b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773852237; x=1774457037; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+2kZ3MLxshElSQdSPBUkONr5v8VUA9DJm5ps1Yq6ky4=;
        b=gW2EaEmHHkxRlEf8OItqOexTT+AsUVzOXFxBQyZUF9UrzEUxcTRLChyLA4jdar691w
         BVTg5YtkbuYVjzS2eANNT4BJ6uynsabPi+mG9xAsZKnBqpDxmgnKjZj7vOdJZLGfzJJh
         VZsh3z/zkcZ6h0HD6XdEozZY7+HSb8Q6V+C1vpTyNTVCBdzrTm22Dbp2nSghMLt7rkPY
         MLbKcLa2SKoPrlB1/PiJSFqdLCBZhRO7WDnAIm3zZJMMqcUzmLKQLtWu///ZyN9xZ/Fb
         z3GTk0K1EI4zAFyx2qKyvKrsh6mrJi0HrdkV6wBILuLaNq/wZuC4wvSEvPLdILwXq7xt
         mJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773852237; x=1774457037;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2kZ3MLxshElSQdSPBUkONr5v8VUA9DJm5ps1Yq6ky4=;
        b=iNmGyfBTsQvIWR33SBTU6Si6sTp/j3ZW8N3IbIDDKI0L6GGKx87ITXDF7bhhv6wHKg
         NZlsxpHf3dfnj8VhFCAhz9YI0ddRN8XkY39Kp05GlmPapLdS5almuGVDxH82Dp5wAJR+
         ntxTboAoPQ1FM2phLcAy1509aXRekEIsDgr+R2hX7ei7F+a+48TSnXPRPsX3CSshvC5X
         PrPhpH0sRjO1j+iWAToACA77Fd7ko2eXndzXPuj9tSBXKOlE+1Ac8aiTSV+3CFYGgP/6
         Rj8v0fZNuPRTJnjGYwtiCW45xNnSz2AJDOBDWOmgYZacLtXeS/GIqu9eoQXB4w4scnV3
         UilA==
X-Forwarded-Encrypted: i=1; AJvYcCVtYBKfC/ZPy9fQMLK6PyXBs1dQSwt2Z3n5LTtAuKFhN4gLwzKP6Gc5dsU4QosBHDWLYgsexw4zX7unqqNYOp07YdyZeqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxoPVdn6XBdKV/nNfcJ8QUXElvdekrfXsCquSMwx038wC3eXj
	fnIwhP11j61kk20oRYlsXJnu2LrbSvIVABTdyoedALCuN/OpvNylk+tp
X-Gm-Gg: ATEYQzw2j9BLIEZYDp4cHUuEuBE/NWqR8JHGVFPD5GJE0pTzs6pdnhKTKiETJ6d8nfQ
	0qBLp9I1KPi4me2dDx6+Q0HhFLOWCLBClgI0MWIqidB6XuoBB46/7LjOPjsviZcy86hd4GJ9lss
	e9ulmnlSCfteByudrbOpWcnSOCghwILrYnQ0h6pcjI7mw8EHew7LYi/nkhVNqda3osWDF3H0KdK
	KK7AQIL/FTxCXpkKP8i5qu6YNqlbmBL0yWkW7pm1Id2TMYDj4VsCA5nwZE0xVPnnfT+kX6/UjXu
	OX18JqSMYgxJSgzCATn2zSWkveTw5ThwDxI602QaK7jYl1PnvUp0dfNtKH/0hGYmSdevqMl7LdY
	ikQU5x2dfxQfHmJXLnb6bgkC7ixXOi1hmI/IOLT3diS2IeLS9fMNDZe12CmKojs//Hcy/6VgNBS
	mmFE475o5uGxF5ypIyLMpZ84x6hSa9
X-Received: by 2002:a05:690e:2456:b0:64e:721a:a60a with SMTP id 956f58d0204a3-64e9ccbd1edmr199515d50.14.1773852237214;
        Wed, 18 Mar 2026 09:43:57 -0700 (PDT)
Received: from suesslenovo ([129.222.86.248])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91bbecf8sm1875975d50.11.2026.03.18.09.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:43:56 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:43:55 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
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
Message-ID: <abrWSwS5urQpvbPb@suesslenovo>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-4-gnoack3000@gmail.com>
 <20260318111507.1nr6rAki@linutronix.de>
 <abqzXO3MmMXKqXOy@suesslenovo>
 <20260318150559.j04YNDtV@linutronix.de>
 <20260318.Jeph6loh9uSa@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318.Jeph6loh9uSa@digikod.net>

On Wed, Mar 18, 2026 at 05:26:20PM +0100, Mickaël Salaün wrote:
> On Wed, Mar 18, 2026 at 04:05:59PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-03-18 10:14:52 [-0400], Justin Suess wrote:
> > > Sebastian,
> > Justin,
> > 
> > > In short: dom_other is a pointer to a landlock-owned refcounted struct.
> > …
> > > 
> > > But we copy the domain pointer, which points to a landlock allocated
> > > and controlled object.
> > 
> > and this is not going away while we are here and preempted after
> > dropping the lock? (if the landlock policy is updated/ changed/ …)
> 
> I agree with Sebastian, this is a bug, see my original proposal:
> https://lore.kernel.org/all/20260217.lievaS8eeng8@digikod.net/
Mickaël,

Just to make sure we're speaking of the same thing (I spotted a bug
shortly after replying to Sebastian).

This is a potential UAF if the dom_other is freed before the access
check takes place correct?

	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
	unix_state_unlock(other);

	unmask_scoped_access(subject->domain, dom_other, &layer_masks,
			     fs_resolve_unix.fs);

If the dom_other->usage reaches zero, then the domain could be
freed after the unix_state_unlock while we're checking access??

(I guess I assumed the sock_hold on the @other would prevent the task
@other belongs to from being freed.)

Would it be better to move the access check under the unix_state_lock or
to acquire another reference to the ruleset (or something else)?

(Good catch Sebastian sorry for the confusion.)

Justin
