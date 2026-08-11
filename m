Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E49F41A77C
	for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2026 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437280; cv=pass; b=D2RNooqbsHMmakFzzSgADTosB26bis5cJH65TEY3zna1b7H624t0TBtc7a86pV23nt2+knNf/+rZ0yqn3qDvWvCQYTgAKAPaHeGTeJgtLem4OjZLJLu9Fat3/2P/HhcG/vFNX6xzzNc35qnMNEJyLkcvbi7b5Y+Eb9yjM3iH4FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437280; c=relaxed/simple;
	bh=HkedlUJRK2NaoVVLLEdjZGUCeAs/seI8pDMStai3ezQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hs6rwgSzhwMbyz6MI8oMUZQTV5+SmdNZ+m1q5pJJvtmZXfhoEYqO3Mq8CBhGoySXvFsTdBLMzMXv2O5fmcTmkfdUYjOQ6f6xDR+l3IYg8NtjZKP/beAjYgriA/c9cqlvW2gk+sjU5vIKqa+Vj2GEF4msgmxd0QPcS8SEQJQusqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hstl9w6X; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hstl9w6X"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4997581cdc1so4003705e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2026 01:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786437277; cv=none;
        d=google.com; s=arc-20260327;
        b=qf6H64iHopOy3zNmnBKnbszj833kbI8DIu9NfsCE8s9p0ZXVhqVOMzyt1RkUGTVefD
         5LlW6wz9aTa9aat0GXRbxAayFsViCHC1I74IjPGrfL3ocp0li6aNODSyJIFOcb3fw30H
         ukkdxT21djwocMXXkMBsKmcDT8ZXjvcGU25AlTl3DPn9RnVHsszIkR9+aJz/gtKbkL2r
         7KXPCN6/ToJ9i7sL/NTMLVwl/bGqoZR2LiKQry85BUtpvFV28sXrMgJlX1r2w98MIEVe
         lRAK1cOTkLFkkC3t4oCjr1ih+Ms7S6oLOl3NfoeNff3jV4WHGZuE5B8aOL8B2HqR8mCw
         bsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=npLC6PjTwERUQHslojU0dg0CwSTAkb6KsuLFcLO1PDE=;
        fh=EX/PEDe2WEkDUe1dDLRcTWKViOlEjdEEIsk84zTiSoA=;
        b=gE6aXhAggpy2mIbW+WYv6xiGLE2ISwZ2eZKhv0hgt6xW0xtq7DLtomfQT+iSJ9sHEI
         lik8wQbX0mNFNux4oMjNmsreUjajlF219zGgpTqmADW94TA6zCXaZU6eP5UKicALzBnG
         7QFP6XIm1iVXRYyWthuahaUceXS3MQnXcebCS9olrWiPoz73dkFsT3lDK4XyvNwqrNl9
         w8J8Fi+7kOm3OON6P8am5cE/M6lYsgkJSVYkO0blddMuWgXlEI/LeXnrZKwWbBVQPNam
         3M+izXtEJ1A+LQt5F1q+5X8TMaJiRfpf+mHzJuCaIkwGpX9Ya/Cf1YSAY3DnyZUCE7z5
         WZtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437277; x=1787042077; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=npLC6PjTwERUQHslojU0dg0CwSTAkb6KsuLFcLO1PDE=;
        b=Hstl9w6Xm0qG5qDSnjakvnW3JqKL1hFLRQ3+DJbSJE9oX/0PcDS3tQ/GoW0q5qhJaM
         f6qY0bVyImZa9aVKXAIfEZonkocpnVtE/siyKBcOnClP179m3o72ooufbaZKJlw9h9XR
         h6r9qnCoEOyuZWRcO1/t7KJnCWB4TIuhWrWyNS7cDxBV0txQWVqFxun4ZMGhkp9sFrbZ
         FxTWXvFWxKvL6O6lnaZuBwcn888S1q/CilAPWXgBv8bmf6KXa03EjWStux30/z2Z4TGr
         ukfvFvc5mzv4v+ae12RlqI9cWjadr174ZFHEwVOboz62zJ4jYIA+UuPIIWtTNwE51QRd
         OR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437277; x=1787042077;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=npLC6PjTwERUQHslojU0dg0CwSTAkb6KsuLFcLO1PDE=;
        b=Z9EGHot9Tgc4jAkIdmgu/AXulbORK0RoGDDcFj6VWvSlD264EGzorUnlwCpVMPP00j
         s7qBj+orXyYzak9EIOyKtys+Bag+QZ5RUwb2NigpXWWlm8fRMopDVXkhOTtB4dCdaAYT
         vQ8iXn5Fo6K1SwKetDzz9SjNyvzvG/bVvuGKEUEc/okF/+jFmL2zBqPsLZghsc6mwp93
         E73T2Oj3oKHWIGpxe8iAXh8D6xl1QdOwAOMXjWaV/+KxIBvQtarUSf3MvezNy3L9P+Sy
         mSq1y1jDRfiLpcT0olPOh8Cprd42bT6SMZFNC3KIOtPRzooOKyUtn0/NLbfRDOFzhC4J
         1BWw==
