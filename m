Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531C3C2777
	for <linux-security-module@vger.kernel.org>; Fri, 15 May 2026 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812944; cv=none; b=i4pSb1LDpkQITu5viVVrOj3waeJJFJM0U4XxNjDSbBaTUUM849jhMjL0rfeczEO2rtwaBijQ9GVkOLIHn6jDGTrdDmtB2RDFemY5dqjHxW8WtWOMfGCtMagxFEDVpJIuE+aj/GPrIjHpU1uJbHVIH2A6dydOhyFXCutTCAgHdpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812944; c=relaxed/simple;
	bh=s84cgZU+PxOHkFtUEmCMt5cz6GMpjzxhGUeHp5kdZHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTRDosaR42XkyYQhwTYohRhUoxWAchrzsqPYoJfkrgYn4gSRmlRa42JLMge4pawGzhe9YPej5AqX7JdFfwWqlGmhPqCw48bqINYkpC7/cW8BAsVsrVeKD8o37ZIdFd9wPX3S+XjHdOQXutE2+H0iN7uqVwg+kZKXq8IcQFvoNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2m2i4bv; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2m2i4bv"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f3c623322bso14710881eec.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 19:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778812943; x=1779417743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rLW09dDhgcqjvD8OY2KOZGl5mvXel79GUCzEbR1uwA=;
        b=n2m2i4bvX66bDIjR34Ue2gm9m78aBax4qkKlKqWNdPk7BQ6vJGv+wt7GbZGXLlflW5
         n8Eab0nblFoc6FvrkeFC35CpCZm8Ccf4n+Xabc7pNFxtegFk6uHuv/vUCQmTp7znP0Pu
         EjQSTLsq9055ojgmHtn3jDsvazgabo+lcQJG0vkR2g0/iIDVARmTQmgiRag4wXBmloQi
         zB4CASi75DQ0kz2bxDnEaKnlRWq72AWZsl+oSfOaMgJbDl6XKr+PZzo6MqGehx5C77d5
         sNnoO4LN+6KFX1OVGmB/iRMgPRpL4pe+3zAS/VoDerDPmGzYttcbqjcbTblKT73J9mHn
         LDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812943; x=1779417743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8rLW09dDhgcqjvD8OY2KOZGl5mvXel79GUCzEbR1uwA=;
        b=aL/1NCq0KEA8TMuz009/gM7UKDYbw7UXC7GUH177o/XtbkNUlROkKRTOn/nvYy4apc
         eD8QyTKcLhPIOwj2OSj3+Zg3aCSnOLNejHhTyg/dys7VgDFeYtAyNEB77fe+kaRmOfoN
         c6oYyxDM67Hq4A1E5fIt+SPDpC+msZxSriWibN+dmqt/EjJopq8lxLRyYrDeoKPNd/Rp
         5dJRYaTxun7VK7QZCDfk/Rc48S3TphOqTQpn4FmQ+SQZoHlcyTaVe62a0+GVDD11mOWl
         DFuGZAUED/SDVaQovIPaC8VThHJW4kOMoPkiqZHkP1vI/+j7kP3TYcqBqceWg1opfg11
         F34g==
X-Forwarded-Encrypted: i=1; AFNElJ8wXWjtwy5jOjytsDjykfFvOIHwn1pPE4HB/Qkg88DfSE9N7WASLC8XHCiVptWQPcL30e9dLO5F+3UGoIq4xjomM5ll1A4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgl81qhteBRupsJKA+cOuM3Sl246Nf65VJqCQGyxnUC0pp/WcV
	uIswefYYHCsPi7r3sfBpMXQ3FD1f9XmIEcbJk+GfFOtyRln7ef5omhI1
X-Gm-Gg: Acq92OGQ3NJYmSuktXTvp5YVqpiN/HvcfbSuqQNjqXRiRLSH3ztchHyfUSzpcw1FsaC
	KmyYRvBtPR6nG9Rmk7977WC2Wj/9l0Jb1S4W17CE+jJDMLyJSpFUoGN3nKd84U7GajRr1DDVMvV
	lSGG2ck3aG/P8PKyhgrDHUIrWuLh6jDBks8q0TK2E/mVZiw0ayiZ4WtPK84+xcbiuJBsZl5ajko
	0P56slgSvkFLp1HtKZW7tyNeMWJAXc8TuDam/3phZttL/erR0tSheqi74bz8VQp00s4c3l03Zqo
	pHaN+85+wk83YoPKn7mUer3SUC/3r2PjlwaX+DUCpQ2QGv3Fn1T4m5YU3+xfS5SBuwUGrAgyKJF
	mkDrwPzLhQWNtJdn0YJx15V5wvTxbUzE408b+Kn2tmxLyzA7xjxngaCyPwXXSQwDPMVsFNrV1ah
	ErOgdyJmlkCpQz8gTg3IofvjdPMMmarTcd9sf7j8g/9b89
X-Received: by 2002:a05:7300:dc97:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-3039818a6damr1107563eec.4.1778812942627;
        Thu, 14 May 2026 19:42:22 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6f6sm6288605eec.17.2026.05.14.19.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 19:42:22 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: paul@paul-moore.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	lyutoon@gmail.com,
	horms@kernel.org,
	huw@codeweavers.com,
	casey@schaufler-ca.com,
	linux-security-module@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net 3/4] netlabel: validate CALIPSO option against skb tail in netlbl_skbuff_getattr
Date: Fri, 15 May 2026 10:42:16 +0800
Message-ID: <20260515024216.203957-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHC9VhR52b2FbD-aiMFsaXwwRrUGTLSdRFzWcVAZjUm-K3qgkw@mail.gmail.com>
References: <CAHC9VhR52b2FbD-aiMFsaXwwRrUGTLSdRFzWcVAZjUm-K3qgkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Agreed, -EINVAL is right.  The bytes passed parse-time
validation, so hitting either bounds check at consume time means
they were mutated after parse.  Treating such a packet as "no
label" via netlbl_unlabel_getattr() drops it into the wrong
default.  v2 returns -EINVAL on both checks.

Will also drop the Smack mention from the commit message (Casey
flagged that separately).

Qi
