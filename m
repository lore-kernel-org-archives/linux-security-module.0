Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3F31D387
	for <linux-security-module@vger.kernel.org>; Thu, 11 Dec 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765484981; cv=none; b=Wht3HzOBvSo8jcnxvmZYfasg/0IPSYYqT3RMl6aTKbLVoybhJaqRjkObATXiOzvtU5EMwJN2VEXc4sFnBrrbOJ2eyhgderP4oE/O0zeo+GO2GmdvbqQZPplaRWweK+Fwpuf0UwwuoN5JYvZsq7Y/lR0tgq6cra1so0H2qx9BT6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765484981; c=relaxed/simple;
	bh=9DRRCSLEBB087PyuGppIjlXf6xvxWvNoT6XXU1Vh9Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iDbaInB/F7/krgK+FoKppLYLuSW2xH97UGDO3yUTkcl1eW8sQWyPGOfpax23F1JRoK+P1aoHXlIKVtQPUD154anNWI1RsL1r8iq/d3lbXKfey6Iknh4UHzzA0uh6ReuyL5G7s3M9O2Ng9ajPOAADUkzJQOxqBoukUtiMja+cAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e823m0nw; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e823m0nw"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6574d7e451dso326465eaf.0
        for <linux-security-module@vger.kernel.org>; Thu, 11 Dec 2025 12:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1765484978; x=1766089778; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DRRCSLEBB087PyuGppIjlXf6xvxWvNoT6XXU1Vh9Gg=;
        b=e823m0nwJkNkC3jZx7TG7mqG2hoLjbpwHIRBo0iPId9eJEy1W3v1CkVfoAFN/gVn0t
         4ualeUJxefTZ52wS4zDYjcd6iqp445apkpfcx0pQAr9+fhfYM2aAKNMAWq4JQ4o6QGvE
         EgO8pt+6HGTESsG7/xMhPZW/jzGQKSNbXMH2h3Q5iOd4pqNbopg+1FGOahufBpULYDjg
         SmteJ7T0JrCsLC3YR1mpw6GLRkIwGIVDLCn9jo0KXKcXjjrRV+M5u8RbAzhtrtQvm7ey
         U11ngNqucxofrx5gcjAWmzllQ5Ze+B1p+svhdgE5Ijk4blM3ubvPI+NUuo5Pn28Nwo7l
         64qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765484978; x=1766089778;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DRRCSLEBB087PyuGppIjlXf6xvxWvNoT6XXU1Vh9Gg=;
        b=mUwpbPnaTqCWv/W8w8c8jlIGkq9pOfvDKZyY+vt8ObwBSe4Way24B/wEHE7JWt9Ovo
         mUy6ZpTUEIDE97odnxARZW+ehzT+J8UJLjpfviH9ssJY7NtrZ+MhXpp7cUrDH0zexrEd
         g2pgXxA3ZcS/IPSgpgdUxZKsGDaVUdT34xhidStSEqxpG+48tQ6Qbeb7LptXyxDllOXB
         azpLJUMGB/bKWwUdyDot2huFEUBdrYtW8eMC/ETli6UNh9peQrBHQyxAquO5T1aink+7
         sunuZO63MlPZZgnrbEMPFvoZDGsoLvx/gBUl+LqH+dFGVsp7UUJDee5D8PBSGMBVMe53
         Zglw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5g8t55GuclAEiJvqhvymn3GOHiJH62ZeGjOjU5A6aZne0HU2HwLOuIFuIRLDH/e9SIKzx+WDDAhn3gRhrsQ7Yv60ens=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJqf6Z9im9gn1YTOK/vYcbpu+PQgnhAodicGjAbHW5NOQDdzQ
	iTjQN8h/HEOT6VpvuDTSUzmYbb46DYwOHL8mB4A7TMTiEIA246WDGWufJF/G/ALDnKI=
X-Gm-Gg: AY/fxX4yh6LpxhenGfX4PGTi4LcUw5iSZehgm5U7L7viGvRhM25dMd9ZMfRakm3jqh7
	TjQU1ptdChqpHqTYMHuXgVdzkUsv+cetY26+/NzmKBAEFCriwTw5qAnYoRJqH0cos5oWJhaAMlC
	c1I0vVT8a7cwdr4MuUsJ5Hl5L0fm+1e3sVkB2yGLMFPJ7UtV9wx5pth6UjfrwA7VuVmgegrflD8
	9dt287i0u5ITyyrDPPWvKl/cGCxRYt0HT9Mb+HOQl/o6vj5xIU7w23lQOj9IViCCVruDXckqiCX
	8kLY9zwosHyDST1K72hQc9mBv9jSCDjSLvbkKWFrUXANyTdD5T+vLgPAjvru4sdlPBK9vIiKiso
	J+VVeZNrRT6aXngGhdumh/kJEmBnSdKGFOT3hTPBsJO9busPUI8uf5LJ73QsQdNdlk0Y=
X-Google-Smtp-Source: AGHT+IGXgSVW4B5tlWc5GJSs37cpa/Qy9qqjFq/iATd96ugTpEgoseFG1mReqoD0ZC/0hihQZErMHw==
X-Received: by 2002:a05:6820:2019:b0:65b:257b:a898 with SMTP id 006d021491bc7-65b2abebd32mr3716006eaf.29.1765484978148;
        Thu, 11 Dec 2025 12:29:38 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b35f4ec54sm1700561eaf.6.2025.12.11.12.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 12:29:37 -0800 (PST)
Date: Thu, 11 Dec 2025 14:29:35 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	kernel-team@cloudflare.com
Subject: xfs/ima: Regression caching i_version
Message-ID: <aTspr4_h9IU4EyrR@CMGLRV3>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jeff,

While testing 6.18, I think I found a regression with
commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps") since 6.13
where IMA is no longer able to properly cache i_version when we overlay
tmpfs on top of XFS. Each measurement diff check in function
process_measurement() reports that the i_version is
always set to zero for iint->real_inode.version.

The function ima_collect_measurement() is looking to extract the version
from the cookie on next measurement to cache i_version.

I'm unclear from the commit description what the right approach here is:
update in IMA land by checking for time changes, or do
something else such as adding the cookie back.

Thanks,
Fred
