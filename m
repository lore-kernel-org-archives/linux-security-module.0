Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142826;
	b=qhKvMjjBiUjQInA+m4j+/0h69/BkObkL0AkHfdlA1mvPb/QVUmFeyh4QMFhrshHlpmlw
	 1rOk+t1EIabSkeslWplhVuGIoXo84Jm0XKbg7ZmV5NaPmneOwY2cWtxrQhaepAmq5Phpi
	 wt/DYFQ5/Yxl8TK1jZmtFygXzdcOOcBRBd5mcossN+6nsSQLTIwVw3BOEc0Vf70VesIOT
	 m4FttBsGIaAzR5E55Prl3vBI0BIUTWyKbKN74b0ZDG7rQjSYZcjm6AuNszAd4JpK4gF+u
	 ftCyrkA0m7suEU71ZF1ljYxUT7jempRNpPQv0lakvak6qPw8C43Wl4pwfnU2p6TRZhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4mJGcnbOikGC5pyvD8OjNMA3lgdYXd+q6xrFutVPm9Q=;
	b=KPbVh/n6VldytRRpJw9/ugRgDORJCWCsozO3hBQAffeMcRVxjD3y00z5MB0j9nO9NA2Q
	 YAwYqDZA4v8TdSCbfaPeucwMzjo2OY/1+89tHujmr4qeyXq0wK/ZrZTiTBYC23RGquAoU
	 UoHPGvZqNCKQYd5uOBVVxeXMh2Vwxepe92PrtZeRO9vprZNrgK2uJW24DEk7Sgr0Ndl9H
	 I9Nd8nUaaRGFvPbb7Ou8zzq9yyZq8fe5Q+j9yBH9FyanZicoqHbszpa9LlNMbQ/vazJs+
	 GSwmIgSDTikIPhfB3HwXc1IByMtZU+diGnw333VS4lp/kv8oIao7sEK1iGiBxbx2Lyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NEt8TNJs;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868C1606A31C
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 13:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 868C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NEt8TNJs
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so64499a91.3
        for <linux-security-module@vger.kernel.org>; Sun, 08 Nov 2026 05:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794142826; x=1794747626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4mJGcnbOikGC5pyvD8OjNMA3lgdYXd+q6xrFutVPm9Q=;
        b=NEt8TNJs6JP9BoXDg7rnJ+F20QyQc5NRQYgxlZU3sRUoaXEv/IVzqnWWf11uu2V+Ai
         lUtYTjuUCXGyyKbyNm/GqXcTa2jBPtl8Vwf3wxfZLFWQKYlo/8Xq2vAS3TN/UiM9khAo
         wnTZMpNN3nQcGWQ24x5ug24PXi8TuVLglrn6ZDn30jefoAQcOvkG9W3U7ZH1/JDfZZF2
         iFrkHMtTrYB8iluJ//NMdY3WnbHEevvP3uTLOByq34K+/TOrpSDQx3HJCFOgo7ZmJXeq
         I4EKrPmGBK3irLqcv4m9LsU/jvmqtbiHS3AIb/LbrMuZl4fwxhcHsoMSuZfF3VVvquzo
         umdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794142826; x=1794747626;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4mJGcnbOikGC5pyvD8OjNMA3lgdYXd+q6xrFutVPm9Q=;
        b=M3B46N8GKvW3/8ZaWIwo4eIllSq7zbgSXLS6+DWoCLxAzpTA38Lf1DHjnPdY15jfo2
         AY/fhu/gQUOb1iAgB3zDZ2so+5G0ZvJ0o4fnAVDab6eD676E8PKiw+y8Bsk5kV4e1z35
         EkW1Uky+sDeF9Es5gbdinivUa2ObkIRq0Iq9nBW4Y7FRFY+Jv5PmfiVoDrL5bLAT35ct
         VyTyDDlY/H/nxXJSxLlo7Qps0FX2Rf0HR+krRi+Jefo5/RuLsGtmsWdQgJlAVHbBOt8f
         ZW8aRTRoJGj7j6QUv0Ns4dkqDeiJRKPNHU/J5r2y7NfqUnAOas8XAVYS+/Bp4sQSsHjS
         m1pg==
X-Forwarded-Encrypted: i=1; AL+hErGr4sEzYWNHlGkA7zIXmJZFnkNZsRC85tdN+lVAPbLuxpOcTYBI0Yi4uMLSEdHKUcsBhFyAzL2puiyCNUi9JigrPBUg2T8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/erqsX1DB9+x5Z4zT0re145TLAWj9ZlYigXW4b3Nn360GLaT/l
	0j2QrWptAmcQ5COXBhpR/qoyf1LItQ34Ni3pJLRBPBgX4a6b4u4IIxil
