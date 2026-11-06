Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994956;
	b=N26v+dyyHIZFgDM5nz81ZUMuI32NPfxAugpUY3iAGuyo412UxU6oafzbuYHWaDv/kqem
	 SUTThauztpUPzApAJR+zQHoseSxh32a0qVAARai8nDzL3+sG6naJ0uzyjhDZpQAfrWCsX
	 fmObgYRQmVFqDEErZ/JeLiHnGdyCgoiOnoFbZ3OAiVI05Z61Eu6B99UqnmupbnoCwV9AZ
	 APugCEmqFHTmK46FLVWguE5tjkdWSXhVMSKaf3nciL75eoKaY4WkqUb5+P38ZswuzJ/fn
	 D+63D0Tf1LsFUJ2nF12MLmJQk1bzXJYOLtswAgqMCNn7AO85MdiPM/5g2eL7lX6COtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994956;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=CuJ09Hb5RQ/Gr3+TQY3Rr3dhL2Ak37LmEQSE2AB39OU=;
	b=gOPN2E0DtoSnLQDH2nMPULsP+hmwzwcy5pgZGLphXLy4PvlbeJhIf8FLsmhirQtxNszc
	 kxE1nxQhx7Zf+KxGk2KqvjAuAGor9xc6mugG3gZDIf6mcIispOdVEDh7mu3V8twD91TYY
	 W4I7U8R5w8Rs/zoh6J8H++OBq1KbsvsUUY50t4PUZqqMr2MRIQmT98ZlhBadcK416Bwo2
	 QJvJIAHbcjBi7oZAztz0s0KBAkrlEcumEjDQPHxx+Wlap+6cKQQ7PWxyGFQhm4OTeEj35
	 4kf1qxv1oViKyyTF1svleLbVbUyprQRhh22U+TFCN/RSaOf6vGTA6u/oJIk3SQMQlQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=wDgbD+oR;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE6606A329;
	Fri,  6 Nov 2026 19:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABCE6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=wDgbD+oR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1793994951; bh=yEj9qxIv6iO0flFl1+VBn04EWiczF6hcvkktycY8KmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wDgbD+oR+s+dAjQ9AGmTs7mPN4peMJLX1lwmZUXoPFwjyyuh0kvvB2MQMbxG2jjTC
	 5c14ClnXyb2V/wkdNvZWZWhXiwmiuGoOj9Q+7kAz1Szh7IlqstMeW9N9DC6QegXnyn
	 tZ03S2d6ubDTTc0Zcf1PClV/XUNN3GCc35NkATqhd1a9YhN3JRo4fkudNEkx1VUAQP
	 6SZjV78uDSClDkREaSB6dJWG/DSGceKQinuaBSHWtWtbEKRrAgnthXEyf9Kg1hqi/i
	 nOzJWaVhjgg9p5D0tpKs7xUM6oniQfxAZc0sgrIu6BOurCH08b80V4wjMIUxE+1ynn
	 PrnsVugdCdyzQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id B6B8A8B5; Fri,  6 Nov 2026 13:55:51 -0600 (CST)
Date: Fri, 6 Nov 2026 13:55:51 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com,
	paul@paul-moore.com, jmorris@namei.org, shuah@kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	lujialin4@huawei.com
Subject: Re: [PATCH -next 0/9] lockdown: fix the securityfs interface and add
 tests
Message-ID: <au4wx1+7+Bkg3wgz@hallyn.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103082421.3033195-1-caixinchen1@huawei.com>

On Tue, Nov 03, 2026 at 04:24:12PM +0800, Cai Xinchen wrote:
> The lockdown LSM exposes /sys/kernel/security/lockdown, but the file is
> not documented and has no selftest.  While looking at the interface we
> also found a configuration bug and several accumulated cleanups.
> 
> The series is organized as follows:
> 
>   - patches 1-2 are small cleanups in lockdown_write(): stop scanning
>     after the matching level and drop an update to a length variable
>     that is not used afterwards.
>   - patch 3 replaces sprintf() with scnprintf() so that the status
>     buffer is bounded explicitly if more levels are added later.
>   - patch 4 makes the LSM select SECURITYFS.  Without it, a kernel
>     built with CONFIG_SECURITYFS=n logs "failed LSM lockdown core
>     initcall with errno -19" and does not create the file advertised
>     by the Kconfig help text.
>   - patch 5 removes LSM_AUDIT_DATA_LOCKDOWN and its formatting code,
>     which became dead when the SELinux lockdown implementation was
>     removed by commit f5d0e5e9d72d.
>   - patches 6-7 drop an unused include, simplify the securityfs
>     registration, and move lockdown_reasons[] next to its only user.
>   - patch 8 documents the ABI and adds the new file to the LOCKDOWN
>     SECURITY MODULE entry in MAINTAINERS.
>   - patch 9 adds a kselftest covering the read format, invalid levels,
>     and the rejection of the current or a lower level.
> 
> The only functional change is patch 4; the rest are cleanups,
> documentation, or test coverage.  The selftest never escalates
> lockdown on the machine where it runs.
> 
> Cai Xinchen (8):
>   lockdown: Add break in lockdown_write
>   lockdown: bound the status string with scnprintf
>   lockdown: select SECURITYFS
>   lsm: remove unused lockdown audit data
>   lockdown: drop an unused include and simplify secfs init
>   lockdown: move lockdown_reasons next to its only user
>   Documentation/ABI: document the lockdown securityfs file
>   selftests/lsm: add lockdown securityfs test
> 
> Kalevi Kolttonen (1):
>   lockdown: remove useless decrement operation

In patch 3, it would be nice if we had a BUILD_BUG_ON if
the temp len became not long enough.  In patch 6, I think
the original was nicer to read.

But otherwise, these all look good to me.

Acked-by: Serge Hallyn <serge@hallyn.com>

> 
>  Documentation/ABI/testing/securityfs-lockdown |  41 ++++
>  MAINTAINERS                                   |   1 +
>  include/linux/lsm_audit.h                     |   2 -
>  include/linux/security.h                      |   2 -
>  security/lockdown/Kconfig                     |   1 +
>  security/lockdown/lockdown.c                  |  63 +++++--
>  security/lsm_audit.c                          |   4 -
>  security/security.c                           |  40 ----
>  tools/testing/selftests/lsm/Makefile          |   3 +-
>  tools/testing/selftests/lsm/common.c          |  35 +++-
>  tools/testing/selftests/lsm/common.h          |   2 +
>  tools/testing/selftests/lsm/lockdown_test.c   | 176 ++++++++++++++++++
>  12 files changed, 300 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/ABI/testing/securityfs-lockdown
>  create mode 100644 tools/testing/selftests/lsm/lockdown_test.c
> 
> -- 
> 2.18.0.huawei.25
