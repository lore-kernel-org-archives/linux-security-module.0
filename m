Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795393279;
	b=jY75xqNd0KHfEmScFZXOl5uGvjKEp+OztnlP8ycTO++64QtAD28PoX7ACo1lb2icUK7D
	 vCp5dfpXcwTU+2cIQbZfzO0mLsUf7iEuRd/K+cqwGeELCZ18QIJrt+GW8Co0OMKJR0mx+
	 iiHSJ/DGRt4ZwjLtflJi+pcb/3/bGo7hc/7peZ5o/jyh7xp8fdayBGZzyQ/1IiaQWKY7i
	 9GTL9QUNC2tuv/EBLjHFC1DqSklLr+LtU/PATN2YBE+QQ9hLRoiHJwIWweoHxVujdThGb
	 xwlBDPZWLIaecml+TXcJX+UPaMW3bPzUq8KuoZ4OpYdVnyXLdh6Q//iFjSm1d0ntpyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795393279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=KF23iyWwR5yZnzbUCvNMaMixSGrIyVPB1oghCsOfI4k=;
	b=VJOdvwtXJ1Q5Y9oqN1QL0FqwMGJUzS08dneLq7mwtHKEgkIRq/lAuJbw5n0dPUcmOgAr
	 SmQAfg2t5eYs18uZ8/gfxGZBbvfohPYvFFlk8ei7UX8FRhJG1Bil1r4rL/GO9sqdPmGfU
	 pJKlIz+RYWJdI/JEhFEWbQP4IAwxTx6q8Ha6tl90DtIOXY+DZG+ZgzDsOJ4cMSdVZx5Wg
	 qMZs9IReAPAJuIrEcxIJem5XZRt35cyiaJssU3Ge6DQqfZiB5gSMDfT2uYL4TeFYlA2Qi
	 f/RqgI7wCzFQ0wYhuW7b9/nA2nsg16ik54qZInbBbtFOYmpBiZsH66ezEvSDY8+58Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ui7qLXEe;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25336606A31E
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 00:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25336606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ui7qLXEe
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cde827b7b95so295772a12.0
        for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 16:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795393278; x=1795998078; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KF23iyWwR5yZnzbUCvNMaMixSGrIyVPB1oghCsOfI4k=;
        b=Ui7qLXEe5JZSNGGNnJt8YRoCIU9BozHUuGdwiGGRpRdbVOmZeySJsVDdurWv9z6VuZ
         VmOigNcxpt4gus56H5t3tfeT+jMthzm64QEJc2zAee84tuc3roRSTwD3Kv0m4dUfr0F+
         4ugqeQMPjbgSS4cdMlpNKVGn/lbd6gTEqFW9TDBlFLcgP5yn4h8g99RzjC8XXY/+LFBY
         IwZpe4ZfiOfxC/PDMkHtsl7/7xATK8AceJkZH0IS98SuaBuBBITDhuqsEsnfsOQEZ/PP
         u3myvmJEKPylm9aDUWQ7+IckA8eVXYDNm+iIKJa0jJHfttZyD/rjsrlkR7z95OGmKQPn
         RqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795393278; x=1795998078;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KF23iyWwR5yZnzbUCvNMaMixSGrIyVPB1oghCsOfI4k=;
        b=YrMk/a91C7HR6f+hQKD4xP5/mCocmlr//a5im+SRSRv6mSiqU8fON46THqnng3d5U+
         jKdFMMrfdhoKklj+ptP/r2i84++EVZx8b5BWgNr8Ocv2NiF2RXa94fkotb9/XxNOr8pK
         x8P55kLtM5J/tmzK7mNIItn1TQf8j2Cd8HUwD122PpsP5lKs5xj1yHoPo2ZMsLmLUgGL
         /vK0S09uQsSnntoG2i4PbXu0SDo0w1DUxaHN+REjQ07jyx1HYcJ+wZOq0qOhSPx3Y9mX
         Wba81zkx4F/otB/3OMkAwsllYzB+GgzgUWsKfQlBWHbWGQ2UVA9UxYwHaRyTeMs7/KFb
         3f3A==
