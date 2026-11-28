Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795830680;
	b=UPsQHfHUUlDiMZuD4Fi6PRKLPa0ILtBsKjohsvIiEwbQCtROO7FSD9ziYzVJ2LtzCvhM
	 LNsfhJzwQfPJ5Nb8K825hHow0n+VzsZvx7GGZ3U13bqCM8lHVQVfMgAJekUdJGNqiFpp9
	 V1jwbHdu3mIqOeZwacxQQrl6KzdhgWUO+uNUBtK09R0d4t16Hwk3jKF2v3jFs4K2J7Poe
	 0GxHn1kZiOJ9RalcW1Zwsp2zrvDAOtHadO3miGjWpUQL7Flop0wmns372PGRGEpwLzNOC
	 xNiuSyNdUdC+rCDTMU0c6UErc8m4sAxZ9fE/HnOO5Od9dIOe1MkNMEWSz4oaetZ8SdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
	b=uMSWeJj9hJDC2ZsAx1Gwo8bSoHcupOJjuBYHkwEQA+pWOTuKym+BWBSnQfR8lzrE6W9K
	 710oz953FXTk4q2d1XeD6NLTjwN8PvBjeP0F9Jx133NgsknDHybob2+ASKk9jfF/9+LFR
	 aR0titeQvpMAvWTfSAsgTd5lD4DaWNIKp5BAAj85CZPm06tVuf2aekbHrelFh/N/4sxt9
	 xUZN9bAk0K0aswvjM3Z75XsdPMi8ZsJPdXw1T+qpEX2CjSoeATKjMEmP4WZT2ycH/TLA5
	 EvXq0O+ORLfXprz76nuKe9XfW5Jx+Am5h9vhZ76oNgJ7NQq35mwqWi8ZApolyDtNaRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLosXPN4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F854606A326
	for <linux-security-module@vger.kernel.org>; Sat, 28 Nov 2026 01:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F854606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLosXPN4
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c5127c7abd5so1322752866b.3
        for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 17:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795830679; cv=none;
        d=google.com; s=arc-20260327;
        b=jHOyX4194avx14AyiRi2oKHLESJOf1wnmrj1aJpQrfTtzU+nxy3IuREPypiFiR6JwS
         bpUNyybt7jPY95tPcE1zGEvXK+enLSnrrXNoM2Ep4rRrMOt5muPQYnUeFewji++0Q4sS
         4HfFt4+vxikoBdU3gRnW02aizeF8jQfeZtJtRrPbHrrmMc0fmGYMbjerRX1hnJepMouJ
         7aDgUi18m3lSy+GQEUWXWL3BAjpOfMLJL8EFwDxpMqCUcav0KtcRGNiwYyoKSyEkvc3e
         wUaRKx7BP8wSSRpq2gWNOe5dVfEa8BGYJBI2kcYYSAY07Fq4TqgQg+Rs0DjoQK/Pemya
         sElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
        fh=+h97TAXUMf3rCKtDSiJivoG34pfmk9tc1Z2+K3v4FEk=;
        b=EU2s5sz47JCAzow/ipRK/ZYmjE65jQDIsDE+tqKp13k3KS56X80BBJbWdMVJtSxfz7
         v2a30m5yiSkqPVFpshnnGcArGNGVZGc164HrHnLf91SppNQ2XvHVF+rxIQnlTyE1e/Wx
         Jgat5kzqFxG1SD9hH7bD38M3A3+EBnMftHz/upL/lNMXxi7VCC9CNQUiIbHFWWER0qKA
         PICqO2kp4dcJ3+bvO0ejTxSDTwb+438Kicigw11RnZ9wsDZGKa2tTVVrQ6cBodbKKlC4
         B+GPVJp0E5O0JEVcP+77ubtrI3aV4xgjhsKtpgIXUUjwkLbQCN9b+tx8RN45QMgvaktS
         oO9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795830679; x=1796435479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
        b=XLosXPN4XY1X7SNdxkqBL+OmW6RyoS3KUKiJGN6VkhP3L0yhHIWAe9gfCGB7c23JLd
         lHNLLgTgGaPV+ANwny7auVJWhylTPy7tn8Qbd1QmlxO7gDNExEWgSGEhy30NAozJQ+8+
         +xKv07hbVc2PMmC0nQwONM+Snu/fB4CVx2Zu1RVG2ABrNV3bydSS40OT+TsJEZK+JELi
         MFuPTs18dGi6k3X7RKL9C6rS6PY4lyASR9cQGoX1ApSJvF/sCt8fWc54v5qN8Mgd+424
         mRGAbRe9QyqlYYy8UZHrD36MAiba/qdVjAz2hG+uSVag6rBQPtZrBpUV+D6X33j1iq7k
         51pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795830679; x=1796435479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
        b=yfl+RsOrsLPcfClpyzk2zKD4XKsp/a0cRq+FVAFARdcRFowZy3/c6JFg/fTrb5r7NW
         B5EiCoBFYdubHQfxaEQPT22B/aG/W6QbA1hm1u41AIBJgtYsI7rL2wcHVyCj3fhE6nh7
         h5rEATGyTJ9LmZg624RdZlwSPgAREvBSOJ/8KNP0BJNH4qsGjYdBm+k+kk2u6KSpmjWM
         6q4nkIyKEOD1WicTpQszxwaQm86EUxx04rfgfZYD9jL+ree29KnlhSVyjE+qVkzkXcyR
         mFZyEn06Nomdj3qgL/tce5p9G/9/iBl6yUe0VJ/oi1JQpir07UyPI7UHl4eV4if7faDz
         fEsQ==
