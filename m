Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7AC38BF60
	for <linux-security-module@vger.kernel.org>; Tue, 24 Feb 2026 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944217; cv=none; b=sMUG4mb18LtQfDGzhoDFWT328RYQ75W4qeefsoreOaOxJUhFvqqSvhlZhPj7MkJRWTlz6DgxcDY/mvd8Nu0yFmOzWghL6zG9RSePnsRMM0lPDXITfSQdOXrxImObPuPnctoGH96+KiaLbsKUgEsrhb9JacLJHHNQC+erKjJVMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944217; c=relaxed/simple;
	bh=49VT7mN4XyjuEankpsfUwF5ENUVjd8PIzkNyE8/ZPOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX4dgxnc/MLt/IW5TP7q+lwA4+6KJVj2j5diXHMmEfIvf/W6iZW/4nRCI1YTTuWJ8aT8/SdW4wGrnLfYjHKuqUi6ju5otkwQuK6t+tE/Uh2ROcuADvte8UMVs3XkKOhmPH0dvRMEe8EsU9ngFvWmpjI8v6tUjbAYj34+UordM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LVYFb3/2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVYFb3/2"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4833115090dso54262285e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 24 Feb 2026 06:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771944215; x=1772549015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=49VT7mN4XyjuEankpsfUwF5ENUVjd8PIzkNyE8/ZPOE=;
        b=LVYFb3/24rMXuG8pwlnJDjWA9xHY4WupMqX4dWK9plmJ2pMvaKCLlxuQRLD9LgZ5IQ
         vZOAC6FFzSj8rWkOSltQtBkdL8MCbr4Kj+wa9LEudx+F/NyQZzxpmakOqp9Bd2IeDVS0
         qGL/km2sdVXdMSLizSwbCmAiY/aWjEi3xpZO8rHJ6bO3WxK3dYloJYA5rSL1gR8/8yqj
         /R6skGairTb0N3ks4HtYAHFHkz8MKSUx/lh78pBVfMqeIOkICBmPXFYJtUCKh/J4ywZ4
         gkxrosYqJ64MuPQNRodoICIrAODMeVvDHXEenju6uMSZ0W3H0TgbWs4TdCweTE7WbB2Z
         49jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771944215; x=1772549015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49VT7mN4XyjuEankpsfUwF5ENUVjd8PIzkNyE8/ZPOE=;
        b=q4l4JKZk7SPP/KjUjvS3Ymn3prRAxpXB6UXLVPZnlBOTzC9qk1NvibCQjOgfdSgVZZ
         o6mhsKJmlLuSaqCD9kOmz6D9m3iDYkhBgQTv2zZvvZ8LQRdfGBGkABvo7GdoeBt3/lWA
         pOY0akaF2mZGIastK4upS7T4qFkBlGiaJN09DmxcUA5AbhbL9FNdzpXolJAbso5cQWOF
         9LkBHWVc5kGVUS0Ae54jut8nFwGx162i2ecaHZqwd3t/xSv9oTV3S3QAcJuFtvQLjnCB
         w5MJBRFLSfT0KIfXeH4X4+07JFKIaYQ7gr+GcWgtsHUyhsEYrKHKbNkmS5qRNPHTr8C+
         xM8g==
X-Gm-Message-State: AOJu0YwcBYk6KG2pdVWYKN2fad83Q+ewCCy72Uq/NN2dGkqId3Fm5hKo
	JjqCjQddZPn/wY3sWqoTnpwbQSQgxjbx2dXdc0LejjVHqc5gLnE/1oDsDo9xdzl7NZQwJxBM2pv
	6DPKunw==
X-Gm-Gg: AZuq6aLIiC4cPRvQ+an1twRjlqhVQ+n+rmlicKvFy/c36VLNSZ4uE3leWPubWLlbF+Y
	jYCYhN8hXpIhSCjNgU0j8YdgrDL6fXmc1z75MJLrjvlryQQsLzFbbzrChRCFXd5HYftsGJKSA5y
	JwRe0EYZKJdfSPyuski0jo5vgx5pD9HPCcpXYBV4KDDKWeUoEXU67SZYN90tISI3Ylk9UiOjtH4
	65o1CqDrZCkFVQ2jzpvx5WEXAxBI1MdOXMJ0Is3XCpdsxt1Srya4JUKSA588J8l0T3Xvpog+hFD
	fr+Jtmjp9paMcWQyxnGzfxI16ayVeCKnILDaaHe+3m7WFbd1+022KEWtJXZmRBa5vCdfCeK1U/F
	0QNiMJNegxY0EZCj1VN8FIH1PLhgmeVDU85TzoVFSd+USxBtijXp8Wsr8bL5Aa2kvaNnFybpToR
	CfCNI0CPR32W8QnBjirQYx+OfYJB+WX574TLjUGYrW5ak2bRS19ejJ/w==
X-Received: by 2002:a05:600c:6206:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-483a95b6debmr196639815e9.6.1771944214417;
        Tue, 24 Feb 2026 06:43:34 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:6a64:ac1e:3081:9ccd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd72bd66sm3181155e9.11.2026.02.24.06.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:43:33 -0800 (PST)
Date: Tue, 24 Feb 2026 15:43:29 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: syzbot <syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [syzbot] [kernel?] INFO: task hung in
 restrict_one_thread_callback
Message-ID: <aZ25EThvPMUptRlY@google.com>
References: <69995a88.050a0220.340abe.0d25.GAE@google.com>
 <00A9E53EDC82309F+7b1dfc69-95f8-4ffc-a67c-967de0e2dfee@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00A9E53EDC82309F+7b1dfc69-95f8-4ffc-a67c-967de0e2dfee@uniontech.com>

#syz set subsystems: lsm, kernel
