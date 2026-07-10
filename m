Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5D381AFC
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710830; cv=none; b=XhqeHYD0NcEDEBBz0O7dtBxzPE+9K9OvtdYDfTGugD7mVk6WoholBElihyOw+uLbretgH9wGSFluh4BXwEAH6dtpJvsS6viUH+zfpIqJygtckhRPPN5flUQJlAJjaHXlJ9Ov3BiN+fIpEA/mmNJi8m70osa92q7Rhps793zjrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710830; c=relaxed/simple;
	bh=gp5NkkfHOKOY42boLo0KN2jRdtnFthUkxT2897JpfS0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Csz0vdOzYjf816slYnUqqVDzL540D4MUp+FV/EAohZfMny6NMiWbWbyVXvP8ehn6vm92UIpeIqGQu1OUZBLTOhjZVTiO0HBkXX7v8xuhHt59KAfR7FOcdCvhMcNdNLokFwLwxJMQ4j76SjfwhvvoIhTjmNAXvR5knIcalCdb7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cz5rKfxO; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cz5rKfxO"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f032b47e3cso10091796d6.0
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783710827; x=1784315627; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iXDRXNekMT4tXdDIG0nF5WvZq2x0snU5hB+K47GtRY=;
        b=cz5rKfxOWz6nJLOyjsj4xiMfeouEyzHltPLgAJ3SorqLMGT4lwM/ULJewDgzBJPIbZ
         cJMKdvtWv4dZPphChOQFRWm/4sBQVT/z+nCMyGQwcAknWnqB0BMSrW/mkeuz6A9ZXGJw
         zUg/NnjcLja/9lF6U0/aH/bkfn2W1K4xJbUFtDdeDdakmk+Dudhhs9MPJhXC1qyyovwJ
         BrNqOHVjr1DGKkawf9JLAXSa6mtPj7EPL0c6qiquXyUp6L/1z3cSHUzvSinDOb7IyGum
         acX12SWbr5FvYVkAeHo69cGNk7IRuv1NrM4W+WzfI2k6SxH3OLB2OWOj/bPoKGD4LXkb
         UsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710827; x=1784315627;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8iXDRXNekMT4tXdDIG0nF5WvZq2x0snU5hB+K47GtRY=;
        b=LTJFbsoA+OI71jKg3G8qwjzVEs6nv/ffaiDWtEQ5QclyyKf7IPHJeeqxFOt+Xqwr6e
         MUU8x3dZpo2QBsQhlVUIWX7XAXM9D7TnSx+4bKvAuzODdOFueY1fgr8cJnfQ+yw8ec9v
         eIJOBcZRnFdp9DEe547Akuq7mNIpDrwh7sP9paFzxP0K9au3JrsZNtWKxW0CAJDhJRuO
         s+9wbTWMWUaVNX1+Zi3C/dhsOVGBNIU09laXKQMBWdxF0WWuhExXJsS/siLnihiX3ODV
         1hz0XTbEKPzPY3dcN2J0BJHOifFNxi5yquwZMZ1VdYrxf+zc3z5wmUwQNYVLnRqo60g1
         vqJA==
X-Forwarded-Encrypted: i=1; AHgh+RrwfRJQze4Qj9rk76MjlPv+xPZ5YWDx1M/M/YnfHMe0GyCu3PIkE7YrG3zaAXOO68CW3lsnaWeqnw8/I+5qCzrGneI39qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiqvOypMSED4qW6naj7SrMzDWNaLH/atl3JoN1v20oPndhXYgi
	lp2tqjQ1uG+QX5i7kIq+gd12AbNsPXWWgsFInaicn8HmJ7y3q5+jXvAwQ8g9PymwfA==
X-Gm-Gg: AfdE7ckRCMujr0h+UzIaUYesJc/S+FBwCLwSWef64j6ib/HAEQTLQCl7pSCIi38h9Fg
	HpxQ+ZL/ytB/UNOSgwGQWqXEQzHeSJGwtdDAx/ZYqp/nNDTmSeo4bw+PBe4ALtAFAqJAoE9QPrl
	0ZiAJAwPhyL5GJPcxKZI7yVDbGQd0yc46B3gLEfpekfdSOc64ibnSChUBqk36uAQ8AwdXIytfAn
	hbUK02ume2KOJzLVlvY64hBdIan80RvFtPFORPyG82ZExaYe4phi1qbMy8keFOQFjYE8B4hpKFq
	xrBCMc6nLih9leukfgVcu1FTlsFpRgrUENbMjkCGt6ZzyqhPJC2OFUNQ0rmHoFfrhG0AU6I7aUh
	8XmJcQZDJva9yll33b+uyaySa+PweDXHDLfeLpH5OClL4Lo3WMOK1499Uk4IsS7nWOusdn1xrPB
	1dRCtGWx1s5YjuC8HUmwYzZ5nBxlY5AN1yon4BDAhO08g4vjPlvY7qPtlUUg==
X-Received: by 2002:a05:6214:5803:b0:8ea:7785:f3e6 with SMTP id 6a1803df08f44-90402c68bf1mr3453026d6.42.1783710827532;
        Fri, 10 Jul 2026 12:13:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e3083sm48371106d6.6.2026.07.10.12.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:13:46 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:13:45 -0400
Message-ID: <44e0f55f936543053d657f0a86a53bd9@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260710
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Linus,

Two small SELinux patches to fix a missing permission check for
TCP Fast Open operations and fix a socket lookup issue with SCTP ASCONF
operations.

Paul

--
The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260710

for you to fetch changes up to 56acfeb10019e200ab6787d01f8d7cbe0f01526f:

  selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
    (2026-07-01 18:22:22 -0400)

----------------------------------------------------------------
selinux/stable-7.2 PR 20260710
----------------------------------------------------------------

Stephen Smalley (1):
      selinux: check connect-related permissions on TCP Fast Open

Tristan Madani (1):
      selinux: avoid sk_socket dereference in
         selinux_sctp_bind_connect()

 security/selinux/hooks.c |   38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

--
paul-moore.com