X-Forwarded-Encrypted: i=1; AL+hErH+F5BXjjPGMoHfplEP7F/0CC+nV0MrKt3RWzJGT0Cagjx2G8elY6x+lWu608QUxaAwl+1Tv7D5lw7WfbSmzNXI6NFAPbw=@vger.kernel.org
X-Gm-Message-State: APuU4Z88B9D9cnvxaM4O1Wzvhav4XgeHkyGSliXZsN3/hh/I89LZeyDz
	iNJjtV3Urglqxfu1WrOfTvbgG197I/V9toFLAjZJRNhTdmFTG3eNZojf
X-Gm-Gg: AZFdTZdZRBXMiJpif/2voYH4pS+5ey3leh3++j679M2U5Ar2UYknpIl/5naKlvfc1Oe
	5ze5eNEtmgVr8qBMXiGvshKmREN+GlKe6v+tE+ZFo901y+GS/nXHCsaK0H107k5pVC6T+rNifkK
	uCZ++wrAopkGsanjDjuxkH5ku6tEEHNxxhy55z74h9JXNw3Ose9cFPA5C4YJ0r00B/DoMl0fTDG
	FVAkq44uZO9S5iTN5jEqnGLYfS9cWLXD+mkJnxyaC4d8shCSZXNQSdSkgt7JT2/9g3mdA52yN+l
	QfgLtlI0O8yezzkYGNVV94Cuu6P0MTC2Kl10N7qoDlDdXwkFAMH8Cl4W34+oGqPFWE0dYruR6NU
	p7jlNZ+snCHhd5uetzZf0z/WiP8AtCee2qAmNC6rzH18EaSXkBrOQ0CMU9tZgMyvZtUh0JnKXqi
	eQzRhxJ4TZmnXd1Z0xVdN6uICF1AidT61f0xQ6Kru+Epxa4ctI6EeQ6Pxsv9r9NiU25LTLN4AEd
	A3Ll/zUjFwhuq2E+kT5F1bXhdjE9NGQy5kHaAR8FkyNLAh5P8a6/3qtdY7cVlWSQidPjm5iRC92
	6FrysOCXLE3OQxZUAaQNY7dS2xSsQd7lO72m0bt8p6UZcMefKXUTdS+j1aVDIPwpB6hO+QNzqnR
	CHak55AiAcj94lq1R+eTMVyriI5eYsoeiyrg=
X-Received: by 2002:a17:90b:1801:b0:3b0:9984:18c9 with SMTP id 98e67ed59e1d1-3b41c8e16efmr9088622a91.11.1795393278264;
        Sun, 22 Nov 2026 16:21:18 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b8733e6sm4860403a91.3.2026.11.22.16.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 16:21:17 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 00:21:16 +0000
Message-Id: <DN25ST0D5K1J.1NI5236BF2BPY@gmail.com>
Cc: <bpf@vger.kernel.org>, <containers@lists.linux.dev>,
 <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-security-module@vger.kernel.org>, "Aleksa Sarai"
 <aleksa@amutable.com>, "Alexander Mikhalitsyn" <alex@amutable.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Andy Lutomirski"
 <luto@amacapital.net>, "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner"
 <brauner@kernel.org>, "David Howells" <dhowells@redhat.com>, "Eric Biggers"
 <ebiggers@kernel.org>, "Giuseppe Scrivano" <giuseppe@scrivano.org>, "Hugh
 Dickins" <hughd@google.com>, "Jan Kara" <jack@suse.cz>, "Jeff Layton"
 <jlayton@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Josef Bacik"
 <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "KP Singh"
 <kpsingh@kernel.org>, "Lennart Poettering" <lennart@poettering.net>, "Neal
 Gompa" <neal@gompa.dev>, "Oleg Nesterov" <oleg@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Serge Hallyn" <sergeh@kernel.org>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Zygmunt Krynicki"
 <zygmunt.krynicki@canonical.com>
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20261122193539.3334213-1-jarkko@kernel.org>
References: <20261122193539.3334213-1-jarkko@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 22, 2026 at 11:35 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> v6: https://lore.kernel.org/linux-fsdevel/20261122011809.2667684-1-jarkko@kernel.org/

v7 was sent 18 hours after v6. v6 got replies from the bots only.
v1 was +2559 lines. v7 is +5782.
All six findings of sashiko on v6 are still in v7.
None of the seven versions got a reply from the vfs or LSM maintainers.

The way you're spamming people you're only reducing chances of anything going in.