X-Forwarded-Encrypted: i=1; AL+hErHXDmgbdYsAoz5doe8YpyscR3TtAbMEAByRIToEJkIXvp4Rg8oJb20UYTuNDe5xuIRXpqvFIVBIR4y5SMX4UjCUDyjOQOU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yYPflqCcCiJ4mG6YV6niioSnJL/b8PjYPIhPdfFziYqZKeIJS
	+Jem2jMJ9+U5nybWXgaQVgYDMejl8zJc3AlmYWBIKBuLS7/b1wkr+1FvbABiMstDPcuXxT4ueKU
	oQnvusiF5zF870Dzt11/dSqojgOlaP34=
X-Gm-Gg: AZFdTZeQmAuOIjCjms88AXWHaI2iz7s8wJmVO1Zl9CYKMuAqXItHhZ0Gt4n5MRbw6no
	jWZvsR09HS810jtdh3ti7qh1O1GrWFAexAYY70MGFDc43Guk24VrFGCP6CpgHQxawKbMTIfcsLm
	hxuwMtwwLA4Y1jJ5l4SqCdIDkJuRlvUFLVEjeEWgBhtQTDcQ3AgQN6XtErbNsFAz0f/EWQUU/O1
	XSmkGiuyXU4Kry+o/F8G5k8XJv+MzD+UTE8sIqQn2p+Y7ybOVl3I7dgO13F6m/BNJVGomW9wr45
	8PAAWxT9GjE1WRw3nb6VAqgw4D1aTWlnv51qsUGP2uZ16jyG2ye6WOljstIvJys+AQKiuJk26sz
	vwHGFWyjaR2sWR5IBaT8Q2j1rwBgNa7EEnG6Q
X-Received: by 2002:a17:906:fa82:b0:c50:4b6e:329 with SMTP id
 a640c23a62f3a-c513a5eaea2mr1724212966b.15.1795830678877; Fri, 27 Nov 2026
 17:51:18 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <awOQDOel_72Xwjm7@kernel.org> <20261127214103.542291-1-safinaskar@gmail.com>
 <awn-ioAuksHNV-Rc@kernel.org> <awn_Y7oI4ckfsjSv@kernel.org>
 <awoHex4LVst2JwkO@kernel.org> <awoO9R7YF_5_6dHA@kernel.org>
In-Reply-To: <awoO9R7YF_5_6dHA@kernel.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 28 Nov 2026 04:50:42 +0300
X-Gm-Features: Aa3M54pCi2p8qLdocdLXd3OCMkn8g_j_UUSVEEax8LAEOxwj1oFmxFAoHI8_4lc
Message-ID: <CAPnZJGBnFyrmr88OsYkMwtLiR93z4g0NAuoMurcnhcYFXz51jg@mail.gmail.com>
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: aleksa@amutable.com, alex@amutable.com, alexei.starovoitov@gmail.com, 
	arnd@arndb.de, bpf@vger.kernel.org, brauner@kernel.org, 
	containers@lists.linux.dev, corbet@lwn.net, dhowells@redhat.com, 
	ebiggers@kernel.org, giuseppe@scrivano.org, hughd@google.com, jack@suse.cz, 
	jlayton@kernel.org, josef@toxicpanda.com, kees@kernel.org, kpsingh@kernel.org, 
	lennart@poettering.net, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	luto@amacapital.net, neal@gompa.dev, oleg@redhat.com, paul@paul-moore.com, 
	ptikhomirov@virtuozzo.com, sergeh@kernel.org, skhan@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, zygmunt.krynicki@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 28, 2026 at 2:15=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> thinking more sequencing than data structures. I.e. I have a game where
> I need to end up to process creation without embryonic state, and add
> just enough weight to kernel to support that outcome, and that leads
> to ~2K'ish LOC of extra kernel complexity.

So you don't have embryonic state? I don't like this.

Let's assume the following situation. Userland's PID 1 is already running.
Our container manager attempts to spawn yet another process into userland.
As well as I understand, it should do clone3 with CLONE_INTO_USERLAND,
and then execve.
This creates time hole when there is process, which already runs inside
userland (i. e. its PID namespace and other namespaces), but runs
container manager's binary and have container manager's mm.
This invites for bugs. Other processes, which already run inside userland,
may somehow take advantage of this.
For example, see section "CVE-2019-5736 Is a Very Very Very Bad
Privilege Escalation to Host Root"
of https://brauner.io/2019/02/12/privileged-containers.html .
So, here I like embryos.

--=20
Askar Safin
