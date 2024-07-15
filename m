Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE5FBE8
	for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2024 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071057; cv=none; b=afQG6p1dw/6phBEKD5khePz8QAmrd1L4Yz27FOLNOy1RLbh49Myda/NFeBPs39YFz1s7opqCDrEpnF+sbA3BSThsWvSDFFs44Sss9Z1Ey6gWdmGEFuZZGtpZeC3FsYZnVXRKkasGWjmXX90p6d5JzGrmQipSDRpKR02bWB38gRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071057; c=relaxed/simple;
	bh=Bsmpc0VdJCgXbGMhJy9C704JLK3m+Ax9F8TxdmjI7ZQ=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Tfro7omqZvV7BuO1ZQNUXCw3447d0WJIuCKnEEj/yMZw2ZU2V34Gns//+CpHpmptuT/olv/aIrMYfBSGiyAdVQSEIFRvketJMREW7bLEAa+yl4r8b9rX/LXdiR2rXFwrc4w+8q27slVw/zZvolXivEj4A0qxvrU1kmVLJxvQROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TUoy4Dq8; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TUoy4Dq8"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79f08b01ba6so392258985a.0
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2024 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721071054; x=1721675854; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1SvJ95k6LtIC53lwJQ166LkSovQJo1Z3A0ATzEYqfw=;
        b=TUoy4Dq8xkX4p4Nhiq7DdKW0YcyOFQj8PrOFN5GGVlEXZAfQEusuB74DvdC5+wpHfZ
         lKdXNzmEfWOL4vBbrNGuzuV9kBiRNHiToZKwgfS9npwkk5rZIbMGyWELXsDeBo6e3d3Z
         XfKjC/bJLqF4FFjUwsTKSJJ36alnTRW6M6NXHohBfXz7ROLJcMrW38G4tqAe6dT/mNDd
         e1msXjJA4N9JHIE/DAtfhzE9yQltwYeHcJwmO6FkXTqA0dK4LFTNhhLyMljTFTRpi5fm
         4hZ1IXGCO9DCVND+StxBMmYerC7/0/3rkZRRoEVyfT7N8d6dNJo7msyLzaSgRROFbWvN
         n8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071054; x=1721675854;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1SvJ95k6LtIC53lwJQ166LkSovQJo1Z3A0ATzEYqfw=;
        b=MsExcYlHNjNzgrGzC3GJfILgk6LLK6dHMkUS3fbK3VsDUIbuc0on/z57v+vawi3z9N
         1l8zunhvRHcs8dFGkkMhFojLW2rT4F0T/lIuxA888Mz0vdlcg+gedgX7+LHgR752AbAi
         coc3og2a8YCTo5gfRHghwoEOOqddk5XtEuwNgGKLc4mPgOK24fGGog6+V5/Z1dbzEBlY
         WcUfrXIVzK9dlg9eVxZod6Q2pdH+W5LOr8gp3Uv8q8D9C9UBtp3E4U6gao3+er69IG53
         zlthRBYVRPGy1rCGCRau6z1CkzOEv/M6tOI6iDoXztKkDdxYqQ8A/L7ypyoc8lr70Xqa
         JBPw==
X-Forwarded-Encrypted: i=1; AJvYcCU6fnLCgfKmEGK+OWKSafN5y6sYwyZ0I7rBp46l+pOM9xfMtWWYxOYh1n2yoSD3bIihabh7e1sTs5lJ3Tb9oRCSKOf4CkOw2FCqMf2jyBZx5k2NrY98
X-Gm-Message-State: AOJu0YyMaLeXOttFVHz+PF2zOSuWMUf+2EQt+Mija2D04+vOJF1a/gz8
	WWe6OmErFF+yz5E2O3sGljM5YcB6FBh2YWOFrCmhD37HQHXqrgx7jqcx5qTviQ==
X-Google-Smtp-Source: AGHT+IGSgcl6qwGZ73pFUTMRJB3d8hsYhody6VszuU8jGekmQlCOH7F40gt0W/lCmiheORwDMsVF2Q==
X-Received: by 2002:a05:620a:2684:b0:79e:e9ac:80c3 with SMTP id af79cd13be357-7a152fbccbbmr1979957285a.1.1721071054513;
        Mon, 15 Jul 2024 12:17:34 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160c6dc8dsm225327885a.110.2024.07.15.12.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:17:34 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:17:33 -0400
Message-ID: <4b4df5f5e3d91b9342b56ae69b3fd2be@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20240715
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

A single SELinux patch for Linux v6.11 to change the type of a
pre-processor constant to better match its use.  Please merge.

-Paul

--
The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20240715

for you to fetch changes up to e123134b39dc40af94e8aec49227ae55b5e087a8:

  selinux: Use 1UL for EBITMAP_BIT to match maps type
    (2024-07-02 11:41:05 -0400)

----------------------------------------------------------------
selinux/stable-6.11 PR 20240715

----------------------------------------------------------------
Canfeng Guo (1):
      selinux: Use 1UL for EBITMAP_BIT to match maps type

 security/selinux/ss/ebitmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
paul-moore.com
