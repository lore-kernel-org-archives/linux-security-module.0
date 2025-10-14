Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00322DC320
	for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483563; cv=none; b=iMS5MBCkycDYkUrYJP2qlYBXhoQBQXnfTIWjr25+DnzsCxTXBbcIq90EQ+ObPofm22hAFb86OMtKQHFw3NK/Qpg3FH2v3NfkOwEeaCV+z+65cfy+PKfwYRTz28OgtjTLISNmnozGh7bPtDa9jo24tVsRiuMDfiuSnQww3kB/szI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483563; c=relaxed/simple;
	bh=jP7eKKlEemoHr9cH5h7XSAsqHsL7E6l+1k/CdljmEEA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=aOqZxFu8lEGvUOMdqclc7tgFXYRj37m1edBI/SaAqLyYk88LSklgIPkUJtD8BjIW2gZ7hEb+nJZslFRp5PcCoL7OQiDkqpgNvf19W1Dp78Oi5uIcJwqlu/xUMYdtKbM8r2gI1ZpRNQhw34OFB0E1XJOeLx4tMQ4N0T/raJuVjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D+m1psg/; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D+m1psg/"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8608f72582eso412232885a.2
        for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 16:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483560; x=1761088360; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLBpXGvn84P1YsJATB/vo2Be6tu4bfzDW/H1Hf/uJzg=;
        b=D+m1psg/0sPA5QUhpnBP97dPq4bd8CQkg3Pfjl/zaOpk19TkocwXe328GVOZCPcJdf
         bdwF7+IjhxslyctHtjf5J4Bbm11EuFY5VAPTLLChUPFzez8fN2e0Zod9GjCK2ix3WHH9
         L4p9WOhLc3SBVfIMcAbMWc5R65PsdBM8o0rCUAzH1o9DlvaM8ILu56S2mFUBcCqELEJ8
         pDfbFHDNvlEsAJWlOKgythNnBcgEbGR1MPesiNfqKBVCLji0Ez0A3Pou+wzUD6cwyqgt
         uJVfBOP67LMupZW2bPSuaWPfy5Yx7m5WjsYovsIzuOkpfH8RqvJfmiQu1R6qvp6wuHg4
         8ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483560; x=1761088360;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WLBpXGvn84P1YsJATB/vo2Be6tu4bfzDW/H1Hf/uJzg=;
        b=nguCYN/ou2tRyLplyCRS2iI5hhkeLsNGe55dWtG4M+c7lwCSUP4tAkH+TherxN/iOf
         ayxlACtGA4uTQc7R0A+kY2kqukiixaCerpRQ8XWwhJfAMfdhs+6ymi8bzMe9Xy5w5jKC
         ZZeqnU+m+jddnp42LMQGTCqe8KPwpd6kqr6ySBnEqv8ZPEObZaEpIFPifth/5niijhkp
         gcBPVGsDzNoX6cMyDTgM/fBWs/nhUSyvXmbN0O0/BtuSK/SDupiATYBwdsMMUSYwroRe
         GUen3AbaU2BxaSxNRikQw7M7wOWjj3IqLaY5APrCBYFJU8c/NKw9FbW3zXdNI5NzvssD
         /S6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX/4PaYbFDvmQeWxXWjrEkFH8zJOdsG3VjQP8PqB5GXQ6J7RaO80z7P2LDQ4D9EzLLQB3c0bulyyDCkqKq1ASAdD8Gtbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJBA9VUgkScBTYUOwGdm3WVTpZE29rxZvXGae3zjyzmAFBn6p
	qqreb1gMZq9Wuqt8LfWQCw15fXwGMBa/TKHutKjHLGMfbASNs758o07G+J+8qgZFIeWXm69kD2N
	Bc7wNHA==
X-Gm-Gg: ASbGncuP2GfDFOImDqIeRr9QYWrWLCEnUowft/JsyXdVZ5QbuIs5qngL6IJxCVndqdl
	Eeid0tApqsZYgPGfB6fI3WPtziEosH3Qmra0wp0YbmFeeU53jVnS9cOanzlqB6XPdCWwDGSY8kV
	c9S9s2Kcg0eCPTHqBNx/V8yKN7UnGDatf+oX+BdV6C1pGwZKc3TxSm8IvtJu7iOZAq1nriXBfPa
	nz8trglCh8gSiGDomgVX3Ps4SsdUxqaOYNeseIoCeU3ELssginmgWiKYpp833WU3sEhV7ciwdsX
	kBiTmT598QWljHGcJMaB3PexSj/l9QUTSSVb5EEiSvHkr1fvqyGZCkNpYqAemCHG0klUjeTcrb+
	DkTc1zCLvaY+YC5goRqjNmn5cR+PJUtgi8BG3ClahD2PZYFsS6taqtOiV5YSkWF78zBU50VA1vc
	17/bIfzPKffMg=
X-Google-Smtp-Source: AGHT+IHHcLVZiMgSbPLG7eY76yfCqa2vB+jpgcP40CTtOHs38xnmpRUGPmtafOl88Gxs8UC/0Ltr+w==
X-Received: by 2002:a05:620a:254b:b0:88e:1671:2e4f with SMTP id af79cd13be357-88e16712febmr95763785a.78.1760483560211;
        Tue, 14 Oct 2025 16:12:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-88e1d60aecfsm23093585a.34.2025.10.14.16.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:38 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:37 -0400
Message-ID: <846555fc86ec02df31f55935e747a71f@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 1/15] Audit: Create audit_stamp structure
References: <20250621171851.5869-2-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-2-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the timestamp and serial number pair used in audit records
> with a structure containing the two elements.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c   | 17 +++++++++--------
>  kernel/audit.h   | 13 +++++++++----
>  kernel/auditsc.c | 22 +++++++++-------------
>  3 files changed, 27 insertions(+), 25 deletions(-)

Dropped as this patch was merged into Linus' tree during the v6.18
merge window via another patchset.  To be clear, I generally don't have
a problem with multiple patchsets including a few common patches, it
helps prevent cross-dependencies between patchsets which is a good
thing.

--
paul-moore.com
