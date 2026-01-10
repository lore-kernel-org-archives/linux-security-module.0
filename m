Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C424DD09
	for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768066957; cv=none; b=gDVV1aWI4669YkzsgxX77GG1F7lbM7XVeICUTUblXuFgRSHJqiVIDnkJj91qPAEJ5k/oq7Me9rurc2Yi0iXRq/Z4ok9JCiKofr6meM169P94nDDFi5c8mx+OjBvmrem3VQZ7yqr4bA94unQxcR1ldKYu0aAeQzkpTaxzjqfmu58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768066957; c=relaxed/simple;
	bh=iqIAwsSkH1LRn7DpHN+juv5RfTbIQFu9fzTgJJtz8f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWXJIwqQWXktf338n7PV00dqnSS1uMfPJl0vzWkTmcqAn+em6qa+g5kFUST9JJgvwT8tQ17CetiBBl6BMkDnnKPbUCwXqDmVycd85yhx10amDYNphGtlgrG0F/xdeENvOqpU2tJUvJfR37FPPKYbPlH/cNbohGZ/xAqQ8wp5L8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj3EOFkE; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj3EOFkE"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4f822b2df7aso72173141cf.2
        for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 09:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768066955; x=1768671755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqIAwsSkH1LRn7DpHN+juv5RfTbIQFu9fzTgJJtz8f0=;
        b=Tj3EOFkEOkUBrLITE4ibuRIHAieZZLy2KXsaiqdi3wWVitahUC91NRX/b22ls0Ui4m
         PWqE9RpARVUO2li2zrBGUIEhp1v7tt82xU8raWwe+h3eYqcKMAL+g38YRdUzhlNWEh8r
         AaY53AolCM8MaJ4jAEWx8ZXkosjcpasfYmg5BJCmTvenbqIgpS5+WPHMM6K42BYg/mnf
         /HqGLflv1sg/403MwNO9faY96YffHXy1Z4/XoyPKfc/n2TN2kgIaQsOfsNVa4Ups2qIo
         DfyzwXXDCTDPTr7DZsk0qSJW7SwLx0xaNMx0Feox+xf4J71Ci36J3bn12o1Qaru55GeL
         GwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768066955; x=1768671755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iqIAwsSkH1LRn7DpHN+juv5RfTbIQFu9fzTgJJtz8f0=;
        b=ajYJ64uvqvz7onIqu68YgJtFx9KDUch9hAts5N8FlBRh560kHLfdjyouQbn6DmZ3CK
         gP6/Fr9S6h0Xc5cSRcq3QOM1PUlMLbEY0/MLTLUYjVXUE2Y2lMYHYVJI790gJO/mySRr
         SWbakxpxo59m5E5wXXMTidfATYKO6DF6QV1a7l05P10bQnZkLNB+cXjq6kcUnWFuOda5
         4WQHHOcH6DzRarNEmIA5dkeVG8wn7YXtqxB8HEJW2ZKBBmzLul47cK/N18wwmPPWhC5Z
         Z2xvq5kjRFn7AMrgaLlaSvAWltnebsKkk37xr3WqIrlqC9tXqt3AmfzBOYv+cPSQWOiZ
         Nsvg==
X-Forwarded-Encrypted: i=1; AJvYcCVghbC1DsoLDzy4mmCgbHf9EnVp/TckIy2TZ8XtZxErJinNcesRUmTonhY8pOEfZcAl3H7GA8XpsLi+F3dvtjZtNKSlJMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyyz6EXIXk00mbvoSUJFy3reI120OdJd1Ka714ZKVLjvOJnq8J
	N9kFKIKLkSjS3LAUwVUsk6Em9wOrt1d7zZR4TwLUinfoQ1qY+YeLixvbyw2drg==
X-Gm-Gg: AY/fxX5XozpL5FxdrmabXJO7NKDfyE0ZLv44TiMuJgbVj04EIP1izNULMGqNsQ+kI/L
	KZBHylkP4zqd1LzYeZK+fdAan3nbSrsRg4Iu0SxwLtOETwq83SXEXsVhUaoT7wqN3GJL/d21wW+
	7IOUVKSblKcmBigRVNVrUh1c8uUirSRmefFaUvgG4dokLVvId1db7cqF6raGdfbbtjxwYhcVYc+
	/ET+R+CxVV+qf9OD1tyMg8aeKW28eigLWb35LD5xp35wn2Agtg9D01fKJnItP9674lVfr18nyqb
	o8FAjUhBR6b862nAHdUUH7//ouGLsYdm7Es8eTyxogkhlaWWrXac5uONY9Zb22svu44t0JMEg91
	uCkoESqctXux7ZeC1nbBUvSDtMOhnKh49fdvzDQFiNF7dBdtS+3vX8cO95z/OhDdiMp0bmpaB7L
	Ul3K5rUZa/LK2TlF+dRJiHBEcHAUHgD4q5wvy+yKX0PiwGZYH4u5kzxu9Q1X+clz3VzQa8+lNpX
	TyLN9sc9g==
X-Google-Smtp-Source: AGHT+IE7ltzgQjoPiBN4Yv2Js/6C6/LS6t10HZYVZxNM27qcbS1X+Y/3pfVEOz+ccq0rpo3AXUIhkA==
X-Received: by 2002:a05:6a00:438a:b0:81f:4ce8:d641 with SMTP id d2e1a72fcca58-81f4ce8f745mr183507b3a.37.1768060842363;
        Sat, 10 Jan 2026 08:00:42 -0800 (PST)
Received: from server.. ([103.251.57.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f36f88f4bsm2513245b3a.36.2026.01.10.08.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 08:00:39 -0800 (PST)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: jackmanb@google.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	david.shane.hunter@gmail.com,
	david@redhat.com,
	edumazet@google.com,
	gnoack@google.com,
	horms@kernel.org,
	khalid@kernel.org,
	kuba@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	mic@digikod.net,
	ming.lei@redhat.com,
	pabeni@redhat.com,
	reddybalavignesh9979@gmail.com,
	richard.weiyang@gmail.com,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@suse.cz
Subject: Re: [PATCH v3] selftests: complete kselftest include centralization
Date: Sat, 10 Jan 2026 21:30:27 +0530
Message-ID: <20260110160027.128949-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DFHI984SEFV3.2JL88CLHNT2SO@google.com>
References: <DFHI984SEFV3.2JL88CLHNT2SO@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey Brendan,

Thanks for the report.

This issue is caused by my change that centralized the kselftest.h
include path in lib.mk, while the x86 selftests Makefile overwrites CFLAGS
with :=, so shared include path unable to find kselftest.h. The fix is to
explicity add the selftests include directory to CFLAGS in
tools/testing/selftests/x86/Makefile.

I have already submitted this:
[PATCH] selftests/x86: Add selftests include path for kselftest.h after centralization
Link: https://lore.kernel.org/lkml/20251022062948.162852-1-reddybalavignesh9979@gmail.com/

it has been tested and confirmed working.
 Tested-by: Anders Roxell <anders.roxell@linaro.org>

Once that patch is merged, the x86 selftests build issue should be
resolved.

Thanks
Bala Vignesh
