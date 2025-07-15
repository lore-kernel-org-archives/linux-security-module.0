Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AFA2AE99
	for <linux-security-module@vger.kernel.org>; Tue, 15 Jul 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569181; cv=none; b=s+dkEZkf3a0aZw2iz0ev+lBI5FyTovZi0ckHxlGgk/zYHMTUn/eGFTe+Apnj5iIvp3sGODkb9Q4KbkPD6s3wFIimDTgl9sgbncFdnfsWZG9eAUNa80p91WZhWSYH0pObpoT8JcJ8/r5K4p+dGqfRIG5xol49ZCuKMufoPNq8FkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569181; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NSyWz8+K9B93woXLGRi6jkw4QZd0Vim32XlKmOREcCj9eJjAvDIKkEoZcSfy0thbHZAaCGvlK/j7PjRJo0N7C/aXwnHTt4W/e+oPhAHHLraS5JeyoJd0yK3lRZfdv6JmDBbaKvKJB9+VKhMsLihz5cKBVu9wSFz9xlDj/9gYsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJzWIdzY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJzWIdzY"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso4239661a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jul 2025 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752569179; x=1753173979; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=DJzWIdzY29FBCFsGd+SwpUw2rwqRL7K79M65fusLD94EZKDyU8NDTz60ScAKmSRB5K
         ITAMr7iKwNtDk6t3NTl0Is62kHZAY1N1pMgBZ0AuPLYT9LwY/oj7x28urVzdguvxc7Do
         E32KNr5r4iPHsferQaEEXXiDgesUnSg2HT5d1uyvVNgG/jN8i/6NE4HRHDR3OrKSoFiC
         N7zIcw3bIGNhq/SDTsWGnN4d/Pn21S1ciebJD820750Ct1J4khVAQxqGoqDoKnngSmdp
         Nq/hSnv7e2f/2gROiM1FzbZHsExZypZxARer1GyRVn+VImFrSIGFiESDNlGvF2Kg8RlI
         CQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752569179; x=1753173979;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=l2ierSQ5IlEQ/RQ0V3JnlUBxhrwcnCmwdFsJgq9/q6gPnWxcDz8YlxoigyiMNLKUCP
         vW0TAzUC6rJxjYApx+nMd9B6fFAp4RaXDxVpDpW3VgDrfQAJjZ/kcHlZ2xdi66qdKVTC
         lmuiHz6TTG/jlOTd4lop9a+wHBBFOq/URnduFW55pXlO2wjT8lUDAyA8mP9dn70YmUra
         5MVv3C3dbAiBM46BeprPxbqrjyj/l+K9FdoWUfdYTXwtoaQoQ0xeJBBPMjo9uIA5POe4
         hRhrrh2KaPNSoUL3kg1nX3a4s9Mp6604VjmKDA3MUqFqbdVRhlTH8ORS+76/HSVpCXfV
         i1MQ==
X-Gm-Message-State: AOJu0YxPaa0Uqlgr8BmqZswnhfxEdwq/r01tc+ZD9uA56peDoAV6yX/v
	DzCM6tJCVTCMi45SnzLwiq8f+C5sNTUqGIUchDLY4xJwVYqnuJBdIqdpbP685FOtzi7nV1vKWdI
	gjZ4N0mLjrW+HOK+vSbg1/XY/GYZzL3fuB4Py
X-Gm-Gg: ASbGnct7BXFieTGmgSusryubhA2OSnOIEj07gk+m10AWk18vHAqmRLDge1JgqqRbsb3
	D/j/rx7VJY9gKbos8OlIE9Pxe0vVt2sDq2UAcLg58fy/Gb51z3Y3vNMKTBRcOxWIihjSy2CHeFm
	fM5tvH7ssnyXWtbVQcMCH+DjDVrbdvJHTQDwaA74Ahq38kP96CUHOuxVraBERKBjuvIOmdF3du3
	l8YdxE=
X-Google-Smtp-Source: AGHT+IE9qe1YJWIstxtAplLWj3pjGiAFNzhkuhtH5wpXmrdmlxPU+sE6x8b/Wo6CpIOaydt8/PywlWSvY6RQsukIe/0=
X-Received: by 2002:a17:90b:58c8:b0:315:9cae:bd8 with SMTP id
 98e67ed59e1d1-31c4cd87c8dmr23184304a91.23.1752569179223; Tue, 15 Jul 2025
 01:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Haass <vvvrrooomm@gmail.com>
Date: Tue, 15 Jul 2025 10:46:06 +0200
X-Gm-Features: Ac12FXwZKEFYpYAtv31q_vRPMG1mujalzlEOHAe8gSOTjUxa2Oc9TB41d-XZ_4g
Message-ID: <CAH3oDPypNSOMYe195X7+LZ7kaw97-EEyKvdkNjVVs0B9cMywJg@mail.gmail.com>
Subject: unsubscribe
To: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"