X-Forwarded-Encrypted: i=1; AHgh+RpBynRW+MD46gltzLa0weNhPQWusQQzbqVbc9MyGIq127PI2w23JsyHfLoYqMhaBtS79qpdVGfrMvQ949MYmI+ibGQ/VMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9NAk3eAATO/mLoGx5sMr9GC38sbq/5uGy5eonsrvAZKxjr03V
	ZkFt32yRzHKPY5vmTpFNP9YKl1XiOA2AtuKLjTBk66yqMXH/KsRbG2T0xnIn9vVY8o2B8i07xYQ
	ra77Ktkw9AcYtKZA8Btmy6Y3qWU2H1OM=
X-Gm-Gg: AR+sD13cIA06eGVFMt+5Lq5L2mnWuUIGvlClGGfT7L8Y7haXDJdKjx5YyOv3EDnne5m
	jucpK2n7v9udtM7cSn5TSYDrxr9Q5nUPoISwOCtAF5t60qbGdWdaBGp3z/cqTDwNQP+VQ/AECYW
	Le5Vadwh+a3BxK3aFr5Or40vmunD+N1AZRKBopsIXavCRiVJ9CpleeYuoJc61SoaEnYLsEvtCic
	xC2/74guh8t5ZsLpCuZwQ/W8hPRupiIwf3ORdvUWYAQ2LFRjoftHLeE8qjOcO2XFxUjdZ0Up8ce
	USzcTuFL3cdHRV+J14Ao1XA8Y5SllJueig7VI8ubr5ML
X-Received: by 2002:a05:600c:1990:b0:499:78b3:7b34 with SMTP id
 5b1f17b1804b1-49978b37c3amr18300885e9.2.1786437277106; Tue, 11 Aug 2026
 01:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809110202.2180410-1-maoyixie.tju@gmail.com> <8a5ac8ef55346825f57f8d3966b312f3d1152c2d.camel@HansenPartnership.com>
In-Reply-To: <8a5ac8ef55346825f57f8d3966b312f3d1152c2d.camel@HansenPartnership.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 11 Aug 2026 16:34:25 +0800
X-Gm-Features: AUfX_mzXGj3FLueDWlUGBha_pzgfc6RrUlO-FB7YwO7ed2qZJbTFdwmCoTfa_lE
Message-ID: <CAHPEe=FJCf9Br7jFqd-89bFZt+aDRwdmj-N2i1-0-+ypFxnsLQ@mail.gmail.com>
Subject: Re: keys: request_key_auth shows a global pid in /proc/keys across
 pid namespaces
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 11, 2026 at 12:50 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> I'm afraid this get_pid/put_pid doesn't look right because what it will
> do is pin the pid in the creator pid namespace.  Unfortunately, some
> keys and keyrings aren't bound to a pid namespace, so if I create a key
> in my user keyring and then enter a new pid namespace, with this change
> it will still show up as the pid number of the init namespace (pinning
> the struct pid there) and vice versa, which still sounds like the wrong
> behaviour.

You're right that get_pid() keeps the creator's pid_namespace alive for the
auth key's lifetime. But the pin does not change the printed number. describe()
renders through the reader's proc pid_ns with pid_nr_ns(). That returns 0 when
the task is not visible there. A key made in init_ns and read from a child
pid_ns shows 0, not the init number. It never shows a foreign pid. In your
example the pin only holds init_pid_ns, which is permanent, so it changes
nothing. Auth keys are short-lived, so a container-created key holds that pin
only until request_key finishes.

> I think if you really want to fix this, you have to keep the pid as is,
> but make sure it always records the pid in the init_pid_ns (i.e. always
> translate back to init_ns) and then translate to the current pid_ns in
> the output generator of /proc/keys.

current->pid is already the init_pid_ns number. Keeping a struct pid lets
pid_nr_ns translate it for each reader, the way pidfd_show_fdinfo() already
does. A raw pid_t would instead need a find_pid_ns() lookup at read time. That
can land on a reused number.

Thanks,
Maoyi
