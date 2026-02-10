Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769F0327BFB
	for <linux-security-module@vger.kernel.org>; Tue, 10 Feb 2026 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743777; cv=none; b=VnaXeZjEqOtNi1ru99pPY+4xiJisxdPjUa/L2XUyrkoGcW6v/73UqpYjichicKH9euLLG0aYL/1An0qQnFx02QyInQXjRTBPLb6OQgB83PYRSu3SeSpX+50CsKWczbZEAfhgd0WDciSeC0AfHJ7wodRPYNl8mIj0gwQiKUogTew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743777; c=relaxed/simple;
	bh=nUcnFETHII0E5rlg2qpCCtkxf6FnxvfXs8nFpP50wMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkg0UOji/f4GnOuXB3r9mIn+0JPMsK2GF7ygULvaBydDkhHf97durmdeoZrJvb9PDP+lJ04+kx3E4Sc+hsvdgk/FXnLjCuokdN2TuqClZiw9isWCAEpiL7vRQqWohu8g+CypWQ98k/HjwfHdB/spu+R5jSdvVnXGesoWTUJMg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2jqyD92; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2jqyD92"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4359228b7c6so2886603f8f.2
        for <linux-security-module@vger.kernel.org>; Tue, 10 Feb 2026 09:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770743775; x=1771348575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMHj8ip2bDcru9Om4PYAVrUfxZXZ6ZycN6CABi5KwTU=;
        b=h2jqyD92Ra8faD6auyClFadlmMNYFfuYKbq3/CbTPhkEeMXeRlL9/poPeuIN4RGD7n
         NGrBjYelTgon6c/R9rWQ1eKu8vCAcTtg4/eTOOgclzdHoO3wV68wlIqD1R9SFyOmOyqW
         LaGT58+pvFCxte/UP5deMmDvb0FF7veVIZh6PhoiIcwnqPGy4C6e1fkY/MccnrY/MELY
         iqczI9zmHq3zp9+iJVfW3ZtNG53YvdxtSu3eDWxPy/kM4Ycva6W9G6mWxo+r1eUiL4G9
         RJZZGUhS3+AB9LmEe1e7T7LrwFkXVJzw2oVlF7r07E6gP6w0/Yxx4AqGeDDmHPKqmBwJ
         dpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770743775; x=1771348575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AMHj8ip2bDcru9Om4PYAVrUfxZXZ6ZycN6CABi5KwTU=;
        b=c/j++2UcIkcRAJ0peiqSV8bKB3lq9Ya71OzXN8XqUQkA5AsI6/pvuRPkkna2ZX+6hx
         X6uvSZrMLK8B+PjkMZMyA+f01TgUKmrx4A9vhfmMkLVK+kpjXmFJ8u/IOj/BPbKf+YIX
         3hw6Dbbp4EX0yWZh9uUzOVYVpyiqamrEml3XrtR1lxmTATeA7/+VTHlP/Bck8gJU0Kjn
         /W50akOlqmIyNEKRTktxzo1KuGn4CoOQTnHNx8PjVv4l7Bnjj2jGrM6ivm2Il5ayRn1H
         ExWa52wKtFVkSDylM+ipNsw8FJTHl02Y82kIc8EXjKKD01gqzroN1lUrFRd+ROWQS1zS
         LL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVESvU0F6kHcRqtlx6RV689v1MIl/+ykbQOivmxmP9h4c0JuerfSa8QkSl/KzFPep7lXFLlKDPqaCbrKEMubCjafKs4z7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHpxTZ+JPMx0unKXtB66v1PWTwJl1G+76VDZh7o15pNjWUICDc
	iir+8DzIzzrjYh46Do1IAHUd3XUnI4KrhUC592EoDb0BBa68I4XkkcoY
X-Gm-Gg: AZuq6aJXinEpAUasMCzUyED6ZOFqZYstKtHEFzEDnGtSk8l/zs6M60tXkJgsqOxhkmw
	DvIcb2cTQX6Qt6AQ/1u0mfdBzEVG1haFooPT/ZYXLdnz/+2aQY8YGPoAZ+/XTFTGE6LvaSQeRLH
	Ix1mM5IkgeeZIOk/1ViD3cIcpXsnMxhmhokuko4IxyqsaFzHDdLSEZ7a21weQFe/CtGj2bnjAzZ
	y3L+Uomnyw2QxSfnowNjerhOtaEuJaJTLYYHBbMtkZIOODnrp99kZZlhWGWA9ZhHUkdCIbs46WO
	NtoahMt3a3BRVZvfTlJr2cQs/nzetF6T8VFqI+Pg0rqalg98CgftfAOHDuag3/R2zve2Hhck9xZ
	ueMLmbMgXPn/pMGAYcZcTq09LdzfxHJbvNJrDvViF5J+muIH2dbMfjvr39XstBRmsA2kbDmrWzA
	SfWBh6ZT+IQ6zHulrgqBDzBbhrV0jgB36/BRYxE0ITpHOZ/+JB+dTThRjh3h4Gtw==
X-Received: by 2002:a05:600c:6290:b0:47e:e78a:c834 with SMTP id 5b1f17b1804b1-48320226676mr252050135e9.34.1770743774563;
        Tue, 10 Feb 2026 09:16:14 -0800 (PST)
Received: from geekom-a8 (net-93-66-82-32.cust.vodafonedsl.it. [93.66.82.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d7f1e4fsm97562565e9.15.2026.02.10.09.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 09:16:14 -0800 (PST)
From: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
To: john.johansen@canonical.com
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Subject: [apparmor][PATCH] apparmor: fix signedness bug in unpack_tags()
Date: Tue, 10 Feb 2026 18:15:38 +0100
Message-ID: <20260210171538.534950-1-mpellizzer.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aYmsYRgv3VClpkjX@stanley.mountain>
References: <aYmsYRgv3VClpkjX@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch static checker warning:
    security/apparmor/policy_unpack.c:966 unpack_pdb()
    warn: unsigned 'unpack_tags(e, &pdb->tags, info)' is never less than zero.

unpack_tags() is declared with return type size_t (unsigned) but returns
negative errno values on failure. The caller in unpack_pdb() tests the
return with `< 0`, which is always false for an unsigned type, making
error handling dead code. Malformed tag data would be silently accepted
instead of causing a load failure.

Change return type of unpack_tags() from size_t to int to match the
functions's actual semantic.

Fixes: 3d28e2397af7 ("apparmor: add support loading per permission tagging")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
---
 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index e68adf39771f..dc908e1f5a88 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -835,7 +835,7 @@ static int unpack_tag_headers(struct aa_ext *e, struct aa_tags_struct *tags)
 }
 
 
-static size_t unpack_tags(struct aa_ext *e, struct aa_tags_struct *tags,
+static int unpack_tags(struct aa_ext *e, struct aa_tags_struct *tags,
 	const char **info)
 {
 	int error = -EPROTO;
-- 
2.51.0