X-Gm-Gg: AYBFou1pj6s9cbJaQ2X/hACMvwTJPsHQqaXjCTvblrHzPJnIVbzzA+F8IRNjR5byXbA
	+OqoxA8SYlaiJ2d6wryihJTjmdVZ1Mj9YgawOHYFhC8JoPDe4fM8aCe2SZsXOGu3k6dMnSY/cXa
	ncvh95BYWyvn5DkMP5TavvLszbiqTsMik4vtePM4l3QffDelrzYc3fv2judycx3jqCjDN0Ua/G0
	3zPX7+gFJC76AnU3OUJac7xOr0dVw5Fy26Jj8VaQlgAs8+48bTVjESX4uHwnLfxpF3IpAvhBI1q
	QtTn2ySDwD7FV02PRZq+4EyD+EXEdwwl8mWMpcoCuZmF2XFtkNeE0mEAZ/h5jvlwt9RZwYoXWxP
	rIwTWtbRA8HX9KANA/7dObFNiTcXY0x4Uhmt3LPIdghJSUX54aWpC0Es4NwSVh7iB4hs3e+Cb93
	cjj4G5iXJlseAYeqtEzaiD1gzRcrPrr4B+TK4utGkQrcPn4apaTPJAc5YRxba6Y3g4ghVk45Pi3
	DMbDHsfqrBH02AG8trk6LjZaXMuKeO1YilaFAqsZL8wFYSOCqp7peW7LHtlzdczEEhH4RiUgTzz
	F4/1s0oQJYvMt4LDC/UtXPUaUJUW1GooCxjJ
X-Received: by 2002:a17:90b:3c8f:b0:3a7:b260:9ccc with SMTP id 98e67ed59e1d1-3b12d5d4c16mr1111842a91.65.1794142825530;
        Sun, 08 Nov 2026 05:00:25 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.124.144])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b127970954sm2986180a91.15.2026.11.08.05.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:00:24 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] KEYS: Protect pkey method checks against type removal
Date: Sun,  8 Nov 2026 20:59:31 +0800
Message-ID: <20261108125932.77081-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <au3fT5HMq7IF-M3e@kernel.org>
References: <auy1ANMSKTXZb8GE@kernel.org> <20261105193632.34363-1-0xbeac@gmail.com> <au3fT5HMq7IF-M3e@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Fri, Nov 06, 2026 at 04:08:15PM +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 06, 2026 at 03:36:31AM +0800, Yuansheng Yang wrote:
> > Remove the key->type->asym_query check from keyctl_pkey_params_get(): it
> > runs without key->sem, so key_gc_keytype() can retype the key right after
> > it.  Instead, make keyctl_pkey_params_get_2(), keyctl_pkey_query(),
> > keyctl_pkey_e_d_s() and keyctl_pkey_verify() each take key->sem for
> > reading, check the key->type->asym_* method they are about to call, call
> > it and release key->sem.
[...]
>
> This is a transliteration of the source code changes. How this helps me
> to quickly understand them vs reading the source code changes and
> skipping this?

It doesn't. It just repeats the diff.

> I'd like to know what is that you are trying to do by doing those
> changes, which is the higher leve question. You should know this
> already. I see pretty much the same thing done for those sites so maybe
> that action is what you want to describe. Action taken, why that action
> won't cause any harm,  enumerate the coverage and address that it is the
> full coverage.

The goal is that an ->asym_*() method is only called while the key's
type cannot go away. The action is the same at every site: take key->sem
for reading, check the method, call it, drop key->sem. The GC needs
key->sem for writing to switch the key to key_type_dead, and
unregister_key_type() waits for the GC, so the type and its module stay
until the method returns.

Why it does no harm: the early checks stay, so the errors do not change
unless the type goes away at the same time. memdup_user() and
copy_to_user() stay outside key->sem. And key->sem is only taken for
reading, so only writers on that key wait for the operation, as they
already wait for ->read().

Coverage: nothing calls ->asym_query(), ->asym_eds_op() or
->asym_verify_signature() except keyctl_pkey_query(),
keyctl_pkey_params_get_2(), keyctl_pkey_e_d_s() and
keyctl_pkey_verify(), and all four get the change.

v5 describes it in that order.

> The above looks to me as if someone had literally prompted "translate
> this source code change to English". Neither much effort thinking  done.

That is close to what happened. I used LLM assistants (Codex and
Claude) to find this bug, while looking for other cases of the
KEYCTL_READ problem, and to draft the patch and its changelogs. I
should have said so from v1. The v5 changelog says so, and what they
were used for. I have gone through this description myself and can
answer for every line of it.

> > -	if (!params->key->type->asym_query)
> > -		return -EOPNOTSUPP;
> > -
>
> I'd drop this as technically it is not part of the bug fix and then you
> have pretty much symmetric action. Helps at least with the description.

Agreed. v5 keeps that check. For the same reason it also keeps the early
asym_eds_op and asym_verify_signature checks in keyctl_pkey_e_d_s() and
keyctl_pkey_verify(), so each of the four sites only gets the
down_read() / check / call / up_read() block.

Keeping them also fixes something I missed in v4: for a key type without
->asym_verify_signature, such as turris-signing-key, KEYCTL_PKEY_VERIFY
with a bad input pointer returned -EFAULT instead of -EOPNOTSUPP.

I'll send v5 right after this mail.

Thanks,
Yuansheng Yang
