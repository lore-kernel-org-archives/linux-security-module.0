Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C51E47A3
	for <linux-security-module@vger.kernel.org>; Tue,  8 Jul 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015244; cv=none; b=osbYjkAWVzrf+2EScRAzf2Zwhl0loa2GCPvFsHi0n/6KzDPChnlmWh2uEvIkf+lHa7b+YCfTo3Rm7zkeOAIZ7xAg+NTktp0DG2EUl6sOdlKpKtIRBj1CI5BftlDiigvflz4BxXo81Qb94G8OxcXHOOLzOVZee6gizjRKtWjI5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015244; c=relaxed/simple;
	bh=BWGrnPzdM29YZ+XEjVdxFQICGfUneK/3oyhUW49b96o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kd71HswKy4F8ZdymD6MPf52lM1RJiogRGT8GEYTZzmkoozogGXXI6GBzHZeKDOIR4A7PWaF170up0JCfNWu9YOROxUikTwrfdzknBeqxb3NvxFIAqS62QNoYHzNlD5QgdiOjpfrtW2MelFJUOJnd0sFe3+AjzlEdbfjqUZPHDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86d0aa2dc99so546967239f.1
        for <linux-security-module@vger.kernel.org>; Tue, 08 Jul 2025 15:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752015242; x=1752620042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xB6rIu45qgH+ua/fJIcg/GQ4LbflrQoSaYRE7j9ojes=;
        b=jUazNMkoD+p7wzqnAaTYqvDQGWyJB9ajJTbBbdxgVbyNtuNvojRPIKRFHhF79NVR0S
         uKv0C9YItk+zO+yFmR4YU84h4KSSObyl0VP/BhJciS1Xka25JIIJWk0XkoWVQXvoGJ0M
         Xk8lqTjo4A4riAIQKHUtUh7LTQSYXhJaZRNfei2ngoiSbj1tRPME4LzJJjhhqxuFJ2Al
         fWIud3yEZSdtHH0usbZb4V7m0i8wP+CUXy86k7qhTdrHLKS5VYD+h1499o+Pkj63ZcUD
         1gKIGB5uCBxuYFUx801rK08O+MnuzxxyneW3izyVWGW9rBaHffsQzlK9i6SDZNKS2c8C
         dJfg==
X-Forwarded-Encrypted: i=1; AJvYcCU7/Np4Rf0z2+5542RR7uD/ivPWYTV+nSWz2NAw9KkioGraQGMcIxlEhnq5Sh9ANIQD0TP+wAFaLpFWJXkOUwfWmJaP+IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVV7xo94KTR1zWeYsfDh9XP7BXatmCSW/6K1PyAvOtMWNbtKt
	ALFRv0hkXhU2OVsbRuUFEP0i0TU505IQE33ZbgtxPzqagB6xz8RrOadP05uOAtf58s/8iOVBCgZ
	MJukd3pmjgBnm0H2FxFgXIYjxxfAkzYb/hKT+C9eSAGtJqbWY25hQDSc5vW0=
X-Google-Smtp-Source: AGHT+IHhl5K1IBm4w3Ha62Q3bSWZNOD6HNSa90AYPP6wynNDvSk/jc3dzaTrHiG+iN1WvOSrqpb+n7vuyOQBxSRasTloLdUsenQH
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:388a:b0:86d:60:702f with SMTP id
 ca18e2360f4ac-8795af33198mr62688239f.0.1752015242081; Tue, 08 Jul 2025
 15:54:02 -0700 (PDT)
Date: Tue, 08 Jul 2025 15:54:02 -0700
In-Reply-To: <20250708224131.332014-1-kuniyu@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686da18a.050a0220.1ffab7.0023.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/smc/af_smc.c:365:3: error: call to undeclared function 'inet_sock_destruct'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]


Tested on:

commit:         ec480130 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c06e3e2454512b3
dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=130a6bd4580000

